From: Pavel Machek <pma@sysgo.com>
Subject: sdhci-esdhc-imx -- MMC 10x slower than it should be
Date: Wed, 15 Jun 2011 11:40:01 +0200
Message-ID: <20110615094001.GA21137@pma.sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.sysgo.com ([195.145.229.155]:44698 "EHLO mail.sysgo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136Ab1FOJrZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Jun 2011 05:47:25 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: pba@sysgo.com, cjb@laptop.org, w.sang@pengutronix.de, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, shawn.guo@freescale.com

Hi!

We are seeing issues with sdhci-esdhc-imx in 2.6.39; performance is
not what it should be; it is about 10x lower in fact.

(
2.6.39 -mostly-vanilla:

dd if=/dev/mmcblk0 of=/dev/null bs=1024 count=10240
<7>sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001

takes cca 17 seconds.

2.6.34 -with-freescale-patches:

dd if=/dev/mmcblk0 of=/dev/null bs=1024 count=10240
takes about 1 second.
)

I could not pinpoint why; I found following issues while debugging:

When the core asks for 52MHz, code seems to select 40MHz even when it
can do 48MHz. I was able to work around with this:

diff -u -r1.1 sdhci-esdhc.h
--- sdhci-esdhc.h	14 Jun 2011 13:04:27 -0000	1.1
+++ sdhci-esdhc.h	15 Jun 2011 08:28:25 -0000
@@ -59,10 +59,12 @@
   while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
   	 pre_div *= 2;
 
+	pre_div /= 2; 
+
	while (host->max_clk / pre_div / div > clock && div < 16)
 	      div++;
 
...but then it sometimes produces higher frequency then
requested. mx_sdhci driver does something way more complex here.

+++ sdhci-esdhc-imx.c	15 Jun 2011 08:28:25 -0000
@@ -164,11 +166,24 @@
   	    */
		return;
 		case SDHCI_HOST_CONTROL:
		     /* FSL messed up here, so we can just keep those two */
	new_val = val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);

...any idea what this comment means? I'd like to eventualy support
8BITBUS...

Part of the problem is that esdhc_writeb_le() does translation of bits
into breescale format; but readb() does not do translation back, and
core code uses read-modify-write on the register, for example when
turning on the LED. What to do there? Translate back? Add shadow
variable? Get rid of read-modify-write?

Any ideas why it is slow?
								Pavel

