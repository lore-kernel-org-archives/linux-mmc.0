From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 06/13] mmc: omap_hsmmc: add dt pbias and control mmc support
Date: Tue, 30 Apr 2013 19:33:46 +0530
Message-ID: <1367330633-5941-7-git-send-email-balajitk@ti.com>
References: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com
Cc: Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Add omap_hsmmc_control to support pbias, high speed mode configuration for mmc1,
loopback clock configuration (when external transceiver is used) for mmc2

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/Makefile              |    2 +-
 drivers/mmc/host/omap_hsmmc.c          |   38 +++
 drivers/mmc/host/omap_hsmmc_control.c  |  466 ++++++++++++++++++++++++++++++++
 include/linux/platform_data/mmc-omap.h |   18 ++
 4 files changed, 523 insertions(+), 1 deletions(-)
 create mode 100644 drivers/mmc/host/omap_hsmmc_control.c

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index c380e3c..5512a05 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
 obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
 obj-$(CONFIG_MMC_OMAP)		+= omap.o
-obj-$(CONFIG_MMC_OMAP_HS)	+= omap_hsmmc.o
+obj-$(CONFIG_MMC_OMAP_HS)	+= omap_hsmmc.o omap_hsmmc_control.o
 obj-$(CONFIG_MMC_ATMELMCI)	+= atmel-mci.o
 obj-$(CONFIG_MMC_TIFM_SD)	+= tifm_sd.o
 obj-$(CONFIG_MMC_MSM)		+= msm_sdcc.o
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6616621..217c063 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -182,6 +182,7 @@ struct omap_hsmmc_host {
 	struct omap_hsmmc_next	next_data;
 
 	struct	omap_mmc_platform_data	*pdata;
+	struct omap_hsmmc_control	*ctrl_mmc;
 	int needs_vmmc:1;
 	int needs_vmmc_aux:1;
 };
@@ -265,6 +266,8 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 
 	if (mmc_slot(host).before_set_reg)
 		mmc_slot(host).before_set_reg(dev, slot, power_on, vdd);
