From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH 3/3] mmc: sdhci: properly check card present state when quirk NO_CARD_NO_RESET is set
Date: Fri, 26 Jun 2015 13:00:10 +0300
Message-ID: <1435312810-23957-4-git-send-email-ivan.ivanov@linaro.org>
References: <1435312810-23957-1-git-send-email-ivan.ivanov@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33450 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbbFZKAS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jun 2015 06:00:18 -0400
Received: by wgck11 with SMTP id k11so84259937wgc.0
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2015 03:00:17 -0700 (PDT)
In-Reply-To: <1435312810-23957-1-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Aisheng Dong <b29396@freescale.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org

Controller could have both NO_CARD_NO_RESET and BROKEN_CARD_DETECTION
quirks set. Use sdhci_do_get_cd() when applying NO_CARD_NO_RESET, which
properly check for BROKEN_CARD_DETECTION quirk.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 drivers/mmc/host/sdhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0b65752..912a3bb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -207,8 +207,7 @@ EXPORT_SYMBOL_GPL(sdhci_reset);
 static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
 {
 	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
-		if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
-			SDHCI_CARD_PRESENT))
+		if (!sdhci_do_get_cd(host))
 			return;
 	}

--
1.9.1

