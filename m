From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 7/8] mmc: sdhci: fix coding style in sdhci_data_irq
Date: Fri,  9 Nov 2012 17:09:57 +0530
Message-ID: <1352461198-21941-8-git-send-email-tushar.behera@linaro.org>
References: <1352461198-21941-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352461198-21941-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/mmc/host/sdhci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4bed582..47cac71 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2286,9 +2286,9 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		host->data->error = -EIO;
 	}
 
-	if (host->data->error)
+	if (host->data->error) {
 		sdhci_finish_data(host);
-	else {
+	} else {
 		if (intmask & (SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL))
 			sdhci_transfer_pio(host);
 
-- 
1.7.4.1
