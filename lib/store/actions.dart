// Sync Action
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:state/store/reducer.dart';

class UpdateQuoteAction {
  String _quote;

  String get quote => this._quote;

  UpdateQuoteAction(this._quote);
}

ThunkAction<AppState> getRandomQuote = (Store<AppState> store) async {

  store.dispatch(new UpdateQuoteAction("updated quote"));
};
