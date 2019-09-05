# React snippets

## Functional Component

```
/** @jsx jsx */
import * as React from 'react';
import { jsx } from '@emotion/core';

import style from './Greet.style';

export interface RequiredProps {
  age: number;
}

export interface DefaultProps {
  who: string;
}

const defaultProps: DefaultProps = {
  who: 'Johny Five'
};

const Greet = ({ age, who }: RequiredProps & DefaultProps) => (
  <p css={style.container(props)}>
    {who} ... {age}
  </p>
);

Greet.defaultProps = defaultProps;

export default Greet;
```

## Class Component

```
/** @jsx jsx */
import * as React from 'react';
import { jsx } from '@emotion/core';

import style from './Greet.style';

export interface RequiredProps {
  age: number;
}

export interface DefaultProps {
  who: string;
}

class Greet extends React.Component<RequiredProps & DefaultProps> {
  static defaultProps: DefaultProps = {
    who: 'Johny Five'
  };

  render() {
    const { age, who } = this.props;

    return (
      <p css={style.container(props)}>
        {who} ... {age}
      </p>
    );
  }
}

export default Greet;
```


## Emotion styles
```
// Greet.style.ts

import { css } from '@emotion/core';

import { Theme } from 'src/design-system/theme';

import { DefaultProps, RequiredProps } from './Greet';

export const container = (props: DefaultProps & RequiredProps) => (theme: Theme) => css``;

export default { container };

```


## Sagas

```js
import { Action } from 'redux-actions';
import { call, put, takeLatest } from 'redux-saga/effects';

import * as someService from '../../../../../api_services/some/service';
import { getSomething } from './actions';

export function* getSomethingRequestSaga({ payload }: Action<string>) {
  try {
    const res = yield call(someService.getSomething, payload);

    yield put(getSomething.success(res.data));
  } catch (error) {
    yield put(getSomething.failure(error));
  } finally {
    yield put(getSomething.fulfill());
  }
}

export default function* sagas() {
  yield takeLatest(getSomething.REQUEST, getSomethingRequestSaga);
}

```

## Testing sagas

```js
import axios from 'axios';
import { TestApi, testSaga } from 'redux-saga-test-plan';
import { takeLatest } from 'redux-saga/effects';

import * as someService from '../../../../../api_services/some/service';
import { getSomething } from './actions';
import sagas, { getSomethingRequestSaga } from './sagas';

describe('Given getSomethingRequestSaga', () => {
  const ID = 'some-id';

  const RESPONSE = {
    data: 33
  };
  const ERROR = new Error('some error');

  axios.get = jest.fn().mockResolvedValue(RESPONSE);

  let saga: TestApi;

  beforeEach(() => {
    saga = testSaga(getSomethingRequestSaga, getSomething.request(ID));
  });

  it('dispatches "success" then "fulfill" actions correctly', () => {
    saga
      .next()
      .call(someService.getStuff, ID)

      .next(RESPONSE)
      .put(getSomething.success(RESPONSE.data))
      .next()
      .put(getSomething.fulfill())
      .next()
      .isDone();
  });

  it('dispatches "failure" then "fulfill" actions correctly', () => {
    saga
      .next()
      .throw(ERROR)
      .put(getSomething.failure(ERROR))
      .next()
      .put(getSomething.fulfill())
      .next()
      .isDone();
  });
});

describe('Given sagas', () => {
  const sagasTest = sagas();

  it('should take getSomething.REQUEST', () => {
    expect(sagasTest.next().value).toStrictEqual(takeLatest(getSomething.REQUEST, getSomethingRequestSaga));
  });
});

```

---

## Api service
```js
import axios from 'axios';

export const getStuff = (id: string) => {
  const url = `/api/things/${id}/stuff`;

  return axios.get(url);
};

```

## Test API service

