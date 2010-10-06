From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
Date: Wed, 6 Oct 2010 23:58:19 +0530 (IST)
Message-ID: <56009.192.168.10.88.1286389699.squirrel@dbdmail.itg.ti.com>
References: <cover.1266847842.git.david.vrabel@csr.com>
    <20100827192248.GJ20407@void.printf.net> <4C7CC480.2040903@csr.com>
    <4C7F3E0F.2080402@compulab.co.il>
    <AANLkTi=RvWpuUC3FjwELkM0v57YXZbH_DBiA-4KuOwdN@mail.gmail.com>
    <C903F2608D694655921F553D0D3557E3@am.dhcp.ti.com>
    <AANLkTikskMMFWS+qxD+J=o6OiOa+d5H02DiT1iZ95vkz@mail.gmail.com>
    <CD6B4CE9F7FA427BBD19242F669AD014@am.dhcp.ti.com>
    <AANLkTin-r5Svg1+YrdYq95WA6=sh7+X0Bwogk=h0V6pP@mail.gmail.com>
    <4CAC146D.3040001@compulab.co.il>
    <AANLkTi=kmLuUyD-9k-Xa5vfgvjx2nNUGfyADhoY0HC1i@mail.gmail.com>
    <4CAC7D65.8010705@compulab.co.il>
    <AANLkTikvduxP+gQOs4HvZz2Yw6KCrqHAyim0Ads0Bvj_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52612 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933011Ab0JFS2n (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Oct 2010 14:28:43 -0400
In-Reply-To: <AANLkTikvduxP+gQOs4HvZz2Yw6KCrqHAyim0Ads0Bvj_@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, David Vrabel <david.vrabel@csr.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>


<snip>

> You are correct!  The version of the patch in the repo indeed has
> 'out' in the wrong place and generates a compile error.
>
> Could you post the patch you are using and I will try to reproduce
> what you are seeing on my hardware?  Best we all work from exactly the
> same patch!
>
> Steve
>

Yes. I think that check breaking the compilation is not needed. How about the
below version? It just removes that check.

This version should apply fine on the latest kernel. I did a sanity test of
MMC/SD cards on OMAP4 SDP.

Steve or Mike can check if SDIO interrupts are working.

Regards,
Madhu

>From 08b77fd388f19f5df3758a2c59dcdec280f373c8 Mon Sep 17 00:00:00 2001
From: David Vrabel <david.vrabel@csr.com>
Date: Wed, 6 Oct 2010 12:39:18 -0500
Subject: [PATCH 1/2] mmc: omap_hsmmc: enable SDIO card interrupts

Enable the use of SDIO card interrupts.

FCLK must be enabled while SDIO interrupts are enabled or the MMC
module won't wake-up (even though ENAWAKEUP in SYSCONFIG and IWE in
HTCL have been set).  Enabling the MMC module to wake-up would require
configuring the MMC module (and the mmci_dat[1] GPIO when the CORE
power domain is OFF) as wake-up sources in the PRCM.

The writes to STAT and ISE when starting a command are unnecessary and
have been removed.

Signed-off-by: David Vrabel <david.vrabel@csr.com>
---
 drivers/mmc/host/omap_hsmmc.c |   72 +++++++++++++++++++++++++++++++++++++----
 1 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4693e62..948dd9a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -66,6 +66,7 @@
 #define SDVS_MASK		0x00000E00
 #define SDVSCLR			0xFFFFF1FF
 #define SDVSDET			0x00000400
+#define ENAWAKEUP		(1 << 2)
 #define AUTOIDLE		0x1
 #define SDBP			(1 << 8)
 #define DTO			0xe
@@ -76,9 +77,12 @@
 #define CLKD_SHIFT		6
 #define DTO_MASK		0x000F0000
 #define DTO_SHIFT		16
+#define CIRQ_ENABLE		(1 << 8)
 #define INT_EN_MASK		0x307F0033
 #define BWR_ENABLE		(1 << 4)
 #define BRR_ENABLE		(1 << 5)
+#define CTPL			(1 << 11)
+#define CLKEXTFREE		(1 << 16)
 #define DTO_ENABLE		(1 << 20)
 #define INIT_STREAM		(1 << 1)
 #define DP_SELECT		(1 << 21)
@@ -87,10 +91,12 @@
 #define MSBS			(1 << 5)
 #define BCE			(1 << 1)
 #define FOUR_BIT		(1 << 1)
+#define IWE			(1 << 24)
 #define DW8			(1 << 5)
 #define CC			0x1
 #define TC			0x02
 #define OD			0x1
+#define CIRQ			(1 << 8)
 #define ERR			(1 << 15)
 #define CMD_TIMEOUT		(1 << 16)
 #define DATA_TIMEOUT		(1 << 20)
@@ -184,6 +190,7 @@ struct omap_hsmmc_host {
 	int			reqs_blocked;
 	int			use_reg;
 	int			req_in_progress;
+	int			sdio_int;

 	struct	omap_mmc_platform_data	*pdata;
 };
@@ -551,6 +558,9 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_host
*host,
 	if (cmd->opcode == MMC_ERASE)
 		irq_mask &= ~DTO_ENABLE;

+	if (host->sdio_int)
+		irq_mask |= CIRQ;
+
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
 	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
