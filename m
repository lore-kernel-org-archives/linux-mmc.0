From: Dongjin Kim <tobetter@gmail.com>
Subject: [PATCH] mmc: dw_mmc: Add MSHC compatible for Exynos4412
Date: Thu, 24 Jan 2013 00:24:38 +0900
Message-ID: <1358954692-5625-1-git-send-email-tobetter@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dongjin Kim <tobetter@gmail.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Thomas Abraham <thomas.abraham@linaro.org>, Will Newton <will.newton@imgtec.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This patch adds the compatible string for MSHC controller of Exynos4412, and
reuse the controller specific properties with Exynos5250 since those have same
features.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 0cb9bcb..4f7685f 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -204,6 +204,8 @@ static const struct dw_mci_drv_data exynos5250_drv_data = {
 };
 
 static const struct of_device_id dw_mci_exynos_match[] = {
+	{ .compatible = "samsung,exynos4412-dw-mshc",
+			.data = &exynos5250_drv_data, },
 	{ .compatible = "samsung,exynos5250-dw-mshc",
 			.data = &exynos5250_drv_data, },
 	{},
-- 
1.7.10.4
