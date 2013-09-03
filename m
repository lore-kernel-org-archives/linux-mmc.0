From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V3 3/4] mmc: mmci: Adapt to register write restrictions
Date: Tue,  3 Sep 2013 11:29:35 +0200
Message-ID: <1378200576-13413-4-git-send-email-ulf.hansson@linaro.org>
References: <1378200576-13413-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:51776 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932610Ab3ICJaN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 05:30:13 -0400
Received: by mail-ea0-f181.google.com with SMTP id d10so2870359eaj.40
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2013 02:30:12 -0700 (PDT)
In-Reply-To: <1378200576-13413-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <jrudholm@gmail.com>

After a write to the MMCICLOCK register data cannot be written to this
register for three feedback clock cycles. Writes to the MMCIPOWER
register must be separated by three MCLK cycles. Previously no issues
has been observered, but using higher ARM clock frequencies on STE-
platforms has triggered this problem.

The MMCICLOCK register is written to in .set_ios and for some data
transmissions for SDIO. We do not need a delay at the data transmission
path, because sending and receiving data will require more than three
clock cycles. Then we use a simple logic to only delay in .set_ios and
thus we don't affect throughput performance.

Signed-off-by: Johan Rudholm <jrudholm@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 drivers/mmc/host/mmci.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c550b3e..82afcd3 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -189,6 +189,21 @@ static int mmci_validate_data(struct mmci_host *host,
 	return 0;
 }
 
+static void mmci_reg_delay(struct mmci_host *host)
+{
+	/*
+	 * According to the spec, at least three feedback clock cycles
+	 * of max 52 MHz must pass between two writes to the MMCICLOCK reg.
+	 * Three MCLK clock cycles must pass between two MMCIPOWER reg writes.
+	 * Worst delay time during card init is at 100 kHz => 30 us.
+	 * Worst delay time when up and running is at 25 MHz => 120 ns.
+	 */
+	if (host->cclk < 20000000)
+		udelay(30);
+	else
+		ndelay(120);
+}
+
 /*
  * This must be called with host->lock held
  */
@@ -1264,6 +1279,7 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	mmci_set_clkreg(host, ios->clock);
 	mmci_write_pwrreg(host, pwr);
+	mmci_reg_delay(host);
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-- 
1.7.9.5

