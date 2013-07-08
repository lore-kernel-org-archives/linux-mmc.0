From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/3] mmc: sdhci-bcm-kona: Staticize sdhci_bcm_kona_card_event
Date: Mon,  8 Jul 2013 11:41:53 +0530
Message-ID: <1373263914-18050-3-git-send-email-sachin.kamat@linaro.org>
References: <1373263914-18050-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:39543 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab3GHG1f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jul 2013 02:27:35 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so3718248pdi.30
        for <linux-mmc@vger.kernel.org>; Sun, 07 Jul 2013 23:27:34 -0700 (PDT)
In-Reply-To: <1373263914-18050-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: csd@broadcom.com, cjb@laptop.org, sachin.kamat@linaro.org, patches@linaro.org

sdhci_bcm_kona_card_event is referenced only in this file.
Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/sdhci-bcm-kona.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index d7a44ae..f59f332 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -161,7 +161,7 @@ static int sdhci_bcm_kona_sd_card_emulate(struct sdhci_host *host, int insert)
 /*
  * SD card interrupt event callback
  */
-void sdhci_bcm_kona_card_event(struct sdhci_host *host)
+static void sdhci_bcm_kona_card_event(struct sdhci_host *host)
 {
 	if (mmc_gpio_get_cd(host->mmc) > 0) {
 		dev_dbg(mmc_dev(host->mmc),
-- 
1.7.9.5

