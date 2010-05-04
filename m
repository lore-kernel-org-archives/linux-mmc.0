From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH] MMC: add support for the Marvell platform SDHCI controller
Date: Tue,  4 May 2010 19:24:43 +0300
Message-ID: <1272990283-18699-1-git-send-email-saeed@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:43308 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab0EDQYx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 May 2010 12:24:53 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: saeed.bishara@gmail.com, Saeed Bishara <saeed@marvell.com>

This patch implements the driver for the platfrom SDHCI controllers that found on some of Marvell's SoC's.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/mmc/host/sdhci-mv.c |  266 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 266 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-mv.c

diff --git a/drivers/mmc/host/sdhci-mv.c b/drivers/mmc/host/sdhci-mv.c
new file mode 100644
index 0000000..a88cae1
--- /dev/null
+++ b/drivers/mmc/host/sdhci-mv.c
@@ -0,0 +1,266 @@
+/*
+ * sdhci-mv.c Support for SDHCI platform devices
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/* Supports:
+ * SDHCI platform devices found on Marvell SoC's
+ *
+ * Based on  sdhci-pltfm.c
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/mmc/host.h>
+#include "sdhci.h"
+
+struct sdhci_mv_host {
+#if defined(CONFIG_HAVE_CLK)
+	struct clk		*clk;
+#endif
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * SDHCI core callbacks                                                      *
+ *                                                                           *
+\*****************************************************************************/
+static u16 mv_readw(struct sdhci_host *host, int reg)
+{
+	u16 ret;
+
+	switch (reg) {
+	case SDHCI_HOST_VERSION:
+	case SDHCI_SLOT_INT_STATUS:
+		/* those registers don't exist */
+		return 0;
+	default:
+		ret = readw(host->ioaddr + reg);
+	}
+	return ret;
+}
+
+static u32 mv_readl(struct sdhci_host *host, int reg)
+{
+	u32 ret;
+
+	switch (reg) {
+	case SDHCI_BUFFER:
+		/*
+		 * This register can't be accessed with 32 bit access, solve
+		 * this issue by breaking it into two 16 bit accesses.
+		 */
+		ret = readw(host->ioaddr + SDHCI_BUFFER);
+		ret |= readw(host->ioaddr + SDHCI_BUFFER + 2) << 16;
+		break;
+	default:
+		ret = readl(host->ioaddr + reg);
+	}
+	return ret;
+}
+
+static void mv_writel(struct sdhci_host *host, u32 val, int reg)
+{
+	switch (reg) {
+	case SDHCI_BUFFER:
+	{
+		/*
+		 * This register can't be accessed with 32 bit access, solve
+		 * this issue by breaking it into two 16 bit accesses.
+		 */
+		u16 temp = reg & 0xFFFF;
+		writew(temp, host->ioaddr + SDHCI_BUFFER);
+		temp = (0xFFFF0000 & reg) >> 16;
+		writew(temp, host->ioaddr + SDHCI_BUFFER + 2);
+	}
+	break;
+	default:
+		writel(val, host->ioaddr + reg);
+	}
+}
+
+static struct sdhci_ops sdhci_mv_ops = {
+	.read_w = mv_readw,
+	.read_l = mv_readl,
+	.write_l = mv_writel,
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * Device probing/removal                                                    *
+ *                                                                           *
+\*****************************************************************************/
+
+static int __devinit sdhci_mv_probe(struct platform_device *pdev)
+{
+	struct sdhci_host *host;
+	struct sdhci_mv_host *mv_host;
+	struct resource *iomem;
+	int ret;
+
+	BUG_ON(pdev == NULL);
+
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iomem) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	if (resource_size(iomem) != 0x100)
+		dev_err(&pdev->dev, "Invalid iomem size. You may "
+			"experience problems.\n");
+
+	if (pdev->dev.parent)
+		host = sdhci_alloc_host(pdev->dev.parent, sizeof(*mv_host));
+	else
+		host = sdhci_alloc_host(&pdev->dev, sizeof(*mv_host));
+
+	if (IS_ERR(host)) {
+		ret = PTR_ERR(host);
+		goto err;
+	}
+
+	mv_host = sdhci_priv(host);
+	host->hw_name = "marvell-sdhci";
+	host->ops = &sdhci_mv_ops;
+	host->irq = platform_get_irq(pdev, 0);
+	host->quirks =  SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER |
+			SDHCI_QUIRK_NO_BUSY_IRQ |
+			SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+
+	if (!devm_request_mem_region(&pdev->dev, iomem->start,
+				     resource_size(iomem),
+				     mmc_hostname(host->mmc))) {
+		dev_err(&pdev->dev, "cannot request region\n");
+		ret = -EBUSY;
+		goto err_request;
+	}
+
+	host->ioaddr = devm_ioremap(&pdev->dev, iomem->start,
+				    resource_size(iomem));
+	if (!host->ioaddr) {
+		dev_err(&pdev->dev, "failed to remap registers\n");
+		ret = -ENOMEM;
+		goto err_request;
+	}
+
+#if defined(CONFIG_HAVE_CLK)
+	mv_host->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(mv_host->clk))
+		dev_notice(&pdev->dev, "cannot get clkdev\n");
+	else
+		clk_enable(mv_host->clk);
+#endif
+
+	ret = sdhci_add_host(host);
+	if (ret)
+		goto err_request;
+
+	platform_set_drvdata(pdev, host);
+
+	return 0;
+
+err_request:
+	sdhci_free_host(host);
+err:
+	printk(KERN_ERR"Probing of sdhci-mv failed: %d\n", ret);
+	return ret;
+}
+
+static int __devexit sdhci_mv_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+#if defined(CONFIG_HAVE_CLK)
+	struct sdhci_mv_host *mv_host = sdhci_priv(host);
+	struct clk *clk = mv_host->clk;
+#endif
+	int dead;
+	u32 scratch;
+
+	dead = 0;
+	scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
+	if (scratch == (u32)-1)
+		dead = 1;
+
+	sdhci_remove_host(host, dead);
+	sdhci_free_host(host);
+	platform_set_drvdata(pdev, NULL);
+#if defined(CONFIG_HAVE_CLK)
+	if (!IS_ERR(clk)) {
+		clk_disable(clk);
+		clk_put(clk);
+	}
+#endif
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int sdhci_mv_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct sdhci_host *host = dev_get_drvdata(&pdev->dev);
+
+	return sdhci_suspend_host(host, state);
+}
+
+static int sdhci_mv_resume(struct platform_device *pdev)
+{
+	struct sdhci_host *host = dev_get_drvdata(&pdev->dev);
+
+	return sdhci_resume_host(host);
+}
+#else
+#define sdhci_mv_suspend NULL
+#define sdhci_mv_resume NULL
+#endif
+
+static struct platform_driver sdhci_mv_driver = {
+	.driver = {
+		.name	= "sdhci-mv",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sdhci_mv_probe,
+	.remove		= __devexit_p(sdhci_mv_remove),
+	.suspend	= sdhci_mv_suspend,
+	.resume		= sdhci_mv_resume,
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * Driver init/exit                                                          *
+ *                                                                           *
+\*****************************************************************************/
+
+static int __init sdhci_mv_init(void)
+{
+	return platform_driver_register(&sdhci_mv_driver);
+}
+
+static void __exit sdhci_mv_exit(void)
+{
+	platform_driver_unregister(&sdhci_mv_driver);
+}
+
+module_init(sdhci_mv_init);
+module_exit(sdhci_mv_exit);
+
+MODULE_DESCRIPTION("Marvell SDHCI platform driver");
+MODULE_AUTHOR("Saeed Bishara <saeed@marvell.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:sdhci-mv");
+
-- 
1.6.0.4

