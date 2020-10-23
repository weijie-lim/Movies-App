import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'keys.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view.dart';
//import 'package:intl/intl.dart';
import 'history.dart';
import 'package:flutter/services.dart';

var allMovies = new List();
var singleMovieList = new List();
Future<Album> oneMovie;

const initialID = 500;
const endingID = 550;

Future<List> getMovies() async{
  for (var i = initialID; i < endingID; i++){
    final response = await http.get('https://api.themoviedb.org/3/movie/$i?api_key=$apiKey');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      allMovies.add(Album.fromJson(jsonDecode(response.body)));



    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load album');
      //allMovies.add([]);
    }
  }
  return allMovies;
}

var allVideos = new List();
Future<List> getVideos() async{
  for (var i = initialID; i < endingID; i++){
    final responseVideos = await http.get('http://api.themoviedb.org/3/movie/$i/videos?api_key=$apiKey');

    if (responseVideos.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      allVideos.add(Videos.fromJson(jsonDecode(responseVideos.body)));

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load album');
      //allMovies.add([]);
    }
  }
  return allVideos;
}


class Home extends StatefulWidget {
  static const String id = 'Home';
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home>{
  List futureAlbum;
  List futureVideos;

  bool isAction = false;
  bool isAdventure = false;
  bool isAnimation = false;
  bool isComedy = false;
  bool isCrime = false;
  bool isDocumentary = false;
  bool isDrama = false;
  bool isFamily = false;
  bool isFantasy = false;
  bool isHistory = false;
  bool isHorror = false;
  bool isMusic = false;
  bool isMystery = false;
  bool isRomance = false;
  bool isScienceFiction = false;
  bool isTVMovie = false;
  bool isThriller = false;
  bool isWar = false;
  bool isWestern = false;
  bool isMostRecent = false;
  bool isOldest = false;

  bool visibilityTag = false;
  bool visibilityTag2 = false;


  var allGenres;
  getGenres(Album movie){
    allGenres = new List();

    if (movie.genres.length == 0){
      allGenres = [];
    }

    if (movie.genres.length == 1){
      allGenres.add(movie.genres[0]['name']);
    } else {
      if (movie.genres.length > 1) {
        for(var i = 0; i<movie.genres.length; i++){
          allGenres.add(movie.genres[i]['name']);
        }
      }
    }
    return allGenres;
  }

  List genreList;
  List originalList;
  var filteredMovies;
  getResults(){
    filteredMovies = new List();
    for(var i =0; i < allMovies.length; i ++){
      //get all genres
      genreList = getGenres(allMovies[i]);
      //print(genreList);

      //if genreList is not empty
      if (genreList.length != 0){
        //find is action is inside
        if (isAction == true){
          if (genreList.contains('Action')){
            filteredMovies.add(allMovies[i]);
          }
        }
        if (isAnimation == true){
          if (genreList.contains('Animation')){
            filteredMovies.add(allMovies[i]);
          }
        }
        if (isAdventure == true){
          if (genreList.contains('Adventure')){
            filteredMovies.add(allMovies[i]);
          }
        }
        if (isComedy == true){
          if (genreList.contains('Comedy')){
            filteredMovies.add(allMovies[i]);
          }
        }
        if (isCrime == true){
          if (genreList.contains('Crime')){
            filteredMovies.add(allMovies[i]);
          }
        }

        if (isDocumentary == true){
          if (genreList.contains('Documentary')){
            filteredMovies.add(allMovies[i]);
          }
        }
        if (isDrama == true){
          if (genreList.contains('Drama')){
            filteredMovies.add(allMovies[i]);
          }
        }
        if (isFamily == true){
          if (genreList.contains('Family')){
            filteredMovies.add(allMovies[i]);
          }
        }
        if (isFantasy == true){
          if (genreList.contains('Fantasy')){
            filteredMovies.add(allMovies[i]);
          }
        }
        if (isHistory == true){
          if (genreList.contains('History')){
            filteredMovies.add(allMovies[i]);
          }
        }

        if (isHorror == true){
          if (genreList.contains('Horror')){
            filteredMovies.add(allMovies[i]);
          }
        }
        if (isMusic == true){
          if (genreList.contains('Music')){
            filteredMovies.add(allMovies[i]);
          }
        }
        if (isMystery == true){
          if (genreList.contains('Mystery')){
            filteredMovies.add(allMovies[i]);
          }
        }


        if (isRomance == true){
          if (genreList.contains('Romance')){
            filteredMovies.add(allMovies[i]);
          }
        }
        if (isScienceFiction == true){
          if (genreList.contains('Science Fiction')){
            filteredMovies.add(allMovies[i]);
          }
        }
        if (isTVMovie == true){
          if (genreList.contains('Tv Movie')){
            filteredMovies.add(allMovies[i]);
          }
        }
        if (isThriller == true){
          if (genreList.contains('Thriller')){
            filteredMovies.add(allMovies[i]);
          }
        }
        if (isWar == true){
          if (genreList.contains('War')){
            filteredMovies.add(allMovies[i]);
          }
        }
        if (isWestern == true){
          if (genreList.contains('Western')){
            filteredMovies.add(allMovies[i]);
          }
        }

        if(isAction == false && isAdventure == false && isAnimation == false &&
        isComedy == false && isCrime == false && isDocumentary == false
        && isDrama == false && isFamily == false && isFantasy == false
        && isHistory == false && isHorror == false && isMusic == false
            && isMystery == false && isRomance == false && isScienceFiction == false
        && isTVMovie == false && isThriller == false && isWar == false &&
        isWestern == false){
          filteredMovies.add(allMovies[i]);
        }
      }

    }
    setState(() {
      allMovies = filteredMovies;
      //print('After Filter: ${allMovies.length}');
    });
  }

  void reset(){
    setState(() {
      futureAlbum = originalList;
      allMovies = originalList;

      isAction = false;
      isAdventure = false;
      isAnimation = false;
      isComedy = false;
      isCrime = false;
      isDocumentary = false;
      isDrama = false;
      isFamily = false;
      isFantasy = false;
      isHistory = false;
      isHorror = false;
      isMusic = false;
      isMystery = false;
      isRomance = false;
      isScienceFiction = false;
      isTVMovie = false;
      isThriller = false;
      isWar = false;
      isWestern = false;
      filteredMovies = new List();
    });
  }


  void reset1(){

    setState(() {
      isMostRecent = false;
      isOldest = false;
      orderList = new List();
      futureAlbum = originalList;
      orderBy();

    });
  }

  var orderList;
  void orderBy(){
    orderList = new List();
    orderList = allMovies;
    if (isOldest == true){
      Comparator<dynamic> sortById = (a, b) => a.releaseDate.compareTo(b.releaseDate);
      orderList.sort(sortById);
      setState(() {
        allMovies = orderList;
      });
    }
    if (isMostRecent == true){
      Comparator<dynamic> sortById = (a, b) => a.releaseDate.compareTo(b.releaseDate);
      orderList.sort(sortById);
      orderList = orderList.reversed.toList();
      setState(() {
        allMovies = orderList;
      });
    }
    if (isMostRecent == false && isOldest == false){
      setState(() {
        allMovies = originalList;
      });
    }
  }

  var HistoryList;

  @override
  void initState() {
    super.initState();
    HistoryList = new List();
    getMovies()
    //.whenComplete() {
    // or
        .then((result) {
      //print("result: $result");
      setState(() {
        futureAlbum = allMovies;
        originalList = allMovies;
        //print('Before Filter: ${allMovies.length}');
      }
      );
    }
    );

    getVideos()
    //.whenComplete() {
    // or
        .then((result) {
      //print("result: $result");
      setState(() {
        //print(allVideos);
      }
      );
    }
    );

  }

  bool gallerySelected = true;
  List genreOptions = ['hello', 'bye'];



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _gridItem(String posterPath, String backdropPath,
        String originalTitle, String title,
        String releaseDate, int id) {
      return Column(
        children: [
          new Container(
          width: MediaQuery.of(context).size.height*0.6,
          height: MediaQuery.of(context).size.width*0.38,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: posterPath != null
                  ? NetworkImage('https://image.tmdb.org/t/p/w500' + posterPath)
                  : AssetImage('images/NoImageAvailable.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
          ),

          Padding(
            padding: EdgeInsets.all(5.5),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: originalTitle == null
                  ? Text(
                originalTitle + ' (' + releaseDate.substring(0,4) + ')',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.raleway(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold
                ),
              ) : title != null
                  ? Text(
                title + ' (' + releaseDate.substring(0,4) + ')',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.raleway(
                    fontSize: 11.0,
                  fontWeight: FontWeight.bold
                ),
              ) : Text(
                'No Title' + ' (' + releaseDate.substring(0,4) + ')',
                style: GoogleFonts.raleway(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold
                ),
              )
            ),
          )
        ],
      );
    }

    _scrollItem(String posterPath, String backdropPath,
        String originalTitle, String title,
        String releaseDate) {
      return Column(
        children: [
          new Container(
            width: MediaQuery.of(context).size.height * 1.8,
            height: MediaQuery.of(context).size.width * 1,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: posterPath != null
                    ? NetworkImage('https://image.tmdb.org/t/p/w500' + posterPath)
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
                child: originalTitle == null
                    ? Text(
                  originalTitle + ' (' + releaseDate.substring(0,4) + ')',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.limelight(
                      fontSize: 30.0
                  ),
                ) : title != null
                    ? Text(
                  title + ' (' + releaseDate.substring(0,4) + ')',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.limelight(
                      fontSize: 30.0
                  ),
                ) : Text(
                  'No Title' + ' (' + releaseDate.substring(0,4) + ')',
                  style: GoogleFonts.limelight(
                      fontSize: 30.0
                  ),
                )
            ),
          )
        ],
      );
    }



    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Movie Scoops!',
          style: GoogleFonts.pacifico(
            color: Colors.white,
            fontSize: 28,
          ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      History(historyList: HistoryList,
                        videos: allVideos
                      ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                      Icons.history,
                      color: Colors.white,
                      size: 20,
                  ),
                  SizedBox(
                      width: 2
                  ),
                  Text(
                      'History',
                    style: GoogleFonts.pacifico(
                    ),
                  ),
                  SizedBox(
                    width: 5
                  ),
                ]
              ),
            )
          ],
        ),
      body: futureAlbum != null
          ? Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            // Change the color of the container beneath
                            setState(() {
                              visibilityTag = !visibilityTag;
                            });
                          },
                          child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.filter_list,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Filter by Genre",
                                  style:  GoogleFonts.aBeeZee(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w900
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ]
                  ),
                ),
                visibilityTag == true ?
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isAction = !isAction;

                                });
                              }, value: isAction,
                            ),
                            Text(
                                'Action'
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isAdventure = !isAdventure;

                                });
                              }, value: isAdventure,
                            ),
                            Text(
                                'Adventure'
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isAnimation = !isAnimation;
                                });
                              }, value: isAnimation,
                            ),
                            Text(
                                'Animation'
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isComedy = !isComedy;
                                });
                              }, value: isComedy,
                            ),
                            Text(
                                'Comedy'
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isCrime = !isCrime;
                                });
                              }, value: isCrime,
                            ),
                            Text(
                                'Crime'
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isDocumentary = !isDocumentary;
                                });
                              }, value: isDocumentary,
                            ),
                            Text(
                                'Documentary'
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isDrama = !isDrama;
                                });
                              }, value: isDrama,
                            ),
                            Text(
                                'Drama'
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isFamily = !isFamily;
                                });
                              }, value: isFamily,
                            ),
                            Text(
                                'Family'
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isFantasy = !isFantasy;
                                });
                              }, value: isFantasy,
                            ),
                            Text(
                                'Fantasy'
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isHistory = !isHistory;
                                });
                              }, value: isHistory,
                            ),
                            Text(
                                'History'
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isHorror = !isHorror;
                                });
                              }, value: isHorror,
                            ),
                            Text(
                                'Horror'
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isMusic = !isMusic;
                                });
                              }, value: isMusic,
                            ),
                            Text(
                                'Music'
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isMystery = !isMystery;
                                });
                              }, value: isMystery,
                            ),
                            Text(
                                'Mystery'
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isRomance = !isRomance;
                                });
                              }, value: isRomance,
                            ),
                            Text(
                                'Romance'
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isScienceFiction = !isScienceFiction;
                                });
                              }, value: isScienceFiction,
                            ),
                            Text(
                                'Science Fiction'
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isTVMovie = !isTVMovie;
                                });
                              }, value: isTVMovie,
                            ),
                            Text(
                                'TV Movie'
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isThriller = !isThriller;
                                });
                              }, value: isThriller,
                            ),
                            Text(
                                'Thriller'
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isWar = !isWar;
                                });
                              }, value: isWar,
                            ),
                            Text(
                                'War'
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isWestern = !isWestern;
                                });
                              }, value: isWestern,
                            ),
                            Text(
                                'Western'
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children:[
                             FlatButton(
                               color: Colors.lightBlueAccent,
                               textColor: Colors.white,
                               disabledColor: Colors.grey,
                               disabledTextColor: Colors.black,
                               padding: EdgeInsets.all(4.0),
                               splashColor: Colors.indigo,
                               onPressed: () {
                                 getResults();
                               },
                               child: Text(
                                 "Apply Filters",
                                 style: GoogleFonts.roboto(
                                     fontSize: 14.0
                                 ),
                               ),
                             ),
                             FlatButton(
                               color: Colors.lightBlueAccent,
                               textColor: Colors.white,
                               disabledColor: Colors.grey,
                               disabledTextColor: Colors.black,
                               padding: EdgeInsets.all(4.0),
                               splashColor: Colors.indigo,
                               onPressed: () {
                                 reset();
                               },
                               child: Text(
                                 "Reset",
                                 style: GoogleFonts.roboto(
                                     fontSize: 14.0
                                 ),
                               ),
                             )
                           ]
                        )
                      ]
                    )
                : SizedBox(
                  height: 0
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            // Change the color of the container beneath
                            setState(() {
                              visibilityTag2 = !visibilityTag2;
                            });
                          },
                          child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Order By",
                                  style:  GoogleFonts.aBeeZee(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ]
                  ),
                ),
                visibilityTag2 == true ?
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isMostRecent = !isMostRecent;
                                  isOldest = !isMostRecent;

                                });
                              }, value: isMostRecent,
                            ),
                            Text(
                                'Most Recent'
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isOldest = !isOldest;
                                  isMostRecent = !isOldest;
                                });
                              }, value: isOldest,
                            ),
                            Text(
                                'Oldest First'
                            ),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:[
                              FlatButton(
                                color: Colors.lightBlueAccent,
                                textColor: Colors.white,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(4.0),
                                splashColor: Colors.indigo,
                                onPressed: () {
                                  setState(() {
                                    orderBy();
                                  });
                                },
                                child: Text(
                                  "Apply",
                                  style: GoogleFonts.roboto(
                                      fontSize: 14.0
                                  ),
                                ),
                              ),
                              FlatButton(
                                color: Colors.lightBlueAccent,
                                textColor: Colors.white,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(4.0),
                                splashColor: Colors.indigo,
                                onPressed: () {
                                  reset1();
                                },
                                child: Text(
                                  "Reset",
                                  style: GoogleFonts.roboto(
                                      fontSize: 14.0
                                  ),
                                ),
                              )
                            ]
                        )
                      ],
                    ): SizedBox(height: 0),

                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            // Change the color of the container beneath
                            setState(() {
                              gallerySelected = true;
                            });
                          },
                          child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.grid_on,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Gallery",
                                  style: gallerySelected == false
                                      ? GoogleFonts.aBeeZee(
                                    fontSize: 20,
                                  ) : GoogleFonts.aBeeZee(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ]
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Change the color of the container beneath
                            setState(() {
                              gallerySelected = false;
                            });
                          },
                          child: Row(
                              children: <Widget>[
                                Icon(
                                    Icons.touch_app,
                                    size: 25
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Scroll View",
                                  style: gallerySelected == true
                                      ? GoogleFonts.aBeeZee(
                                    fontSize: 20,
                                  ) : GoogleFonts.aBeeZee(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ]
                  ),
                ),

                Expanded(
                  child: gallerySelected == true
                      ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                        child: GridView.builder(
                    itemCount: allMovies.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 3,
                          crossAxisCount: 3,
                          childAspectRatio: MediaQuery.of(context)
                              .size
                              .width /
                              (MediaQuery.of(context).size.height /
                                  1.5)),

                    itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: (){
                            if (! HistoryList.contains(allMovies[index])){
                              HistoryList.add(allMovies[index]);
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  View(movie:
                                  Movie(
                                      allMovies[index].adult, allMovies[index].backdropPath,
                                      allMovies[index].belongsToCollection,
                                      allMovies[index].budget, allMovies[index].genres,
                                      allMovies[index].homepage, allMovies[index].id,
                                      allMovies[index].imdbID, allMovies[index].originalLanguage,
                                      allMovies[index].originalTitle, allMovies[index].overview,
                                      allMovies[index].popularity, allMovies[index].posterPath,
                                      allMovies[index].productionCompanies, allMovies[index].productionCountries,
                                      allMovies[index].releaseDate, allMovies[index].revenue,
                                      allMovies[index].runtime, allMovies[index].spokenLanguages,
                                      allMovies[index].status, allMovies[index].tagLine,
                                      allMovies[index].title, allMovies[index].video, allMovies[index].voteAverage,
                                      allMovies[index].voteCount, allVideos
                                  ),
                                  ),
                              ),
                            );
                          },
                          child: _gridItem(
                              allMovies[index].posterPath,
                              allMovies[index].backdropPath,
                              allMovies[index].originalTitle,
                              allMovies[index].title,
                              allMovies[index].releaseDate, allMovies[index].id),
                        );
                    },
                  ),
                      ) :  ListView(
                    padding: EdgeInsets.all(10),
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: allMovies.length,
                          itemBuilder: (BuildContext context, int index) => Card(
                            child: new AspectRatio(
                              aspectRatio: MediaQuery.of(context).size.height * 0.25 /
                                  MediaQuery.of(context).size.width,
                              child: new Container(
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                ),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          View(movie:
                                          Movie(
                                              allMovies[index].adult, allMovies[index].backdropPath,
                                              allMovies[index].belongsToCollection,
                                              allMovies[index].budget, allMovies[index].genres,
                                              allMovies[index].homepage, allMovies[index].id,
                                              allMovies[index].imdbID, allMovies[index].originalLanguage,
                                              allMovies[index].originalTitle, allMovies[index].overview,
                                              allMovies[index].popularity, allMovies[index].posterPath,
                                              allMovies[index].productionCompanies, allMovies[index].productionCountries,
                                              allMovies[index].releaseDate, allMovies[index].revenue,
                                              allMovies[index].runtime, allMovies[index].spokenLanguages,
                                              allMovies[index].status, allMovies[index].tagLine,
                                              allMovies[index].title, allMovies[index].video, allMovies[index].voteAverage,
                                              allMovies[index].voteCount, allVideos
                                          ),
                                          ),
                                      ),
                                    );
                                  },
                                  child: _scrollItem(
                                      allMovies[index].posterPath,
                                      allMovies[index].backdropPath,
                                      allMovies[index].originalTitle,
                                      allMovies[index].title,
                                      allMovies[index].releaseDate),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
      )
          : Center(
              child: CircularProgressIndicator()
          )

    );


  }
}

