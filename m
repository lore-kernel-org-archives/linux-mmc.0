From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 6/6] mmc: sdhc-s3c: Constify platform_device_id
Date: Sat,  2 May 2015 00:49:22 +0900
Message-ID: <1430495362-31506-6-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36388 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525AbbEAPve (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 May 2015 11:51:34 -0400
In-Reply-To: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/mmc/host/sdhci-s3c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index c6d2dd7317c1..70c724bc6fc7 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -736,7 +736,7 @@ static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
 #define EXYNOS4_SDHCI_DRV_DATA ((kernel_ulong_t)NULL)
 #endif
 
-static struct platform_device_id sdhci_s3c_driver_ids[] = {
+static const struct platform_device_id sdhci_s3c_driver_ids[] = {
 	{
 		.name		= "s3c-sdhci",
 		.driver_data	= (kernel_ulong_t)NULL,
-- 
2.1.4

