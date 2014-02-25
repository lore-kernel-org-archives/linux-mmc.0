From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 05/10] mmc: dw_mmc: Remove redundant of_match_ptr
Date: Tue, 25 Feb 2014 15:18:23 +0530
Message-ID: <1393321708-9719-5-git-send-email-sachin.kamat@linaro.org>
References: <1393321708-9719-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:58673 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaBYJyV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Feb 2014 04:54:21 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so7877202pab.2
        for <linux-mmc@vger.kernel.org>; Tue, 25 Feb 2014 01:54:21 -0800 (PST)
In-Reply-To: <1393321708-9719-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, sachin.kamat@linaro.org

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

