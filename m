From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 1/6] ESDHC: add PIO mode support
Date: Thu, 15 Dec 2011 02:53:36 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11646D9B@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1323829182-1551-1-git-send-email-r66093@freescale.com>
 <1323829182-1551-2-git-send-email-r66093@freescale.com>
 <20111214070411.GA2593@pengutronix.de>
 <8A2FC72B45BB5A4C9F801431E06AE48F11646D12@039-SN1MPN1-006.039d.mgd.msft.net>
 <20111215024427.GA12130@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:54544 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758493Ab1LOCxl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2011 21:53:41 -0500
In-Reply-To: <20111215024427.GA12130@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Gao Guanhua-B22826 <B22826@freescale.com>



> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Thursday, December 15, 2011 10:44 AM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Gao Guanhua-B22826
> Subject: Re: [PATCH 1/6] ESDHC: add PIO mode support
> 
> > > 2) ... the aproach seems wrong to me. The quirks should be set
> > > depending on the compatible entry, e.g. if compatible ==
> > > "this_controller" then quirks
> > > |= whatever_needed. Or?
> > >
> > The quirk will not be set only depending on the compatible entry, the
> > property entry can be, too.
> 
> Where is that needed? I don't see how they are board-specific.
> 
Maybe you don't familiar with the Freescale's eSDHC controller.
For P2020E Rev1.0, the DMA can't work, we need the PIO mode.
For P2020E, P1010E, MPC8536, we can't use the timeout value calculated by driver, we need the max value.
For eSDHC, after suspending, the power of esdhc controller will shutdown, we need to save the value of some registers before suspending, wich will used to restore the context after resuming.
For eSDHC, the bit DCR[DMA__AHB2MAG_IRQ_BYPASS] can't be set automatically, so we need to set it manually
For P1010E, the eSDHC controller can't use the max possible frequency(e.g. SDHC 50MHz), so we need one workaround to make the SD work


