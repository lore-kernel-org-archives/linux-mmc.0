From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH 2/3] mmc: sdhci: don't use card state polling when CD GPIO is defined
Date: Fri, 26 Jun 2015 13:00:09 +0300
Message-ID: <1435312810-23957-3-git-send-email-ivan.ivanov@linaro.org>
References: <1435312810-23957-1-git-send-email-ivan.ivanov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435312810-23957-1-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Aisheng Dong <b29396@freescale.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

There is no reason to use polling for card detection state change when
drivers are using dedicated GPIO for this. Don't poll in this case.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8bafb9f..0b65752 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3121,7 +3121,8 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;

 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
-	    !(mmc->caps & MMC_CAP_NONREMOVABLE))
+	    !(mmc->caps & MMC_CAP_NONREMOVABLE) &&
+	    IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc)))
 		mmc->caps |= MMC_CAP_NEEDS_POLL;

 	/* If there are external regulators, get them */
--
1.9.1
