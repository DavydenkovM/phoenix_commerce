import Constants from '../constants';

const initialState = {form: []};

const reducer = (state = initialState, action = {}) => {
  switch (action.type) {
    case Constants.CREATE_PRODUCT:
      return {...state, 
               form: { 
                 new_product_form: { 
                   ...state.form.new_product_form,
                   _error: action.response
                 }
               }
             };
    default:
      return state;
  }
};

export default reducer;
