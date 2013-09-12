From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/3] mmc: dw_mmc-socfpga: Staticize dw_mci_socfpga_probe
Date: Thu, 12 Sep 2013 12:16:36 +0530
Message-ID: <1378968396-18604-3-git-send-email-sachin.kamat@linaro.org>
References: <1378968396-18604-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:62999 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab3ILHEt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2013 03:04:49 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so694792pab.22
        for <linux-mmc@vger.kernel.org>; Thu, 12 Sep 2013 00:04:49 -0700 (PDT)
In-Reply-To: <1378968396-18604-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: tgih.jun@samsung.com, jh80.chung@samsung.com, cjb@laptop.org, nico@fluxnic.net, sachin.kamat@linaro.org

'dw_mci_socfpga_probe' is used only in this file. Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/dw_mmc-socfpga.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
index 5ce00b2..56c7fe2 100644
--- a/drivers/mmc/host/dw_mmc-socfpga.c
+++ b/drivers/mmc/host/dw_mmc-socfpga.c
@@ -113,7 +113,7 @@ static const struct of_device_id dw_mci_socfpga_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dw_mci_socfpga_match);
 
-int dw_mci_socfpga_probe(struct platform_device *pdev)
+static int dw_mci_socfpga_probe(struct platform_device *pdev)
 {
 	const struct dw_mci_drv_data *drv_data;
 	const struct of_device_id *match;
-- 
1.7.9.5

