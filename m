From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 2/4] mmc: dw_mmc: exynos: Fix modalias to make module auto-loading work
Date: Thu, 14 May 2015 16:59:45 +0800
Message-ID: <1431593987-455-3-git-send-email-zhangfei.gao@linaro.org>
References: <1431593987-455-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35094 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbbENJAK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 May 2015 05:00:10 -0400
Received: by pabtp1 with SMTP id tp1so78827406pab.2
        for <linux-mmc@vger.kernel.org>; Thu, 14 May 2015 02:00:09 -0700 (PDT)
In-Reply-To: <1431593987-455-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

Make the modalias match driver name, this is required to make module
auto-loading work.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/mmc/host/dw_mmc-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index e761eb1..1e75309 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -556,4 +556,4 @@ module_platform_driver(dw_mci_exynos_pltfm_driver);
 MODULE_DESCRIPTION("Samsung Specific DW-MSHC Driver Extension");
 MODULE_AUTHOR("Thomas Abraham <thomas.ab@samsung.com");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:dwmmc-exynos");
+MODULE_ALIAS("platform:dwmmc_exynos");
-- 
1.9.1

