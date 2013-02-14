From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v2] mmc: host: sdhci: Fix parameter of sdhci_do_start_signal_voltage_switch()
Date: Thu, 14 Feb 2013 10:35:03 -0200
Message-ID: <1360845303-21620-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:2259 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759672Ab3BNMfp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Feb 2013 07:35:45 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: kliu5@marvell.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Fabio Estevam <fabio.estevam@freescale.com>

Commit 3714f4315354 (mmc: sdhci: update signal voltage switch code) changed the 
type of the second parameter of sdhci_do_start_signal_voltage_switch(), from
"struct mmc_ios *ios" to "int signal_voltage" which causes the following build 
warning:

drivers/mmc/host/sdhci.c:2044:2: warning: initialization from incompatible pointer type [enabled by default]
drivers/mmc/host/sdhci.c:2044:2: warning: (near initialization for 'sdhci_ops.start_signal_voltage_switch') [enabled by default]

Use the previous type so that it matches the start_signal_voltage_switch()
definition from host.h.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Fix it inside sdhci to avoid breakage on other mmc controllers

 drivers/mmc/host/sdhci.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 735526b..51bbba4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1675,7 +1675,7 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 }
 
 static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
-						int signal_voltage)
+						struct mmc_ios *ios)
 {
 	u16 ctrl;
 	int ret;
@@ -1689,7 +1689,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 
-	switch (signal_voltage) {
+	switch (ios->signal_voltage) {
 	case MMC_SIGNAL_VOLTAGE_330:
 		/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
 		ctrl &= ~SDHCI_CTRL_VDD_180;
@@ -1762,7 +1762,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 }
 
 static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
-	int signal_voltage)
+	struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	int err;
@@ -1770,7 +1770,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 	if (host->version < SDHCI_SPEC_300)
 		return 0;
 	sdhci_runtime_pm_get(host);
-	err = sdhci_do_start_signal_voltage_switch(host, signal_voltage);
+	err = sdhci_do_start_signal_voltage_switch(host, ios);
 	sdhci_runtime_pm_put(host);
 	return err;
 }
-- 
1.7.9.5


