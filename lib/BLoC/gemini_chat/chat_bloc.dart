import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_gemini_x_flutter/BLoC/gemini_chat/chat_events.dart';
import 'package:magic_gemini_x_flutter/BLoC/gemini_chat/chat_states.dart';
import 'package:magic_gemini_x_flutter/domain/chat_list_repository.dart';
import 'package:magic_gemini_x_flutter/domain/gemini_chat_repository.dart';

class ChatBloc extends Bloc<ChatEvents, ChatStates> {
  final ChatListRepo chatListRepo;

  ChatBloc({required this.chatListRepo}) : super(InitChat()) {
    on<LoadChats>(_onLoadChats);
  }

  Future<void> _onLoadChats(
      LoadChats event, Emitter<ChatStates> emit) async {
    emit(ChatLoading());
    try {
      final result =
          await chatListRepo.loadChats(event.uid, event.chatId);

      emit(ChatLoaded(contents: result!));
    } catch (error) {
      emit(ChatError(message: "Error loading chat: $error"));
    }
  }
}


class AskGeminiBloc extends Bloc<AskGemini, AskToGeminiStates> {
  final GeminiChatRepo geminiChatRepo;

  AskGeminiBloc({required this.geminiChatRepo}) : super(InitAsking()) {
    on<AskGemini>(_onAskGemini);
  }

  Future<void> _onAskGemini(
      AskGemini event, Emitter<AskToGeminiStates> emit) async {
    emit(GeminiThinking());
    try {
      final result =
          await geminiChatRepo.requestToGemini(event.text ,event.uid, event.chatId);

      emit(SavedChat(chatID: result));
    } catch (error) {
      emit(AskingGeminiError(message: "Error asking Gemini: $error"));
    }
  }
}