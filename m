From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/2] mmc: tegra: Support module reset
Date: Thu, 23 Feb 2017 17:23:41 +0100
Message-ID: <20170223162342.15911-1-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The device tree binding for the SDHCI controller found on Tegra SoCs
specifies that a reset control can be provided by the device tree. No
code was ever added to support the module reset, which can cause the
driver to try and access registers from a module that's in reset. On
most Tegra SoC generations doing so would cause a hang.

Note that it's unlikely to see this happen because on most platforms
these resets will have been deasserted by the bootloader. However the
portability can be improved by making sure the driver deasserts the
reset before accessing any registers.

Since resets are synchronous on Tegra SoCs, the platform driver needs
to implement a custom ->remove() callback now to make sure the clock
is disabled after the reset is asserted.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Changes in v2:
- assert reset in ->probe() error path
- remove unneeded PCI specific quirk

 drivers/mmc/host/sdhci-tegra.c | 43 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 20b6ff5b4af1..9ae5895678e8 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/reset.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -65,6 +66,8 @@ struct sdhci_tegra {
 	struct gpio_desc *power_gpio;
 	bool ddr_signaling;
 	bool pad_calib_required;
+
+	struct reset_control *rst;
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -489,6 +492,25 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	clk_prepare_enable(clk);
 	pltfm_host->clk = clk;
 
+	tegra_host->rst = devm_reset_control_get(&pdev->dev, "sdhci");
+	if (IS_ERR(tegra_host->rst)) {
+		rc = PTR_ERR(tegra_host->rst);
+		dev_err(&pdev->dev, "failed to get reset control: %d\n", rc);
+		goto err_rst_get;
+	}
+
+	rc = reset_control_assert(tegra_host->rst);
+	if (rc)
+		goto err_rst_get;
+
+	usleep_range(2000, 4000);
+
+	rc = reset_control_deassert(tegra_host->rst);
+	if (rc)
+		goto err_rst_get;
+
+	usleep_range(2000, 4000);
+
 	rc = sdhci_add_host(host);
 	if (rc)
 		goto err_add_host;
@@ -496,6 +518,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	return 0;
 
 err_add_host:
+	reset_control_assert(tegra_host->rst);
+err_rst_get:
 	clk_disable_unprepare(pltfm_host->clk);
 err_clk_get:
 err_power_req:
@@ -504,6 +528,23 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	return rc;
 }
 
+static int sdhci_tegra_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *platform = sdhci_priv(host);
+	struct sdhci_tegra *tegra = sdhci_pltfm_priv(platform);
+
+	sdhci_remove_host(host, 0);
+
+	reset_control_assert(tegra->rst);
+	usleep_range(2000, 4000);
+	clk_disable_unprepare(platform->clk);
+
+	sdhci_pltfm_free(pdev);
+
+	return 0;
+}
+
 static struct platform_driver sdhci_tegra_driver = {
 	.driver		= {
 		.name	= "sdhci-tegra",
@@ -511,7 +552,7 @@ static struct platform_driver sdhci_tegra_driver = {
 		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe		= sdhci_tegra_probe,
-	.remove		= sdhci_pltfm_unregister,
+	.remove		= sdhci_tegra_remove,
 };
 
 module_platform_driver(sdhci_tegra_driver);
-- 
2.11.1
