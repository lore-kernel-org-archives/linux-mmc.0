From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 12/15] mmc: sdhci: Flag re-tuning is needed on CRC or End-Bit errors
Date: Fri, 27 Mar 2015 22:57:40 +0200
Message-ID: <1427489863-9050-13-git-send-email-adrian.hunter@intel.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24700 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752432AbbC0VAM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Mar 2015 17:00:12 -0400
In-Reply-To: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

CRC or End-Bit errors could possibly be alleviated by
re-tuning so flag re-tuning needed in those cases.
Note this has no effect if re-tuning has not been
enabled.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c9a34b5..e6125e9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2308,8 +2308,10 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
 	if (intmask & SDHCI_INT_TIMEOUT)
 		host->cmd->error = -ETIMEDOUT;
 	else if (intmask & (SDHCI_INT_CRC | SDHCI_INT_END_BIT |
-			SDHCI_INT_INDEX))
+			SDHCI_INT_INDEX)) {
 		host->cmd->error = -EILSEQ;
+		mmc_retune_needed(host->mmc);
+	}
 
 	if (host->cmd->error) {
 		tasklet_schedule(&host->finish_tasklet);
@@ -2434,13 +2436,15 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 
 	if (intmask & SDHCI_INT_DATA_TIMEOUT)
 		host->data->error = -ETIMEDOUT;
-	else if (intmask & SDHCI_INT_DATA_END_BIT)
+	else if (intmask & SDHCI_INT_DATA_END_BIT) {
 		host->data->error = -EILSEQ;
-	else if ((intmask & SDHCI_INT_DATA_CRC) &&
+		mmc_retune_needed(host->mmc);
+	} else if ((intmask & SDHCI_INT_DATA_CRC) &&
 		SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))
-			!= MMC_BUS_TEST_R)
+			!= MMC_BUS_TEST_R) {
 		host->data->error = -EILSEQ;
-	else if (intmask & SDHCI_INT_ADMA_ERROR) {
+		mmc_retune_needed(host->mmc);
+	} else if (intmask & SDHCI_INT_ADMA_ERROR) {
 		pr_err("%s: ADMA error\n", mmc_hostname(host->mmc));
 		sdhci_adma_show_error(host);
 		host->data->error = -EIO;
-- 
1.9.1

