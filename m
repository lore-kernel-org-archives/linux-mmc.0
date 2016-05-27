From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/2] mmc: dw_mmc: check card present before starting request
Date: Fri, 27 May 2016 14:37:05 +0800
Message-ID: <1464331025-16275-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

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

Changes in v2:
- hold lock before dw_mci_queue_request

 drivers/mmc/host/dw_mmc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index cb30e91..2b4b3df 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -105,6 +105,7 @@ struct idmac_desc {
 static bool dw_mci_reset(struct dw_mci *host);
 static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
 static int dw_mci_card_busy(struct mmc_host *mmc);
+static int dw_mci_get_cd(struct mmc_host *mmc);
 
 #if defined(CONFIG_DEBUG_FS)
 static int dw_mci_req_show(struct seq_file *s, void *v)
@@ -1253,15 +1254,15 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	 * atomic, otherwise the card could be removed in between and the
 	 * request wouldn't fail until another card was inserted.
 	 */
-	spin_lock_bh(&host->lock);
 
-	if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
-		spin_unlock_bh(&host->lock);
+	if (!dw_mci_get_cd(mmc)) {
 		mrq->cmd->error = -ENOMEDIUM;
 		mmc_request_done(mmc, mrq);
 		return;
 	}
 
+	spin_lock_bh(&host->lock);
+
 	dw_mci_queue_request(host, slot, mrq);
 
 	spin_unlock_bh(&host->lock);
-- 
2.3.7
