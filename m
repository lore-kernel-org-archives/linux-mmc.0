From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/2] mmc: dw_mmc: remove redundant of set_bit and clear_bit
Date: Fri, 27 May 2016 14:36:40 +0800
Message-ID: <1464331000-16230-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:40280 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbcE0GhJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 May 2016 02:37:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

dw_mci_get_cd have already dealt with these for
both of internal card-detect and gpio card-detect.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 829a6ee..cb30e91 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2616,10 +2616,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 		mmc->max_seg_size = mmc->max_req_size;
 	}
 
-	if (dw_mci_get_cd(mmc))
-		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
-	else
-		clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
+	dw_mci_get_cd(mmc);
 
 	ret = mmc_add_host(mmc);
 	if (ret)
-- 
2.3.7


