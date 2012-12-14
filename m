From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V2 2/2] mmc: mmci: Move ios_handler functionality into the driver
Date: Fri, 14 Dec 2012 15:30:29 +0100
Message-ID: <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:54512 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756124Ab2LNPA1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 10:00:27 -0500
In-Reply-To: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

From: Lee Jones <lee.jones@linaro.org>

There are currently two instances of the ios_handler being used.
Both of which mearly toy with some regulator settings. Now there
is a GPIO regulator API, we can use that instead, and lessen the
per platform burden. By doing this, we also become more Device
Tree compatible.

Cc: Chris Ball <cjb@laptop.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9da5f24..e56655a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1097,6 +1097,11 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	case MMC_POWER_OFF:
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+
+		if (!IS_ERR(mmc->supply.vqmmc) &&
+		    regulator_is_enabled(mmc->supply.vqmmc))
+			regulator_disable(mmc->supply.vqmmc);
+
 		break;
 	case MMC_POWER_UP:
 		if (!IS_ERR(mmc->supply.vmmc))
@@ -1111,6 +1116,10 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		break;
 	case MMC_POWER_ON:
+		if (!IS_ERR(mmc->supply.vqmmc) &&
+		    !regulator_is_enabled(mmc->supply.vqmmc))
+			regulator_enable(mmc->supply.vqmmc);
+
 		pwr |= MCI_PWR_ON;
 		break;
 	}
-- 
1.7.10

