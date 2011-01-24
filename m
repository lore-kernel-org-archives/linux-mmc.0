From: Tony Olech <tony.olech@elandigitalsystems.com>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
 Resubmission
Date: Mon, 24 Jan 2011 16:27:01 +0000
Message-ID: <1295886421.1677.37.camel@apple-mac>
References: <20101116150022.GA27726@void.printf.net>
	 <27884BED0E3C489C8849EE12A803F536@AN00536>
	 <m3oc9pnt6g.fsf@pullcord.laptop.org>
	 <4CE41BE3.1060806@elandigitalsystems.com>
	 <m3oc9n241c.fsf@pullcord.laptop.org>
	 <4CEA86D4.9050109@elandigitalsystems.com>
	 <1295607004.1816.6.camel@apple-mac>
	 <alpine.LFD.2.00.1101211608330.8580@xanadu.home>
	 <20110122142112.GC15620@pengutronix.de>
	 <alpine.LFD.2.00.1101221405110.8580@xanadu.home>
	 <20110123100917.GB32578@pengutronix.de>
	 <alpine.LFD.2.00.1101230854430.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53635 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160Ab1AXQ1J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jan 2011 11:27:09 -0500
In-Reply-To: <alpine.LFD.2.00.1101230854430.8580@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, David Vrabel <david.vrabel@csr.com>

On Sun, 2011-01-23 at 09:01 -0500, Nicolas Pitre wrote:
> On Sun, 23 Jan 2011, Wolfram Sang wrote:
> > On Sat, Jan 22, 2011 at 02:07:21PM -0500, Nicolas Pitre wrote:
> > > On Sat, 22 Jan 2011, Wolfram Sang wrote:
> > > > On Fri, Jan 21, 2011 at 04:14:46PM -0500, Nicolas Pitre wrote:
> > > > > On Fri, 21 Jan 2011, Tony Olech wrote:
> > > > > > Add a driver for Elan Digital System's VUB300 chip
> > > > > > which is a USB connected SDIO/SDmem/MMC host controller.
> > > > > > A VUB300 chip enables a USB 2.0 or USB 1.1 connected host
> > > > > > computer to use SDIO/SD/MMC cards without the need for
> > > > > > a directly connected, for example via PCI, SDIO host
> > > > > > controller.
> > > > > > There are 5 "do not initialise statics" errors reported by scripts/checkpatch.pl
> > > > > you probably should fix those.  They are due to lines such as:
> > > > > static int pad_input_to_usb_pkt = 0;
> > > > > static int disable_offload_processing = 0;
> > > > > static int force_1_bit_data_xfers = 0;
> > > > > static int force_polling_for_irqs = 0;
> > > > Should those be static anyhow? Being USB, you could probably hook up two of
> > > > those and want to operate one of them in this and the other one in another
> > > > mode?
> > > You could.  Whether or not you would is another question.  Until then I 
> > > don't think it is worth bothering with such corner cases for the initial 
> > > merging of this driver.
> > A static variable which should be per-device is a corner-case? Frankly, I'd
> > think it is a flaw. Unless, of course, these module_params are only rarely
> > used. Which would lead to the question if they are really needed. There are
> > quite a lot.
> Given their name, I'd say they are there only for debugging purposes.  
> So yes, they probably are rarely used, which doesn't mean they're 
> useless.  Same thing goes for maxfreq and nodma in mvsdio.c for example.

Basically the are diagnostic, but their use might enable a
non-functioning device to actually work.

> I'm sure the author of this driver would be eager to hear from you with 
> a concrete suggestion.
> Nicolas

YES

Tony olech

