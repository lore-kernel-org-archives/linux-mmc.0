From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 08/23] mmc: sdhci: rename quirk SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12
Date: Sat, 16 Apr 2016 01:29:32 +0800
Message-ID: <1460741387-23815-9-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0060.outbound.protection.outlook.com ([157.56.110.60]:23552
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750776AbcDORxl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 15 Apr 2016 13:53:41 -0400
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org, aisheng.dong@nxp.com, haibo.chen@nxp.com, dongas86@gmail.com

Rename ACMD12 quirk to SDHCI_QUIRK_MULTIBLOCK_ACMD12 to avoid confusion
since it's needed for both read and write.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 2 +-
 drivers/mmc/host/sdhci-pltfm.c       | 2 +-
 drivers/mmc/host/sdhci-s3c.c         | 2 +-
 drivers/mmc/host/sdhci.c             | 2 +-
 drivers/mmc/host/sdhci.h             | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index d48f031..1ed1f995 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -162,7 +162,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 	case PCI_DEVICE_ID_O2_FUJIN2:
 		reg = sdhci_readl(host, O2_SD_VENDOR_SETTING);
 		if (reg & 0x1)
-			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
+			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_ACMD12;
 
 		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
 			break;
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 072bb27..206057a 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -74,7 +74,7 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	u32 bus_width;
 
 	if (of_get_property(np, "sdhci,auto-cmd12", NULL))
-		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
+		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_ACMD12;
 
 	if (of_get_property(np, "sdhci,1-bit-only", NULL) ||
 	    (of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 70c724b..756b9bb 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -564,7 +564,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ;
 
 	/* This host supports the Auto CMD12 */
-	host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
+	host->quirks |= SDHCI_QUIRK_MULTIBLOCK_ACMD12;
 
 	/* Samsung SoCs need BROKEN_ADMA_ZEROLEN_DESC */
 	host->quirks |= SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 96ccb15..40e3551 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2988,7 +2988,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
 	mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
 
-	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
+	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_ACMD12)
 		host->flags |= SDHCI_AUTO_CMD12;
 
 	/* Auto-CMD23 stuff only works in ADMA or PIO. */
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0f39f4f..afa4de8 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -379,7 +379,7 @@ struct sdhci_host {
 /* Controller is missing device caps. Use caps provided by host */
 #define SDHCI_QUIRK_MISSING_CAPS			(1<<27)
 /* Controller uses Auto CMD12 command to stop the transfer */
-#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
+#define SDHCI_QUIRK_MULTIBLOCK_ACMD12			(1<<28)
 /* Controller doesn't have HISPD bit field in HI-SPEED SD card */
 #define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
 /* Controller treats ADMA descriptors with length 0000h incorrectly */
-- 
1.9.1

