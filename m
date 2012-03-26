From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] mmc: sh_mmcif: double clock speed
Date: Mon, 26 Mar 2012 11:21:54 +0900
Message-ID: <20120326022154.GB6860@verge.net.au>
References: <1332320549-28584-1-git-send-email-horms@verge.net.au>
 <1332320549-28584-2-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1203241845060.19427@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:37423 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442Ab2CZCV6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Mar 2012 22:21:58 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1203241845060.19427@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Cao Minh Hiep <hiepcm@gmail.com>

On Sat, Mar 24, 2012 at 06:56:16PM +0100, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> On Wed, 21 Mar 2012, Simon Horman wrote:
> 
> > This corrects an off-by one error when calculating the clock divisor.
> > The code previously assumed that for example a divisor of 2 is
> > set using a value of 0001 (the inverse of 1/2), a divisor of 4 is
> > set using a value of 0010 (the inverse of 1/4) etc.. However, the correct
> > values are 0000, 0001, etc...
> > 
> > The use of DIV_ROUND_UP() was suggested by Guennadi Liakhovetski to avoid
> > understating the divisor by one in the case where the host clock is not a
> > binary power of the MMCIF clock.
> 
> The patch looks good, but the commit message is not quite right. Cases of 
> host->clk / clk != 2^n are handled by using fls(x - 1) instead of fls(x) - 
> 1, as you initially suggested. DIV_ROUND_UP() is needed for divisions with 
> a residue. E.g., for host clock 13MHz, target clock 3MHz you want a 
> divisor of 5, resulting in 2 << 16, not 4, resulting in 1 << 16. With this 
> fixed
> 
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Hi Guennadi, how about this?:

Correct an off-by one error when calculating the clock divisor in cases
where the host clock is a power of two of the target clock.  Previously the
divisor was one greater than the correct value in these cases leading to
the clock being set at half the desired speed.

Thanks to Guennadi Liakhovetski for working with me on
the logic for this change.

> > The use of DIV_ROUND_UP() was suggested by Guennadi Liakhovetski to avoid
> > understating the divisor by one in the case where the host clock is not a
> > binary power of the MMCIF clock.
> 
> The patch looks good, but the commit message is not quite right. Cases of 
> host->clk / clk != 2^n are handled by using fls(x - 1) instead of fls(x) - 
> 1, as you initially suggested. DIV_ROUND_UP() is needed for divisions with 
> a residue. E.g., for host clock 13MHz, target clock 3MHz you want a 
> divisor of 5, resulting in 2 << 16, not 4, resulting in 1 << 16. With this 
> fixed
> 
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

> Thanks
> Guennadi
> 
> > 
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Tested-by: Cao Minh Hiep <hiepcm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> >  drivers/mmc/host/sh_mmcif.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> > index 8057bf3..5014bc4 100644
> > --- a/drivers/mmc/host/sh_mmcif.c
> > +++ b/drivers/mmc/host/sh_mmcif.c
> > @@ -453,7 +453,8 @@ static void sh_mmcif_clock_control(struct sh_mmcif_host *host, unsigned int clk)
> >  		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_SUP_PCLK);
> >  	else
> >  		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_CLEAR &
> > -				((fls(host->clk / clk) - 1) << 16));
> > +				((fls(DIV_ROUND_UP(host->clk,
> > +						   clk) - 1) - 1) << 16));
> >  
> >  	sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_ENABLE);
> >  }
> > -- 
> > 1.7.6.3
> > 
> 
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 
