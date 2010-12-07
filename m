From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 3/5] mmc: msm_sdcc: Reset SDCC in case of data transfer errors
Date: Tue,  7 Dec 2010 16:25:14 +0530
Message-ID: <1291719316-23948-3-git-send-email-stummala@codeaurora.org>
References: <1291719316-23948-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:3776 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab0LGK4H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2010 05:56:07 -0500
In-Reply-To: <1291719316-23948-1-git-send-email-stummala@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: san@google.com, linux-arm-msm@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>

Reset SDCC in case of data transfer errors to ensure that
any left over data in FIFOs is flushed out.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index b64775c..b5cca8c 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -44,6 +44,7 @@
 #include <mach/mmc.h>
 #include <mach/msm_iomap.h>
 #include <mach/dma.h>
+#include <mach/clk.h>
 
 #include "msm_sdcc.h"
 
@@ -126,6 +127,40 @@ static void
 msmsdcc_start_command(struct msmsdcc_host *host, struct mmc_command *cmd,
 		      u32 c);
 
+static void msmsdcc_reset_and_restore(struct msmsdcc_host *host)
+{
+	u32	mci_clk = 0;
+	u32	mci_mask0 = 0;
+	int	ret = 0;
+
+	/* Save the controller state */
+	mci_clk = readl(host->base + MMCICLOCK);
+	mci_mask0 = readl(host->base + MMCIMASK0);
+
+	/* Reset the controller */
+	ret = clk_reset(host->clk, CLK_RESET_ASSERT);
+	if (ret)
+		pr_err("%s: Clock assert failed at %u Hz with err %d\n",
+				mmc_hostname(host->mmc), host->clk_rate, ret);
+
+	ret = clk_reset(host->clk, CLK_RESET_DEASSERT);
+	if (ret)
+		pr_err("%s: Clock deassert failed at %u Hz with err %d\n",
+				mmc_hostname(host->mmc), host->clk_rate, ret);
+
+	pr_info("%s: Controller has been re-initialiazed\n",
+			mmc_hostname(host->mmc));
+
+	/* Restore the contoller state */
+	writel(host->pwr, host->base + MMCIPOWER);
+	writel(mci_clk, host->base + MMCICLOCK);
+	writel(mci_mask0, host->base + MMCIMASK0);
+	ret = clk_set_rate(host->clk, host->clk_rate);
+	if (ret)
+		pr_err("%s: Failed to set clk rate %u Hz (%d)\n",
+				mmc_hostname(host->mmc), host->clk_rate, ret);
+}
+
 static void
 msmsdcc_request_end(struct msmsdcc_host *host, struct mmc_request *mrq)
 {
@@ -223,6 +258,8 @@ msmsdcc_dma_complete_tlet(unsigned long data)
 		pr_err("Flush data: %.8x %.8x %.8x %.8x %.8x %.8x\n",
 		       err.flush[0], err.flush[1], err.flush[2],
 		       err.flush[3], err.flush[4], err.flush[5]);
+
+		msmsdcc_reset_and_restore(host);
 		if (!mrq->data->error)
 			mrq->data->error = -EIO;
 	}
@@ -723,6 +760,7 @@ static void msmsdcc_do_cmdirq(struct msmsdcc_host *host, uint32_t status)
 			msm_dmov_stop_cmd(host->dma.channel,
 					  &host->dma.hdr, 0);
 		else if (host->curr.data) { /* Non DMA */
+			msmsdcc_reset_and_restore(host);
 			msmsdcc_stop_data(host);
 			msmsdcc_request_end(host, cmd->mrq);
 		} else { /* host->data == NULL */
@@ -771,6 +809,7 @@ msmsdcc_handle_irq_data(struct msmsdcc_host *host, u32 status,
 			msm_dmov_stop_cmd(host->dma.channel,
 					  &host->dma.hdr, 0);
 		else {
+			msmsdcc_reset_and_restore(host);
 			if (host->curr.data)
 				msmsdcc_stop_data(host);
 			if (!data->stop)
-- 
1.7.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
