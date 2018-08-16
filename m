From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH V5 08/10] mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
Date: Thu, 16 Aug 2018 15:54:22 +0800
Message-ID: <1534406064-10065-9-git-send-email-zhang.chunyan@linaro.org>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@unisoc.com>, Jason Wu <jason.wu@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

When Host Version 4 Enable is set to 1, SDMA uses ADMA System Address
register (05Fh-058h) instead of using register (000h-004h) to indicate
its system address of data location. The register (000h-004h) is
re-assigned to 32-bit Block Count and Auto CMD23 argument, so then SDMA
may use Auto CMD23.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 06c2ae9..4e375ba 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3851,10 +3851,14 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
 		host->flags |= SDHCI_AUTO_CMD12;
 
-	/* Auto-CMD23 stuff only works in ADMA or PIO. */
+	/*
+	 * For v3 mode, Auto-CMD23 stuff only works in ADMA or PIO;
+	 * For v4 mode, SDMA may use Auto-CMD23 as well.
+	 */
 	if ((host->version >= SDHCI_SPEC_300) &&
 	    ((host->flags & SDHCI_USE_ADMA) ||
-	     !(host->flags & SDHCI_USE_SDMA)) &&
+	     (!host->v4_mode && !(host->flags & SDHCI_USE_SDMA)) ||
+	     (host->v4_mode && (host->flags & SDHCI_USE_SDMA))) &&
 	     !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {
 		host->flags |= SDHCI_AUTO_CMD23;
 		DBG("Auto-CMD23 available\n");
-- 
2.7.4
