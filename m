From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [RFC PATCH 3/7] pinctrl: sh-pfc: r8a7790: Add regulators for SD
 voltage switch
Date: Thu, 30 Apr 2015 13:31:35 +0100
Message-ID: <1430397095.5802.42.camel@xylophone.i.decadent.org.uk>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:45442 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbbD3Mbk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2015 08:31:40 -0400
In-Reply-To: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@lists.codethink.co.uk

Model the choice of 1.8V or 3.3V signalling for each SD interface as a
regulator.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/pinctrl/sh-pfc/Kconfig       |    1 +
 drivers/pinctrl/sh-pfc/core.c        |    2 +-
 drivers/pinctrl/sh-pfc/core.h        |    1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |  189 ++++++++++++++++++++++++++++++++++
 4 files changed, 192 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/Kconfig b/drivers/pinctrl/sh-pfc/Kconfig
index 8c4b3d391823..4b1895a6ac69 100644
--- a/drivers/pinctrl/sh-pfc/Kconfig
+++ b/drivers/pinctrl/sh-pfc/Kconfig
@@ -49,6 +49,7 @@ config PINCTRL_PFC_R8A7790
 	def_bool y
 	depends on ARCH_R8A7790
 	select PINCTRL_SH_PFC
+	select REGULATOR if OF
 
 config PINCTRL_PFC_R8A7791
 	def_bool y
diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 7b2c9495c383..7d51f96afc9a 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -92,7 +92,7 @@ static int sh_pfc_map_resources(struct sh_pfc *pfc,
 	return 0;
 }
 
-static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 reg)
+void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 reg)
 {
 	struct sh_pfc_window *window;
 	phys_addr_t address = reg;
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 6dc8a6fc2746..af355629c5d2 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -57,6 +57,7 @@ int sh_pfc_unregister_gpiochip(struct sh_pfc *pfc);
 int sh_pfc_register_pinctrl(struct sh_pfc *pfc);
 int sh_pfc_unregister_pinctrl(struct sh_pfc *pfc);
 
+void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 address);
 u32 sh_pfc_read_raw_reg(void __iomem *mapped_reg, unsigned int reg_width);
 void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned int reg_width,
 			  u32 data);
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 22a5470889f5..0c9d2c018a10 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -23,6 +23,13 @@
 
 #include <linux/kernel.h>
 #include <linux/platform_data/gpio-rcar.h>
+#ifdef CONFIG_OF
+#include <linux/of.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/string.h>
+#endif
 
 #include "core.h"
 #include "sh_pfc.h"
@@ -5586,8 +5593,190 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	{ },
 };
 
