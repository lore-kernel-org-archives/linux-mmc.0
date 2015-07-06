From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH v2 2/3] mmc: sdhci: don't use card state polling when CD GPIO is defined
Date: Mon,  6 Jul 2015 15:16:20 +0300
Message-ID: <1436184981-16719-3-git-send-email-ivan.ivanov@linaro.org>
References: <1436184981-16719-1-git-send-email-ivan.ivanov@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34227 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952AbbGFMQf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jul 2015 08:16:35 -0400
Received: by wifm2 with SMTP id m2so27881749wif.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2015 05:16:33 -0700 (PDT)
In-Reply-To: <1436184981-16719-1-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Aisheng Dong <b29396@freescale.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org

There is no reason to use polling for card detection state change when
drivers are using dedicated GPIO for this. Don't poll in this case.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index dd91b24..02ac7a4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3124,7 +3124,8 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;

 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
-	    !(mmc->caps & MMC_CAP_NONREMOVABLE))
+	    !(mmc->caps & MMC_CAP_NONREMOVABLE) &&
+	    IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc)))
 		mmc->caps |= MMC_CAP_NEEDS_POLL;

 	/* If there are external regulators, get them */
--
1.9.1

