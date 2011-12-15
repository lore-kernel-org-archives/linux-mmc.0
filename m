From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 1/6] ESDHC: add PIO mode support
Date: Thu, 15 Dec 2011 07:24:31 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11650206@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1323829182-1551-1-git-send-email-r66093@freescale.com>
 <1323829182-1551-2-git-send-email-r66093@freescale.com>
 <20111214070411.GA2593@pengutronix.de>
 <8A2FC72B45BB5A4C9F801431E06AE48F11646D12@039-SN1MPN1-006.039d.mgd.msft.net>
 <20111215024427.GA12130@pengutronix.de>
 <8A2FC72B45BB5A4C9F801431E06AE48F11646D9B@039-SN1MPN1-006.039d.mgd.msft.net>
 <20111215030950.GB12130@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:22431
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751752Ab1LOHYi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 15 Dec 2011 02:24:38 -0500
In-Reply-To: <20111215030950.GB12130@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Gao Guanhua-B22826 <B22826@freescale.com>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Wolfram Sang
> Sent: Thursday, December 15, 2011 11:10 AM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Gao Guanhua-B22826
> Subject: Re: [PATCH 1/6] ESDHC: add PIO mode support
> 
> > For P2020E Rev1.0, the DMA can't work, we need the PIO mode.
> > For P2020E, P1010E, MPC8536, we can't use the timeout value calculated
> by driver, we need the max value.
> > For P1010E, the eSDHC controller can't use the max possible
> frequency(e.g. SDHC 50MHz), so we need one workaround to make the SD work
> 
> This is SoC specific, not board specific, so you could check for
> "fsl,p2020-esdhc" for example. 1010 and 2020-rev1 would need proper
> compatibles
> as well.
I will think about your suggestion.

> > For eSDHC, after suspending, the power of esdhc controller will
> shutdown, we need to save the value of some registers before suspending,
> wich will used to restore the context after resuming.
> > For eSDHC, the bit DCR[DMA__AHB2MAG_IRQ_BYPASS] can't be set
> automatically, so we need to set it manually
> 
> If this is true for all revisions (be careful about the imx users), you
> don't
> need properties, but could simply set it.
I don't know the future SOC how to handle them, so I think it is safe to have the property

