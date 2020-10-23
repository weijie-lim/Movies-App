import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view.dart';
import 'home.dart';
import 'package:flutter/services.dart';

class History extends StatefulWidget {
  final List historyList;
  final List videos;
  History({Key key, @required this.historyList, this.videos}) : super(key: key);
  static const id = 'View';
  @override
  _History createState() => new _History(historyList, videos);
}

class _History extends State<History>{
  List historyList;
  final List videos;
  _History(this.historyList, this.videos);


  String allGenres;
  getGenres(dynamic movie, int index){
    allGenres = '';
    print(movie[index]['name']);
    if (movie[index].length == 0){
      allGenres = 'Unknown';
    }

    if (movie[index].length == 1){
      allGenres = movie.genres[0]['name'];
    } else {
      if (movie[index].length > 1) {
        for(var i = 0; i<movie[index].length; i++){
          allGenres = allGenres + movie[i]['name'] + ' ';
        }
      }
    }
    return allGenres;

  }

  @override
  void initState() {

    super.initState();
    historyList = historyList.reversed.toList();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movies Searched!',
          style: GoogleFonts.pacifico(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
      ),
      body: historyList.length != 0
          ? ListView.builder(
        itemCount: historyList.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    View(movie:
                    Movie(
                        historyList[i].adult, historyList[i].backdropPath,
                        historyList[i].belongsToCollection,
                        historyList[i].budget, historyList[i].genres,
                        historyList[i].homepage,historyList[i].id,
                        historyList[i].imdbID, historyList[i].originalLanguage,
                        historyList[i].originalTitle, historyList[i].overview,
                        historyList[i].popularity, historyList[i].posterPath,
                        historyList[i].productionCompanies, historyList[i].productionCountries,
                        historyList[i].releaseDate, historyList[i].revenue,
                        historyList[i].runtime, historyList[i].spokenLanguages,
                        historyList[i].status, historyList[i].tagLine,
                        historyList[i].title, historyList[i].video, historyList[i].voteAverage,
                        historyList[i].voteCount, videos
                    ),
                    ),
                ),
              );
            },
            child: ListTile(
              title: historyList[i].originalTitle == null
                  ? Text(
                historyList[i].originalTitle + ' (' +  historyList[i].releaseDate.substring(0,4) + ')',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.limelight(
                    fontSize: 22.0
                ),
              ) :  historyList[i].title != null
                  ? Text(
                historyList[i].title + ' (' +  historyList[i].releaseDate.substring(0,4) + ')',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.limelight(
                    fontSize: 22.0
                ),
              ) : Text(
                'No Title' + ' (' +  historyList[i].releaseDate.substring(0,4) + ')',
                style: GoogleFonts.limelight(
                    fontSize: 22.0
                ),
              ),
              subtitle: Text(
                'Genres: ${getGenres(historyList[i].genres, i)}',
                style: GoogleFonts.roboto(
                  fontSize: 15
                ),
              ),
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 44,
                    maxHeight: 44,
                  ),
                  child: historyList[i].posterPath != null
                      ? Image.network('https://image.tmdb.org/t/p/w500' + historyList[i].posterPath, fit: BoxFit.cover)
                      : Image.asset('images/NoImageAvailable.png',fit: BoxFit.cover),
                    ),
                ),
          );
        },
      ) : Center(
        child: Text(
            'No movies searched in this session',
          style: GoogleFonts.roboto(
            fontSize: 20
          ),
        )
      ),
    );

  }
}
