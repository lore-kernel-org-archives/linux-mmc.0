From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc: minor cleanup for dw_mci_adjust_fifoth
Date: Wed, 21 Sep 2016 10:40:25 +0800
Message-ID: <1474425625-24178-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:43706 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755361AbcIUCj7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2016 22:39:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

msize and rx_wmark are properly initialized, we dont't
need to assign them again.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 22dacae..d838428 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -876,11 +876,8 @@ static void dw_mci_adjust_fifoth(struct dw_mci *host, struct mmc_data *data)
 	 * MSIZE is '1',
 	 * if blksz is not a multiple of the FIFO width
 	 */
-	if (blksz % fifo_width) {
-		msize = 0;
-		rx_wmark = 1;
+	if (blksz % fifo_width)
 		goto done;
-	}
 
 	do {
 		if (!((blksz_depth % mszs[idx]) ||
-- 
2.3.7


