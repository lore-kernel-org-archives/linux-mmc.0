From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: [PATCH 4/5] mmc: msm_sdcc: Remove duplicate check around dmares
Date: Tue, 16 Sep 2014 16:47:47 +0530
Message-ID: <1410866268-15185-5-git-send-email-pramod.gurav@smartplayin.com>
References: <1410866268-15185-1-git-send-email-pramod.gurav@smartplayin.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1410866268-15185-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This removes duplicate check on host->dmares. As function
msmsdcc_init_dma() is called only after host->dmares is found
true, it is unnecessary to recheck inside the function.

Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: linux-mmc@vger.kernel.org
CC: linux-arm-msm@vger.kernel.org
Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---
 drivers/mmc/host/msm_sdcc.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 2111c03..5025364 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1143,9 +1143,6 @@ msmsdcc_init_dma(struct msmsdcc_host *host)
 	host->dma.host = host;
 	host->dma.channel = -1;
 
-	if (!host->dmares)
-		return -ENODEV;
-
 	host->dma.nc = dma_alloc_coherent(NULL,
 					  sizeof(struct msmsdcc_nc_dmadata),
 					  &host->dma.nc_busaddr,
-- 
1.7.9.5