+#ifdef CONFIG_OF
+
+struct r8a7790_sd_regulator_data {
+	struct regulator_desc desc;
+	char name[10];
+	struct regulator_dev *dev;
+	int state;
+};
+
+#define SD_REGULATOR_NAME "regulator-r8a7790-sd"
+
+#define SD_LOW_VOLTAGE	1800000
+#define SD_STD_VOLTAGE	3300000
+
+static int r8a7790_sd_regulator_set_voltage(struct regulator_dev *dev,
+					    int min_uV, int max_uV,
+					    unsigned int *selector)
+{
+	struct r8a7790_sd_regulator_data *drvdata = rdev_get_drvdata(dev);
+	struct sh_pfc *pfc = dev_get_drvdata(dev->dev.parent);
+	void __iomem *mapped_reg;
+	u32 data, mask;
+	int state;
+
+	if (min_uV <= SD_LOW_VOLTAGE && max_uV >= SD_LOW_VOLTAGE)
+		state = 0;
+	else if (min_uV <= SD_STD_VOLTAGE && max_uV >= SD_STD_VOLTAGE)
+		state = 1;
+	else
+		return -EINVAL;
+
+	/* Map IOCTRL6 */
+	mapped_reg = sh_pfc_phys_to_virt(pfc, 0xe606008c);
+
+	spin_lock(&pfc->lock);
+
+	data = sh_pfc_read_raw_reg(mapped_reg, 32);
+
+	/* Set I/O voltage for the 8 pins for this SD interface */
+	mask = 0xff << (24 - drvdata->desc.id * 8);
+	if (state)
+		data |= mask;
+	else
+		data &= ~mask;
+
+	sh_pfc_write_raw_reg(
+		sh_pfc_phys_to_virt(pfc, pfc->info->unlock_reg), 32,
+		~data);
+	sh_pfc_write_raw_reg(mapped_reg, 32, data);
+
+	spin_unlock(&pfc->lock);
+
+	drvdata->state = state;
+	if (selector)
+		*selector = state;
+
+	return 0;
+}
+
+static int r8a7790_sd_regulator_list_voltage(struct regulator_dev *dev,
+				       unsigned int selector)
+{
+	switch (selector) {
+	case 0:
+		return SD_LOW_VOLTAGE;
+	case 1:
+		return SD_STD_VOLTAGE;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int r8a7790_sd_regulator_get_voltage(struct regulator_dev *dev)
+{
+	struct r8a7790_sd_regulator_data *drvdata = rdev_get_drvdata(dev);
+
+	return r8a7790_sd_regulator_list_voltage(dev, drvdata->state);
+}
+
+static const struct regulator_ops r8a7790_sd_regulator_ops = {
+	.set_voltage = r8a7790_sd_regulator_set_voltage,
+	.get_voltage = r8a7790_sd_regulator_get_voltage,
+	.list_voltage = r8a7790_sd_regulator_list_voltage,
+};
+
+static const struct regulator_init_data r8a7790_sd_regulator_init = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+		.min_uV = SD_LOW_VOLTAGE,
+		.max_uV = SD_STD_VOLTAGE,
+	},
+};
+
+static int r8a7790_sd_regulator_probe(struct sh_pfc *pfc, int index)
+{
+	char child_name[20];
+	struct device_node *np;
+	struct r8a7790_sd_regulator_data *drvdata;
+	struct regulator_config cfg = { };
+	void __iomem *mapped_reg;
+	int ret;
+
+	snprintf(child_name, sizeof(child_name), "sd-regulator@%d", index);
+	np = NULL;
+	while ((np = of_get_next_available_child(pfc->dev->of_node, np))) {
+		if (!strcmp(kbasename(np->full_name), child_name))
+			break;
+	}
+	if (!np) {
+		dev_dbg(pfc->dev, "no %s child node found\n", child_name);
+		return -ENODEV;
+	}
+
+	drvdata = devm_kzalloc(pfc->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	drvdata->desc.owner = THIS_MODULE;
+	/* XXX drvdata->desc.enable_time = ???; */
+	drvdata->desc.id = index;
+	drvdata->desc.type = REGULATOR_VOLTAGE;
+	drvdata->desc.ops = &r8a7790_sd_regulator_ops;
+	drvdata->desc.n_voltages = 2;
+
+	snprintf(drvdata->name, sizeof(drvdata->name), "sd%d-vccq", index);
+	drvdata->desc.name = drvdata->name;
+
+	/* Read initial state from IOCTRL6 */
+	mapped_reg = sh_pfc_phys_to_virt(pfc, 0xe606008c);
+	switch ((sh_pfc_read_raw_reg(mapped_reg, 32) >> (24 - index * 8)) &
+		0xff) {
+	case 0:		/* low = 1.8V */
+		drvdata->state = 0;
+		break;
+	case 0xff:	/* standard = 3.3V */
+		drvdata->state = 1;
+		break;
+	default:	/* mixed?! */
+		drvdata->state = -1;
+		break;
+	}
+
+	cfg.dev = pfc->dev;
+	cfg.of_node = np;
+	cfg.driver_data = drvdata;
+	cfg.init_data = &r8a7790_sd_regulator_init;
+
+	drvdata->dev = devm_regulator_register(pfc->dev, &drvdata->desc, &cfg);
+	if (IS_ERR(drvdata->dev)) {
+		ret = PTR_ERR(drvdata->dev);
+		dev_err(pfc->dev, "Failed to register regulator: %d\n", ret);
+	}
+
+out:
+	of_node_put(np);
+	return ret;
+}
+
+static int r8a7790_pinmux_soc_init(struct sh_pfc *pfc)
+{
+	int i, ret;
+
+	for (i = 0; i < 4; ++i) {
+		ret = r8a7790_sd_regulator_probe(pfc, i);
+		if (ret && ret != -ENODEV)
+			return ret;
+	}
+
+	return 0;
+}
+
+#endif /* CONFIG_OF */
+
+static const struct sh_pfc_soc_operations pinmux_ops = {
+#ifdef CONFIG_OF
+	.init = r8a7790_pinmux_soc_init,
+#endif
+};
+
 const struct sh_pfc_soc_info r8a7790_pinmux_info = {
 	.name = "r8a77900_pfc",
+	.ops = &pinmux_ops,
+
 	.unlock_reg = 0xe6060000, /* PMMR */
 
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
-- 
1.7.10.4




