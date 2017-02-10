From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 21/39] mmc: mmc: Enable CQE's
Date: Fri, 10 Feb 2017 14:55:34 +0200
Message-ID: <1486731352-8018-22-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23923 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbdBJNMJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:12:09 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Enable or disable CQE when a card is added or removed respectively.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/bus.c |  7 +++++++
 drivers/mmc/core/mmc.c | 17 ++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

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
index 3af218c8f5b9..f7c2bcb60c52 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1801,7 +1801,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 
 	/* Enable Command Queue if supported */
 	card->ext_csd.cmdq_en = false;
-	if (card->ext_csd.cmdq_support && host->caps & MMC_CAP_CMD_DURING_TFR) {
+	if (card->ext_csd.cmdq_support &&
+	    (host->caps & MMC_CAP_CMD_DURING_TFR ||
+	     host->caps2 & MMC_CAP2_CQE)) {
 		err = mmc_cmdq_enable(card);
 		if (err && err != -EBADMSG)
 			goto free_card;
@@ -1820,6 +1822,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
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

