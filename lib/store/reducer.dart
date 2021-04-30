import 'package:redux/redux.dart';
import 'package:state/main.dart';
import "./actions.dart";

class AppState {
  final int count;
  final int clickCount;
  final String quote;

  AppState({this.count, this.clickCount, this.quote});

  AppState copyWith({count, clickCount, quote}) {
    return AppState(
        count: count ?? this.count,
        clickCount: clickCount ?? this.clickCount,
        quote: quote ?? this.quote);
  }
}

// reducers:
AppState counterReducer(AppState state, dynamic action) {
  switch (action) {
    case Actions.Increment:
      return state.copyWith(count: state.count + 1);
  }

  return state;
}

AppState updateQuote(AppState state, dynamic action) {
  if (action is UpdateQuoteAction) {
    return state.copyWith(quote: action.quote);
  }

  return state;
}

AppState valueReducer(AppState state, dynamic action) {
  if (action == Actions.Click) {
    return state.copyWith(clickCount: state.clickCount + 1);
  }

  return state;
}

final reducers =
    combineReducers<AppState>([counterReducer, valueReducer, updateQuote]);
