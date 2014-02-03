From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 8/8] mmc: dw_mmc: fix the checking whether card is present
Date: Mon, 03 Feb 2014 20:15:39 +0900
Message-ID: <52EF7A5B.3030902@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49506 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbaBCLPl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Feb 2014 06:15:41 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0F006DL3A4V0C0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 03 Feb 2014 20:15:40 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>

Broken card detection is assumed "the card is present".
Non-removable card didn't call get_cd().
dw-mmc controller didn't check whether card is present or not.
Because DW_MMC_CARD_PRESENT flag is set into dw_mci_get_cd().
If cd-pin is used, then dw_mci_get_cd() is called.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ac2907d..0d6ab8f 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -910,6 +910,7 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
+	struct dw_mci_board *brd = host->pdata;
 
 	WARN_ON(slot->mrq);
 
@@ -920,7 +921,8 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	 */
 	spin_lock_bh(&host->lock);
 
-	if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
+	if (!(brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION) &&
+			!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
 		spin_unlock_bh(&host->lock);
 		mrq->cmd->error = -ENOMEDIUM;
 		mmc_request_done(mmc, mrq);
-- 
1.7.9.5
