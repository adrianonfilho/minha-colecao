# Árvore de widgets (exibição simplificada)

MyApp
 └─ ValueListenableBuilder<ThemeMode> (ThemeService)
    └─ MaterialApp
       ├─ theme: AppTheme.light
       ├─ darkTheme: AppTheme.dark
       └─ home: HomePage

HomePage
 ├─ AppBar
 ├─ Drawer
 │   ├─ DrawerHeader
 │   ├─ ListTile (Coleções) -> Navigator.push -> CollectionsPage
 │   └─ ListTile (Configurações) -> Navigator.push -> SettingsPage
 └─ Body
    └─ Center
       └─ ElevatedButton.icon -> Navigator.push -> CollectionsPage

CollectionsPage
 ├─ AppBar
 ├─ ListView
 │  └─ CollectionCard (Card -> ListTile)
 │     ├─ onTap -> Navigator.push -> ItemsPage(collection)
 │     └─ trailing IconButton (delete)
 └─ FloatingActionButton -> Navigator.push -> CollectionFormPage

CollectionFormPage
 ├─ AppBar
 └─ Form
    ├─ TextFormField (Nome)
    └─ ElevatedButton (Salvar)

ItemsPage
 ├─ AppBar (title: Itens: {collection.name})
 ├─ RefreshIndicator
 │  └─ ListView
 │     ├─ (if empty) Center -> Text('Nenhum item...')
 │     └─ ItemCard (Card -> ListTile)
 │        ├─ onTap -> Navigator.push -> ItemDetailPage(item, collection)
 │        ├─ leading: Image.file(...) | Icon
 │        ├─ title: Text(item.title)
 │        ├─ subtitle: Text(item.description)
 │        └─ trailing: Row[IconButton(edit) -> ItemFormPage(edit), IconButton(delete)]
 └─ FloatingActionButton -> Navigator.push -> ItemFormPage(collection, createdAt)

ItemFormPage (create/edit)
 ├─ AppBar ("Novo Item" | "Editar Item")
 └─ Form (ListView)
    ├─ TextFormField (Título)
    ├─ TextFormField (Descrição)
    ├─ Image preview (if _imagePath != null)
    ├─ Row Buttons
    │  ├─ ElevatedButton.icon (Tirar Foto) -> ImagePicker.camera
    │  ├─ ElevatedButton.icon (Galeria) -> ImagePicker.gallery
    │  └─ TextButton (Remover)
    └─ ElevatedButton (Salvar) -> insert or update via ItemRepository

ItemDetailPage
 ├─ AppBar (title: item.title)
 │  ├─ IconButton(edit) -> Navigator.push -> ItemFormPage(edit) [if collection provided]
 │  └─ IconButton(delete) -> confirm -> repo.delete -> Navigator.pop(true)
 └─ Body (ListView)
    ├─ Image.file(...) (large preview)
    ├─ Text(item.title) (titleLarge)
    ├─ Text(item.description) (bodyMedium)
    └─ Text('Criado em: ...') (bodySmall)

SettingsPage
 ├─ AppBar
 └─ ListView
    ├─ Section title
    ├─ RadioListTile (Usar tema do sistema) -> ThemeService.setThemeMode(ThemeMode.system)
    ├─ RadioListTile (Claro) -> ThemeService.setThemeMode(ThemeMode.light)
    ├─ RadioListTile (Escuro) -> ThemeService.setThemeMode(ThemeMode.dark)
    └─ ListTile (Sobre)

Notas rápidas
 - ThemeService: controla `ValueNotifier<ThemeMode>` e persiste em SharedPreferences; iniciado em `main.dart`.
 - DBHelper inicializa `sqflite_common_ffi` em plataformas desktop (Windows/Linux/macOS) para habilitar `openDatabase`.
 - ItemRepository: `insert`, `getByCollection`, `update`, `delete`.
