From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2] mmc: host: iproc: Add ACPI support to IPROC SDHCI
Date: Sat, 28 Jul 2018 21:45:29 +0530
Message-ID: <1532794529-30137-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, vikram.prakash@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Srinath Mannam <srinath.mannam@broadcom.com>
List-Id: linux-mmc@vger.kernel.org

Add ACPI support to all IPROC SDHCI varients

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
---
Changes from v1:
  - Removed sdhci_iproc_data array change and add directly
    into of and acpi id tables.
  - Add a change to get match data directly.
  - Removed clock-frequency property read change.
  - Used sdhci_get_property to get properties.
  - Verified with patch given by Adrian Hunter
    mmc: sdhci-pltfm: Convert DT properties to generic device properties

 drivers/mmc/host/Kconfig       |  1 +
 drivers/mmc/host/sdhci-iproc.c | 63 +++++++++++++++++++++++++++++-------------
 2 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0581c19..bc6702e 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -334,6 +334,7 @@ config MMC_SDHCI_IPROC
 	tristate "SDHCI support for the BCM2835 & iProc SD/MMC Controller"
 	depends on ARCH_BCM2835 || ARCH_BCM_IPROC || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
+	depends on OF || ACPI
 	default ARCH_BCM_IPROC
 	select MMC_SDHCI_IO_ACCESSORS
 	help
diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index d0e83db..abf5269 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -15,6 +15,7 @@
  * iProc SDHCI platform driver
  */
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/mmc/host.h>
@@ -162,9 +163,19 @@ static void sdhci_iproc_writeb(struct sdhci_host *host, u8 val, int reg)
 	sdhci_iproc_writel(host, newval, reg & ~3);
 }
 
+static unsigned int sdhci_iproc_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	if (pltfm_host->clk)
+		return sdhci_pltfm_clk_get_max_clock(host);
+	else
+		return pltfm_host->clock;
+}
+
 static const struct sdhci_ops sdhci_iproc_ops = {
 	.set_clock = sdhci_set_clock,
-	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.get_max_clock = sdhci_iproc_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
@@ -178,7 +189,7 @@ static const struct sdhci_ops sdhci_iproc_32only_ops = {
 	.write_w = sdhci_iproc_writew,
 	.write_b = sdhci_iproc_writeb,
 	.set_clock = sdhci_set_clock,
-	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.get_max_clock = sdhci_iproc_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
@@ -256,19 +267,29 @@ static const struct of_device_id sdhci_iproc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
 
+static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
+	{ .id = "BRCM5871", .driver_data = (kernel_ulong_t)&iproc_cygnus_data },
+	{ .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, sdhci_iproc_acpi_ids);
+
 static int sdhci_iproc_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
-	const struct sdhci_iproc_data *iproc_data;
+	struct device *dev = &pdev->dev;
+	const struct sdhci_iproc_data *iproc_data = NULL;
 	struct sdhci_host *host;
 	struct sdhci_iproc_host *iproc_host;
 	struct sdhci_pltfm_host *pltfm_host;
 	int ret;
 
-	match = of_match_device(sdhci_iproc_of_match, &pdev->dev);
-	if (!match)
-		return -EINVAL;
-	iproc_data = match->data;
+	if (dev->of_node)
+		iproc_data = of_device_get_match_data(dev);
+	else if (has_acpi_companion(dev))
+		iproc_data = acpi_device_get_match_data(dev);
+
+	if (!iproc_data)
+		return -ENODEV;
 
 	host = sdhci_pltfm_init(pdev, iproc_data->pdata, sizeof(*iproc_host));
 	if (IS_ERR(host))
@@ -280,19 +301,21 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 	iproc_host->data = iproc_data;
 
 	mmc_of_parse(host->mmc);
-	sdhci_get_of_property(pdev);
+	sdhci_get_property(pdev);
 
 	host->mmc->caps |= iproc_host->data->mmc_caps;
 
-	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pltfm_host->clk)) {
-		ret = PTR_ERR(pltfm_host->clk);
-		goto err;
-	}
-	ret = clk_prepare_enable(pltfm_host->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable host clk\n");
-		goto err;
+	if (dev->of_node) {
+		pltfm_host->clk = devm_clk_get(dev, NULL);
+		if (IS_ERR(pltfm_host->clk)) {
+			ret = PTR_ERR(pltfm_host->clk);
+			goto err;
+		}
+		ret = clk_prepare_enable(pltfm_host->clk);
+		if (ret) {
+			dev_err(dev, "failed to enable host clk\n");
+			goto err;
+		}
 	}
 
 	if (iproc_host->data->pdata->quirks & SDHCI_QUIRK_MISSING_CAPS) {
@@ -307,7 +330,8 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 	return 0;
 
 err_clk:
-	clk_disable_unprepare(pltfm_host->clk);
+	if (dev->of_node)
+		clk_disable_unprepare(pltfm_host->clk);
 err:
 	sdhci_pltfm_free(pdev);
 	return ret;
@@ -317,6 +341,7 @@ static struct platform_driver sdhci_iproc_driver = {
 	.driver = {
 		.name = "sdhci-iproc",
 		.of_match_table = sdhci_iproc_of_match,
+		.acpi_match_table = ACPI_PTR(sdhci_iproc_acpi_ids),
 		.pm = &sdhci_pltfm_pmops,
 	},
 	.probe = sdhci_iproc_probe,
-- 
2.7.4
