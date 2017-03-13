From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 19/22] mmc: mmc: Enable CQE's
Date: Mon, 13 Mar 2017 14:36:50 +0200
Message-ID: <1489408613-26915-20-git-send-email-adrian.hunter@intel.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:33190 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751981AbdCMMoW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 Mar 2017 08:44:22 -0400
In-Reply-To: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

Enable or disable CQE when a card is added or removed respectively.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/bus.c |  7 +++++++
 drivers/mmc/core/mmc.c | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 301246513a37..a4b49e25fe96 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -369,10 +369,17 @@ int mmc_add_card(struct mmc_card *card)
  */
 void mmc_remove_card(struct mmc_card *card)
 {
+	struct mmc_host *host = card->host;
+
 #ifdef CONFIG_DEBUG_FS
 	mmc_remove_card_debugfs(card);
 #endif
 
+	if (host->cqe_enabled) {
+		host->cqe_ops->cqe_disable(host);
+		host->cqe_enabled = false;
+	}
+
 	if (mmc_card_present(card)) {
 		if (mmc_host_is_spi(card->host)) {
 			pr_info("%s: SPI card removed\n",
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 70337068d85f..0b161024c214 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1810,6 +1810,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	card->reenable_cmdq = card->ext_csd.cmdq_en;
 
+	if (card->ext_csd.cmdq_en && (host->caps2 & MMC_CAP2_CQE) &&
+	    !host->cqe_enabled) {
+		err = host->cqe_ops->cqe_enable(host, card);
+		if (err) {
+			pr_err("%s: Failed to enable CQE, error %d\n",
+				mmc_hostname(host), err);
+		} else {
+			host->cqe_enabled = true;
+			pr_info("%s: Command Queue Engine enabled\n",
+				mmc_hostname(host));
+		}
+	}
+
 	/*
 	 * The mandatory minimum values are defined for packed command.
 	 * read: 5, write: 3
-- 
1.9.1

