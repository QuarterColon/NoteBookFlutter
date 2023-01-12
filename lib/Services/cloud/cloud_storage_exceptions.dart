class CloudStorageExceptions implements Exception{
  const CloudStorageExceptions();
}

class CouldNotGetAllNotesException extends CloudStorageExceptions {}

class CouldNotCreateNoteException extends CloudStorageExceptions {}

class CouldNotUpdateNoteException extends CloudStorageExceptions {}

class CouldNotDeleteNoteException extends CloudStorageExceptions {}

