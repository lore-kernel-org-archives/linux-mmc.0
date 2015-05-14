From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 3/4] mmc: dw_mmc: rockchip: Fix modalias to make module auto-loading work
Date: Thu, 14 May 2015 16:59:46 +0800
Message-ID: <1431593987-455-4-git-send-email-zhangfei.gao@linaro.org>
References: <1431593987-455-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33246 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbbENJAP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 May 2015 05:00:15 -0400
Received: by pdbnk13 with SMTP id nk13so79851294pdb.0
        for <linux-mmc@vger.kernel.org>; Thu, 14 May 2015 02:00:15 -0700 (PDT)
In-Reply-To: <1431593987-455-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>, Doug Anderson <dianders@chromium.org>

Make the modalias match driver name, this is required to make module
auto-loading work.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index dbf166f..de15121 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -153,5 +153,5 @@ module_platform_driver(dw_mci_rockchip_pltfm_driver);
 
 MODULE_AUTHOR("Addy Ke <addy.ke@rock-chips.com>");
 MODULE_DESCRIPTION("Rockchip Specific DW-MSHC Driver Extension");
-MODULE_ALIAS("platform:dwmmc-rockchip");
+MODULE_ALIAS("platform:dwmmc_rockchip");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1

