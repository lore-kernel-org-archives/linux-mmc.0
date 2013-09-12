From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/3] mmc: dw_mmc-socfpga: Remove redundant of_match_ptr
Date: Thu, 12 Sep 2013 12:16:35 +0530
Message-ID: <1378968396-18604-2-git-send-email-sachin.kamat@linaro.org>
References: <1378968396-18604-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:50918 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab3ILHEq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2013 03:04:46 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so10244526pdj.2
        for <linux-mmc@vger.kernel.org>; Thu, 12 Sep 2013 00:04:46 -0700 (PDT)
In-Reply-To: <1378968396-18604-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: tgih.jun@samsung.com, jh80.chung@samsung.com, cjb@laptop.org, nico@fluxnic.net, sachin.kamat@linaro.org

'dw_mci_socfpga_match' is always compiled in.
Hence of_match_ptr is not necessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/dw_mmc-socfpga.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
index 14b5961..5ce00b2 100644
--- a/drivers/mmc/host/dw_mmc-socfpga.c
+++ b/drivers/mmc/host/dw_mmc-socfpga.c
@@ -128,7 +128,7 @@ static struct platform_driver dw_mci_socfpga_pltfm_driver = {
 	.remove		= __exit_p(dw_mci_pltfm_remove),
 	.driver		= {
 		.name		= "dwmmc_socfpga",
-		.of_match_table	= of_match_ptr(dw_mci_socfpga_match),
+		.of_match_table	= dw_mci_socfpga_match,
 		.pm		= &dw_mci_pltfm_pmops,
 	},
 };
-- 
1.7.9.5

