From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: remove the unnecessary IS_ERR() checking for
 ciu/biu clock
Date: Fri, 15 Jul 2016 10:54:08 +0900
Message-ID: <1468547648-4458-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:57650 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbcGOByN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2016 21:54:13 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0OAC02HUD2MB0590@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 15 Jul 2016 10:54:11 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

If ciu/biu clock are NULL, clk_disable_unprepare should be just
returned. In clk_disable_unprepare(), already checked whether clk is
error or NULL.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2dfdc58..9fab5ed 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3184,12 +3184,10 @@ err_dmaunmap:
 		host->dma_ops->exit(host);
 
 err_clk_ciu:
-	if (!IS_ERR(host->ciu_clk))
-		clk_disable_unprepare(host->ciu_clk);
+	clk_disable_unprepare(host->ciu_clk);
 
 err_clk_biu:
-	if (!IS_ERR(host->biu_clk))
-		clk_disable_unprepare(host->biu_clk);
+	clk_disable_unprepare(host->biu_clk);
 
 	return ret;
 }
@@ -3215,11 +3213,8 @@ void dw_mci_remove(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
-	if (!IS_ERR(host->ciu_clk))
-		clk_disable_unprepare(host->ciu_clk);
-
-	if (!IS_ERR(host->biu_clk))
-		clk_disable_unprepare(host->biu_clk);
+	clk_disable_unprepare(host->ciu_clk);
+	clk_disable_unprepare(host->biu_clk);
 }
 EXPORT_SYMBOL(dw_mci_remove);
 
-- 
1.9.1

