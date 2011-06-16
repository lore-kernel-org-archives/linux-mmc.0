From: Pavel Machek <pma@sysgo.com>
Subject: Re: sdhci-esdhc-imx -- MMC 10x slower than it should be
Date: Thu, 16 Jun 2011 14:14:11 +0200
Message-ID: <20110616121411.GE31375@pma.sysgo.com>
References: <20110615094001.GA21137@pma.sysgo.com>
 <20110615105318.GB3097@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.sysgo.com ([195.145.229.155]:54671 "EHLO mail.sysgo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756846Ab1FPMON (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Jun 2011 08:14:13 -0400
Content-Disposition: inline
In-Reply-To: <20110615105318.GB3097@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, pba@sysgo.com, cjb@laptop.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, shawn.guo@freescale.com

Hi!

> > We are seeing issues with sdhci-esdhc-imx in 2.6.39; performance is
> > not what it should be; it is about 10x lower in fact.
> 
> Which SoC? 25/35/51/53?

25.

> > ...any idea what this comment means? I'd like to eventualy support
> > 8BITBUS...
> 
> 8-Bit bus is not specified in the standard, so it cannot be detected.
> Check other drivers where they use MMC_CAP_8_BIT_DATA.

I came up with patch below... but could not get it to
work. Read-modify-write of on upper layer means  

> > Any ideas why it is slow?
> 
> Your board polls for card-detect, Shawn recently sent a series which
> lets you fix that for mx5.

Thanks... 1/4+2/4 should be enough to fix that, right? (I'd have to
figure out GPIO of card detect for the rest; I don't need that just
now.) That did not change the performance.

> ADMA is marked broken in mainline, cause it didn't work with a number of
> cards. Richard sent a patch recently.

I tried that one, and it breaks MMC for me.

> Both series could need some more testing :)

Mostly done :-).


									Pavel
(hand edited patch)

Index: sdhci-esdhc-imx.c
===================================================================
RCS file: /home/keeper/repos/10255-TQ-Rittal/bsp-cmc-tc-pu3/linux-2.6.39/drivers/mmc/host/sdhci-esdhc-imx.c,v
retrieving revision 1.1
diff -u -r1.1 sdhci-esdhc-imx.c
--- sdhci-esdhc-imx.c	14 Jun 2011 13:04:27 -0000	1.1
+++ sdhci-esdhc-imx.c	16 Jun 2011 10:47:28 -0000
@@ -164,11 +166,24 @@
 		 */
 		return;
 	case SDHCI_HOST_CONTROL:
-		/* FSL messed up here, so we can just keep those two */
-		new_val = val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);
+		if (val & 4)
+			printk("enabling 8bit access\n");
+//	  	new_val = val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS | 4);
+	  	new_val = val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);
+
+#if 0
+//		if (val & SDHCI_CTRL_8BITBUS) {
+			new_val &= ~SDHCI_CTRL_4BITBUS;
+			new_val |= 4; /* fixme -- 4 for real 8bit */
+//		}
+		printk("Setting bus width: %lx requested %lx..\n", new_val, val);
+#endif
 		/* ensure the endianess */
 		new_val |= ESDHC_HOST_CONTROL_LE;
 		/* DMA mode bits are shifted */
+
+		/* FIXME: this si broken, because upper layer does
+		 * read-modify-write cycles */
 		new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
 
 		esdhc_clrset_le(host, 0xffff, new_val, reg);
@@ -177,10 +192,11 @@
 	esdhc_clrset_le(host, 0xff, val, reg);
 }
 
+/* labeled "max clock", but it actually specifies base clock frequency */
 static unsigned int esdhc_pltfm_get_max_clock(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-
+	
 	return clk_get_rate(pltfm_host->clk);
 }
 
@@ -201,15 +217,51 @@
+
+static int esdhc_8bit(struct sdhci_host *host, int bus_width)
+{
+        u32 ctrl;
+
+        ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+        if (bus_width == MMC_BUS_WIDTH_8) {
+		printk("asked for 8bits\n");
+                ctrl &= ~SDHCI_CTRL_4BITBUS;
+                ctrl |= 4;
+        } else {
+                ctrl &= ~4;
+                if (bus_width == MMC_BUS_WIDTH_4) {
+			printk("asked for 4bits\n");
+                        ctrl |= SDHCI_CTRL_4BITBUS;
+                } else {
+			printk("asked for 1bit\n");
+                        ctrl &= ~SDHCI_CTRL_4BITBUS;
+		}
+        }
+	printk("8bit: want bus width %d, code %x\n", bus_width, ctrl);
+        sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+        return 0;
+}
+
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
 	.write_l = esdhc_writel_le,
 	.write_w = esdhc_writew_le,
 	.write_b = esdhc_writeb_le,
-	.set_clock = esdhc_set_clock,
+	.set_clock = esdhc_set_clock2,
 	.get_max_clock = esdhc_pltfm_get_max_clock,
 	.get_min_clock = esdhc_pltfm_get_min_clock,
+	.platform_8bit_width = esdhc_8bit,
 };
 
 static irqreturn_t cd_irq(int irq, void *data)
@@ -289,6 +341,7 @@
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 	}
 
+//	host->mmc->caps |= MMC_CAP_8_BIT_DATA;
 	return 0;
 
  no_card_detect_irq:
Index: sdhci.c
===================================================================
RCS file: /home/keeper/repos/10255-TQ-Rittal/bsp-cmc-tc-pu3/linux-2.6.39/drivers/mmc/host/sdhci.c,v
retrieving revision 1.1
diff -u -r1.1 sdhci.c
--- sdhci.c	14 Jun 2011 14:14:49 -0000	1.1
+++ sdhci.c	16 Jun 2011 10:47:28 -0000
@@ -213,6 +213,8 @@
 {
 	u8 ctrl;
 
+	/* FIXME: this reads host control registers then writes it back.
+	   But we do nasty processing in esdhc_writeb_le() */
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 	ctrl |= SDHCI_CTRL_LED;
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);


