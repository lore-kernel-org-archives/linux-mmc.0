From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 1/6] ESDHC: add PIO mode support
Date: Thu, 15 Dec 2011 02:37:03 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11646D12@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1323829182-1551-1-git-send-email-r66093@freescale.com>
 <1323829182-1551-2-git-send-email-r66093@freescale.com>
 <20111214070411.GA2593@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:15341 "EHLO
	TX2EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863Ab1LOChJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2011 21:37:09 -0500
In-Reply-To: <20111214070411.GA2593@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Gao Guanhua-B22826 <B22826@freescale.com>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Wolfram Sang
> Sent: Wednesday, December 14, 2011 3:04 PM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093; Gao Guanhua-B22826
> Subject: Re: [PATCH 1/6] ESDHC: add PIO mode support
> 
> On Wed, Dec 14, 2011 at 10:19:37AM +0800, r66093@freescale.com wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > For some FSL ESDHC controller(e.g. P2020E, Rev1.0), the SDHC can not
> > work on DMA mode because of the hardware bug, so we set a broken dma
> > flag and use PIO mode.
> >
> > Signed-off-by: Gao Guanhua <B22826@freescale.com>
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> NACK for the series
> 
> 1) If you introduce a new property you always have to document the
> binding which is missing. But you don't need to write it because...
I will document them.

> 2) ... the aproach seems wrong to me. The quirks should be set depending
> on the compatible entry, e.g. if compatible == "this_controller" then
> quirks |= whatever_needed. Or?
> 
The quirk will not be set only depending on the compatible entry, the property entry can be, too.

