From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv3] mmc: atmel-mci: add vmmc-supply support
Date: Thu, 17 Oct 2013 12:46:48 +0200
Message-ID: <1382006808-22728-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49948 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750726Ab3JQKrP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Oct 2013 06:47:15 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: ulf.hansson@linaro.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Other MMC hosts handle a regulator named vmmc-supply that allows to power the
MMC card or SDIO device before communicating on the bus.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---

Changes in v2:
 - use mmc_regulator_get_supply instead of devm_regulator_get

Changes in v3:
 - en/disable the regulator in .set_ios using mmc_regulator_set_ocr

 drivers/mmc/host/atmel-mci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 69e438e..a9e1ba6 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1385,8 +1385,14 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		clk_unprepare(host->mck);
 
 	switch (ios->power_mode) {
+	case MMC_POWER_OFF:
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		break;
 	case MMC_POWER_UP:
 		set_bit(ATMCI_CARD_NEED_INIT, &slot->flags);
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
 		break;
 	default:
 		/*
@@ -2196,6 +2202,7 @@ static int __init atmci_init_slot(struct atmel_mci *host,
 	}
 
 	host->slot[id] = slot;
+	mmc_regulator_get_supply(mmc);
 	mmc_add_host(mmc);
 
 	if (gpio_is_valid(slot->detect_pin)) {
-- 
1.8.1.2

