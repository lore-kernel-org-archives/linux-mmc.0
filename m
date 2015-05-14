From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 1/4] mmc: dw_mmc: k3: Fix modalias to make module auto-loading work
Date: Thu, 14 May 2015 16:59:44 +0800
Message-ID: <1431593987-455-2-git-send-email-zhangfei.gao@linaro.org>
References: <1431593987-455-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35974 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932443AbbENJAF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 May 2015 05:00:05 -0400
Received: by pdea3 with SMTP id a3so79693709pde.3
        for <linux-mmc@vger.kernel.org>; Thu, 14 May 2015 02:00:05 -0700 (PDT)
In-Reply-To: <1431593987-455-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

Make the modalias match driver name, this is required to make module
auto-loading work.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/mmc/host/dw_mmc-k3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 137670b..63c2e2e 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -193,4 +193,4 @@ module_platform_driver(dw_mci_k3_pltfm_driver);
 
 MODULE_DESCRIPTION("K3 Specific DW-MSHC Driver Extension");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:dwmmc-k3");
+MODULE_ALIAS("platform:dwmmc_k3");
-- 
1.9.1

