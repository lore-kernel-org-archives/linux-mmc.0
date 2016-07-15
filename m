From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/2] mmc: dw_mmc: rockchip: unset the MMC_CAP_ERASE flag
Date: Fri, 15 Jul 2016 10:54:51 +0900
Message-ID: <1468547691-4525-2-git-send-email-jh80.chung@samsung.com>
References: <1468547691-4525-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:38119 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbcGOBzM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2016 21:55:12 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0OAC01SLU2NH1TD0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 15 Jul 2016 10:54:53 +0900 (KST)
In-reply-to: <1468547691-4525-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

In dw_mmc.c, it's enabled by default.
It doesn't need to set MMC_CAP_ERASE in rockchip anymore.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index d3cf1f1..25eae35 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -294,10 +294,10 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 
 /* Common capabilities of RK3288 SoC */
 static unsigned long dw_mci_rk3288_dwmmc_caps[4] = {
-	MMC_CAP_ERASE | MMC_CAP_CMD23,
-	MMC_CAP_ERASE | MMC_CAP_CMD23,
-	MMC_CAP_ERASE | MMC_CAP_CMD23,
-	MMC_CAP_ERASE | MMC_CAP_CMD23,
+	MMC_CAP_CMD23,
+	MMC_CAP_CMD23,
+	MMC_CAP_CMD23,
+	MMC_CAP_CMD23,
 };
 
 static const struct dw_mci_drv_data rk2928_drv_data = {
-- 
1.9.1

