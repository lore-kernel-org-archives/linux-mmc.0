From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 12/15] mmc: sdhci: Flag re-tuning is needed on CRC or End-Bit errors
Date: Thu, 29 Jan 2015 11:00:27 +0200
Message-ID: <1422522030-17793-13-git-send-email-adrian.hunter@intel.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:48919 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758539AbbA2JC5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 29 Jan 2015 04:02:57 -0500
In-Reply-To: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

CRC or End-Bit errors could possibly be alleviated by
re-tuning so flag re-tuning needed in those cases.
Note this has no effect if re-tuning has not been
enabled.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index dd0be76..06c5b96 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2320,8 +2320,10 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
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
@@ -2446,13 +2448,15 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 
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

