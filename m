From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 31/39] mmc: sdhci: Factor out sdhci_set_default_irqs
Date: Fri, 10 Feb 2017 14:55:44 +0200
Message-ID: <1486731352-8018-32-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6215 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752513AbdBJP54 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 10:57:56 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Factor out sdhci_set_default_irqs().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cd8a7eb5431d..79ab36a37484 100644
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

