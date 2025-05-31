import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_gemini_x_flutter/BLoC/chat_list/chat_list_events.dart';
import 'package:magic_gemini_x_flutter/BLoC/chat_list/chat_list_states.dart';
import 'package:magic_gemini_x_flutter/domain/chat_list_repository.dart';

class ChatListBloc extends Bloc<ChatListEvents, ChatListStates> {
  final ChatListRepo chatListRepo;

  ChatListBloc({required this.chatListRepo}) : super(InitChatList()) {
    on<LoadChatList>(_onLoadChatList);
  }

  Future<void> _onLoadChatList(
      LoadChatList event, Emitter<ChatListStates> emit) async {
    emit(ChatListLoading());
    try {
      final result =
          await chatListRepo.loadChatList(event.uid);

      emit(ChatListLoaded(chats: result));
    } catch (error) {
      emit(ChatListError(message: "Error loading chatList: $error"));
    }
  }
}