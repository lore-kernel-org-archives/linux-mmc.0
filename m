From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
Date: Thu, 18 Feb 2010 12:39:25 -0600
Message-ID: <004001cab0c9$b208b2b0$544ff780@am.dhcp.ti.com>
References: <cover.1265801967.git.david.vrabel@csr.com> <846fbf1a68cde5fd2d7c7ab084ace239c8de6867.1265801967.git.david.vrabel@csr.com> <f4f02c7875316b7f65466a5ac06f5b2b2960aa96.1265801967.git.david.vrabel@csr.com> <9ce6cf93ba1e6c3fd239f732ea5889a856948db3.1265801967.git.david.vrabel@csr.com> <004901cab001$6b19f6c0$544ff780@am.dhcp.ti.com> <4B7C4608.5010008@csr.com> <alpine.DEB.2.00.1002171254040.24812@utopia.booyaka.com> <4B7D3EAE.1010908@csr.com> <alpine.DEB.2.00.1002180951330.24812@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38883 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754513Ab0BRSjf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Feb 2010 13:39:35 -0500
In-Reply-To: <alpine.DEB.2.00.1002180951330.24812@utopia.booyaka.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Paul Walmsley' <paul@pwsan.com>, 'David Vrabel' <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org



> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, February 18, 2010 11:44 AM
> To: David Vrabel
> Cc: Madhusudhan; linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
> 
> On Thu, 18 Feb 2010, David Vrabel wrote:
> 
> > Paul Walmsley wrote:
> > >
> > > Perhaps I'm misunderstanding what you're referring to, but it seems
> there
> > > is some confusion as to what target smart-idle mode does.
> >
> > The TI OMAP 34xx TRM is the one of the most obtuse document I've had to
> > read.  An even after multiple reads of relevant sections it still
> > doesn't make sense.  Parts are contradictory, parts are poorly explained
> > and some bit are just plain incorrect.
> 
> Yes.  TI needs to also release the functional specifications for each IP
> block; the information in the current TRM is generally insufficient to
> write high-quality drivers.
> 
> TI should also host a process, open to the public, to submit TRM revision
> and clarification requests, and to track their disposition.
> 
Paul, David,

Not to add further confusion but as far as I understand SDIO should be able
to asynchronously wakeup OMAP regardless of MMC clocks being OFF . As per
the SDIO spec DAT1 line is used for signaling the card interrupt to the
host. The TRM clearly shows a GPIO connected to DAT1 line for wakeup through
the SDIO interrupt. Wouldn't this help?   

> > I don't have time to sort out any of this properly -- it works well
> > enough for me.
> 
> Thanks very much for the SDIO patches.  They are appreciated.

Definitely these are good features that are being added. Just that there are
confusions around and not everyone has a setup to validate these features.
If I look in the mainline kernel today there is only one SDIO card driver "
sdio_uart.c". And at least I don't see a way I can test any of these
features myself.

Regards,
Madhu   
> 
> 
> - Paul

