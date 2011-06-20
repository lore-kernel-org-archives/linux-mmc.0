From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH 4/4] PCI: make cardbus-bridge resources nice-to-have
Date: Mon, 20 Jun 2011 15:47:17 -0700
Message-ID: <1308610037-6261-5-git-send-email-linuxram@us.ibm.com>
References: <1308610037-6261-1-git-send-email-linuxram@us.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308610037-6261-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jbarnes@virtuousgeek.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, svenkatr@ti.com, yinghai@kernel.org, cjb@laptop.org, linux-pci@vger.kernel.org, linux-net-drivers@solarflare.com, bhutchings@solarflare.com, Ram Pai <linuxram@us.ibm.com>
List-Id: linux-mmc@vger.kernel.org

Allocate resources to cardbus bridge only after all other genuine
resources requests are satisfied. Dont retry if resource allocation
for cardbus-bridge fails.

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 drivers/pci/setup-bus.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4f8873e..023fc9c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -742,7 +742,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	return 1;
 }
 
-static void pci_bus_size_cardbus(struct pci_bus *bus)
+static void pci_bus_size_cardbus(struct pci_bus *bus,
+			struct resource_list_x *add_head)
 {
 	struct pci_dev *bridge = bus->self;
 	struct resource *b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
@@ -753,12 +754,14 @@ static void pci_bus_size_cardbus(struct pci_bus *bus)
 	 * a fixed amount of bus space for CardBus bridges.
 	 */
 	b_res[0].start = 0;
-	b_res[0].end = pci_cardbus_io_size - 1;
+	b_res[0].end = 0;
 	b_res[0].flags |= IORESOURCE_IO | IORESOURCE_SIZEALIGN;
+	add_to_list(add_head, bridge, b_res, pci_cardbus_io_size - 1, 1);
 
 	b_res[1].start = 0;
-	b_res[1].end = pci_cardbus_io_size - 1;
+	b_res[1].end = 0;
 	b_res[1].flags |= IORESOURCE_IO | IORESOURCE_SIZEALIGN;
+	add_to_list(add_head, bridge, b_res+1, pci_cardbus_io_size - 1, 1);
 
 	/*
 	 * Check whether prefetchable memory is supported
@@ -778,16 +781,19 @@ static void pci_bus_size_cardbus(struct pci_bus *bus)
 	 */
 	if (ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM0) {
 		b_res[2].start = 0;
-		b_res[2].end = pci_cardbus_mem_size - 1;
+		b_res[2].end = 0;
 		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH | IORESOURCE_SIZEALIGN;
+		add_to_list(add_head, bridge, b_res+2, pci_cardbus_mem_size - 1, 1);
 
 		b_res[3].start = 0;
-		b_res[3].end = pci_cardbus_mem_size - 1;
+		b_res[3].end = 0;
 		b_res[3].flags |= IORESOURCE_MEM | IORESOURCE_SIZEALIGN;
+		add_to_list(add_head, bridge, b_res+3, pci_cardbus_mem_size - 1, 1);
 	} else {
 		b_res[3].start = 0;
-		b_res[3].end = pci_cardbus_mem_size * 2 - 1;
+		b_res[3].end = 0;
 		b_res[3].flags |= IORESOURCE_MEM | IORESOURCE_SIZEALIGN;
+		add_to_list(add_head, bridge, b_res+3, pci_cardbus_mem_size * 2 - 1, 1);
 	}
 }
 
@@ -805,7 +811,7 @@ void __ref __pci_bus_size_bridges(struct pci_bus *bus,
 
 		switch (dev->class >> 8) {
 		case PCI_CLASS_BRIDGE_CARDBUS:
-			pci_bus_size_cardbus(b);
+			pci_bus_size_cardbus(b, add_head);
 			break;
 
 		case PCI_CLASS_BRIDGE_PCI:
-- 
1.7.0.4
