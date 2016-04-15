import { combineReducers }        from 'redux';
import { routeReducer }           from 'react-router-redux';
import { reducer as formReducer } from 'redux-form';
import product              from './product';
// import registration         from './registration';
// import boards               from './boards';
// import currentBoard         from './current_board';
// import currentCard          from './current_card';
// import header               from './header';


export default combineReducers({
  routing: routeReducer,
  products: product,
  form: formReducer
});
