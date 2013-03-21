From: Barry Song <Barry.Song@csr.com>
Subject: [PATCH] sdhci: sirf: add mmc host sdhci-pltfm based driver for SiRF
 SoCs
Date: Thu, 21 Mar 2013 16:27:19 +0800
Message-ID: <1363854439-6859-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: cjb@laptop.org
Cc: Bin Shi <Bin.Shi@csr.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>
List-Id: linux-mmc@vger.kernel.org

From: Barry Song <Baohua.Song@csr.com>

this patch adds the new driver for CSR SiRF SoCs:
SiRFprimaII: unicore ARM Cortex-A9
SiRFatlas6: unicore ARM Cortex-A9
SiRFmarco: dual core ARM Cortex-A9 SMP

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Bin Shi <Bin.Shi@csr.com>
---
 .../devicetree/bindings/mmc/sdhci-sirf.txt         |   18 ++
 MAINTAINERS                                        |    1 +
 drivers/mmc/host/Kconfig                           |   11 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sdhci-sirf.c                      |  193 ++++++++++++++++++++
 5 files changed, 224 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
 create mode 100644 drivers/mmc/host/sdhci-sirf.c

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt b/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
new file mode 100644
index 0000000..dd6ed46
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
@@ -0,0 +1,18 @@
+* SiRFprimII/marco/atlas6 SDHCI Controller
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the sdhci-sirf driver.
+
+Required properties:
+- compatible: sirf,prima2-sdhc
+
+Optional properties:
+- cd-gpios: card detect gpio, with zero flags.
+
+Example:
+
+	sd0: sdhci@56000000 {
+		compatible = "sirf,prima2-sdhc";
+		reg = <0xcd000000 0x100000>;
+		cd-gpios = <&gpio 6 0>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 50b4d73..df68766 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -799,6 +799,7 @@ S:	Maintained
 F:	arch/arm/mach-prima2/
 F:	drivers/dma/sirf-dma.c
 F:	drivers/i2c/busses/i2c-sirf.c
+F:	drivers/mmc/host/sdhci-sirf.c
 F:	drivers/pinctrl/pinctrl-sirf.c
 F:	drivers/spi/spi-sirf.c
 
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d88219e..7f80dd9 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -190,6 +190,17 @@ config MMC_SDHCI_S3C
 
 	  If unsure, say N.
 
+config MMC_SDHCI_SIRF
+	tristate "SDHCI support on CSR SiRFprimaII and SiRFmarco SoCs"
+	depends on ARCH_SIRF
+	depends on MMC_SDHCI_PLTFM
+	help
+	  This selects the SDHCI support for SiRF System-on-Chip devices.
+
+	  If you have a controller with this interface, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_PXAV3
 	tristate "Marvell MMP2 SD Host Controller support (PXAV3)"
 	depends on CLKDEV_LOOKUP
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index c380e3c..cd32280 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
 obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
 obj-$(CONFIG_MMC_SDHCI_PXAV2)	+= sdhci-pxav2.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
+obj-$(CONFIG_MMC_SDHCI_SIRF)   	+= sdhci-sirf.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
 obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
new file mode 100644
index 0000000..09805af
--- /dev/null
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -0,0 +1,193 @@
+/*
+ * SDHCI support for SiRF primaII and marco SoCs
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/mmc/host.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/pinctrl/consumer.h>
+#include "sdhci-pltfm.h"
+
+struct sdhci_sirf_priv {
+	struct clk *clk;
+	int gpio_cd;
+};
+
+static unsigned int sdhci_sirf_get_max_clk(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_sirf_priv *priv = pltfm_host->priv;
+	return clk_get_rate(priv->clk);
+}
+
+static struct sdhci_ops sdhci_sirf_ops = {
+	.get_max_clock	= sdhci_sirf_get_max_clk,
+};
+
+static struct sdhci_pltfm_data sdhci_sirf_pdata = {
+	.ops = &sdhci_sirf_ops,
+	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
+		SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
+		SDHCI_QUIRK_DELAY_AFTER_POWER,
+};
+
+static int sdhci_sirf_probe(struct platform_device *pdev)
+{
+	struct sdhci_host *host;
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_sirf_priv *priv;
+	struct pinctrl *pinctrl;
+	int ret;
+
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		dev_err(&pdev->dev, "unable to get pinmux");
+		return PTR_ERR(pinctrl);
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct sdhci_sirf_priv),
+		GFP_KERNEL);
+	if (!priv) {
+		dev_err(&pdev->dev, "unable to allocate private data");
+		return -ENOMEM;
+	}
+
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		dev_err(&pdev->dev, "unable to get clock");
+		return PTR_ERR(priv->clk);
+	}
+
+	if (pdev->dev.of_node) {
+		priv->gpio_cd = of_get_named_gpio(pdev->dev.of_node,
+			"cd-gpios", 0);
+	} else {
+		priv->gpio_cd = -EINVAL;
+	}
+
+	host = sdhci_pltfm_init(pdev, &sdhci_sirf_pdata);
+	if (IS_ERR(host)) {
+		ret = PTR_ERR(host);
+		goto err_sdhci_pltfm_init;
+	}
+
+	pltfm_host = sdhci_priv(host);
+	pltfm_host->priv = priv;
+
+	sdhci_get_of_property(pdev);
+
+	clk_prepare_enable(priv->clk);
+
+	ret = sdhci_add_host(host);
+	if (ret)
+		goto err_sdhci_add;
+
+	/*
+	 * We must request the IRQ after sdhci_add_host(), as the tasklet only
+	 * gets setup in sdhci_add_host() and we oops.
+	 */
+	if (gpio_is_valid(priv->gpio_cd)) {
+		ret = mmc_gpio_request_cd(host->mmc, priv->gpio_cd);
+		if (ret) {
+			dev_err(&pdev->dev, "card detect irq request failed: %d\n",
+				ret);
+			goto err_request_cd;
+		}
+	}
+
+	return 0;
+
+err_request_cd:
+	sdhci_remove_host(host, 0);
+err_sdhci_add:
+	clk_disable_unprepare(priv->clk);
+	sdhci_pltfm_free(pdev);
+err_sdhci_pltfm_init:
+	return ret;
+}
+
+static int sdhci_sirf_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_sirf_priv *priv = pltfm_host->priv;
+
+	sdhci_pltfm_unregister(pdev);
+
+	if (gpio_is_valid(priv->gpio_cd))
+		mmc_gpio_free_cd(host->mmc);
+
+	clk_disable_unprepare(priv->clk);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int sdhci_sirf_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_sirf_priv *priv = pltfm_host->priv;
+	int ret;
+
+	ret = sdhci_suspend_host(host);
+	if (ret)
+		return ret;
+
+	clk_disable(priv->clk);
+
+	return 0;
+}
+
+static int sdhci_sirf_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_sirf_priv *priv = pltfm_host->priv;
+	int ret;
+
+	ret = clk_enable(priv->clk);
+	if (ret) {
+		dev_dbg(dev, "Resume: Error enabling clock\n");
+		return ret;
+	}
+
+	return sdhci_resume_host(host);
+}
+
+static SIMPLE_DEV_PM_OPS(sdhci_sirf_pm_ops, sdhci_sirf_suspend, sdhci_sirf_resume);
+#endif
+
+static const struct of_device_id sdhci_sirf_of_match[] = {
+	{ .compatible = "sirf,prima2-sdhc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sdhci_sirf_of_match);
+
+static struct platform_driver sdhci_sirf_driver = {
+	.driver		= {
+		.name	= "sdhci-sirf",
+		.owner	= THIS_MODULE,
+		.of_match_table = sdhci_sirf_of_match,
+#ifdef CONFIG_PM_SLEEP
+		.pm	= &sdhci_sirf_pm_ops,
+#endif
+	},
+	.probe		= sdhci_sirf_probe,
+	.remove		= sdhci_sirf_remove,
+};
+
+module_platform_driver(sdhci_sirf_driver);
+
+MODULE_DESCRIPTION("SDHCI driver for SiRFprimaII/SiRFmarco");
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
