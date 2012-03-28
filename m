From: ludovic.desroches@atmel.com
Subject: [PATCH v2 1/3] mmc: atmel-mci: add device tree support
Date: Wed, 28 Mar 2012 12:05:48 +0200
Message-ID: <1332929150-14240-2-git-send-email-ludovic.desroches@atmel.com>
References: <1332929150-14240-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:46161 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab2C1IIU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Mar 2012 04:08:20 -0400
In-Reply-To: <1332929150-14240-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, ludovic.desroches@atmel.com, plagnioj@jcrosoft.com, devicetree-discuss@lists.ozlabs.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 .../devicetree/bindings/mmc/atmel-hsmci.txt        |   67 ++++++++++++++++
 drivers/mmc/host/atmel-mci.c                       |   80 ++++++++++++++++++++
 2 files changed, 147 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/atmel-hsmci.txt

diff --git a/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt b/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
new file mode 100644
index 0000000..bd21e52
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
@@ -0,0 +1,67 @@
+* Atmel High Speed MultiMedia Card Interface
+
+This controller on atmel products provides an interface for MMC, SD and SDIO
+types of memory cards.
+
+1) MCI node
+
+Required properties:
+- compatible: no blank "atmel,hsmci"
+- reg: should contain HSMCI registers location and length
+- interrupts: should contain HSMCI interrupt number
+- #address-cells: should be one. The cell is the slot id.
+- #size-cells: should be zero.
+- at least one slot node
+
+The node contains child nodes for each slot that the platform uses
+
+Example MCI node:
+
+mmc0: mmc@f0008000 {
+	compatible = "atmel,hsmci";
+	reg = <0xf0008000 0x600>;
+	interrupts = <12 4>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	[ child node definitions...]
+};
+
+2) slot nodes
+
+Required properties:
+- reg: should contain the slot id.
+
+Optional properties:
+- bus-width: number of data lines connected to the controller
+- cd-gpios: specify GPIOs for card detection
+- cd-invert: invert the value of external card detect gpio line
+- wp-gpios: specify GPIOs for write protection
+
+Example slot node:
+
+slot@0 {
+	reg = <0>;
+	bus-width = <4>;
+	cd-gpios = <&pioD 15 0>
+	cd-invert;
+};
+
+Example full MCI node:
+mmc0: mmc@f0008000 {
+	compatible = "atmel,hsmci";
+	reg = <0xf0008000 0x600>;
+	interrupts = <12 4>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	slot@0 {
+		reg = <0>;
+		bus-width = <4>;
+		cd-gpios = <&pioD 15 0>
+		cd-invert;
+	};
+	slot@1 {
+		reg = <1>;
+		bus-width = <4>;
+	};
+};
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index b5693fd..b160be6 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -19,6 +19,9 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
 #include <linux/seq_file.h>
@@ -477,6 +480,70 @@ err:
 	dev_err(&mmc->class_dev, "failed to initialize debugfs for slot\n");
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id atmci_dt_ids[] = {
+	{ .compatible = "atmel,hsmci" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, atmci_dt_ids);
+
+static int __devinit atmci_of_init(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *cnp;
+	struct mci_platform_data *pdata;
+	unsigned int slot_id;
+	const __be32 *reg;
+
+	if (!np)
+		return 0;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	for_each_child_of_node(np, cnp) {
+		reg = of_get_property(cnp, "reg", NULL);
+		if (!reg) {
+			dev_warn(&pdev->dev, "reg property is missing for %s\n",
+				 cnp->full_name);
+			continue;
+		}
+
+		slot_id = be32_to_cpu(reg[0]);
+
+		if (slot_id > (ATMCI_MAX_NR_SLOTS-1)) {
+			dev_warn(&pdev->dev, "can't have more than %d slots\n",
+			         ATMCI_MAX_NR_SLOTS);
+			break;
+		}
+
+		if (of_property_read_u32(cnp, "bus-width",
+		                         &pdata->slot[slot_id].bus_width))
+			pdata->slot[slot_id].bus_width = 1;
+
+		pdata->slot[slot_id].detect_pin =
+			of_get_named_gpio(cnp, "cd-gpios", 0);
+
+		if (of_find_property(cnp, "cd-invert", NULL))
+			pdata->slot[slot_id].detect_is_active_high = true;
+
+		pdata->slot[slot_id].wp_pin =
+			of_get_named_gpio(cnp, "wp-gpios", 0);
+	}
+
+	pdev->dev.platform_data = pdata;
+
+	return 0;
+}
+#else /* CONFIG_OF */
+static inline int atmci_of_init(struct platform_device *dev)
+{
+	return 0;
+}
+#endif
+
 static inline unsigned int atmci_ns_to_clocks(struct atmel_mci *host,
 					unsigned int ns)
 {
@@ -1847,6 +1914,13 @@ static int __init atmci_init_slot(struct atmel_mci *host,
 	slot->sdc_reg = sdc_reg;
 	slot->sdio_irq = sdio_irq;
 
+	dev_dbg(&mmc->class_dev,
+	        "slot[%u]: bus_width=%u, detect_pin=%d, "
+		"detect_is_active_high=%s, wp_pin=%d\n",
+		id, slot_data->bus_width, slot_data->detect_pin,
+		slot_data->detect_is_active_high ? "true" : "false",
+		slot_data->wp_pin);
+
 	mmc->ops = &atmci_ops;
 	mmc->f_min = DIV_ROUND_UP(host->bus_hz, 512);
 	mmc->f_max = host->bus_hz / 2;
@@ -2047,6 +2121,11 @@ static int __init atmci_probe(struct platform_device *pdev)
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs)
 		return -ENXIO;
+
+	ret = atmci_of_init(pdev);
+	if (ret)
+		return ret;
+
 	pdata = pdev->dev.platform_data;
 	if (!pdata)
 		return -ENXIO;
@@ -2242,6 +2321,7 @@ static struct platform_driver atmci_driver = {
 	.driver		= {
 		.name		= "atmel_mci",
 		.pm		= ATMCI_PM_OPS,
+		.of_match_table	= of_match_ptr(atmci_dt_ids),
 	},
 };
 
-- 
1.7.5.4

