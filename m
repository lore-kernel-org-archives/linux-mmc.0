From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 08/12] mmc: sh_mobile_sdhi: Convert to clk_prepare/unprepare
Date: Wed, 11 Dec 2013 13:01:21 +0100
Message-ID: <23114596.UeGyAebmZh@avalon>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <3901213.QOEV1AdNoe@avalon> <2163819.oJv92Ekf2I@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <2163819.oJv92Ekf2I@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

On Tuesday 26 November 2013 03:02:48 Laurent Pinchart wrote:
> On Saturday 09 November 2013 13:56:40 Laurent Pinchart wrote:
> > Hi Chris,
> > 
> > Could you please pick this patch up ?
> 
> Ping ?

PING ?

> As this patch is a dependency for other series that will go through
> different trees, could you please provide a stable branch in your tree with
> this patch included that you will push to v3.14 ?
> 
> > On Tuesday 29 October 2013 09:09:37 Guennadi Liakhovetski wrote:
> > > On Mon, 28 Oct 2013, Laurent Pinchart wrote:
> > > > Turn clk_enable() and clk_disable() calls into clk_prepare_enable()
> > > > and clk_disable_unprepare() to get ready for the migration to the
> > > > common clock framework.
> > > > 
> > > > Cc: Chris Ball <cjb@laptop.org>
> > > > Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > > > Cc: linux-mmc@vger.kernel.org
> > > > Signed-off-by: Laurent Pinchart
> > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > 
> > > Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > 
> > > Thanks
> > > Guennadi
> > > 
> > > > ---
> > > > 
> > > >  drivers/mmc/host/sh_mobile_sdhi.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c
> > > > b/drivers/mmc/host/sh_mobile_sdhi.c index f344659..ed1718a 100644
> > > > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > > > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > > > @@ -54,7 +54,7 @@ static int sh_mobile_sdhi_clk_enable(struct
> > > > platform_device *pdev, unsigned int
> > > >  	struct mmc_host *mmc = platform_get_drvdata(pdev);
> > > >  	struct tmio_mmc_host *host = mmc_priv(mmc);
> > > >  	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct
> > > >  	sh_mobile_sdhi, mmc_data);
> > > > 
> > > > -	int ret = clk_enable(priv->clk);
> > > > +	int ret = clk_prepare_enable(priv->clk);
> > > >  	if (ret < 0)
> > > >  		return ret;
> > > > 
> > > > @@ -67,7 +67,7 @@ static void sh_mobile_sdhi_clk_disable(struct
> > > > platform_device *pdev)
> > > >  	struct mmc_host *mmc = platform_get_drvdata(pdev);
> > > >  	struct tmio_mmc_host *host = mmc_priv(mmc);
> > > >  	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct
> > > >  	sh_mobile_sdhi, mmc_data);
> > > > 
> > > > -	clk_disable(priv->clk);
> > > > +	clk_disable_unprepare(priv->clk);
> > > >  }
> > > >  
> > > >  static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)

-- 
Regards,

Laurent Pinchart