class Album {
  final bool adult;
  final String backdropPath;
  final Object belongsToCollection;
  final int budget;
  final List genres;
  final String homepage;
  final int id;
  final String imdbID;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List productionCompanies;
  final List productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List spokenLanguages;
  final String status;
  final String tagLine;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Album({this.adult, this.backdropPath, this.belongsToCollection, this.budget, this.genres,
    this.homepage, this.id, this.imdbID, this.originalLanguage, this.originalTitle, this.overview,
    this.popularity, this.posterPath, this.productionCompanies, this.productionCountries,
    this.releaseDate, this.revenue, this.runtime, this.spokenLanguages, this.status, this.tagLine,
    this.title, this.video, this.voteAverage, this.voteCount
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      //belongsToCollection: json['belongs_to_collection'],
      budget: json['budget'],
      genres: json['genres'],
      homepage: json['homepage'],
      id: json['id'],
      imdbID: json['imdbID'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      productionCompanies: json['production_companies'],
      productionCountries: json['production_countries'],
      releaseDate: json['release_date'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguages: json['spoken_languages'],
      status: json['status'],
      tagLine: json['tagline'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count']
    );
  }
}

class Videos {
  final List results;
  final int id;

  Videos({this.results, this.id
  });

  factory Videos.fromJson(Map<String, dynamic> json) {
    return Videos(
        results: json['results'],
      id: json['id']
    );
  }
}


class Movie {
  final bool adult;
  final String backdropPath;
  final Object belongsToCollection;
  final int budget;
  final List genres;
  final String homepage;
  final int id;
  final String imdbID;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List productionCompanies;
  final List productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List spokenLanguages;
  final String status;
  final String tagLine;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final List listOfVideos;

  Movie(this.adult, this.backdropPath, this.belongsToCollection, this.budget, this.genres,
    this.homepage, this.id, this.imdbID, this.originalLanguage, this.originalTitle, this.overview,
    this.popularity, this.posterPath, this.productionCompanies, this.productionCountries,
    this.releaseDate, this.revenue, this.runtime, this.spokenLanguages, this.status, this.tagLine,
    this.title, this.video, this.voteAverage, this.voteCount, this.listOfVideos
  );

}


