package google.cloud;

import js.lib.Promise;

@:jsRequire('@google-cloud/firestore')
extern class Firestore {
	function new(?opt:{});
	function listCollections():Promise<Array<CollectionReference<Any>>>;
	function collection<T>(name:String):CollectionReference<T>;
}
extern class CollectionReference<T> extends Query<T> {
	var id(default, never):String;
	function doc(?name:String):DocumentReference<T>;
}
extern class Query<T> {
	function where(path:String, op:String, value:Any):Query<T>;
	function orderBy(field:String, order:String):Query<T>;
	function limit(v:Int):Query<T>;
	function get():Promise<QuerySnapshot<T>>;
}
extern class DocumentReference<T> {
	var id(default, never):String;
	function get():Promise<DocumentSnapshot<T>>;
	function update(v:Dynamic):Promise<WriteResult>;
	function set(v:T):Promise<WriteResult>;
	function delete():Promise<WriteResult>;
}
extern class DocumentSnapshot<T> {
	var id(default, never):String;
	var exists(default, never):Bool;
	function data():T;
}
extern class QueryDocumentSnapshot<T> extends DocumentSnapshot<T> {}

extern class QuerySnapshot<T> {
	final docs:Array<QueryDocumentSnapshot<T>>;
}
extern class WriteResult {}

@:jsRequire('@google-cloud/firestore', 'Timestamp')
extern class Timestamp {
	static function fromDate(date:Date):Timestamp;
	function toDate():Date;
}