```js
import axios from 'axios';

import * as service from './service';

const AXIOS_GET_MOCK = jest.fn();
axios.get = AXIOS_GET_MOCK;
const ID = 'some-id';

describe('Given a stuff api service', () => {
  beforeEach(() => {
    jest.resetAllMocks();
  });

  describe('getStuff', () => {
    const url = `/api/things/${ID}/stuff`;

    beforeEach(() => {
      service.getStuff(ID);
    });

    it('should call axios.get with the correct url', () => {
      expect(AXIOS_GET_MOCK).toHaveBeenCalledWith(url);
    });
  });
});

```

---

## Reducer

```js
import { createReducer } from './createReducer';
import { Stuff } from 'utils/types';

import { getStuff } from './actions';

export interface State {
  stuff: {
    data: Stuff[];
    loading: boolean;
    error: string;
  };
}

const initialState: State = {
  stuff: {
    data: [],
    loading: false,
    error: ''
  }
};

const getStuffRequest = (state: State): State => ({
  ...state,
  stuff: {
    ...state.stuff,
    loading: true
  }
});

const getStuffSuccess = (state: State, { payload }: { payload: Stuff[] }): State => ({
  ...state,
  stuff: {
    ...state.stuff,
    data: payload
  }
});

const getStuffFailure = (state: State): State => ({
  stuff: {
    ...state.stuff,
    error: 'TBC'
  }
});

const getStuffFullfill = (state: State): State => ({
  ...state,
  stuff: {
    ...state.stuff,
    loading: false
  }
});

const someReducer = createReducer(
  initialState,
  {
    [getStuff.REQUEST]: getStuffRequest,
    [getStuff.SUCCESS]: getStuffSuccess,
    [getStuff.FAILURE]: getStuffFailure,
    [getStuff.FULFILL]: getStuffFullfill
  }
);

export default someReducer;

```

## Test reducer

```js
import * as actions from './actions';
import reducer, { State } from './reducer';

const defaultState = {
  stuff: {
    data: [],
    loading: false,
    error: ''
  }
};

describe('Given a reducer', () => {
  describe('when it is initiated', () => {
    let state: State;

    beforeEach(() => {
      state = reducer(undefined, { type: 'FAKE_ACTION', payload: [] });
    });

    it('should return the default state', () => {
      expect(state).toStrictEqual(defaultState);
    });

    describe('and getStuff.REQUEST action is received', () => {
      beforeEach(() => {
        state = reducer(state, actions.getStuff.request());
      });

      it('should return the correct state', () => {
        expect(state).toStrictEqual({
          ...state,
          stuff: {
            ...state.stuff,
            loading: true
          }
        });
      });
    });

    describe('and getStuff.SUCCESS action is received', () => {
      const mockSubs = ['some', 'subs'];
      beforeEach(() => {
        state = reducer(state, actions.getStuff.success(mockSubs));
      });

      it('should return the correct state', () => {
        expect(state).toStrictEqual({
          ...state,
          stuff: {
            ...state.stuff,
            data: mockSubs
          }
        });
      });
    });

    describe('and getStuff.FAILURE action is received', () => {
      beforeEach(() => {
        state = reducer(state, actions.getStuff.failure());
      });

      it('should return the correct state', () => {
        expect(state).toStrictEqual({
          ...state,
          stuff: {
            ...state.stuff,
            error: 'TBC'
          }
        });
      });
    });

    describe('and getStuff.FULLFILL action is received', () => {
      beforeEach(() => {
        state = reducer(state, actions.getStuff.fulfill());
      });

      it('should return the correct state', () => {
        expect(state).toStrictEqual({
          ...state,
          stuff: {
            ...state.stuff,
            loading: false
          }
        });
      });
    });
  });
});
```


## createReducer

```js
export type GenericAction = { type: string; payload: any };

export const createReducer = <State>(
  initialState: State,
  handlers: Record<string, (state: State, action: GenericAction) => State>
) => {
  return function reducer(state = initialState, action: GenericAction) {
    return (handlers[action.type] && handlers[action.type](state, action)) || state;
  };
};
```


