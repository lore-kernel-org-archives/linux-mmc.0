From: Ladislav.Michl@seznam.cz
Subject: mmci-omap does not detect a card
Date: Sun, 1 Nov 2009 22:04:09 +0100
Message-ID: <20091101210409.GA2505@localhost.localdomain>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.72.43]:59715 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211AbZKAUEJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 1 Nov 2009 15:04:09 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>

Last time I used MMC card with linux-2.6.15-omap2 and it worked pretty well on
my custom OMAP5910 based board. Current git nor linux-2.6.22-omap1 (currently
used for production) doesn't work at all. Inserting module ends this way:

# modprobe omap
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD55)
mmci-omap mmci-omap.0: command timeout (CMD55)
mmci-omap mmci-omap.0: command timeout (CMD55)
mmci-omap mmci-omap.0: command timeout (CMD55)
mmci-omap mmci-omap.0: Spurious IRQ 0x1001
mmc0: unrecognised CSD structure version 0
mmci-omap mmci-omap.0: Spurious IRQ 0x0080
mmc0: error -22 whilst initialising MMC card

It seems that sending init stream only once makes it better. With patch
bellow MMC is detected and can be read and written. Inserting module
produces this debug output:

# modprobe omap
MMC_POWER_OFF
MMC dsor: 0
MMC_POWER_UP
MMC_POWER_ON
MMC dsor: 878
time elapsed: 259us
MMC_POWER_ON
MMC dsor: 878
MMC_POWER_ON
MMC dsor: 878
mmci-omap mmci-omap.0: command timeout (CMD8)
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD55)
mmci-omap mmci-omap.0: command timeout (CMD55)
mmci-omap mmci-omap.0: command timeout (CMD55)
mmci-omap mmci-omap.0: command timeout (CMD55)
MMC_POWER_ON
MMC dsor: 878
MMC_POWER_ON
MMC dsor: 878
MMC_POWER_ON
MMC dsor: 878
MMC_POWER_ON
MMC dsor: 878
MMC_POWER_ON
MMC dsor: 803
mmc0: new MMC card at address 0001
mmcblk0: mmc0:0001 D0601 122 MiB
 mmcblk0:
 p1

Note that "worst case at 400kHz, 80 cycles makes 200 microsecs" actually
takes more than 250usec thus delay loop breaks before status is cleared
(I did not checked it with scope, so it could be problem of inaccurate
udelay() as well). I also do not know where those "command timeout"s come
from. 2.6.15-omap2 works just fine and I did not find any suspicious change
in drivers/mmc/host/omap.c and I have only vague knowledge how MMC works.

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 5d773b8..6a4a681 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -132,6 +132,7 @@ struct mmc_omap_host {
 	int			irq;
 	unsigned char		bus_mode;
 	unsigned char		hw_bus_mode;
+	unsigned char		power_mode;
 
 	struct work_struct	cmd_abort_work;
 	unsigned		abort:1;
@@ -1233,7 +1234,7 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct mmc_omap_slot *slot = mmc_priv(mmc);
 	struct mmc_omap_host *host = slot->host;
 	int i, dsor;
-	int clk_enabled;
+	int clk_enabled, init_stream;
 
 	mmc_omap_select_slot(slot, 0);
 
@@ -1243,20 +1244,27 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		slot->vdd = ios->vdd;
 
 	clk_enabled = 0;
+	init_stream = 0;
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
+		printk("MMC_POWER_OFF\n");
 		mmc_omap_set_power(slot, 0, ios->vdd);
 		break;
 	case MMC_POWER_UP:
+		printk("MMC_POWER_UP\n");
 		/* Cannot touch dsor yet, just power up MMC */
 		mmc_omap_set_power(slot, 1, ios->vdd);
+		host->power_mode = ios->power_mode;
 		goto exit;
 	case MMC_POWER_ON:
+		printk("MMC_POWER_ON\n");
 		mmc_omap_fclk_enable(host, 1);
 		clk_enabled = 1;
-		dsor |= 1 << 11;
+		if (host->power_mode != MMC_POWER_ON)
+			init_stream = 1;
 		break;
 	}
+	host->power_mode = ios->power_mode;
 
 	if (slot->bus_mode != ios->bus_mode) {
 		if (slot->pdata->set_bus_mode != NULL)
@@ -1269,12 +1277,15 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	 * goes somehow out of sync, and the POW bit is not being set,
 	 * which results in the while loop below getting stuck.
 	 * Writing to the CON register twice seems to do the trick. */
+	if (ios->power_mode == MMC_POWER_ON)
+		dsor |= 1 << 11;
+	printk("MMC dsor: %x\n", dsor);
 	for (i = 0; i < 2; i++)
 		OMAP_MMC_WRITE(host, CON, dsor);
 	slot->saved_con = dsor;
-	if (ios->power_mode == MMC_POWER_ON) {
+	if (init_stream) {
 		/* worst case at 400kHz, 80 cycles makes 200 microsecs */
-		int usecs = 250;
+		int usecs = 512;
 
 		/* Send clock cycles, poll completion */
 		OMAP_MMC_WRITE(host, IE, 0);
@@ -1285,8 +1296,8 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			usecs--;
 		}
 		OMAP_MMC_WRITE(host, STAT, 1);
+		printk("time elapsed: %dus\n", 512 - usecs);
 	}
-
 exit:
 	mmc_omap_release_slot(slot, clk_enabled);
 }
@@ -1445,6 +1456,7 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 
 	host->id = pdev->id;
+	host->power_mode = -1;
 	host->mem_res = res;
 	host->irq = irq;
 
@@ -1529,6 +1541,7 @@ static int mmc_omap_remove(struct platform_device *pdev)
 		host->pdata->cleanup(&pdev->dev);
 
 	mmc_omap_fclk_enable(host, 0);
+	free_irq(host->irq, host);
 	clk_put(host->fclk);
 	clk_disable(host->iclk);
 	clk_put(host->iclk);

Any suggestion will be appreciated, translated into code, tested and eventually
recasted into a proper patch.

Thank you,
	ladis
