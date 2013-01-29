From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 1/5] mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
Date: Tue, 29 Jan 2013 16:21:05 +0800
Message-ID: <1359447669-20089-2-git-send-email-kliu5@marvell.com>
References: <1359447669-20089-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:47216 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753514Ab3A2IUf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jan 2013 03:20:35 -0500
In-Reply-To: <1359447669-20089-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kl>

With current code, for commands like cmd5/cmd7 which transfer without data,
function sdhci_set_transfer_mode will just return without updating the
transfer setting. So the Transfer Mode Register (offset 0x3E) still keep
previous setting, which may be wrong since some bits (0x3E<5:0>) may have
been set unexpectedly.
For example, cmd5 following cmd18/cmd25 will have timeout error
since auto cmd23 has been enabled.

This bug will lead to timeout error during emmc suspend/resume
when cmd5 is called to sleep/awake emmc.
And this fix has been verified on sdhci-pxav3 platform.

Reviewed By: Girish K S <girish.shivananjappa@linaro.org>
Reviewed-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Signed-off-by: Jialing Fu <jlfu@marvell.com>
Signed-off-by: Tim Wang <wangtt@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>

Change-Id: I2e53475fe7557ad4026f2a20b1727cb7ed34086e
---
 drivers/mmc/host/sdhci.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3bb9b88..8a14927 100644
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
 
@@ -1860,13 +1873,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
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
1.7.9.5

