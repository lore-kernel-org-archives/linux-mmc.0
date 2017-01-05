From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC 1/3] mmc: host: tmio: refactor calls to sdio irq
Date: Thu,  5 Jan 2017 12:43:24 +0100
Message-ID: <20170105114326.12426-2-wsa+renesas@sang-engineering.com>
References: <20170105114326.12426-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:47318 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970577AbdAELuR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 5 Jan 2017 06:50:17 -0500
In-Reply-To: <20170105114326.12426-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>

tmio_mmc_sdio_irq() is not used as a seperate irq handler anymore, so we
can make it similar to the other irq helper functions, namely:

* only give the host as argument function which is what it really needs
* prefix function name with __

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 3ca97f3c307975..60dc43b4574117 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -709,9 +709,8 @@ static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host,
 	return false;
 }
 
-static void tmio_mmc_sdio_irq(int irq, void *devid)
+static void __tmio_mmc_sdio_irq(struct tmio_mmc_host *host)
 {
-	struct tmio_mmc_host *host = devid;
 	struct mmc_host *mmc = host->mmc;
 	struct tmio_mmc_data *pdata = host->pdata;
 	unsigned int ireg, status;
@@ -752,7 +751,7 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 	if (__tmio_mmc_sdcard_irq(host, ireg, status))
 		return IRQ_HANDLED;
 
-	tmio_mmc_sdio_irq(irq, devid);
+	__tmio_mmc_sdio_irq(host);
 
 	return IRQ_HANDLED;
 }
-- 
2.11.0

