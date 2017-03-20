From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 18/25] mmc: sdhci: Factor out sdhci_set_default_irqs
Date: Mon, 20 Mar 2017 19:50:46 +0200
Message-ID: <1490032253-6030-19-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:36549 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756102AbdCTR6f (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:35 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Factor out sdhci_set_default_irqs().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b2ef0d93cebd..7f1c0126342f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -225,15 +225,8 @@ static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
 	}
 }
 
-static void sdhci_init(struct sdhci_host *host, int soft)
+static void sdhci_set_default_irqs(struct sdhci_host *host)
 {
-	struct mmc_host *mmc = host->mmc;
-
-	if (soft)
-		sdhci_do_reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
-	else
-		sdhci_do_reset(host, SDHCI_RESET_ALL);
-
 	host->ier = SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
 		    SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT |
 		    SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC |
@@ -246,6 +239,18 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+}
+
+static void sdhci_init(struct sdhci_host *host, int soft)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	if (soft)
+		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+	else
+		sdhci_do_reset(host, SDHCI_RESET_ALL);
+
+	sdhci_set_default_irqs(host);
 
 	if (soft) {
 		/* force clock reconfiguration */
-- 
1.9.1

