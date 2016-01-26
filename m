From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v3 19/25] mmc: sdhci-pxav3: fix higher speed mode capabilities
Date: Tue, 26 Jan 2016 13:40:47 +0000
Message-ID: <E1aO3rT-0005jT-VN@rmk-PC.arm.linux.org.uk>
References: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36923 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964989AbcAZNo4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 08:44:56 -0500
In-Reply-To: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Commit 1140011ee9d9 ("mmc: sdhci-pxav3: Modify clock settings for the
SDR50 and DDR50 modes") broke any chance of the SDR50 or DDR50 modes
being used.

The commit claims that SDR50 and DDR50 require clock adjustments in
the SDIO3 Configuration register, which is located via the "conf-sdio3"
resource.  However, when this resource is given, we fail to read the
host capabilities 1 register, resulting in host->caps1 being zero.
Hence, both SDHCI_SUPPORT_SDR50 and SDHCI_SUPPORT_DDR50 bits remain
zero, disabling the SDR50 and DDR50 modes.

The underlying idea in this function appears to be to read the device
capabilities, modify them, and set SDHCI_QUIRK_MISSING_CAPS to cause
our modified capabilities to be used.  Implement exactly that.

Fixes: 1140011ee9d9 ("mmc: sdhci-pxav3: Modify clock settings for the SDR50 and DDR50 modes")
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-pxav3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index f5edf9d3a18a..c7f27fe4805a 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -137,6 +137,10 @@ static int armada_38x_quirks(struct platform_device *pdev,
 
 	host->quirks &= ~SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
 	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
+
+	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					   "conf-sdio3");
 	if (res) {
@@ -150,7 +154,6 @@ static int armada_38x_quirks(struct platform_device *pdev,
 		 * Configuration register, if the adjustment is not done,
 		 * remove them from the capabilities.
 		 */
-		host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
 		host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
 
 		dev_warn(&pdev->dev, "conf-sdio3 register not found: disabling SDR50 and DDR50 modes.\nConsider updating your dtb\n");
@@ -161,7 +164,6 @@ static int armada_38x_quirks(struct platform_device *pdev,
 	 * controller has different capabilities than the ones shown
 	 * in its registers
 	 */
-	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
 	if (of_property_read_bool(np, "no-1-8-v")) {
 		host->caps &= ~SDHCI_CAN_VDD_180;
 		host->mmc->caps &= ~MMC_CAP_1_8V_DDR;
-- 
2.1.0

