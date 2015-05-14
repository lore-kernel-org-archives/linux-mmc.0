From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 4/4] mmc: sdhci-st: Fix modalias to make module auto-loading work
Date: Thu, 14 May 2015 16:59:47 +0800
Message-ID: <1431593987-455-5-git-send-email-zhangfei.gao@linaro.org>
References: <1431593987-455-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36444 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbbENJAU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 May 2015 05:00:20 -0400
Received: by pdea3 with SMTP id a3so79701879pde.3
        for <linux-mmc@vger.kernel.org>; Thu, 14 May 2015 02:00:20 -0700 (PDT)
In-Reply-To: <1431593987-455-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>, Peter Griffin <peter.griffin@linaro.org>

Make the modalias match driver name, this is required to make module
auto-loading work.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/mmc/host/sdhci-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 682f2bb..969c2b0 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -509,4 +509,4 @@ module_platform_driver(sdhci_st_driver);
 MODULE_DESCRIPTION("SDHCI driver for STMicroelectronics SoCs");
 MODULE_AUTHOR("Giuseppe Cavallaro <peppe.cavallaro@st.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:st-sdhci");
+MODULE_ALIAS("platform:sdhci-st");
-- 
1.9.1

