From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 31/38] mmc: sdhci: move remaining power handling into
 sdhci_set_power()
Date: Wed, 23 Apr 2014 20:08:48 +0100
Message-ID: <E1Wd2XI-0003wM-P5@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46518 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932456AbaDWTIu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:08:50 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

Move the remaining parts of the power handling in sdhci_do_set_ios()
into sdhci_set_power().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index decc5c64efb8..a3334460c0c6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1216,12 +1216,13 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 }
 EXPORT_SYMBOL_GPL(sdhci_set_clock);
 
-static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
+static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
+			    unsigned short vdd)
 {
 	u8 pwr = 0;
 
-	if (power != (unsigned short)-1) {
-		switch (1 << power) {
+	if (mode != MMC_POWER_OFF) {
+		switch (1 << vdd) {
 		case MMC_VDD_165_195:
 			pwr = SDHCI_POWER_180;
 			break;
@@ -1247,7 +1248,7 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
 		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
 			sdhci_runtime_pm_bus_off(host);
-		power = 0;
+		vdd = 0;
 	} else {
 		/*
 		 * Spec says that we should clear the power reg before setting
@@ -1281,7 +1282,7 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 
 	if (host->vmmc) {
 		spin_unlock_irq(&host->lock);
-		mmc_regulator_set_ocr(host->mmc, host->vmmc, power);
+		mmc_regulator_set_ocr(host->mmc, host->vmmc, vdd);
 		spin_lock_irq(&host->lock);
 	}
 }
@@ -1463,10 +1464,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		host->clock = ios->clock;
 	}
 
-	if (ios->power_mode == MMC_POWER_OFF)
-		sdhci_set_power(host, -1);
-	else
-		sdhci_set_power(host, ios->vdd);
+	sdhci_set_power(host, ios->power_mode, ios->vdd);
 
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
-- 
1.8.3.1

