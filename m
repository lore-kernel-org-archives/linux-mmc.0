From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] mmc: dw_mmc: exynos: Staticize dw_mci_exynos_pmops
Date: Tue,  4 Mar 2014 10:33:25 +0530
Message-ID: <1393909405-2760-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40633 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbaCDFJW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Mar 2014 00:09:22 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so4651973pdi.35
        for <linux-mmc@vger.kernel.org>; Mon, 03 Mar 2014 21:09:21 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, tgih.jun@samsung.com, chris@printf.net, jh80.chung@samsung.com, sachin.kamat@linaro.org

'dw_mci_exynos_pmops' is local to this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/dw_mmc-exynos.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 3423c5ed50c7..12f0929f12a9 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -426,7 +426,7 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
 	return dw_mci_pltfm_register(pdev, drv_data);
 }
 
-const struct dev_pm_ops dw_mci_exynos_pmops = {
+static const struct dev_pm_ops dw_mci_exynos_pmops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dw_mci_exynos_suspend, dw_mci_exynos_resume)
 	.resume_noirq = dw_mci_exynos_resume_noirq,
 	.thaw_noirq = dw_mci_exynos_resume_noirq,
-- 
1.7.9.5

