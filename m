From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH v2 1/3] mmc: sdhci: let GPIO based card detection have higher precedence
Date: Mon,  6 Jul 2015 15:16:19 +0300
Message-ID: <1436184981-16719-2-git-send-email-ivan.ivanov@linaro.org>
References: <1436184981-16719-1-git-send-email-ivan.ivanov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436184981-16719-1-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Aisheng Dong <b29396@freescale.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Controller could have BROKEN_CARD_DETECTION quirk set, but drivers
could use GPIO to detect card present state. Let, when defined, GPIO
take precedence, so drivers could properly detect card state and not
use polling.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 drivers/mmc/host/sdhci.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bc14452..dd91b24 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1601,15 +1601,21 @@ static int sdhci_do_get_cd(struct sdhci_host *host)
 	if (host->flags & SDHCI_DEVICE_DEAD)
 		return 0;

-	/* If polling/nonremovable, assume that the card is always present. */
-	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
-	    (host->mmc->caps & MMC_CAP_NONREMOVABLE))
+	/* If nonremovable, assume that the card is always present. */
+	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
 		return 1;

-	/* Try slot gpio detect */
+	/*
+	 * Try slot gpio detect, if defined it take precedence
+	 * over build in controller functionality
+	 */
 	if (!IS_ERR_VALUE(gpio_cd))
 		return !!gpio_cd;

+	/* If polling, assume that the card is always present. */
+	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
+		return 1;
+
 	/* Host native card detect */
 	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
 }
--
1.9.1
