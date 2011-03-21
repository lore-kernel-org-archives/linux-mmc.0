From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/6] mmc: tmio: split core functionality, DMA and MFD
 glue
Date: Mon, 21 Mar 2011 12:19:29 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103211208290.21013@axis700.grange>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
 <Pine.LNX.4.64.1103110844080.23675@axis700.grange>
 <AANLkTinQB2NB---0o65Uy-axApw9DwPZoMeMBc=qmvSC@mail.gmail.com>
 <Pine.LNX.4.64.1103122347270.28741@axis700.grange>
 <AANLkTi=YAcSOBUyWa-OpD0fL-nr-_i=On8ssN0TXZTqJ@mail.gmail.com>
 <Pine.LNX.4.64.1103132349140.23221@axis700.grange>
 <AANLkTinDSfn-QTNdmU6gGnZ0fY0U-wnpbO3-aTxE3GBz@mail.gmail.com>
 <AANLkTim_-MLJaWtnJN2jJjiXQdChfzi6yNkX8hSy8sgg@mail.gmail.com>
 <AANLkTiksL=M0GOUy4-g7wiA6dj5TdW3atLNJiQ3zgien@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50064 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab1CULTc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Mar 2011 07:19:32 -0400
In-Reply-To: <AANLkTiksL=M0GOUy4-g7wiA6dj5TdW3atLNJiQ3zgien@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi Ian

On Wed, 16 Mar 2011, Magnus Damm wrote:

> >>>> >> On Fri, Mar 11, 2011 at 4:51 PM, Guennadi Liakhovetski
> >>>> >> <g.liakhovetski@gmx.de> wrote:
> >>>> >> > TMIO MMC chips contain an SD / SDIO IP core from Panasonic, similar to
> >>>> >> > the one, used in MN5774 and other MN57xx controllers. These IP cores are
> >>>> >> > included in many multifunction devices, in sh-mobile chips from Renesas,
> >>>> >> > in the latter case they can also use DMA. Some sh-mobile implementations
> >>>> >> > also have some other specialities, that MFD-based solutions don't have.
> >>>> >> > This makes supporting all these features in a monolithic driver inconveniet
> >>>> >> > and error-prone. This patch splits the driver into 3 parts: the core,
> >>>> >> > the MFD glue and the DMA support. In case of a modular build, two modules
> >>>> >> > will be built: mmc_tmio_core and mmc_tmio.
> >>>> >> >
> >>>> >> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> On Wed, Mar 16, 2011 at 8:09 PM, Ian Molton <ian@mnementh.co.uk> wrote:
> > Im fine with it as long as it doesnt complicate my plan to add PXA DMA
> > to the driver.
> 
> Hi Ian,
> 
> Thanks for your email. I'm glad to hear that you have no objections to
> this patch series.
> 
> Regarding PXA DMA, without knowing the PXA DMA hardware that well
> (never recall using DMA on that platform), from a code reuse point of
> view it would be absolutely best to share the DMA Engine interface in
> the tmio mmc driver with the SDHI. But I'm not sure if any DMA Engine
> driver exists for the PXA though.

I presume you're talking about an external tmio MFD chip connected to a   
PXA SoC. Concerning adding DMA to this configuration, just like Magnus, I 
am not aware of any dmaengine implementations for PXA. I know, there is a 
private PXA DMA API, used, e.g., in pxa_camera.c and defined in 
arch/arm/plat-pxa/dma.c. I think, that's also what you would use for 
external DMA.

There has been a discussion whether the dmaengine API should be used 
universally, and the conclusion more or less was:

1. if your DMA engine can do standard operations like memcpy, xor, then 
yes
2. if you use drivers for external hardware or built-in IP blocks, that 
use the dmaengine API, then yes
3. otherwise it's not compulsory

So, until now PXA didn't have any of the (1) or (2) cases. Now, if you 
want to use tmio on PXA you have a choice: either (1) to add a new DMA 
glue to tmio for PXA, or (2) to add a dmaengine API to PXA DMA. The latter 
seems to be preferred. But even if you decide to go the first route, this 
driver split shall make your work easier.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
