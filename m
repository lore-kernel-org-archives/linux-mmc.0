From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 08/54] mmc: sdhci: Get rid of redundant BUG_ONs
Date: Wed, 29 Jun 2016 16:24:21 +0300
Message-ID: <1467206707-30185-9-git-send-email-adrian.hunter@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35817 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbcF2N3t (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 09:29:49 -0400
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

BUG is never the right thing for SDHCI to do. Get rid of BUG_ON in cases it
will oops anyway if the pointer is NULL, or if the condition is logically
impossible.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9ca4253b0ab7..f4d6c0460818 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -428,8 +428,6 @@ static void sdhci_transfer_pio(struct sdhci_host *host)
 {
 	u32 mask;
 
-	BUG_ON(!host->data);
-
 	if (host->blocks == 0)
 		return;
 
@@ -929,8 +927,6 @@ static void sdhci_finish_data(struct sdhci_host *host)
 {
 	struct mmc_data *data;
 
-	BUG_ON(!host->data);
-
 	data = host->data;
 	host->data = NULL;
 
@@ -1060,8 +1056,6 @@ static void sdhci_finish_command(struct sdhci_host *host)
 {
 	int i;
 
-	BUG_ON(host->cmd == NULL);
-
 	if (host->cmd->flags & MMC_RSP_PRESENT) {
 		if (host->cmd->flags & MMC_RSP_136) {
 			/* CRC is stripped so we need to do some shifting. */
@@ -2279,8 +2273,6 @@ static void sdhci_timeout_timer(unsigned long data)
 
 static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
 {
-	BUG_ON(intmask == 0);
-
 	if (!host->cmd) {
 		pr_err("%s: Got command interrupt 0x%08x even though no command operation was in progress.\n",
 		       mmc_hostname(host->mmc), (unsigned)intmask);
@@ -2361,7 +2353,6 @@ static void sdhci_adma_show_error(struct sdhci_host *host) { }
 static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 {
 	u32 command;
-	BUG_ON(intmask == 0);
 
 	/* CMD19 generates _only_ Buffer Read Ready interrupt */
 	if (intmask & SDHCI_INT_DATA_AVAIL) {
-- 
1.9.1

