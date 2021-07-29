AutoComplete TextField Data Flow
1.[GetLocationData] action is dispatched
2.Middleware called and data is fetched from firestore
3.Middleware dispatches [SaveLocationIndex] action and stores values of List 'LocationIndex' 
4.StoreConnector Rebuilds the UI
