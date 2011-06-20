From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH 3/4] PCI: make SRIOV resources nice-to-have
Date: Mon, 20 Jun 2011 15:47:16 -0700
Message-ID: <1308610037-6261-4-git-send-email-linuxram@us.ibm.com>
References: <1308610037-6261-1-git-send-email-linuxram@us.ibm.com>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1308610037-6261-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
To: jbarnes@virtuousgeek.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, svenkatr@ti.com, yinghai@kernel.org, cjb@laptop.org, linux-pci@vger.kernel.org, linux-net-drivers@solarflare.com, bhutchings@solarflare.com, Ram Pai <linuxram@us.ibm.com>
List-Id: linux-mmc@vger.kernel.org

From: Yinghai Lu <yinghai@kernel.org>

Allocate resources to SRIOV BARs only after all other genuine resources
requests are satisfied. Dont retry if resource allocation for SRIOV BARs fail.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c282c48..4f8873e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -672,6 +672,16 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			if (r->parent || (r->flags & mask) != type)
 				continue;
 			r_size = resource_size(r);
+#ifdef CONFIG_PCI_IOV
+			/* add SRIOV BARs to nice-to-have list */
+			if (add_head && i >= PCI_IOV_RESOURCES &&
+					i <= PCI_IOV_RESOURCE_END) {
+				r->end = r->start - 1;
+				add_to_list(add_head, dev, r, r_size, 1);
+				children_add_size += r_size;
+				continue;
+			}
+#endif
 			/* For bridges size != alignment */
 			align = pci_resource_alignment(dev, r);
 			order = __ffs(align) - 20;
-- 
1.7.0.4
