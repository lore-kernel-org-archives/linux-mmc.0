From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Tue, 15 Feb 2011 17:32:55 +0000
Message-ID: <20110215173255.GR4152@n2100.arm.linux.org.uk>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com> <1297650746-12841-2-git-send-email-shawn.guo@freescale.com> <20110214165958.GH10709@pengutronix.de> <20110215223941.GJ10990@S2100-06.ap.freescale.net> <20110215171341.GD10770@pengutronix.de> <20110215171917.GQ4152@n2100.arm.linux.org.uk> <20110215172948.GE10770@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43675 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755267Ab1BORdK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 12:33:10 -0500
Content-Disposition: inline
In-Reply-To: <20110215172948.GE10770@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>, arnd@arndb.de, s.hauer@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de

On Tue, Feb 15, 2011 at 06:29:48PM +0100, Wolfram Sang wrote:
> On Tue, Feb 15, 2011 at 05:19:17PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Feb 15, 2011 at 06:13:41PM +0100, Wolfram Sang wrote:
> > > MMC fails for me (note: the card works fine with an mx35-based board)
> > > 
> > > 	mmc0: new high speed MMC card at address 0001
> > > 	mmcblk0: mmc0:0001 AF HMP 247 MiB 
> > > 	mmcblk0: retrying using single block read
> > > 	mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
> > > 	end_request: I/O error, dev mmcblk0, sector 0
> > 
> > EILSEQ means CRC failure.  Probably unrelated.
> 
> Even if it works in another setup? As a result of the above, I can't read the
> partition table of that MMC. The mx35 can do so.

CRC is generated to protect the link between the card and the host.  It
means that the CRC computed by the card for the transfer and the CRC
computed by the host didn't match.

In other words, data was corrupted in some way between the card and the
MMC host.
