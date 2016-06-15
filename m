From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFC 09/10] mmc: cmdq-host: add halt support to command queue host
Date: Wed, 15 Jun 2016 18:31:13 +0530
Message-ID: <1465995674-15816-10-git-send-email-riteshh@codeaurora.org>
References: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43791 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbcFONDJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2016 09:03:09 -0400
In-Reply-To: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, jh80.chung@samsung.com, dongas86@gmail.com, asutoshd@codeaurora.org, zhangfei.gao@gmail.com, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>

From: Asutosh Das <asutoshd@codeaurora.org>

Halt can be used in error cases to get control of the
bus. This is used to remove a task from device queue
and/or other recovery mechanisms.

Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
[riteshh@codeaurora.org: fixed merge conflicts]
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/cmdq_hci.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/mmc/host/cmdq_hci.c b/drivers/mmc/host/cmdq_hci.c
index 68c8e03..64be0ce 100644
--- a/drivers/mmc/host/cmdq_hci.c
+++ b/drivers/mmc/host/cmdq_hci.c
@@ -29,6 +29,9 @@
 #define DCMD_SLOT 31
 #define NUM_SLOTS 32
 
+/* 1 sec */
+#define HALT_TIMEOUT_MS 1000
+
 static inline u8 *get_desc(struct cmdq_host *cq_host, u8 tag)
 {
 	return cq_host->desc_base + (tag * cq_host->slot_sz);
@@ -570,11 +573,42 @@ irqreturn_t cmdq_irq(struct mmc_host *mmc, u32 intmask)
 		cmdq_dumpregs(cq_host);
 	}
 
+	if (status & CQIS_HAC) {
+		/* halt is completed, wakeup waiting thread */
+		complete(&cq_host->halt_comp);
+	}
+
 out:
 	return IRQ_HANDLED;
 }
 EXPORT_SYMBOL(cmdq_irq);
 
+/* May sleep */
+static int cmdq_halt(struct mmc_host *mmc, bool halt)
+{
+	struct cmdq_host *cq_host = (struct cmdq_host *)mmc_cmdq_private(mmc);
+	u32 val;
+
+	if (halt) {
+		cmdq_writel(cq_host, cmdq_readl(cq_host, CQCTL) | HALT,
+			    CQCTL);
+		val = wait_for_completion_timeout(&cq_host->halt_comp,
+					  msecs_to_jiffies(HALT_TIMEOUT_MS));
+		/* halt done: re-enable legacy interrupts */
+		if (cq_host->ops->clear_set_irqs)
+			cq_host->ops->clear_set_irqs(mmc, false);
+
+		return val ? 0 : -ETIMEDOUT;
+	} else {
+		if (cq_host->ops->clear_set_irqs)
+			cq_host->ops->clear_set_irqs(mmc, true);
+		cmdq_writel(cq_host, cmdq_readl(cq_host, CQCTL) & ~HALT,
+			    CQCTL);
+	}
+
+	return 0;
+}
+
 static void cmdq_post_req(struct mmc_host *host, struct mmc_request *mrq,
 			  int err)
 {
@@ -597,6 +631,7 @@ static const struct mmc_cmdq_host_ops cmdq_host_ops = {
 	.disable = cmdq_disable,
 	.request = cmdq_request,
 	.post_req = cmdq_post_req,
+	.halt = cmdq_halt,
 };
 
 struct cmdq_host *cmdq_pltfm_init(struct platform_device *pdev)
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

