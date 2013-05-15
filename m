From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 2/4] mmc: mmci: Support signal voltage switch for UHS cards
Date: Wed, 15 May 2013 11:40:20 +0200
Message-ID: <1368610823-14113-3-git-send-email-ulf.hansson@stericsson.com>
References: <1368610823-14113-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog125.obsmtp.com ([207.126.144.159]:44957 "EHLO
	eu1sys200aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758800Ab3EOJmE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 May 2013 05:42:04 -0400
In-Reply-To: <1368610823-14113-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

Add .start_signal_voltage_switch callback to be able to support UHS cards.
The voltage switch requires the optional vqmmc regulator to exist since
the actual voltage switch will be performed directly on it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2983c15..8d4ceb8 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1253,6 +1253,39 @@ static int mmci_get_cd(struct mmc_host *mmc)
 	return status;
 }
 
+static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	int ret = 0;
+
+	if (!IS_ERR(mmc->supply.vqmmc)) {
+
+		pm_runtime_get_sync(mmc_dev(mmc));
+
+		switch (ios->signal_voltage) {
+		case MMC_SIGNAL_VOLTAGE_330:
+			ret = regulator_set_voltage(mmc->supply.vqmmc,
+						2700000, 3600000);
+			break;
+		case MMC_SIGNAL_VOLTAGE_180:
+			ret = regulator_set_voltage(mmc->supply.vqmmc,
+						1700000, 1950000);
+			break;
+		case MMC_SIGNAL_VOLTAGE_120:
+			ret = regulator_set_voltage(mmc->supply.vqmmc,
+						1100000, 1300000);
+			break;
+		}
+
+		if (ret)
+			dev_warn(mmc_dev(mmc), "Voltage switch failed\n");
+
+		pm_runtime_mark_last_busy(mmc_dev(mmc));
+		pm_runtime_put_autosuspend(mmc_dev(mmc));
+	}
+
+	return ret;
+}
+
 static irqreturn_t mmci_cd_irq(int irq, void *dev_id)
 {
 	struct mmci_host *host = dev_id;
@@ -1269,6 +1302,7 @@ static const struct mmc_host_ops mmci_ops = {
 	.set_ios	= mmci_set_ios,
 	.get_ro		= mmci_get_ro,
 	.get_cd		= mmci_get_cd,
+	.start_signal_voltage_switch = mmci_sig_volt_switch,
 };
 
 #ifdef CONFIG_OF
-- 
1.7.10

