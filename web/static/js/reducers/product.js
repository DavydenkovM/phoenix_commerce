import Constants from '../constants';

const initialState = {item: undefined, items: []};

const reducer = (state = initialState, action = {}) => {
  switch (action.type) {
    case Constants.FETCH_PRODUCTS:
      // const new_products = action.products.map((p) =>
      //   {...p, price: parseInt(p.price)}
      // );

       return {...state, items: [...state.items, ...action.products]};

    case Constants.FETCH_PRODUCT:
       return {...state, item: [...state.item, ...action.product]};

    default:
      return state;
  }
};

export default reducer;
