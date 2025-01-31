//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <gal/gal_plugin_c_api.h>
#include <objectbox_flutter_libs/objectbox_flutter_libs_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  GalPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("GalPluginCApi"));
  ObjectboxFlutterLibsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ObjectboxFlutterLibsPlugin"));
}
