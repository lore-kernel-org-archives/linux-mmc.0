From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 10/21] mmc: sdhci: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date: Wed, 27 Jan 2016 13:08:03 +0800
Message-ID: <1453871283-3724-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

SDHCI_QUIRK_BROKEN_CARD_DETECTION is for "broken-cd".
If we add MMC_CAP_NONREMOVABLE("non-removeble"), we shoud
not add "broken-cd" together according to mmc.txt for
dt-bingdings. Also, "broken-cd" can obtain from mmc_of_parse,
which will add MMC_CAP_NEEDS_POLL into mmc->caps.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d622435..b208cb7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -145,7 +145,7 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 {
 	u32 present;
 
-	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
+	if ((host->mmc->caps & MMC_CAP_NEEDS_POLL) ||
 	    (host->mmc->caps & MMC_CAP_NONREMOVABLE))
 		return;
 
@@ -1618,7 +1618,8 @@ static int sdhci_do_get_cd(struct sdhci_host *host)
 		return 0;
 
 	/* If nonremovable, assume that the card is always present. */
-	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
+	if (host->mmc->caps & MMC_CAP_NONREMOVABLE ||
+	    host->mmc->caps & MMC_CAP_NEEDS_POLL)
 		return 1;
 
 	/*
@@ -1628,10 +1629,6 @@ static int sdhci_do_get_cd(struct sdhci_host *host)
 	if (!IS_ERR_VALUE(gpio_cd))
 		return !!gpio_cd;
 
-	/* If polling, assume that the card is always present. */
-	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
-		return 1;
-
 	/* Host native card detect */
 	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
 }
@@ -2658,7 +2655,7 @@ void sdhci_enable_irq_wakeups(struct sdhci_host *host)
 	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
 	val |= mask ;
 	/* Avoid fake wake up */
-	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
+	if (host->mmc->caps & MMC_CAP_NEEDS_POLL)
 		val &= ~(SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE);
 	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
 }
@@ -3112,8 +3109,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps[0] & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
-	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
-	    !(mmc->caps & MMC_CAP_NONREMOVABLE) &&
+	if (!(mmc->caps & MMC_CAP_NONREMOVABLE) &&
 	    IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc)))
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
-- 
2.3.7
