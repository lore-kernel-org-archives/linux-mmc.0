From: Tony Olech <tony.olech@elandigitalsystems.com>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
 Resubmission
Date: Mon, 24 Jan 2011 16:21:25 +0000
Message-ID: <1295886085.1677.32.camel@apple-mac>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54450 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab1AXQVo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jan 2011 11:21:44 -0500
In-Reply-To: <20110123100917.GB32578@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, David Vrabel <david.vrabel@csr.com>

On Sun, 2011-01-23 at 11:09 +0100, Wolfram Sang wrote:
> On Sat, Jan 22, 2011 at 02:07:21PM -0500, Nicolas Pitre wrote:
> > On Sat, 22 Jan 2011, Wolfram Sang wrote:
> > > On Fri, Jan 21, 2011 at 04:14:46PM -0500, Nicolas Pitre wrote:
> > > > On Fri, 21 Jan 2011, Tony Olech wrote:
> > > > > Add a driver for Elan Digital System's VUB300 chip
> > > > > which is a USB connected SDIO/SDmem/MMC host controller.
> > > > > A VUB300 chip enables a USB 2.0 or USB 1.1 connected host
> > > > > computer to use SDIO/SD/MMC cards without the need for
> > > > > a directly connected, for example via PCI, SDIO host
> > > > > controller.t.
> > > > > There are 5 "do not initialise statics" errors reported by scripts/checkpatch.pl
> > > > you probably should fix those.  They are due to lines such as:
> > > > static int pad_input_to_usb_pkt = 0;
> > > > static int disable_offload_processing = 0;
> > > > static int force_1_bit_data_xfers = 0;
> > > > static int force_polling_for_irqs = 0;
> > > Should those be static anyhow? Being USB, you could probably hook up two of
> > > those and want to operate one of them in this and the other one in another
> > > mode?
> > You could.  Whether or not you would is another question.  Until then I 
> > don't think it is worth bothering with such corner cases
> Kind regards,
>    Wolfram
The intended use of the read-only sysfs file is to enable first-line
support staff to determine quickly what actual firmware file is being
used.
Tony Olech

