From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] mmc: dw_mmc: exynos: Add compatibility for exynos4412 SoC
Date: Thu,  7 Feb 2013 17:27:15 +0530
Message-ID: <1360238236-17694-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f47.google.com ([209.85.210.47]:63568 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756686Ab3BGMGs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Feb 2013 07:06:48 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so1169877dak.6
        for <linux-mmc@vger.kernel.org>; Thu, 07 Feb 2013 04:06:47 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, tgih.jun@samsung.com, jh80.chung@samsung.com, sachin.kamat@linaro.org, patches@linaro.org, Thomas Abraham <thomas.abraham@linaro.org>

Added compatibility string for Exynos4412 SoC.

Cc: Thomas Abraham <thomas.abraham@linaro.org>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/dw_mmc-exynos.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 72fd0f2..f15b4d3 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -209,6 +209,8 @@ static const struct dw_mci_drv_data exynos5250_drv_data = {
 };
 
 static const struct of_device_id dw_mci_exynos_match[] = {
+	{ .compatible = "samsung,exynos4412-dw-mshc",
+			.data = &exynos5250_drv_data, },
 	{ .compatible = "samsung,exynos5250-dw-mshc",
 			.data = &exynos5250_drv_data, },
 	{},
-- 
1.7.4.1

