From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 04/11] mmc: core: Turn off CQE before sending commands
Date: Fri, 21 Jul 2017 12:49:37 +0300
Message-ID: <1500630584-22852-5-git-send-email-adrian.hunter@intel.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:29961 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753762AbdGUJ43 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Jul 2017 05:56:29 -0400
In-Reply-To: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

Turn off the CQE before sending commands, and ensure it is off in any reset
or power management paths, or re-tuning.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 26431267a3e2..b0af9db18eef 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -260,6 +260,9 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 
 	trace_mmc_request_start(host, mrq);
 
+	if (host->cqe_on)
+		host->cqe_ops->cqe_off(host);
+
 	host->ops->request(host, mrq);
 }
 
@@ -982,6 +985,9 @@ int mmc_execute_tuning(struct mmc_card *card)
 	if (!host->ops->execute_tuning)
 		return 0;
 
+	if (host->cqe_on)
+		host->cqe_ops->cqe_off(host);
+
 	if (mmc_card_mmc(card))
 		opcode = MMC_SEND_TUNING_BLOCK_HS200;
 	else
@@ -1021,6 +1027,9 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
  */
 void mmc_set_initial_state(struct mmc_host *host)
 {
+	if (host->cqe_on)
+		host->cqe_ops->cqe_off(host);
+
 	mmc_retune_disable(host);
 
 	if (mmc_host_is_spi(host))
-- 
1.9.1

