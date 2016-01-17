From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: [PATCH 4/5 RFC] mmc: sdhci-iproc: add bcm2835 support
Date: Sun, 17 Jan 2016 14:59:03 +0000
Message-ID: <1453042744-16196-5-git-send-email-stefan.wahren@i2se.com>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453042744-16196-1-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Scott Branden from Broadcom said that the BCM2835 eMMC IP core is
very similar to IPROC and share most of the quirks. So use this driver
instead of separate one.

The sdhci-iproc contains a better workaround for the clock domain
crossing problem which doesn't need any delays. This results in a
better write performance.

Btw we get the rid of the SDHCI_CAPABILITIES hack in the sdhci_readl
function.

Suggested-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
---
 drivers/mmc/host/Kconfig       |    6 +++---
 drivers/mmc/host/sdhci-iproc.c |   20 ++++++++++++++++++--
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 1526b8a..60de1e4 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -318,15 +318,15 @@ config MMC_SDHCI_F_SDH30
 	  If unsure, say N.
 
 config MMC_SDHCI_IPROC
-	tristate "SDHCI platform support for the iProc SD/MMC Controller"
-	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	tristate "SDHCI support for the BCM2835 & iProc SD/MMC Controller"
+	depends on ARCH_BCM2835 || ARCH_BCM_IPROC || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	default ARCH_BCM_IPROC
 	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the iProc SD/MMC controller.
 
-	  If you have an IPROC platform with SD or MMC devices,
+	  If you have a BCM2835 or IPROC platform with SD or MMC devices,
 	  say Y or M here.
 
 	  If unsure, say N.
diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 55bc348..88399eb 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -167,7 +167,20 @@ static const struct sdhci_iproc_data iproc_data = {
 	.caps1 = 0x00000064,
 };
 
+static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
+	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
+		| SDHCI_QUIRK_MISSING_CAPS,
+	.ops = &sdhci_iproc_ops,
+};
+
+static const struct sdhci_iproc_data bcm2835_data = {
+	.pdata = &sdhci_bcm2835_pltfm_data,
+	.caps = SDHCI_CAN_VDD_330,
+	.caps1 = 0x00000000,
+};
+
 static const struct of_device_id sdhci_iproc_of_match[] = {
+	{ .compatible = "brcm,bcm2835-sdhci", .data = &bcm2835_data },
 	{ .compatible = "brcm,sdhci-iproc-cygnus", .data = &iproc_data },
 	{ }
 };
@@ -180,6 +193,7 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 	struct sdhci_host *host;
 	struct sdhci_iproc_host *iproc_host;
 	struct sdhci_pltfm_host *pltfm_host;
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
 	match = of_match_device(sdhci_iproc_of_match, &pdev->dev);
@@ -199,8 +213,10 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 	mmc_of_parse(host->mmc);
 	sdhci_get_of_property(pdev);
 
-	/* Enable EMMC 1/8V DDR capable */
-	host->mmc->caps |= MMC_CAP_1_8V_DDR;
+	if (of_device_is_compatible(np, "brcm,sdhci-iproc-cygnus")) {
+		/* Enable EMMC 1/8V DDR capable */
+		host->mmc->caps |= MMC_CAP_1_8V_DDR;
+	}
 
 	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pltfm_host->clk)) {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
