From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 07/12] mmc: sh_mmcif: Convert to clk_prepare/unprepare
Date: Wed, 30 Oct 2013 23:23:37 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1310302322480.25391@axis700.grange>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <Pine.LNX.4.64.1310290910160.8404@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1310290910160.8404@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 29 Oct 2013, Guennadi Liakhovetski wrote:

> On Mon, 28 Oct 2013, Laurent Pinchart wrote:
> 
> > Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
> > clk_disable_unprepare() to get ready for the migration to the common
> > clock framework.
> > 
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > Cc: linux-mmc@vger.kernel.org
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Sorry, I just realised, that an identical patch

http://patches.linaro.org/21212/

has been submitted prior to this one, so, we should really take the other 
one.

Thanks
Guennadi
> 
> > ---
> >  drivers/mmc/host/sh_mmcif.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> > index 36629a0..37a6c57 100644
> > --- a/drivers/mmc/host/sh_mmcif.c
> > +++ b/drivers/mmc/host/sh_mmcif.c
> > @@ -964,7 +964,7 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >  
> >  static int sh_mmcif_clk_update(struct sh_mmcif_host *host)
> >  {
> > -	int ret = clk_enable(host->hclk);
> > +	int ret = clk_prepare_enable(host->hclk);
> >  
> >  	if (!ret) {
> >  		host->clk = clk_get_rate(host->hclk);
> > @@ -1018,7 +1018,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  		}
> >  		if (host->power) {
> >  			pm_runtime_put_sync(&host->pd->dev);
> > -			clk_disable(host->hclk);
> > +			clk_disable_unprepare(host->hclk);
> >  			host->power = false;
> >  			if (ios->power_mode == MMC_POWER_OFF)
> >  				sh_mmcif_set_power(host, ios);
> > @@ -1466,7 +1466,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
> >  
> >  	mutex_init(&host->thread_lock);
> >  
> > -	clk_disable(host->hclk);
> > +	clk_disable_unprepare(host->hclk);
> >  	ret = mmc_add_host(mmc);
> >  	if (ret < 0)
> >  		goto emmcaddh;
> > @@ -1487,7 +1487,7 @@ ereqirq1:
> >  ereqirq0:
> >  	pm_runtime_suspend(&pdev->dev);
> >  eresume:
> > -	clk_disable(host->hclk);
> > +	clk_disable_unprepare(host->hclk);
> >  eclkupdate:
> >  	clk_put(host->hclk);
> >  eclkget:
> > @@ -1505,7 +1505,7 @@ static int sh_mmcif_remove(struct platform_device *pdev)
> >  	int irq[2];
> >  
> >  	host->dying = true;
> > -	clk_enable(host->hclk);
> > +	clk_prepare_enable(host->hclk);
> >  	pm_runtime_get_sync(&pdev->dev);
> >  
> >  	dev_pm_qos_hide_latency_limit(&pdev->dev);
> > @@ -1530,7 +1530,7 @@ static int sh_mmcif_remove(struct platform_device *pdev)
> >  	if (irq[1] >= 0)
> >  		free_irq(irq[1], host);
> >  
> > -	clk_disable(host->hclk);
> > +	clk_disable_unprepare(host->hclk);
> >  	mmc_free_host(host->mmc);
> >  	pm_runtime_put_sync(&pdev->dev);
> >  	pm_runtime_disable(&pdev->dev);
> > -- 
> > 1.8.1.5
> > 
> 
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
