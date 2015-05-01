From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 5/6] mmc: sdhci-imx: Constify platform_device_id
Date: Sat,  2 May 2015 00:49:21 +0900
Message-ID: <1430495362-31506-5-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33935 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338AbbEAPvb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 May 2015 11:51:31 -0400
In-Reply-To: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 82f512d87cb8..7b6ff7067320 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -161,7 +161,7 @@ struct pltfm_imx_data {
 	u32 is_ddr;
 };
 
-static struct platform_device_id imx_esdhc_devtype[] = {
+static const struct platform_device_id imx_esdhc_devtype[] = {
 	{
 		.name = "sdhci-esdhc-imx25",
 		.driver_data = (kernel_ulong_t) &esdhc_imx25_data,
-- 
2.1.4

