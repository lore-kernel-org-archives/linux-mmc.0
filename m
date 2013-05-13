From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 2/3] mmc: mmci: Adapt to register write restrictions
Date: Mon, 13 May 2013 15:47:16 +0200
Message-ID: <1368452837-31458-3-git-send-email-ulf.hansson@stericsson.com>
References: <1368452837-31458-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:49660 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752727Ab3EMNsR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 09:48:17 -0400
In-Reply-To: <1368452837-31458-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rickard Andersson <rickard.andersson@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <jrudholm@gmail.com>

From: Ulf Hansson <ulf.hansson@linaro.org>

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

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Johan Rudholm <jrudholm@gmail.com>
---
 drivers/mmc/host/mmci.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 98b0c16..7815816 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -166,6 +166,21 @@ static int mmci_validate_data(struct mmci_host *host,
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
@@ -1212,6 +1227,7 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	mmci_set_clkreg(host, ios->clock);
 	mmci_write_pwrreg(host, pwr);
+	mmci_reg_delay(host);
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-- 
1.7.10

