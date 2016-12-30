From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [RFC PATCH 3/3] mmc: sdhci: Add more debug info in case of data error
Date: Fri, 30 Dec 2016 17:02:11 +0530
Message-ID: <1483097531-9991-4-git-send-email-riteshh@codeaurora.org>
References: <1483097531-9991-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1483097531-9991-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, subhashj@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

print error log message and dump sdhc registers for debugging
purpose in case of data errors (except when tuning commands
generate CRC/timeout/end bit errors).

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 73a8918..2e51e49 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2616,9 +2616,26 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			host->ops->adma_workaround(host, intmask);
 	}
 
-	if (host->data->error)
+	if (host->data->error) {
+		bool pr_msg = true;
+
+		if (intmask & (SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT |
+		    SDHCI_INT_DATA_END_BIT)) {
+			command = SDHCI_GET_CMD(sdhci_readw(host,
+							    SDHCI_COMMAND));
+			if (command == MMC_SEND_TUNING_BLOCK_HS200 ||
+			    command == MMC_SEND_TUNING_BLOCK)
+				pr_msg = false;
+		}
+		if (pr_msg) {
+			pr_err("%s: data txfr (0x%08x) error: %d\n",
+			       mmc_hostname(host->mmc), intmask,
+			       host->data->error);
+			sdhci_dumpregs(host);
+		}
+
 		sdhci_finish_data(host);
-	else {
+	} else {
 		if (intmask & (SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL))
 			sdhci_transfer_pio(host);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
