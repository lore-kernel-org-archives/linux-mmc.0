From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 5/7] mmc: dw_mmc: Remove redundant of_match_ptr
Date: Thu, 19 Dec 2013 14:13:32 +0530
Message-ID: <1387442614-4193-5-git-send-email-sachin.kamat@linaro.org>
References: <1387442614-4193-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38194 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab3LSIrB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 03:47:01 -0500
Received: by mail-pa0-f46.google.com with SMTP id kl14so875785pab.33
        for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2013 00:47:01 -0800 (PST)
In-Reply-To: <1387442614-4193-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc-pltfm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 5c4965655297..2553bfbfc6df 100644
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

