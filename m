From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/3] mmc: dw_mmc: Remove redundant of_match_ptr
Date: Mon, 30 Sep 2013 10:29:32 +0530
Message-ID: <1380517173-10537-2-git-send-email-sachin.kamat@linaro.org>
References: <1380517173-10537-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:38861 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab3I3E7s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Sep 2013 00:59:48 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so5173073pdi.28
        for <linux-mmc@vger.kernel.org>; Sun, 29 Sep 2013 21:59:47 -0700 (PDT)
In-Reply-To: <1380517173-10537-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, tgih.jun@samsung.com, jh80.chung@samsung.com, sachin.kamat@linaro.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/dw_mmc-pltfm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 5c49656..2553bfb 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -123,7 +123,7 @@ static struct platform_driver dw_mci_pltfm_driver = {
 	.remove		= dw_mci_pltfm_remove,
 	.driver		= {
 		.name		= "dw_mmc",
-		.of_match_table	= of_match_ptr(dw_mci_pltfm_match),
+		.of_match_table	= dw_mci_pltfm_match,
 		.pm		= &dw_mci_pltfm_pmops,
 	},
 };
-- 
1.7.9.5

