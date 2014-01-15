From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 5/9] mmc: dw_mmc: Remove redundant of_match_ptr
Date: Wed, 15 Jan 2014 11:25:09 +0530
Message-ID: <1389765313-16744-5-git-send-email-sachin.kamat@linaro.org>
References: <1389765313-16744-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:51188 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaAOF7g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 00:59:36 -0500
Received: by mail-pb0-f41.google.com with SMTP id up15so157053pbc.28
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2014 21:59:35 -0800 (PST)
In-Reply-To: <1389765313-16744-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, sachin.kamat@linaro.org, patches@linaro.org

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

