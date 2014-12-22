From: Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v3 2/3] mmc: dw_mmc: exynos: don't use if clock isn't available
Date: Mon, 22 Dec 2014 17:42:03 +0530
Message-ID: <1419250324-11743-3-git-send-email-alim.akhtar@samsung.com>
References: <1419250324-11743-1-git-send-email-alim.akhtar@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:15468 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbaLVMT6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Dec 2014 07:19:58 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NGZ006GNGX8G500@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 22 Dec 2014 21:19:57 +0900 (KST)
In-reply-to: <1419250324-11743-1-git-send-email-alim.akhtar@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@gmail.com, linux-arm-kernel@lists.infradead.org

From: Seungwon Jeon <tgih.jun@samsung.com>

Add checking whether the clock is valid.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 509365c..556663f 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -127,9 +127,9 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 static int dw_mci_exynos_setup_clock(struct dw_mci *host)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
-	unsigned long rate = clk_get_rate(host->ciu_clk);
 
-	host->bus_hz = rate / (priv->ciu_div + 1);
+	host->bus_hz /= (priv->ciu_div + 1);
+
 	return 0;
 }
 
@@ -232,8 +232,11 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 			mci_writel(host, CLKSEL, priv->sdr_timing);
 	}
 
-	/* Don't care if wanted clock is zero */
-	if (!wanted)
+	/*
+	 * Don't care if wanted clock is zero or
+	 * ciu clock is unavailable
+	 */
+	if (!wanted || IS_ERR(host->ciu_clk))
 		return;
 
 	/* Guaranteed minimum frequency for cclkin */
-- 
1.7.9.5

