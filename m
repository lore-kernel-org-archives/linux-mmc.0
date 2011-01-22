From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
 Resubmission
Date: Sat, 22 Jan 2011 14:07:21 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101221405110.8580@xanadu.home>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536>
 <20101116150022.GA27726@void.printf.net>
 <27884BED0E3C489C8849EE12A803F536@AN00536>
 <m3oc9pnt6g.fsf@pullcord.laptop.org> <4CE41BE3.1060806@elandigitalsystems.com>
 <m3oc9n241c.fsf@pullcord.laptop.org> <4CEA86D4.9050109@elandigitalsystems.com>
 <1295607004.1816.6.camel@apple-mac>
 <alpine.LFD.2.00.1101211608330.8580@xanadu.home>
 <20110122142112.GC15620@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:42760 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab1AVTHW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Jan 2011 14:07:22 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFF005S0UFNZED0@vl-mo-mrz24.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Sat, 22 Jan 2011 14:06:59 -0500 (EST)
In-reply-to: <20110122142112.GC15620@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Tony Olech <tony.olech@elandigitalsystems.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, David Vrabel <david.vrabel@csr.com>

On Sat, 22 Jan 2011, Wolfram Sang wrote:

> On Fri, Jan 21, 2011 at 04:14:46PM -0500, Nicolas Pitre wrote:
> > On Fri, 21 Jan 2011, Tony Olech wrote:
> > 
> > > Add a driver for Elan Digital System's VUB300 chip
> > > which is a USB connected SDIO/SDmem/MMC host controller.
> > > A VUB300 chip enables a USB 2.0 or USB 1.1 connected host
> > > computer to use SDIO/SD/MMC cards without the need for
> > > a directly connected, for example via PCI, SDIO host
> > > controller.
> > > 
> > > Signed-off-by: Anthony F Olech <tony.olech@elandigitalsystems.com>
> > > ---
> > > This is the second submission attempt.
> > > There are 5 "do not initialise statics" errors reported by scripts/checkpatch.pl
> > 
> > you probably should fix those.  They are due to lines such as:
> > 
> > static int pad_input_to_usb_pkt = 0;
> > static int disable_offload_processing = 0;
> > static int force_1_bit_data_xfers = 0;
> > static int force_polling_for_irqs = 0;
> 
> Should those be static anyhow? Being USB, you could probably hook up two of
> those and want to operate one of them in this and the other one in another
> mode?

You could.  Whether or not you would is another question.  Until then I 
don't think it is worth bothering with such corner cases for the initial 
merging of this driver.


Nicolas
