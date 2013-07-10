From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 5/7] mmc: SDHI: add DT compatibility strings for
 further SoCs
Date: Wed, 10 Jul 2013 10:18:08 +0900
Message-ID: <20130710011807.GQ32603@verge.net.au>
References: <1373298887-9877-1-git-send-email-g.liakhovetski@gmx.de>
 <1373298887-9877-6-git-send-email-g.liakhovetski@gmx.de>
 <878v1gtgcg.wl%kuninori.morimoto.gx@renesas.com>
 <20130710003832.GE15011@verge.net.au>
 <874nc3w7ln.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874nc3w7ln.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 09, 2013 at 06:02:00PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> > > > index cc4c872..b58c1a9 100644
> > > > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > > > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > > > @@ -130,6 +130,9 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
> > > >  	{ .compatible = "renesas,shmobile-sdhi" },
> > > >  	{ .compatible = "renesas,sh7372-sdhi" },
> > > >  	{ .compatible = "renesas,r8a7740-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
> > > > +	{ .compatible = "renesas,sh73a0-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
> > > > +	{ .compatible = "renesas,r8a73a4-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
> > > > +	{ .compatible = "renesas,r8a7790-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
> > > >  	{},
> > > 
> > > According to HW people, latest Renesas chip needs "TMIO_MMC_HAS_IDLE_WAIT".
> > > Could you plase add r8a7778 / r8a7779 here ?
> > > 
> > > # or we can use common compatible name for it ?
> > 
> > Hi Guennadi,
> > 
> > could you please address Morimoto-san's review?
> 
> He did it on
> 
> Subject: [PATCH v4 5/7] mmc: SDHI: add DT compatibility strings for further SoCs
> Date:	Tue, 9 Jul 2013 09:43:40 +0200 (CEST)

Thanks for pointing that out. Somehow I missed it.
