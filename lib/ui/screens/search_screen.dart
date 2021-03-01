import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma_flutter/blocs/movie_search_bloc/search_bloc.dart';
import 'package:plasma_flutter/blocs/movie_search_bloc/search_events.dart';
import 'package:plasma_flutter/blocs/movie_search_bloc/search_state.dart';
import 'package:plasma_flutter/constants/app_fonts.dart';
import 'package:plasma_flutter/constants/app_strings.dart';
import 'package:plasma_flutter/models/movie.dart';
import 'package:plasma_flutter/ui/widgets/loading_progress_widget.dart';
import 'package:plasma_flutter/ui/widgets/movie_widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchBloc _searchBloc;
  ScrollController _scrollController = ScrollController();
  List<Movie> _movieList = [];
  String _searchQuery;
  int _page;

  @override
  void initState() {
    _searchBloc = SearchBloc(SearchLoadingState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                maxLines: 1,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  _searchQuery = value;
                  _movieList.clear();
                  _searchBloc.add(
                      SearchMovieEvent(searchQuery: value, page: _page = 1));
                },
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[100],
                  fontFamily: AppFonts.TRUCULENTA,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration.collapsed(
                  hintText: AppStrings.SEARCH_MOVIES_TV_SHOWS,
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              cubit: _searchBloc,
              builder: (context, state) {
                if (state is SearchLoadingState && _page == 1) {
                  return LoadingProgressWidget();
                } else if (state is SearchErrorState && _page == 1) {
                  return Center(
                    child: Text(
                      state.error,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: AppFonts.TRUCULENTA,
                          fontWeight: FontWeight.w700),
                    ),
                  );
                }else if(state is SearchLoadedState){
                  _movieList.addAll(state.pagedMovieResponse.results);
                  _searchBloc.hasNextPage = state.pagedMovieResponse.totalPages > _page;
                }
                return GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 0.55,
                  children: List.generate(_movieList.length,
                      (index) => MovieWidget(_movieList[index])),
                  controller: _scrollController
                    ..addListener(() {
                      if (_scrollController.offset ==
                              _scrollController.position.maxScrollExtent &&
                          !_searchBloc.isDataFetching &&
                          _searchBloc.hasNextPage) {
                        _searchBloc.isDataFetching = true;
                        _searchBloc.add(SearchMovieEvent(
                            searchQuery: _searchQuery, page: ++_page));
                      }
                    }),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
