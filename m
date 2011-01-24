From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
 Resubmission
Date: Mon, 24 Jan 2011 09:43:47 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101240936260.8580@xanadu.home>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536>
 <20101116150022.GA27726@void.printf.net>
 <27884BED0E3C489C8849EE12A803F536@AN00536>
 <m3oc9pnt6g.fsf@pullcord.laptop.org> <4CE41BE3.1060806@elandigitalsystems.com>
 <m3oc9n241c.fsf@pullcord.laptop.org> <4CEA86D4.9050109@elandigitalsystems.com>
 <1295607004.1816.6.camel@apple-mac>
 <alpine.LFD.2.00.1101211608330.8580@xanadu.home>
 <1295858946.1677.3.camel@apple-mac>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:40273 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab1AXOns (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jan 2011 09:43:48 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFJ009KZ7KB6L70@vl-mo-mrz23.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Mon, 24 Jan 2011 09:43:24 -0500 (EST)
In-reply-to: <1295858946.1677.3.camel@apple-mac>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, David Vrabel <david.vrabel@csr.com>

On Mon, 24 Jan 2011, Tony Olech wrote:

> On Fri, 2011-01-21 at 16:14 -0500, Nicolas Pitre wrote:
> > On Fri, 21 Jan 2011, Tony Olech wrote:
> > > There are 5 "do not initialise statics" errors reported by scripts/checkpatch.pl
> > 
> > you probably should fix those.  They are due to lines such as:
> > 
> > static int pad_input_to_usb_pkt = 0;
> > static int disable_offload_processing = 0;
> > static int force_1_bit_data_xfers = 0;
> > static int force_polling_for_irqs = 0;
> > 
> > Since those are global variables, you may omit to initialize them to 0 
> > which would then allocate them to the .bss section which is not included 
> > in the compiled binary, and automatically cleared to zero at run time
> > Nicolas
> Yes they are due to exactly that, BUT I  have a great aversion to using
> uninitialized variables. How can initializing all one's variables be
> considered a bug????

Let me repeat myself.

Uninitialized global scope variables are by definition assigned to the 
.bss section.  The .bss section is dynamically allocated at run time 
rather than being stored in the compiled binary, and also cleared to 
zero at run time.  So the preference is for zero-initialized global 
variables not to be initialized at all because 1) they are implicitly 
initialized to zero anyway, and 2) that makes the resulting binaries 
smaller.

So this is not about fixing a bug, but rather to conform to the adopted 
policy for kernel code.


Nicolas