+	if (host->ctrl_mmc && host->ctrl_mmc->before)
+		host->ctrl_mmc->before(host->ctrl_mmc->dev, power_on, vdd);
 
 	/*
 	 * Assume Vcc regulator is used only to power the card ... OMAP
@@ -302,6 +305,8 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 
 	if (mmc_slot(host).after_set_reg)
 		mmc_slot(host).after_set_reg(dev, slot, power_on, vdd);
+	if (host->ctrl_mmc && host->ctrl_mmc->after)
+		host->ctrl_mmc->after(host->ctrl_mmc->dev, power_on, vdd);
 
 	return ret;
 }
@@ -1760,6 +1765,33 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 
 	return pdata;
 }
+
+static int omap_hsmmc_get_ctrl_mmc(struct omap_hsmmc_host *host)
+{
+	struct device_node *np = host->dev->of_node;
+	struct device_node *ctrl_np;
+	struct platform_device *ctrl_mmc_pdev;
+	struct omap_hsmmc_control *ctl_mmc;
+
+	ctrl_np = of_parse_phandle(np, "ctrl-module", 0);
+	if (!ctrl_np)
+		return 0;
+
+	ctrl_mmc_pdev = of_find_device_by_node(ctrl_np);
+	if (ctrl_mmc_pdev) {
+		ctl_mmc = platform_get_drvdata(ctrl_mmc_pdev);
+		if (ctl_mmc &&
+		    try_module_get(ctrl_mmc_pdev->dev.driver->owner)) {
+			host->ctrl_mmc = ctl_mmc;
+		} else {
+			dev_err(mmc_dev(host->mmc),
+				"defer probe for omap-hsmmc-control\n");
+			return -EPROBE_DEFER;
+		}
+	}
+
+	return 0;
+}
 #else
 static inline struct omap_mmc_platform_data
 			*of_get_hsmmc_pdata(struct device *dev)
@@ -1834,6 +1866,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->needs_vmmc_aux = pdata->needs_vmmc_aux;
 
 	platform_set_drvdata(pdev, host);
+	ret = omap_hsmmc_get_ctrl_mmc(host);
+	if (ret)
+		goto err_alloc;
 
 	mmc->ops	= &omap_hsmmc_ops;
 
@@ -1956,6 +1991,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (host->ctrl_mmc && host->ctrl_mmc->init)
+		host->ctrl_mmc->init(host->ctrl_mmc->dev);
+
 	if (omap_hsmmc_have_reg() && !mmc_slot(host).set_power) {
 		ret = omap_hsmmc_reg_get(host);
 		if (ret)
diff --git a/drivers/mmc/host/omap_hsmmc_control.c b/drivers/mmc/host/omap_hsmmc_control.c
new file mode 100644
index 0000000..0d0ae4d
--- /dev/null
+++ b/drivers/mmc/host/omap_hsmmc_control.c
@@ -0,0 +1,466 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/mmc/host.h>
+#include <linux/platform_data/mmc-omap.h>
+
+#define DRIVER_NAME		"omap-hsmmc-control"
+/* CONTROL_DEVCONF1 bits */
+#define OMAP243X_MMC1_ACTIVE_OVERWRITE	(1 << 31)
+#define OMAP2_MMCSDIO2ADPCLKISEL	(1 << 6) /* MMC2 loop back clock */
+/* CONTROL_DEVCONF0 bits */
+#define OMAP2_MMCSDIO1ADPCLKISEL	(1 << 24) /* MMC1 loop back clock */
+/* CONTROL_PBIAS_LITE bits */
+#define OMAP2_PBIASSPEEDCTRL0		(1 << 2)
+#define OMAP2_PBIASLITEPWRDNZ0		(1 << 1)
+#define OMAP2_PBIASLITEVMODE0		(1 << 0)
+/* CONTROL_PROG_IO1 bits */
+#define OMAP3630_PRG_SDMMC1_SPEEDCTRL	(1 << 20)
+/* OMAP4: CONTROL_PBIASLITE */
+#define OMAP4_MMC1_PWRDNZ_MASK			(1 << 26)
+#define OMAP4_MMC1_PBIASLITE_HIZ_MODE_MASK	(1 << 25)
+#define OMAP4_MMC1_PBIASLITE_SUPPLY_HI_OUT_MASK	(1 << 24)
+#define OMAP4_MMC1_PBIASLITE_VMODE_ERROR_MASK	(1 << 23)
+#define OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK	(1 << 22)
+#define OMAP4_MMC1_PBIASLITE_VMODE_MASK		(1 << 21)
+/* OMAP4: CONTROL_MMC1 */
+#define OMAP4_SDMMC1_PUSTRENGTH_GRP0_MASK	(1 << 31)
+#define OMAP4_SDMMC1_PUSTRENGTH_GRP1_MASK	(1 << 30)
+#define OMAP4_SDMMC1_PUSTRENGTH_GRP2_MASK	(1 << 29)
+#define OMAP4_SDMMC1_PUSTRENGTH_GRP3_MASK	(1 << 28)
+#define OMAP4_SDMMC1_DR0_SPEEDCTRL_MASK		(1 << 27)
+#define OMAP4_SDMMC1_DR1_SPEEDCTRL_MASK		(1 << 26)
+#define OMAP4_SDMMC1_DR2_SPEEDCTRL_MASK		(1 << 25)
+/* OMAP5: CONTROL_PBIAS */
+#define OMAP5_SDCARD_IO_PWRRDNZ		(1 << 26)
+#define OMAP5_SDCARD_BIAS_PWRDNZ	(1 << 27)
+
+#define CTRL_NONE		0
+#define CTRL_MMC1_2430		1
+#define CTRL_MMC2		2
+#define CTRL_MMC1_3430		3
+#define CTRL_MMC1_3630		4
+#define CTRL_MMC1_4430		5
+#define CTRL_MMC2_4430		6
+#define CTRL_MMC1_5430		7
+
+static void omap_control_mmc_writel(u32 reg, u32 *base2)
+{
+	if (base2)
+		__raw_writel(reg, base2);
+	return;
+}
+
+static u32 omap_control_mmc_readl(u32 *base2)
+{
+	u32 pbias_reg = 0;
+
+	if (base2)
+		pbias_reg = __raw_readl(base2);
+	return pbias_reg;
+}
+
+static void omap2430_mmc1_active_overwrite(u32 __iomem *devconf1, int vdd)
+{
+	u32 reg;
+
+	reg = omap_control_mmc_readl(devconf1);
+	if ((1 << vdd) >= MMC_VDD_30_31)
+		reg |= OMAP243X_MMC1_ACTIVE_OVERWRITE;
+	else
+		reg &= ~OMAP243X_MMC1_ACTIVE_OVERWRITE;
+	omap_control_mmc_writel(reg, devconf1);
+}
+/* pbias configuration for omap2430, omap3 */
+static void omap_hsmmc1_before_set_reg(struct device *dev,
+				  int power_on, int vdd)
+{
+	u32 reg;
+	struct omap_hsmmc_control *ctl_mmc = dev_get_drvdata(dev);
+
+	if (ctl_mmc->devconf1)
+		omap2430_mmc1_active_overwrite(ctl_mmc->devconf1, vdd);
+
+	reg = omap_control_mmc_readl(ctl_mmc->pbias);
+	reg &= ~OMAP2_PBIASLITEPWRDNZ0;
+	omap_control_mmc_writel(reg, ctl_mmc->pbias);
+}
+
+static void omap_hsmmc1_after_set_reg(struct device *dev,
+				 int power_on, int vdd)
+{
+	u32 reg;
+	struct omap_hsmmc_control *ctl_mmc = dev_get_drvdata(dev);
+
+	/* 100ms delay required for PBIAS configuration */
+	msleep(100);
+
+	if (power_on) {
+		reg = omap_control_mmc_readl(ctl_mmc->pbias);
+		reg |= OMAP2_PBIASLITEPWRDNZ0;
+		if ((1 << vdd) <= MMC_VDD_165_195)
+			reg &= ~OMAP2_PBIASLITEVMODE0;
+		else
+			reg |= OMAP2_PBIASLITEVMODE0;
+		omap_control_mmc_writel(reg, ctl_mmc->pbias);
+	} else {
+		reg = omap_control_mmc_readl(ctl_mmc->pbias);
+		reg |= (OMAP2_PBIASLITEPWRDNZ0 |
+			OMAP2_PBIASLITEVMODE0);
+		omap_control_mmc_writel(reg, ctl_mmc->pbias);
+	}
+}
+
+static void omap4_hsmmc1_before_set_reg(struct device *dev,
+				  int power_on, int vdd)
+{
+	u32 reg;
+	struct omap_hsmmc_control *ctl_mmc = dev_get_drvdata(dev);
+
+	reg = omap_control_mmc_readl(ctl_mmc->pbias);
+	reg &= ~(OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
+		OMAP4_MMC1_PWRDNZ_MASK |
+		OMAP4_MMC1_PBIASLITE_VMODE_MASK);
+	omap_control_mmc_writel(reg, ctl_mmc->pbias);
+}
+
+static void omap4_hsmmc1_after_set_reg(struct device *dev,
+				 int power_on, int vdd)
+{
+	u32 reg;
+	unsigned long timeout;
+	struct omap_hsmmc_control *ctl_mmc = dev_get_drvdata(dev);
+
+	if (power_on) {
+		reg = omap_control_mmc_readl(ctl_mmc->pbias);
+		reg |= OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK;
+		if ((1 << vdd) <= MMC_VDD_165_195)
+			reg &= ~OMAP4_MMC1_PBIASLITE_VMODE_MASK;
+		else
+			reg |= OMAP4_MMC1_PBIASLITE_VMODE_MASK;
+		reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
+			OMAP4_MMC1_PWRDNZ_MASK);
+		omap_control_mmc_writel(reg, ctl_mmc->pbias);
+
+		timeout = jiffies + msecs_to_jiffies(5);
+		do {
+			reg = omap_control_mmc_readl(ctl_mmc->pbias);
+			if (!(reg & OMAP4_MMC1_PBIASLITE_VMODE_ERROR_MASK))
+				break;
+			usleep_range(100, 200);
+		} while (!time_after(jiffies, timeout));
+
+		if (reg & OMAP4_MMC1_PBIASLITE_VMODE_ERROR_MASK) {
+			dev_err(dev, "Pbias Voltage is not same as LDO\n");
+			/* Caution : On VMODE_ERROR Power Down MMC IO */
+			reg &= ~(OMAP4_MMC1_PWRDNZ_MASK);
+			omap_control_mmc_writel(reg, ctl_mmc->pbias);
+		}
+	}
+}
+
+/* OMAP5 PBIAS configuration */
+static void omap5_before_set_reg(struct device *dev,
+					int power_on, int vdd)
+{
+	u32 reg;
+	struct omap_hsmmc_control *ctl_mmc = dev_get_drvdata(dev);
+
+	reg = omap_control_mmc_readl(ctl_mmc->pbias);
+	reg &= ~(OMAP5_SDCARD_IO_PWRRDNZ);
+	omap_control_mmc_writel(reg, ctl_mmc->pbias);
+	usleep_range(10, 20);
+	reg &= ~(OMAP5_SDCARD_BIAS_PWRDNZ);
+	omap_control_mmc_writel(reg, ctl_mmc->pbias);
+}
+
+static void omap5_after_set_reg(struct device *dev,
+				 int power_on, int vdd)
+{
+	u32 reg;
+	struct omap_hsmmc_control *ctl_mmc = dev_get_drvdata(dev);
+
+	if (power_on) {
+		reg = omap_control_mmc_readl(ctl_mmc->pbias);
+		reg |= OMAP5_SDCARD_BIAS_PWRDNZ;
+		omap_control_mmc_writel(reg, ctl_mmc->pbias);
+		usleep_range(150, 200);
+		reg |= OMAP5_SDCARD_IO_PWRRDNZ;
+		omap_control_mmc_writel(reg, ctl_mmc->pbias);
+		usleep_range(150, 200);
+	}
+}
+
+static void omap2_mmc1_enable_loopback_clock(struct device *dev)
+{
+	struct omap_hsmmc_control *ctl_mmc = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = omap_control_mmc_readl(ctl_mmc->devconf0);
+	if (ctl_mmc->external_clock)
+		reg &= ~OMAP2_MMCSDIO1ADPCLKISEL;
+	else
+		reg |= OMAP2_MMCSDIO1ADPCLKISEL;
+	omap_control_mmc_writel(reg, ctl_mmc->devconf0);
+}
+
+static void omap2_mmc1_high_speed_enable(u32 __iomem *pbias)
+{
+	u32 reg;
+
+	reg = omap_control_mmc_readl(pbias);
+	reg |= OMAP2_PBIASSPEEDCTRL0;
+	omap_control_mmc_writel(reg, pbias);
+}
+
+static void omap3630_mmc1_high_speed_enable(u32 __iomem *prog_io1)
+{
+	u32 prog_io;
+
+	prog_io = omap_control_mmc_readl(prog_io1);
+	prog_io |= OMAP3630_PRG_SDMMC1_SPEEDCTRL;
+	omap_control_mmc_writel(prog_io, prog_io1);
+}
+
+static void omap2_mmc1_init(struct device *dev)
+{
+	struct omap_hsmmc_control *ctl_mmc = dev_get_drvdata(dev);
+
+	if (ctl_mmc->devconf0)
+		omap2_mmc1_enable_loopback_clock(dev);
+
+	if (ctl_mmc->prog_io1)
+		omap3630_mmc1_high_speed_enable(ctl_mmc->prog_io1);
+	else if (ctl_mmc->pbias)
+		omap2_mmc1_high_speed_enable(ctl_mmc->pbias);
+}
+
+static void omap4_mmc1_init(struct device *dev)
+{
+	struct omap_hsmmc_control *ctl_mmc = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = omap_control_mmc_readl(ctl_mmc->ctrl_mmc1);
+	reg |= (OMAP4_SDMMC1_PUSTRENGTH_GRP0_MASK |
+		OMAP4_SDMMC1_PUSTRENGTH_GRP1_MASK);
+	reg &= ~(OMAP4_SDMMC1_PUSTRENGTH_GRP2_MASK |
+		OMAP4_SDMMC1_PUSTRENGTH_GRP3_MASK);
+	reg |= (OMAP4_SDMMC1_DR0_SPEEDCTRL_MASK |
+		OMAP4_SDMMC1_DR1_SPEEDCTRL_MASK |
+		OMAP4_SDMMC1_DR2_SPEEDCTRL_MASK);
+	omap_control_mmc_writel(reg, ctl_mmc->ctrl_mmc1);
+}
+
+static void omap_mmc2_enable_loopback_clock(struct device *dev)
+{
+	struct omap_hsmmc_control *ctl_mmc = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = omap_control_mmc_readl(ctl_mmc->devconf1);
+	if (ctl_mmc->external_clock)
+		reg &= ~OMAP2_MMCSDIO2ADPCLKISEL;
+	else
+		reg |= OMAP2_MMCSDIO2ADPCLKISEL;
+	omap_control_mmc_writel(reg, ctl_mmc->devconf1);
+}
+
+static inline int has_pbias(int ctrl_type)
+{
+	if ((ctrl_type == CTRL_MMC1_2430) || (ctrl_type == CTRL_MMC1_3430) ||
+	    (ctrl_type == CTRL_MMC1_3630) || (ctrl_type == CTRL_MMC1_4430) ||
+	    (ctrl_type == CTRL_MMC1_5430))
+		return 1;
+
+	return  0;
+}
+
+static inline int has_devconf0(int ctrl_type)
+{
+	if ((ctrl_type == CTRL_MMC1_2430) || (ctrl_type == CTRL_MMC1_3430))
+		return 1;
+
+	return  0;
+}
+
+static inline int has_devconf1(int ctrl_type)
+{
+	if ((ctrl_type == CTRL_MMC1_2430) || (ctrl_type == CTRL_MMC2))
+		return 1;
+
+	return  0;
+}
+
+static inline int has_prog_io1(int ctrl_type)
+{
+	if (ctrl_type == CTRL_MMC1_3630)
+		return 1;
+
+	return  0;
+}
+
+static inline int has_ctrl_mmc1(int ctrl_type)
+{
+	if (ctrl_type == CTRL_MMC1_4430)
+		return 1;
+
+	return  0;
+}
+
+static int omap_hsmmc_control_probe(struct platform_device *pdev)
+{
+	struct resource	*res;
+	struct device_node *np = pdev->dev.of_node;
+	static struct omap_hsmmc_control *control_mmc;
+	int ctrl_type = 0;
+
+	control_mmc = devm_kzalloc(&pdev->dev, sizeof(*control_mmc),
+		GFP_KERNEL);
+	if (!control_mmc) {
+		dev_err(&pdev->dev, "unable to alloc memory for control mmc\n");
+		return -ENOMEM;
+	}
+
+	control_mmc->dev	= &pdev->dev;
+
+	control_mmc->external_clock = of_property_read_bool(np, "external_clk");
+
+	if (of_find_property(np, "ctrl-type", NULL))
+		of_property_read_u32(np, "ctrl-type", &ctrl_type);
+	control_mmc->ctrl_type = ctrl_type;
+
+	if (has_pbias(ctrl_type)) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+			"pbias");
+		if (res)
+			control_mmc->pbias = devm_ioremap(&pdev->dev,
+						res->start, resource_size(res));
+		else
+			dev_err(&pdev->dev, "Failed to get mmc1 pbias resource\n");
+		if (!control_mmc->pbias)
+			dev_err(&pdev->dev, "Failed to get mmc1 pbias memory\n");
+	}
+
+	if (control_mmc->pbias) {
+		switch (ctrl_type) {
+		case CTRL_MMC1_2430:
+		case CTRL_MMC1_3430:
+		case CTRL_MMC1_3630:
+			control_mmc->before = omap_hsmmc1_before_set_reg;
+			control_mmc->after = omap_hsmmc1_after_set_reg;
+			break;
+		case CTRL_MMC1_4430:
+			control_mmc->before = omap4_hsmmc1_before_set_reg;
+			control_mmc->after = omap4_hsmmc1_after_set_reg;
+			break;
+		case CTRL_MMC1_5430:
+			control_mmc->before = omap5_before_set_reg;
+			control_mmc->after = omap5_after_set_reg;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (has_ctrl_mmc1(ctrl_type)) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+			"mmc1");
+		if (res)
+			control_mmc->ctrl_mmc1 = devm_ioremap(&pdev->dev,
+						res->start, resource_size(res));
+		else
+			dev_err(&pdev->dev, "Failed to get mmc1 resource\n");
+		if (!control_mmc->ctrl_mmc1)
+			dev_err(&pdev->dev, "Failed to get mmc1 memory\n");
+	}
+
+	if (has_devconf0(ctrl_type)) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+			"devconf0");
+		if (res)
+			control_mmc->devconf0 = devm_ioremap(&pdev->dev,
+						res->start, resource_size(res));
+		else
+			dev_err(&pdev->dev, "Failed to get devconf0 resource\n");
+		if (!control_mmc->devconf0)
+			dev_err(&pdev->dev, "Failed to get devconf0 memory\n");
+	}
+
+	if (has_devconf1(ctrl_type)) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+			"devconf1");
+		if (res)
+			control_mmc->devconf1 = devm_ioremap(&pdev->dev,
+						res->start, resource_size(res));
+		else
+			dev_err(&pdev->dev, "Failed to get devconf1 resource\n");
+
+		if (!control_mmc->devconf1)
+			dev_err(&pdev->dev, "Failed to get devconf1 memory\n");
+	}
+
+	if (has_prog_io1(ctrl_type)) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+			"prog_io1");
+		if (res)
+			control_mmc->prog_io1 = devm_ioremap(&pdev->dev,
+						res->start, resource_size(res));
+		else
+			dev_err(&pdev->dev, "Failed to get prog io1 resource\n");
+		if (!control_mmc->prog_io1)
+			dev_err(&pdev->dev, "Failed to get prog io1 memory\n");
+	}
+
+	switch (ctrl_type) {
+	case CTRL_MMC2:
+		control_mmc->init = omap_mmc2_enable_loopback_clock;
+		break;
+	case CTRL_MMC1_2430:
+	case CTRL_MMC1_3430:
+	case CTRL_MMC1_3630:
+		control_mmc->init = omap2_mmc1_init;
+		break;
+	case CTRL_MMC1_4430:
+		control_mmc->init = omap4_mmc1_init;
+		break;
+	default:
+		break;
+	}
+	dev_set_drvdata(control_mmc->dev, control_mmc);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id omap_hsmmc_control_id_table[] = {
+	{
+		.compatible = "ti,omap-hsmmc-control",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, omap_hsmmc_control_id_table);
+#endif
+
+static struct platform_driver omap_hsmmc_control_driver = {
+	.probe		= omap_hsmmc_control_probe,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(omap_hsmmc_control_id_table),
+	},
+};
+
+module_platform_driver(omap_hsmmc_control_driver);
+MODULE_ALIAS("platform: DRIVER_NAME");
+MODULE_AUTHOR("Texas Instruments Inc.");
+MODULE_DESCRIPTION("OMAP Control Module MMC Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
index 11583a6..d5195ae 100644
--- a/include/linux/platform_data/mmc-omap.h
+++ b/include/linux/platform_data/mmc-omap.h
@@ -35,6 +35,24 @@ struct omap_mmc_dev_attr {
 	u8 flags;
 };
 
+struct omap_hsmmc_control {
+	struct device *dev;
+
+	u32 __iomem *pbias;
+	u32 __iomem *prog_io1;
+	u32 __iomem *devconf0;
+	u32 __iomem *devconf1;
+	u32 __iomem *ctrl_mmc1;
+
+	unsigned external_clock:1;
+	u32 ctrl_type;
+
+	void (*before)(struct device *dev, int power_on, int vdd);
+	void (*after) (struct device *dev, int power_on, int vdd);
+	void (*init) (struct device *dev);
+	void (*exit) (struct device *dev);
+};
+
 struct omap_mmc_platform_data {
 	/* back-link to device */
 	struct device *dev;
-- 
1.7.5.4