@@ -603,7 +613,7 @@ static int omap_hsmmc_context_restore(struct
omap_hsmmc_host *host)
 		;

 	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
-			OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE);
+		OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE | ENAWAKEUP);

 	if (host->id == OMAP_MMC1_DEVID) {
 		if (host->power_mode != MMC_POWER_OFF &&
@@ -618,7 +628,7 @@ static int omap_hsmmc_context_restore(struct
omap_hsmmc_host *host)
 	}

 	OMAP_HSMMC_WRITE(host->base, HCTL,
-			OMAP_HSMMC_READ(host->base, HCTL) | hctl);
+			OMAP_HSMMC_READ(host->base, HCTL) | hctl | IWE);

 	OMAP_HSMMC_WRITE(host->base, CAPA,
 			OMAP_HSMMC_READ(host->base, CAPA) | capa);
@@ -1019,6 +1029,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host
*host, int status)
 {
 	struct mmc_data *data;
 	int end_cmd = 0, end_trans = 0;
+	bool card_irq = false;

 	if (!host->req_in_progress) {
 		do {
@@ -1032,6 +1043,9 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host
*host, int status)
 	data = host->data;
 	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);

+	if (status & CIRQ)
+		card_irq = true;
+
 	if (status & ERR) {
 #ifdef CONFIG_MMC_DEBUG
 		omap_hsmmc_report_irq(host, status);
@@ -1087,6 +1101,9 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host
*host, int status)
 		omap_hsmmc_cmd_done(host, host->cmd);
 	if ((end_trans || (status & TC)) && host->mrq)
 		omap_hsmmc_xfer_done(host, data);
+	if (card_irq)
+		mmc_signal_sdio_irq(host->mmc);
+
 }

 /*
@@ -1639,6 +1656,47 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc,
struct mmc_card *card)
 		mmc_slot(host).init_card(card);
 }

+static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct omap_hsmmc_host *host = mmc_priv(mmc);
+	u32 ie, con;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->irq_lock, flags);
+
+	/*
+	 * When interrupts are enabled, CTPL must be set to enable
+	 * DAT1 input buffer (or the card interrupt is always
+	 * asserted) and FCLK must be enabled as wake-up does not
+	 * work.  Take care to disable FCLK after all the register
+	 * accesses as they might not complete if FCLK is off.
+	 *
+	 * FIXME: if the MMC module (and the mmci_dat[1] GPIO when the
+	 * CORE power domain is OFF) are configured as a wake-up
+	 * sources in the PRCM, then FCLK could be switched off.  This
+	 * might add too much latency.
+	 */
+	con = OMAP_HSMMC_READ(host->base, CON);
+	ie = OMAP_HSMMC_READ(host->base, IE);
+	if (enable) {
+		clk_enable(host->fclk);
+		ie |= CIRQ_ENABLE;
+		con |= CTPL | CLKEXTFREE;
+		host->sdio_int = 1;
+	} else {
+		ie &= ~CIRQ_ENABLE;
+		con &= ~(CTPL | CLKEXTFREE);
+		host->sdio_int = 0;
+	}
+	OMAP_HSMMC_WRITE(host->base, CON, con);
+	OMAP_HSMMC_WRITE(host->base, IE, ie);
+	OMAP_HSMMC_READ(host->base, IE); /* flush posted write */
+	if (!enable)
+		clk_disable(host->fclk);
+
+	spin_unlock_irqrestore(&host->irq_lock, flags);
+}
+
 static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 {
 	u32 hctl, capa, value;
@@ -1653,14 +1711,14 @@ static void omap_hsmmc_conf_bus_power(struct
omap_hsmmc_host *host)
 	}

 	value = OMAP_HSMMC_READ(host->base, HCTL) & ~SDVS_MASK;
-	OMAP_HSMMC_WRITE(host->base, HCTL, value | hctl);
+	OMAP_HSMMC_WRITE(host->base, HCTL, value | hctl | IWE);

 	value = OMAP_HSMMC_READ(host->base, CAPA);
 	OMAP_HSMMC_WRITE(host->base, CAPA, value | capa);

 	/* Set the controller to AUTO IDLE mode */
 	value = OMAP_HSMMC_READ(host->base, SYSCONFIG);
-	OMAP_HSMMC_WRITE(host->base, SYSCONFIG, value | AUTOIDLE);
+	OMAP_HSMMC_WRITE(host->base, SYSCONFIG, value | AUTOIDLE | ENAWAKEUP);

 	/* Set SD bus power bit */
 	set_sd_bus_power(host);
@@ -1911,7 +1969,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
 	.init_card = omap_hsmmc_init_card,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };

 static const struct mmc_host_ops omap_hsmmc_ps_ops = {
@@ -1922,7 +1980,7 @@ static const struct mmc_host_ops omap_hsmmc_ps_ops = {
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
 	.init_card = omap_hsmmc_init_card,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };

 #ifdef CONFIG_DEBUG_FS
@@ -2139,7 +2197,7 @@ static int __init omap_hsmmc_probe(struct platform_device
*pdev)
 	mmc->max_seg_size = mmc->max_req_size;

 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE;
+		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;

 	mmc->caps |= mmc_slot(host).caps;
 	if (mmc->caps & MMC_CAP_8_BIT_DATA)
-- 
1.7.0.4






