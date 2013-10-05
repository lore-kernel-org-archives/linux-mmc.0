From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/3] mmc:sdhci-esdhc-imx: Use NULL instead of zero
Date: Fri,  4 Oct 2013 22:59:23 -0300
Message-ID: <1380938365-7769-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f48.google.com ([209.85.213.48]:40887 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab3JEB7j (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Oct 2013 21:59:39 -0400
Received: by mail-yh0-f48.google.com with SMTP id f11so1182870yha.21
        for <linux-mmc@vger.kernel.org>; Fri, 04 Oct 2013 18:59:38 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following sparse warning:

drivers/mmc/host/sdhci-esdhc-imx.c:617:35: warning: Using plain integer as NULL pointer

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b9899e9..086ea52 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -614,7 +614,7 @@ static void esdhc_request_done(struct mmc_request *mrq)
 static int esdhc_send_tuning_cmd(struct sdhci_host *host, u32 opcode)
 {
 	struct mmc_command cmd = {0};
-	struct mmc_request mrq = {0};
+	struct mmc_request mrq = { NULL };
 	struct mmc_data data = {0};
 	struct scatterlist sg;
 	char tuning_pattern[ESDHC_TUNING_BLOCK_PATTERN_LEN];
-- 
1.8.1.2

