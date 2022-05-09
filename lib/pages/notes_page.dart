import 'package:flutter/material.dart';
import '../db/notes_database.dart';
import '../model/note.dart';
import '../pallete.dart';
import '../widget/note_card_widget.dart';
import 'edit_note_page.dart';
import 'note_detail_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
      duration: const Duration(milliseconds: 250),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0),
        child: Scaffold(
          backgroundColor: Colors.black,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddEditNotePage()),
              );

              refreshNotes();
            },
            backgroundColor: const Color(0xff3a3a3a),
            child: const Icon(
              Icons.edit_road_outlined,
              color: Color(0xfff46a4e),
            ),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                  backgroundColor: Colors.black,
                  expandedHeight: 300.0,
                  flexibleSpace: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('All notes', style: Palette.h1),
                      Text('5 notes', style: Palette.h2),
                    ],
                  )),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            isDrawerOpen
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        xOffset = 0;
                                        yOffset = 0;
                                        scaleFactor = 1;
                                        isDrawerOpen = false;
                                      });
                                    },
                                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white))
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        xOffset = 230;
                                        yOffset = 150;
                                        scaleFactor = 0.6;
                                        isDrawerOpen = true;
                                      });
                                    },
                                    icon: const Icon(Icons.menu, color: Colors.white)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(onPressed: () {}, icon: const Icon(Icons.picture_as_pdf, color: Colors.white)),
                            IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.white)),
                            IconButton(onPressed: () {}, icon: const Icon(Icons.alt_route_sharp, color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Date modified | ↓', style: Palette.h2, textAlign: TextAlign.right),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 150,
                  child: Center(
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : notes.isEmpty
                            ? const Text(
                                "No Notes",
                                style: TextStyle(color: Colors.white, fontSize: 24),
                              )
                            : buildNotes(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNotes() => StaggeredGridView.countBuilder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );

  Widget Card() {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 120,
            decoration: Palette.noteCard,
            child: const Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                style: Palette.text),
          ),
          const Text('Text note', style: Palette.h2),
          const Text('02/05', style: Palette.h2),
          const Text('4 May', style: Palette.h2),
        ],
      ),
    );
  }
}
