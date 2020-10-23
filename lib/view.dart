import 'package:flutter/material.dart';
import'home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';


class View extends StatefulWidget {
  final Movie movie;
  View({Key key, @required this.movie}) : super(key: key);
  static const id = 'View';
  @override
  _View createState() => new _View(movie);
}

class _View extends State<View> {
  Movie movie;

  _View(this.movie);

  String allGenres = '';

  getGenres() {
    if (movie.genres.length == 0) {
      allGenres = 'Unknown';
    }

    if (movie.genres.length == 1) {
      allGenres = movie.genres[0]['name'];
    } else {
      if (movie.genres.length > 1) {
        for (var i = 0; i < movie.genres.length; i++) {
          allGenres = allGenres + movie.genres[i]['name'] + ' ';
        }
      }
    }
  }

  String youtubeID;

  Future findMatchVideo() async {
    youtubeID = '';

    for (var i = 0; i < movie.listOfVideos.length; i++) {
      //print(movie.listOfVideos[i].results.length);
      if (movie.listOfVideos[i].results.length != 0){
        if (movie.id == movie.listOfVideos[i].id) {
          if (movie.listOfVideos[i].results[0]['site'] == 'YouTube') {
            setState(() {
              youtubeID = movie.listOfVideos[i].results[0]['key'];
            });
          }
          break;
        }
      }
    }
  }

  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    getGenres();

    findMatchVideo()
    //.whenComplete() {
    // or
        .then((result) {
      //print("result: $result");
      setState(() {
        _controller = YoutubePlayerController(
          initialVideoId: youtubeID,
        );
      }
      );
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie Scoops!',
          style: GoogleFonts.pacifico(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: new AspectRatio(
              aspectRatio: MediaQuery
                  .of(context)
                  .size
                  .height * 0.25 /
                  MediaQuery
                      .of(context)
                      .size
                      .width,
              child: new Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    new Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .height * 2,
                      height: MediaQuery
                          .of(context)
                          .size
                          .width * 1.5,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: movie.posterPath != null
                              ? NetworkImage('https://image.tmdb.org/t/p/w500' +
                              movie.posterPath)
                              : AssetImage('images/NoImageAvailable.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: EdgeInsets.all(5.5),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: movie.originalTitle == null
                              ? Text(
                            movie.originalTitle + ' (' + movie.releaseDate
                                .substring(0, 4) + ')',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.limelight(
                                fontSize: 22.0
                            ),
                          ) : movie.title != null
                              ? Text(
                            movie.title + ' (' +
                                movie.releaseDate.substring(0, 4) + ')',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.limelight(
                                fontSize: 22.0
                            ),
                          ) : Text(
                            'No Title' + ' (' +
                                movie.releaseDate.substring(0, 4) + ')',
                            style: GoogleFonts.limelight(
                                fontSize: 22.0
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              'Synopsis:',
              style: GoogleFonts.roboto(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                movie.overview,
                style: GoogleFonts.roboto(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    child: Text(
                      'Release Date:',
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                    child: Text(
                      movie.releaseDate,
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    child: Text(
                      'Genre:',
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
              ),
              Flexible(
                child: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      allGenres,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    child: Text(
                      'RunTime:',
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                    child: Text(
                      '${movie.runtime} mins',
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    child: Text(
                      'Average Ratings:',
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                    child: Text(
                      '${movie.voteAverage} out of 10',
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    child: Text(
                      'Status of Film:',
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                    child: Text(
                      movie.status,
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15
          ),
          Center(
            child: Text(
              'Watch Trailer',
              style: GoogleFonts.bahiana(
                fontSize: 40,
                fontWeight: FontWeight.bold
              )
            ),
          ),
          SizedBox(
              height: 15
          ),
          youtubeID != ''
              ? YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ) : Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              color: Colors.black
            ),
            child: Center(
              child: Text(
                'Trailer Not Found!',
                style: GoogleFonts.zcoolKuaiLe(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ),
          SizedBox(
              height: 15
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.thumb_up,
                      color: Colors.indigo,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                        'Love'
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.thumb_down,
                      color: Colors.indigoAccent,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                        'Hate'
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                        'Views'
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.bubble_chart,
                      color: Colors.lightBlueAccent,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                        'Comment'
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
              height: 50
          ),
        ],
      ),
    );
  }
}

