From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] mmc: dw_mmc: exynos: Remove unnecessary use of of_match_ptr()
Date: Mon, 18 Feb 2013 14:23:09 +0530
Message-ID: <1361177589-23953-2-git-send-email-sachin.kamat@linaro.org>
References: <1361177589-23953-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:54031 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab3BRJDH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Feb 2013 04:03:07 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so2423454dak.16
        for <linux-mmc@vger.kernel.org>; Mon, 18 Feb 2013 01:03:07 -0800 (PST)
In-Reply-To: <1361177589-23953-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, jh80.chung@samsung.com, sachin.kamat@linaro.org, patches@linaro.org, tgih.jun@samsung.com

'dw_mci_exynos_match' is always compiled in. Hence of_match_ptr
is not required.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/dw_mmc-exynos.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 5a09c77..517a603 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -230,7 +230,7 @@ static struct platform_driver dw_mci_exynos_pltfm_driver = {
 	.remove		= __exit_p(dw_mci_pltfm_remove),
 	.driver		= {
 		.name		= "dwmmc_exynos",
-		.of_match_table	= of_match_ptr(dw_mci_exynos_match),
+		.of_match_table	= dw_mci_exynos_match,
 		.pm		= &dw_mci_pltfm_pmops,
 	},
 };
-- 
1.7.4.1

