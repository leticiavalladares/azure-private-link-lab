data "azurerm_network_watcher" "net_watcher_westeu" {
  name                = "NetworkWatcher_westeurope"
  resource_group_name = "NetworkWatcherRG"
}