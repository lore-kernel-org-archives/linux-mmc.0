From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 4/4] mmc: Add SDIO function devicetree
 subnode parsing
Date: Sat, 31 May 2014 21:03:34 +0200
Message-ID: <1401563014-13856-5-git-send-email-hdegoede@redhat.com>
References: <1401563014-13856-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBG6PVCOAKGQEVFY7QZA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1401563014-13856-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

This adds SDIO devicetree subnode parsing to the mmc core. While
SDIO devices are runtime probable they sometimes need nonprobable
additional information on embedded systems, like an additional gpio
interrupt or a clock. This patch makes it possible to supply this
information from the devicetree. SDIO drivers will find a pointer
to the devicenode in their devices of_node pointer.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
[hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org: Updated to parse sdio functions inside slot subnodes]
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/core/bus.c      |  4 ++++
 drivers/mmc/core/core.c     | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.h     |  3 +++
 drivers/mmc/core/sdio_bus.c | 11 +++++++++++
 4 files changed, 56 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 8246448..90b0ce8 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/of.h>
 #include <linux/pm_runtime.h>
 
 #include <linux/mmc/card.h>
@@ -359,6 +360,8 @@ int mmc_add_card(struct mmc_card *card)
 #endif
 	mmc_init_context_info(card->host);
 
+	card->dev.of_node = mmc_of_find_child_device(card->host, 0);
+
 	ret = device_add(&card->dev);
 	if (ret)
 		return ret;
@@ -387,6 +390,7 @@ void mmc_remove_card(struct mmc_card *card)
 				mmc_hostname(card->host), card->rca);
 		}
 		device_del(&card->dev);
+		of_node_put(card->dev.of_node);
 	}
 
 	put_device(&card->dev);
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index acbc3f2..70d9f88 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1201,6 +1201,44 @@ EXPORT_SYMBOL(mmc_of_parse_voltage);
 
 #endif /* CONFIG_OF */
 
+static int mmc_of_get_reg(struct device_node *node)
+{
+	u32 reg;
+	int ret;
+
+	ret = of_property_read_u32(node, "reg", &reg);
+	if (ret < 0)
+		return ret;
+
+	return reg;
+}
+
+struct device_node *mmc_of_find_child_device(struct mmc_host *host,
+		unsigned func_num)
+{
+	struct device_node *parent = host->parent->of_node;
+	struct device_node *node, *slot = NULL;
+
+	if (!parent)
+		return NULL;
+
+	for_each_child_of_node(parent, node) {
+		if (mmc_of_get_reg(node) == host->slotno) {
+			slot = node;
+			break;
+		}
+	}
+	if (!slot)
+		return NULL;
+
+	for_each_child_of_node(slot, node) {
+		if (mmc_of_get_reg(node) == func_num)
+			return node;
+	}
+
+	return NULL;
+}
+
 #ifdef CONFIG_REGULATOR
 
 /**
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 443a584..f712f6e 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -32,6 +32,9 @@ struct mmc_bus_ops {
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
 void mmc_detach_bus(struct mmc_host *host);
 
+struct device_node *mmc_of_find_child_device(struct mmc_host *host,
+		unsigned func_num);
+
 void mmc_init_erase(struct mmc_card *card);
 
 void mmc_set_chip_select(struct mmc_host *host, int mode);
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 92d1ba8..35c23ae 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -21,7 +21,9 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdio_func.h>
+#include <linux/of.h>
 
+#include "core.h"
 #include "sdio_cis.h"
 #include "sdio_bus.h"
 
@@ -314,6 +316,13 @@ static void sdio_acpi_set_handle(struct sdio_func *func)
 static inline void sdio_acpi_set_handle(struct sdio_func *func) {}
 #endif
 
+static void sdio_set_of_node(struct sdio_func *func)
+{
+	struct mmc_host *host = func->card->host;
+
+	func->dev.of_node = mmc_of_find_child_device(host, func->num);
+}
+
 /*
  * Register a new SDIO function with the driver model.
  */
@@ -323,6 +332,7 @@ int sdio_add_func(struct sdio_func *func)
 
 	dev_set_name(&func->dev, "%s:%d", mmc_card_id(func->card), func->num);
 
+	sdio_set_of_node(func);
 	sdio_acpi_set_handle(func);
 	ret = device_add(&func->dev);
 	if (ret == 0) {
@@ -346,6 +356,7 @@ void sdio_remove_func(struct sdio_func *func)
 
 	acpi_dev_pm_detach(&func->dev, false);
 	device_del(&func->dev);
+	of_node_put(func->dev.of_node);
 	put_device(&func->dev);
 }
 
-- 
2.0.0
