From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 13/25] mmc: sdhci: Use sdhci_readl() not readl() in sdhci_dumpregs()
Date: Mon, 20 Mar 2017 19:50:41 +0200
Message-ID: <1490032253-6030-14-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:18862 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756157AbdCTR6M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:12 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Use sdhci io wrappers consistently.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 40f69ae51adf..93730a3013ff 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -100,13 +100,13 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 	if (host->flags & SDHCI_USE_ADMA) {
 		if (host->flags & SDHCI_USE_64_BIT_DMA)
 			pr_err(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x%08x\n",
-			       readl(host->ioaddr + SDHCI_ADMA_ERROR),
-			       readl(host->ioaddr + SDHCI_ADMA_ADDRESS_HI),
-			       readl(host->ioaddr + SDHCI_ADMA_ADDRESS));
+			       sdhci_readl(host, SDHCI_ADMA_ERROR),
+			       sdhci_readl(host, SDHCI_ADMA_ADDRESS_HI),
+			       sdhci_readl(host, SDHCI_ADMA_ADDRESS));
 		else
 			pr_err(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x\n",
-			       readl(host->ioaddr + SDHCI_ADMA_ERROR),
-			       readl(host->ioaddr + SDHCI_ADMA_ADDRESS));
+			       sdhci_readl(host, SDHCI_ADMA_ERROR),
+			       sdhci_readl(host, SDHCI_ADMA_ADDRESS));
 	}
 
 	pr_err(DRIVER_NAME ": ===========================================\n");
-- 
1.9.1

