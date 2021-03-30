# React snippets

## Table of contents

**[Functional Component](#Functional-Component)**<br>
**[Functional Component - basic](#Functional-Component---basic)**<br>
**[Class Component](#Class-Component)**<br>
**[Form Component](#Form-Component)**<br>
**[index](#index)**<br>
**[Testing components - shallow](#Testing-components---shallow)**<br>
**[Testing components - mount](#Testing-components---mount)**<br>
**[Emotion styles](#Emotion-styles)**<br>
**[Storybook](#Storybook)**<br>
**[Actions](#Actions)**<br>
**[Sagas](#Sagas)**<br>
**[Testing sagas](#Testing-sagas)**<br>
**[API service](#API-service)**<br>
**[API service - tests](#API-service---tests)**<br>
**[Reducer](#Reducer)**<br>
**[Reducer - tests](#Test-reducer)**<br>
**[selectors](#selectors)**<br>
**[createReducer](#createReducer)**<br>
**[AppState type](#AppState-type)**<br>
**[redux connect](#redux-connect)**<br>


---

## Functional Component

```tsx
// Greet.tsx

/** @jsx jsx */
import React from 'react';
import { jsx } from '@emotion/core';

import { Margins } from 'src/design-system/style-types';

import { style } from './Greet.style';

interface RequiredProps {}

interface DefaultProps {
  marginBottom: Margins;
  className: string;
}

const defaultProps: DefaultProps = {
  marginBottom: '0',
  className: ''
};

export const Greet = (props: RequiredProps & DefaultProps) => {
  const { className } = props;

  return <div className={className} css={style.container(props)}>yo</div>;
};

Greet.defaultProps = defaultProps;

```

---
**[[Top](#React-Snippets)]**<br><br>

## Functional Component - basic

```tsx
// Greet.tsx

/** @jsx jsx */
import React from 'react';
import { jsx } from '@emotion/core';

interface RequiredProps {}

export const Greet = (props: RequiredProps) => {
  return <div>yo</div>;
};
```

---
**[[Top](#React-Snippets)]**<br><br>

## Class Component

```tsx
// Greet.tsx

/** @jsx jsx */
import React from 'react';
import { jsx } from '@emotion/core';

import { Margins } from 'src/design-system/style-types';

import { style } from './Greet.style';

interface RequiredProps {}

interface DefaultProps {
  marginBottom: Margins;
  className: string;
}

interface State {
  showResults: boolean;
}

export class Greet extends React.Component<RequiredProps & DefaultProps, State> {
  state = {
    showResults: false
  };
  
  static defaultProps: DefaultProps = {
    marginBottom: '0',
    className: ''
  };

  render() {
    const { className } = this.props;

    return <div className={className} css={style.container(this.props)}>yo</div>;
  }
}

```

## Form Component

---
**[[Top](#React-Snippets)]**<br><br>


```tsx
/** @jsx jsx */
import React from 'react';
import { jsx } from '@emotion/core';
import { Formik, FormikHelpers } from 'formik';
import { useHistory } from 'react-router';
import * as yup from 'yup';

import Box from 'src/components/Box/Box';
import { Button } from 'src/components/Button/Button';
import Card from 'src/components/Card/Card';
import { InputField } from 'src/components/InputField/InputField';
import { Heading } from 'src/components/Text/Heading';
import { Span } from 'src/components/Text/Span';
import { toastService } from 'src/utils/toastService';

interface RequiredProps {}

interface Fields {
  subdomain: string;
}

const validationSchema = yup.object().shape({
  subdomain: yup.string().required('A subdomain is required'),
});

export const Greet = (props: RequiredProps) => {
  const history = useHistory();

  const handleSubmit = async (values: Fields, actions: FormikHelpers<Fields>) => {
    const { subdomain } = values;

    console.log(subdomain, '<-- subdomain'); // eslint-disable-line

    try {
      toastService.success('Portal settings saved');
    } catch {
      toastService.error('An error occurred while saving the portal settings');
      actions.setSubmitting(false);
    }
  };

  return (
    <div>
      <Box>
        <Box d="column" mb="lg">
          <Heading marginBottom="sm">Configure portal settings</Heading>
          <Span size="sm" color="grey">
            Configure the settings for your company's booking portal (e.g. mybusiness.wheelieportal.com)
          </Span>
        </Box>
      </Box>

      <Card padding={{ xs: 'lg', md: '2xl' }}>
        <Formik<Fields>
          onSubmit={handleSubmit}
          initialValues={{
            subdomain: 'hi',
          }}
          validationSchema={validationSchema}
        >
          {(form) => {
            return (
              <form onSubmit={form.handleSubmit}>
                <Box g="lg" mb="lg">
                  <Box mb="lg">
                    <Box w={{ xs: 1, sm: 1 / 2 }}>
                      <InputField
                        name="subdomain"
                        placeholder="Subdomain"
                        label="Subdomain"
                        onChange={form.handleChange}
                        value={form.values.subdomain}
                        error={form.errors.subdomain}
                        touched={form.touched.subdomain}
                      />
                    </Box>
                  </Box>
                </Box>

                <Box j="flex-end">
                  <Box mr="lg" w="auto">
                    <Button onClick={() => history.push('/admin/dashboard/portal-settings')}>Cancel</Button>
                  </Box>
                  <Box w="auto">
                    <Button
                      loading={form.isSubmitting}
                      type="primary"
                      onClick={() => form.validateForm().then(() => form.submitForm())}
                    >
                      Save portal settings
                    </Button>
                  </Box>
                </Box>
              </form>
            );
          }}
        </Formik>
      </Card>
    </div>
  );
};

export default Greet;
```

**[[Top](#React-Snippets)]**<br><br> 

## index

```ts
export { Greet } from './Greet';
```

---

**[[Top](#React-Snippets)]**<br><br> 


## Testing components - shallow


```tsx
// Greet.test.tsx

import React from 'react';
import { shallow, ShallowWrapper } from 'enzyme';

import { mockDispatchProps, dataQa } from 'src/utils/test-utils';

import { _Greet as Greet, dispatchToProps } from './Greet';

const actions = mockDispatchProps(dispatchToProps);

const props: React.ComponentProps<typeof Greet> = {
  ...actions,
};

const qa = dataQaList(['mainContent']);

describe('Given a Greet component', () => {
  let wrapper: ShallowWrapper<React.ComponentProps<typeof Greet>>;

  describe('When it is rendered', () => {
    beforeEach(() => {
      jest.clearAllMocks();
      
      wrapper = shallow(<Greet {...props} />);
    });

    it('Then ...', () => {
      expect(true).toBe(true);
    });
  });
});


```

---
**[[Top](#React-Snippets)]**<br><br>


## Testing components - mount


```tsx
// Greet.test.tsx

import React from 'react';
import { mount, ReactWrapper } from 'enzyme';

import { dataQaList, mockDispatchProps, TestApp } from 'src/utils/test-utils';

import { _Greet as Greet, dispatchToProps } from './Greet';

const actions = mockDispatchProps(dispatchToProps);

const props: React.ComponentProps<typeof Greet> = {
  ...actions,
};

const qa = dataQaList(['mainContent']);

describe('Given a Greet component', () => {
  let wrapper: ReactWrapper<React.ComponentProps<typeof Greet>>;

  describe('When it is rendered', () => {
    beforeEach(() => {
      jest.clearAllMocks();

      wrapper = mount(
        <TestApp>
          <Greet {...props} />
        </TestApp>
      );
    });

    it('Then ...', () => {
      expect(true).toBe(true);
    });
  });
});




```

---
**[[Top](#React-Snippets)]**<br><br>

## Emotion styles

```ts
// Greet.style.ts

import { css } from '@emotion/core';

import { Theme } from 'src/design-system/theme';

import { Greet } from './Greet';

const container = (props: React.ComponentProps<typeof Greet>) => (theme: Theme) => css`
  background-color: coral;
  margin-bottom: ${theme.margins[props.marginBottom]}px;
`;

export const style = { container };

```

---
**[[Top](#React-Snippets)]**<br><br>

## Storybook

```tsx
// Greet.stories.tsx

import React from 'react';
import { storiesOf } from '@storybook/react';

import { Greet } from './Greet';

storiesOf('Greet', module)
  .addDecorator(story => <div className="center-col width-600">{story()}</div>)
  .add('default', () => {
    return <Greet />;
  })
  .add('interactive', () =>
    React.createElement(() => {
      const [value, setValue] = React.useState('');

      return <Greet />;
    })
  );
```

---
**[[Top](#React-Snippets)]**<br><br>

## Actions

```ts
import { createActionCreator } from 'deox';

import { GetThingsData } from 'src/api_services/apps/types';
import { Params } from 'src/api_services/types';

const PREFIX = '@WEBSITE_CREATION';
const GET_THINGS = `${PREFIX}/GET_THINGS`;
const GET_THINGS_SUCCESS = `${PREFIX}/GET_THINGS_SUCCESS`;
const GET_THINGS_ERROR = `${PREFIX}/GET_THINGS_ERROR`;

export const getThings = {
  request: createActionCreator(GET_THINGS, resolve => ({ orgId, params }: { orgId: string; params: Params }) =>
    resolve({ orgId, params })
  ),
  success: createActionCreator(GET_THINGS_SUCCESS, resolve => (data: GetThingsData) => resolve(data)),
  error: createActionCreator(GET_THINGS_ERROR, resolve => (error: Error) => resolve(error))
};
```

---
**[[Top](#React-Snippets)]**<br><br>

## Sagas

```ts
import { ActionType, getType } from 'deox';
import { call, put, takeEvery } from 'redux-saga/effects';

import * as apiService from 'src/api_services/things/service';

import { getThings } from './actions';

export function* getThingsSaga({ payload }: ActionType<typeof getThings.request>) {
  const {
    params: { userId },
    onSuccess,
    onError,
  } = payload;

  try {
    const res: RestoreDeletedWebsiteRes = yield call(apiService.getThings, payload);
    yield put(restoreDeletedWebsite.success({ data: res }));
    onSuccess && onSuccess();
  } catch (error) {
    yield put(restoreDeletedWebsite.error(error));
    onError && onError();
  }
}

export function* thingsSaga() {
  yield takeEvery(getType(getThings.request), getThingsRequestSaga);
}
```

---
**[[Top](#React-Snippets)]**<br><br>

## Testing sagas

```ts
import axios from 'axios';
import { getType } from 'deox';
import { SagaType, TestApi, testSaga } from 'redux-saga-test-plan';
import { takeLatest } from 'redux-saga/effects';

import * as apiService from 'src/api_services/things/service';
import { REDUCER_META_MOCK } from 'src/mocks/_common/reducer-meta.mock';

import { getThings } from './actions';
import { thingsSaga, getThingsRequestSaga } from './sagas';

jest.mock('axios');

describe('Given getThingsRequestSaga', () => {
  const PAYLOAD = {
    orgId: 'some-id',
    params: {}
  };
  const RESPONSE = {
    meta: REDUCER_META_MOCK,
    items: []
  };
  const ERROR_RESPONSE = { response: { data: { code: 'errorCode' } } } as any;
  const ERORR_MSG = 'some error';
  const ERROR = new Error(ERROR_RESPONSE);
  axios.get = jest.fn().mockResolvedValue(RESPONSE);

  const sagaTest = testSaga(getThingsRequestSaga as SagaType, getThings.request(PAYLOAD));

  beforeEach(() => {
    sagaTest.restart();
  });

  it('dispatches "success" actions correctly', () => {
    sagaTest
      .next()
      .call(apiService.getThings, PAYLOAD)
      .next(RESPONSE)
      .put(getThings.success(RESPONSE))
      .next()
      .finish()
      .isDone();
  });

  it('dispatches "error" actions correctly', () => {
    sagaTest
      .next()
      .throw(ERROR)
      .put(getThings.error(ERROR))
      .next()
      .finish()
      .isDone();
  });
});

describe('Given thingsSaga', () => {
  const sagasTest = thingsSaga();

  it('should take getThings.REQUEST', () => {
    expect(sagasTest.next().value).toStrictEqual(takeLatest(getType(getThings.request), getThingsRequestSaga));
  });
});

```

```ts
import axios from 'axios';
import { SagaType, TestApi, testSaga } from 'redux-saga-test-plan';

import { thingsApi } from 'src/api_services/wordpress/service';
import { thingsMock } from 'src/mocks/wordpress/plugins.mock';

import { thingsActions } from './actions';
import { getThingsRequestSaga } from './saga';

jest.mock('axios');

const appId = 'app-id-1';
const orgId = 'orgId-1';
const websiteId = 'websiteId-1';
const meta = { appId };
const onSuccess = jest.fn();
const onError = jest.fn();
const payload = {
  params: { appId, orgId, websiteId },
  onSuccess,
  onError,
};
const thrownError = new Error('some error');
const error = 'Error: some error';

describe('Given getThingsRequestSaga', () => {
  const response = {
    data: {
      items: thingsMock,
    },
    meta,
  };

  axios.get = jest.fn().mockResolvedValue(response);

  const sagaTest = testSaga(
    getThingsRequestSaga as SagaType,
    thingsActions.getThingsGrouped.request(payload)
  );

  beforeEach(() => {
    sagaTest.restart();
  });

  it('dispatches "success" actions correctly', () => {
    sagaTest
      .next()
      .call(thingsApi.getThings, payload.params)
      .next(response)
      .put(thingsActions.getThingsGrouped.success(response))
      .next()
      .finish()
      .isDone();
  });

  it('dispatches "error" actions correctly', () => {
    sagaTest
      .next()
      .throw(thrownError)
      .put(thingsActions.getThingsGrouped.error({ error, meta }))
      .next()
      .finish()
      .isDone();
  });
});
```

---
**[[Top](#React-Snippets)]**<br><br>

## API service

```ts
import axios from 'axios';

export interface GetThingsResponse {
  meta: ReducerMeta;
  items: Things[];
}


const getThings = async ({ orgId, params }: { orgId: string; params?: Params }): Promise<GetThingsResponse> => {
  const url = `/api/things`;

  const response: { total: number; items: Things[] } = await axios.get(url, {
    params
  });
  const { total, items } = response;

  const output: {
    meta: ReducerMeta;
    items: Things[];
  } = {
    meta: {
      total,
      ...params
    },
    items
  };

  return output;
};

```

---

## API service - tests

```ts
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
**[[Top](#React-Snippets)]**<br><br>

## Reducer

```ts
import { createReducer } from 'deox';

import * as actions from './actions';
import { State } from './types';

export const initialState: State = {
  meta: {
    total: 0,
    offset: 0,
    limit: 0,
    sortBy: '',
    sortOrder: '',
    search: ''
  },
  data: [],
  loading: true,
  error: ''
};

export const thingsReducer = createReducer(initialState, handleAction => [
  handleAction(actions.getThings.request, state => ({
    ...state,
    loading: true
  })),
  handleAction(actions.getThings.success, (state, { payload: { meta, items } }) => ({
    ...state,
    meta: {
      ...state.meta,
      ...meta
    },
    data: items,
    loading: false
  })),
  handleAction(actions.getThings.error, state => ({
    ...state,
    error: 'TBC',
    loading: false
  }))
]);
```

---
**[[Top](#React-Snippets)]**<br><br>

## Test reducer

```ts
describe('getCatsReducer', () => {
  it('catsActions.getCats.request', () => {
    const state = getCatsReducer(
      initialCatsState,
      catsActions.getCats.request({ companyId: '123' } })
    );
    expect(state).toStrictEqual(42);
  });
});
```

---
**[[Top](#React-Snippets)]**<br><br>

## selectors

```ts
import { AppState } from 'src/store';

export const selectCats = (state: AppState) => state.cats.data;
export const selectMeta = (state: AppState) => state.cats.meta;
export const selectLoading = (state: AppState) => state.cats.loading;
export const selectError = (state: AppState) => state.cats.error;
```

---
**[[Top](#React-Snippets)]**<br><br>

## createReducer

```ts
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

---
**[[Top](#React-Snippets)]**<br><br>

## AppState type

```ts
import configureStore from './configureStore';
import rootReducer from './rootReducer';

export type AppState = ReturnType<typeof rootReducer>;
export { configureStore };
```
  
---

**[[Top](#React-Snippets)]**<br><br> 
  
  
## redux connect

```tsx
const stateToProps = (state: AppState) => ({
  cats: catsSelectors.catsState(state),
});

export const dispatchToProps = {
  getCats: catsActions.getCats.request,
};

export const Component =  connect(stateToProps, dispatchToProps)(_Component);
```

---
**[[Top](#React-Snippets)]**<br><br> 



