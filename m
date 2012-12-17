From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v10 01/12] mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
Date: Mon, 17 Dec 2012 19:21:57 +0800
Message-ID: <1355743328-17758-2-git-send-email-kliu5@marvell.com>
References: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:41616 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752275Ab2LQLWd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 06:22:33 -0500
In-Reply-To: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, peppe.cavallaro@st.com, ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com, prakity@nvidia.com
Cc: zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>, Jialing Fu <jlfu@marvell.com>, Tim Wang <wangtt@marvell.com>

With current code, commands without data transfer like cmd5/cmd7
still use previous transfer mode setting, which may lead to error
since some bits may have been set unexpectedly.
For example, cmd5 following cmd18/cmd25 will have timeout error
since audo cmd23 has been enabled.

This bug will lead to timeout error during emmc suspend/resume
when cmd5 is called to sleep/awake emmc.
And this fix has been verified on pxa988 platform.

Reviewed By: Girish K S <girish.shivananjappa@linaro.org>
Reviewed-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Signed-off-by: Jialing Fu <jlfu@marvell.com>
Signed-off-by: Tim Wang <wangtt@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6f0bfc0..44f4ecb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -886,8 +886,21 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	u16 mode;
 	struct mmc_data *data = cmd->data;
 
-	if (data == NULL)
+	if (!data) {
+		if (cmd->opcode == MMC_SEND_TUNING_BLOCK ||
+			cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
+			/*
+			 * The tuning block is sent by the card to the host
+			 * controller. So we set the TRNS_READ bit in the
+			 * Transfer Mode register. This also takes care of
+			 * setting DMA Enable and Multi Block Select in the
+			 * same register to 0.
+			 */
+			sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
+		else
+			sdhci_writew(host, 0, SDHCI_TRANSFER_MODE);
 		return;
+	}
 
 	WARN_ON(!host->data);
 
@@ -1853,13 +1866,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 				     SDHCI_BLOCK_SIZE);
 		}
 
-		/*
-		 * The tuning block is sent by the card to the host controller.
-		 * So we set the TRNS_READ bit in the Transfer Mode register.
-		 * This also takes care of setting DMA Enable and Multi Block
-		 * Select in the same register to 0.
-		 */
-		sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
 
 		sdhci_send_command(host, &cmd);
 
-- 
1.7.0.4

