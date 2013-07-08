From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/3] mmc: sdhci-bcm-kona: Remove redundant use of_match_ptr
Date: Mon,  8 Jul 2013 11:41:52 +0530
Message-ID: <1373263914-18050-2-git-send-email-sachin.kamat@linaro.org>
References: <1373263914-18050-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:41102 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab3GHG1b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jul 2013 02:27:31 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so3922819pbb.36
        for <linux-mmc@vger.kernel.org>; Sun, 07 Jul 2013 23:27:31 -0700 (PDT)
In-Reply-To: <1373263914-18050-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: csd@broadcom.com, cjb@laptop.org, sachin.kamat@linaro.org, patches@linaro.org

sdhci_bcm_kona_of_match structure is always compiled in. Hence
of_match_ptr macro is not necessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/sdhci-bcm-kona.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index bca6d55..d7a44ae 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -335,7 +335,7 @@ static struct platform_driver sdhci_bcm_kona_driver = {
 		.name	= "sdhci-kona",
 		.owner	= THIS_MODULE,
 		.pm	= SDHCI_PLTFM_PMOPS,
-		.of_match_table = of_match_ptr(sdhci_bcm_kona_of_match),
+		.of_match_table = sdhci_bcm_kona_of_match,
 	},
 	.probe		= sdhci_bcm_kona_probe,
 	.remove		= __exit_p(sdhci_bcm_kona_remove),
-- 
1.7.9.5

