From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH] mmc: dw_mmc: exynos: Revert the sdr_timing assignment
Date: Tue, 22 Oct 2013 14:41:56 +0530
Message-ID: <1382433116-22180-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:51778 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab3JVJMU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Oct 2013 05:12:20 -0400
Received: by mail-pb0-f52.google.com with SMTP id wy17so5300766pbc.25
        for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2013 02:12:20 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, thomas.ab@samsung.com, grundler@chromium.org
Cc: dianders@chromium.org, sonnyrao@chromium.org, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

commit 4ad602c9df1e3b04979c260b5612141b4b892257 was wrongly assigning
ddr_timing value to sdr_timing.This patch fix's this by reverting
the sdr_timing assignment statement to the earlier location.

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index d42e664..3423c5e 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -251,12 +251,13 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
 	if (ret)
 		return ret;
 
+	priv->sdr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
+
 	ret = of_property_read_u32_array(np,
 			"samsung,dw-mshc-ddr-timing", timing, 2);
 	if (ret)
 		return ret;
 
-	priv->sdr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
 	priv->ddr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
 	host->priv = priv;
 	return 0;
-- 
1.7.9.5

