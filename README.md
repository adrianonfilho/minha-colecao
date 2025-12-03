# Minha Coleção (exemplo)

Projeto de exemplo para o trabalho final: app Flutter que permite criar coleções e itens com foto.

Funcionalidades:
- Modularização de código
- Sistema de logs (logger)
- Uso de câmera via image_picker
- Persistência via sqflite (SQLite)
- Temas claro e escuro
- Suporta orientação retrato e paisagem (não travada)

Como rodar:
1. Instale dependências: `flutter pub get`
2. Abra em um emulador/ dispositivo com câmera
3. Rode: `flutter run`

Observações:
- Para alternar tema em tempo real seria necessário state management adicional (Provider / Riverpod / setState lifting).
- Não se esqueça de configurar permissões Android/iOS para câmera e armazenamento.
