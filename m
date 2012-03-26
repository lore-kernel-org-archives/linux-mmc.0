From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] mmc: sh_mmcif: mmc->f_max should be half of the bus
 clock
Date: Mon, 26 Mar 2012 14:52:59 +0900
Message-ID: <20120326055256.GE2347@verge.net.au>
References: <1332320549-28584-1-git-send-email-horms@verge.net.au>
 <1332320549-28584-3-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1203241904150.19427@axis700.grange>
 <20120325223033.GA6860@verge.net.au>
 <4F70027A.9020203@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:33654 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851Ab2CZFxD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Mar 2012 01:53:03 -0400
Content-Disposition: inline
In-Reply-To: <4F70027A.9020203@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yusuke Goda <yusuke.goda.sx@renesas.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Cao Minh Hiep <hiepcm@gmail.com>

On Mon, Mar 26, 2012 at 02:45:30PM +0900, Yusuke Goda wrote:
> Hi Simon-san, Guennadi-san
> 
> (2012/03/26 7:30), Simon Horman wrote:
> > On Sat, Mar 24, 2012 at 07:06:31PM +0100, Guennadi Liakhovetski wrote:
> >> On Wed, 21 Mar 2012, Simon Horman wrote:
> >>
> >>> mmc->f_max should be half of the bus clock.
> >>> And now that mmc->f_max is not equal to the bus clock the
> >>> latter should be used directly to calculate mmc->f_min.
> >>
> >> The patch seems correct as it stands, however, looking at it - does anyone 
> >> understands why that "close to 400kHz" comment and such a complicated 
> >> calculation? Shouldn't it be just host->clk / 512 always? Maybe this 
> >> should be a separate patch, so, for this one
> >>
> >> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > 
> > Hi Guennadi,
> > 
> > that code seems to date back to the original driver submission
> > made by Goda-san. I have CCed him as perhaps he recalls why
> > the code is like it is.
> I thought to get closer to 400kHz if possible.
> Probably even host->clk / 512 does not have any problem.

Sorry for my ignorance, is ~400kHz desirable for some reason?

> cheers,
> Goda
> 
> >>> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> >>> Tested-by: Cao Minh Hiep <hiepcm@gmail.com>
> >>> Signed-off-by: Simon Horman <horms@verge.net.au>
> >>> ---
> >>>  drivers/mmc/host/sh_mmcif.c |   12 ++++++------
> >>>  1 files changed, 6 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> >>> index 5014bc4..1410baa 100644
> >>> --- a/drivers/mmc/host/sh_mmcif.c
> >>> +++ b/drivers/mmc/host/sh_mmcif.c
> >>> @@ -1297,14 +1297,14 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
> >>>  	spin_lock_init(&host->lock);
> >>>  
> >>>  	mmc->ops = &sh_mmcif_ops;
> >>> -	mmc->f_max = host->clk;
> >>> +	mmc->f_max = host->clk / 2;
> >>>  	/* close to 400KHz */
> >>> -	if (mmc->f_max < 51200000)
> >>> -		mmc->f_min = mmc->f_max / 128;
> >>> -	else if (mmc->f_max < 102400000)
> >>> -		mmc->f_min = mmc->f_max / 256;
> >>> +	if (host->clk < 51200000)
> >>> +		mmc->f_min = host->clk / 128;
> >>> +	else if (host->clk < 102400000)
> >>> +		mmc->f_min = host->clk / 256;
> >>>  	else
> >>> -		mmc->f_min = mmc->f_max / 512;
> >>> +		mmc->f_min = host->clk / 512;
> >>>  	if (pd->ocr)
> >>>  		mmc->ocr_avail = pd->ocr;
> >>>  	mmc->caps = MMC_CAP_MMC_HIGHSPEED;
> >>> -- 
> >>> 1.7.6.3
> >>>
> >>
> >> ---
> >> Guennadi Liakhovetski, Ph.D.
> >> Freelance Open-Source Software Developer
> >> http://www.open-technology.de/
> >>
> > 
> > 
> 
> -- 
> EC No.
> 
