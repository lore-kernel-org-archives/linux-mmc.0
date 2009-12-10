From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH]OMAP35xx:SDIO IRQ Support for OMAP35xx
Date: Thu, 10 Dec 2009 11:20:26 +0200
Message-ID: <4B20BD5A.6050004@nokia.com>
References: <8B7FC6A3798741D6B3E3284E1A8D7A27@embwise16de1b5>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63807 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758020AbZLJJUf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Dec 2009 04:20:35 -0500
In-Reply-To: <8B7FC6A3798741D6B3E3284E1A8D7A27@embwise16de1b5>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Phaneedra Kumar Alapati <phani@embwise.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, "Paasikivi Teemu.3 (EXT-Ixonos/Tampere)" <ext-teemu.3.paasikivi@nokia.com>

CC'ing linux-mmc list and the maintainer Madhusudhan Chikkature
and others who might be interested.


-------- Original Message --------
From: Phaneedra Kumar Alapati <phani@embwise.com>
To: linux-omap@vger.kernel.org <linux-omap@vger.kernel.org>
CC: phani@embwise.com <phani@embwise.com>
Date: Thu, 10 Dec 2009 08:24:57 +0100
Subject: [PATCH]OMAP35xx:SDIO IRQ Support for OMAP35xx
Thread-Topic: [PATCH]OMAP35xx:SDIO IRQ Support for OMAP35xx
Thread-Index: Acp5aeARQUQJtw2USfCUiuj07cawqQ==
Message-ID: <8B7FC6A3798741D6B3E3284E1A8D7A27@embwise16de1b5>

This patch adds SDIO IRQ support for OMAP35xx. Tested on OMAP3530EVM
with Marvell 88W8686 card and below are the observed throughput results
(ttcp utility): 13Mbps (Downlink), 10.5 Mbps(Uplink)

Signed-off-by: Phaneendra Kumar <phani@embwise.com>
---
 drivers/mmc/host/omap_hsmmc.c |   55
++++++++++++++++++++++++++++++++++++----
 1 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4b23225..fa94580 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -100,6 +100,10 @@
 #define SRD			(1 << 26)
 #define SOFTRESET		(1 << 1)
 #define RESETDONE		(1 << 0)
+#define CIRQ		(1 << 8)
+#define CIRQ_ENABLE	(1 << 8)
+#define CTPL		(1 << 11)
+#define CLKEXTFREE	(1 << 16)
 
 /*
  * FIXME: Most likely all the data using these _DEVID defines should come
@@ -171,6 +175,7 @@ struct omap_hsmmc_host {
 	int			vdd;
 	int			protect_card;
 	int			reqs_blocked;
+	int			sdio_int;
 
 	struct	omap_mmc_platform_data	*pdata;
 };
@@ -436,6 +441,13 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host,
struct mmc_command *cmd,
 	else
 		OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
 
+	if (host->sdio_int) {
+		OMAP_HSMMC_WRITE(host->base, ISE,
+			(OMAP_HSMMC_READ(host->base, ISE) | CIRQ_ENABLE));
+		OMAP_HSMMC_WRITE(host->base, IE,
+			(OMAP_HSMMC_READ(host->base, IE) | CIRQ_ENABLE));
+	}
+
 	host->response_busy = 0;
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136)
@@ -640,6 +652,17 @@ static irqreturn_t omap_hsmmc_irq(int irq, void
*dev_id)
 
 	spin_lock(&host->irq_lock);
 
+	data = host->data;
+	status = OMAP_HSMMC_READ(host->base, STAT);
+	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
+
+	if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
+		if (status & CIRQ) {
+			dev_dbg(mmc_dev(host->mmc), "SDIO Card
Interrupt\n");
+			mmc_signal_sdio_irq(host->mmc);
+		}
+	}
+
 	if (host->mrq == NULL) {
 		OMAP_HSMMC_WRITE(host->base, STAT,
 			OMAP_HSMMC_READ(host->base, STAT));
@@ -649,10 +672,6 @@ static irqreturn_t omap_hsmmc_irq(int irq, void
*dev_id)
 		return IRQ_HANDLED;
 	}
 
-	data = host->data;
-	status = OMAP_HSMMC_READ(host->base, STAT);
-	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
-
 	if (status & ERR) {
 #ifdef CONFIG_MMC_DEBUG
 		omap_hsmmc_report_irq(host, status);
@@ -1254,6 +1273,25 @@ static int omap_hsmmc_get_ro(struct mmc_host *mmc)
 	return mmc_slot(host).get_ro(host->dev, 0);
 }
 
+static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct omap_hsmmc_host *host = mmc_priv(mmc);
+
+	host->sdio_int = enable;
+	if (enable) {
+		OMAP_HSMMC_WRITE(host->base, ISE,
+			(OMAP_HSMMC_READ(host->base, ISE) | CIRQ_ENABLE));
+		OMAP_HSMMC_WRITE(host->base, IE,
+			(OMAP_HSMMC_READ(host->base, IE) | CIRQ_ENABLE));
+	} else {
+		OMAP_HSMMC_WRITE(host->base, IE,
+			(OMAP_HSMMC_READ(host->base, IE) & (~CIRQ_ENABLE)));
+		OMAP_HSMMC_WRITE(host->base, ISE,
+			(OMAP_HSMMC_READ(host->base, ISE) &
(~CIRQ_ENABLE)));
+	}
+
+}
+
 static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 {
 	u32 hctl, capa, value;
@@ -1519,7 +1557,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
 	.set_ios = omap_hsmmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
 
 static const struct mmc_host_ops omap_hsmmc_ps_ops = {
@@ -1529,7 +1567,7 @@ static const struct mmc_host_ops omap_hsmmc_ps_ops = {
 	.set_ios = omap_hsmmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -1657,6 +1695,7 @@ static int __init omap_hsmmc_probe(struct
platform_device *pdev)
 	host->mapbase	= res->start;
 	host->base	= ioremap(host->mapbase, SZ_4K);
 	host->power_mode = -1;
+	host->sdio_int = 0;
 
 	platform_set_drvdata(pdev, host);
 	INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect);
@@ -1744,6 +1783,10 @@ static int __init omap_hsmmc_probe(struct
platform_device *pdev)
 	if (mmc_slot(host).nonremovable)
 		mmc->caps |= MMC_CAP_NONREMOVABLE;
 
+	mmc->caps |= MMC_CAP_SDIO_IRQ;
+	OMAP_HSMMC_WRITE(host->base, CON,
+			OMAP_HSMMC_READ(host->base, CON) | (CTPL |
CLKEXTFREE));
+
 	omap_hsmmc_conf_bus_power(host);
 
 	/* Select DMA lines */
-- 
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

