From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] mmc: dw_mmc: check card present before starting request
Date: Fri, 27 May 2016 11:02:21 +0800
Message-ID: <1464318141-5360-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:52838 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168AbcE0DDG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2016 23:03:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

The main reason to add this check is to avoid unnecessary
mmc_request like the on-going cmd and the corresponding sbc
if the card is removed. Although we have already checked this in
dw_mci_handle_cd for runtime usage of sd card and dw_mci_init_slot
for noremovable devices, but there is a timing gap before it really
calls dw_mci_get_cd as mmc_detect_change needs some delay here.

Another gain here is that we could save some checkings of card status
after sd card been removed.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index cb30e91..8eb7898 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -105,6 +105,7 @@ struct idmac_desc {
 static bool dw_mci_reset(struct dw_mci *host);
 static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
 static int dw_mci_card_busy(struct mmc_host *mmc);
+static int dw_mci_get_cd(struct mmc_host *mmc);
 
 #if defined(CONFIG_DEBUG_FS)
 static int dw_mci_req_show(struct seq_file *s, void *v)
@@ -1255,7 +1256,7 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	 */
 	spin_lock_bh(&host->lock);
 
-	if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
+	if (!dw_mci_get_cd(mmc)) {
 		spin_unlock_bh(&host->lock);
 		mrq->cmd->error = -ENOMEDIUM;
 		mmc_request_done(mmc, mrq);
-- 
2.3.7


