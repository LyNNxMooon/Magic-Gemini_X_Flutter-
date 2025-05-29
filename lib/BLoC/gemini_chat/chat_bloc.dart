import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_gemini_x_flutter/BLoC/gemini_chat/chat_events.dart';
import 'package:magic_gemini_x_flutter/BLoC/gemini_chat/chat_states.dart';
import 'package:magic_gemini_x_flutter/domain/gemini_chat_repository.dart';

class ChatBloc extends Bloc<ChatEvents, ChatStates> {
  final GeminiChatRepo geminiChatRepo;

  ChatBloc({required this.geminiChatRepo}) : super(InitChat()) {
    on<AskGemini>(_onAskGemini);
  }

  Future<void> _onAskGemini(
      AskGemini event, Emitter<ChatStates> emit) async {
    emit(ChatLoading());
    try {
      final result =
          await geminiChatRepo.requestToGemini(event.text, event.uid);

      emit(ChatLoaded(contents: result));
    } catch (error) {
      emit(ChatError(message: "Error asking Gemini: $error"));
    }
  }
}