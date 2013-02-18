From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] mmc: dw_mmc: Make dw_mci_exynos_probe static
Date: Mon, 18 Feb 2013 14:23:08 +0530
Message-ID: <1361177589-23953-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f52.google.com ([209.85.210.52]:46935 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab3BRJDE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Feb 2013 04:03:04 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so2344563dak.11
        for <linux-mmc@vger.kernel.org>; Mon, 18 Feb 2013 01:03:03 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, jh80.chung@samsung.com, sachin.kamat@linaro.org, patches@linaro.org, tgih.jun@samsung.com

Silences the following sparse warning:
drivers/mmc/host/dw_mmc-exynos.c:218:5: warning:
symbol 'dw_mci_exynos_probe' was not declared. Should it be static?

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/dw_mmc-exynos.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 72fd0f2..5a09c77 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -215,7 +215,7 @@ static const struct of_device_id dw_mci_exynos_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dw_mci_exynos_match);
 
-int dw_mci_exynos_probe(struct platform_device *pdev)
+static int dw_mci_exynos_probe(struct platform_device *pdev)
 {
 	const struct dw_mci_drv_data *drv_data;
 	const struct of_device_id *match;
-- 
1.7.4.1

