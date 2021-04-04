package google.cloud;

import js.lib.Promise;
import haxe.extern.Rest;

@:jsRequire('@google-cloud/firestore')
extern class Firestore {
	function new(?opt:{});
	function runTransaction<T>(updateFunction:(transaction:Transaction) -> js.lib.Promise<T>, ?transactionOptions:{ @:optional var maxAttempts : Float; }):js.lib.Promise<T>;
	function batch():WriteBatch;
	function listCollections():Promise<Array<CollectionReference<Any>>>;
	function collection<T>(name:String):CollectionReference<T>;
}
extern class CollectionReference<T> extends Query<T> {
	final id:String;
	final path:String;
	final parent:Null<DocumentReference<Any>>;
	function doc(?name:String):DocumentReference<T>;
	function add(data:T):Promise<DocumentReference<T>>;
	function withConverter<U>(converter:DataConverter<T, U>):CollectionReference<U>;
}
extern class Query<T> {
	function where(path:String, op:String, value:Any):Query<T>;
	function orderBy(field:String, order:String):Query<T>;
	function limit(v:Int):Query<T>;
	function get():Promise<QuerySnapshot<T>>;
	function withConverter<U>(converter:DataConverter<T, U>):Query<U>;
}
extern class DocumentReference<T> {
	final id:String;
	final path:String;
	final parent:CollectionReference<T>;
	function get():Promise<DocumentSnapshot<T>>;
	function update(v:Partial<T>):Promise<WriteResult>;
	function set(v:T):Promise<WriteResult>;
	function delete():Promise<WriteResult>;
	function collection<U>(name:String):CollectionReference<U>;
	function withConverter<U>(converter:DataConverter<T, U>):DocumentReference<U>;
}
extern class DocumentSnapshot<T> {
	final id:String;
	final exists:Bool;
	function data():T;
}
extern class QueryDocumentSnapshot<T> extends DocumentSnapshot<T> {}

extern class QuerySnapshot<T> {
	final empty:Bool;
	final docs:Array<QueryDocumentSnapshot<T>>;
}
extern class WriteResult {
	final writeTime:Timestamp;
}
extern class WriteBatch {
	function create<T>(documentRef:DocumentReference<T>, data:T):WriteBatch;
	function set<T>(documentRef:DocumentReference<T>, data:T, ?options:SetOptions):WriteBatch;
	function update<T>(documentRef:DocumentReference<T>, data:Partial<T>):WriteBatch;
	function delete(documentRef:DocumentReference<Dynamic>):WriteBatch;
	function commit():Promise<Array<WriteResult>>;
}

extern class Transaction {
	overload function get<T>(documentRef:DocumentReference<T>):Promise<DocumentSnapshot<T>>;
	overload function get<T>(query:Query<T>):Promise<QuerySnapshot<T>>;
	function getAll<T>(documentRefs:Rest<DocumentReference<T>>):Promise<Array<DocumentSnapshot<T>>>;
	function create<T>(documentRef:DocumentReference<T>, data:T):Transaction;
	function set<T>(documentRef:DocumentReference<T>, data:T, ?options:SetOptions):Transaction;
	function update<T>(documentRef:DocumentReference<T>, data:Partial<T>):Transaction;
	function delete<T>(documentRef:DocumentReference<T>):Transaction;
}

typedef SetOptions = {
	final ?merge:Bool;
	final ?mergeFields:Array<String>;
}

typedef DataConverter<FirestoreData, AppData> = {
	function toFirestore(modelObject:AppData):FirestoreData;
	function fromFirestore(snapshot:QueryDocumentSnapshot<FirestoreData>):AppData;
}

abstract Timestamp(FirestoreTimestamp) from FirestoreTimestamp to FirestoreTimestamp {
	@:from static inline function fromDate(date:Date):Timestamp
		return FirestoreTimestamp.fromDate(date);
	@:to inline function toDate():Date
		return this.toDate();
}

@:jsRequire('@google-cloud/firestore', 'Timestamp')
private extern class FirestoreTimestamp {
	static function fromDate(date:Date):Timestamp;
	function toDate():Date;
}

typedef Partial<T> = Dynamic;