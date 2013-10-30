From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 5/7] mmc: dw_mmc: Remove redundant of_match_ptr
Date: Wed, 30 Oct 2013 17:13:48 +0530
Message-ID: <1383133430-22079-5-git-send-email-sachin.kamat@linaro.org>
References: <1383133430-22079-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:63811 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811Ab3J3LpT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 07:45:19 -0400
Received: by mail-pd0-f178.google.com with SMTP id x10so853945pdj.9
        for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2013 04:45:19 -0700 (PDT)
In-Reply-To: <1383133430-22079-1-git-send-email-sachin.kamat@linaro.org>
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

