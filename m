From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc, sh: use a consistent pr_ prefix
Date: Thu, 11 Nov 2010 08:57:23 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011110856220.15747@axis700.grange>
References: <1289384864-6531-1-git-send-email-horms@verge.net.au>
 <20101110110049.GA1475@linux-sh.org> <20101110133807.GB21836@verge.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20101110133807.GB21836@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <simon@horms.net>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 10 Nov 2010, Simon Horman wrote:

> On Wed, Nov 10, 2010 at 08:00:49PM +0900, Paul Mundt wrote:
> > On Wed, Nov 10, 2010 at 07:27:44PM +0900, Simon Horman wrote:
> > > Use pr_fmt to set the prefix for pr_ messages.
> > > I believe this method is common in other
> > > source files in the kernel tree.
> > > 
> > pr_fmt() is ok when you have no better options, but in this case you have
> > the struct device working for you, so you really should be using it.
> > 
> > Consider the case where you have multiple MMCIF blocks, the debug
> > messages here won't really give you much helpful information if you have
> > no idea which block you're on.
> > 
> > For example..
> > 
> > > diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> > > index 3f49273..9f37f74 100644
> > > --- a/drivers/mmc/host/sh_mmcif.c
> > > +++ b/drivers/mmc/host/sh_mmcif.c
> > > @@ -221,8 +222,8 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
> > >  
> > >  	state1 = sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS1);
> > >  	state2 = sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS2);
> > > -	pr_debug("%s: ERR HOST_STS1 = %08x\n", DRIVER_NAME, state1);
> > > -	pr_debug("%s: ERR HOST_STS2 = %08x\n", DRIVER_NAME, state2);
> > > +	pr_debug("ERR HOST_STS1 = %08x\n", state1);
> > > +	pr_debug("ERR HOST_STS2 = %08x\n", state2);
> > >  
> > >  	if (state1 & STS1_CMDSEQ) {
> > >  		sh_mmcif_bitset(host, MMCIF_CE_CMD_CTRL, CMD_CTRL_BREAK);
> > 
> > You can just convert these to:
> > 
> > 	dev_dbg(&host->pd->dev, ...);
> > 
> > > @@ -230,7 +231,7 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
> > >  		while (1) {
> > >  			timeout--;
> > >  			if (timeout < 0) {
> > > -				pr_err(DRIVER_NAME": Forceed end of " \
> > > +				pr_err("Forceed end of " \
> > >  					"command sequence timeout err\n");
> > >  				return -EIO;
> > >  			}
> > 
> > dev_err(), and so on.
> > 
> 
> Thanks, will do.

Unfortunately I haven't seen this earlier, but one of my just submitted 
patches already does this. Sorry.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
