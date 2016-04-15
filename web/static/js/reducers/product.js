import Constants from '../constants';

const initialState = {items: []};

const reducer = (state = initialState, action = {}) => {
  switch (action.type) {
    case Constants.FETCH_PRODUCTS:
      // const new_products = action.products.map((p) =>
      //   {...p, price: parseInt(p.price)}
      // );

       return {...state, items: [...state.items, ...action.products]};

    default:
      return state;
  }
};

export default reducer;
