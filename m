From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 4/4] mmc: dw_mmc: fixed wrong condtion checking.
Date: Fri, 05 Sep 2014 14:15:00 +0900
Message-ID: <1409894100-4713-5-git-send-email-jh80.chung@samsung.com>
References: <1409894100-4713-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36812 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbaIEFPI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Sep 2014 01:15:08 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NBE00ID8X93CTD0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 05 Sep 2014 14:15:03 +0900 (KST)
In-reply-to: <1409894100-4713-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

DDR mode can use  with 4bit or 8bit buswidth.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index aee39bc..0884df6 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -190,8 +190,7 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	if (ios->timing == MMC_TIMING_MMC_DDR52) {
 		mci_writel(host, CLKSEL, priv->ddr_timing);
 		/* Should be double rate for DDR mode */
-		if (ios->bus_width == MMC_BUS_WIDTH_8)
-			wanted <<= 1;
+		wanted <<= 1;
 	} else {
 		mci_writel(host, CLKSEL, priv->sdr_timing);
 	}
-- 
1.7.9.5

