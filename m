From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 3/4] mmc: sdhi: Make use of per-source irq handlers
Date: Tue, 16 Aug 2011 14:40:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1108161438530.13913@axis700.grange>
References: <1313489486-831-1-git-send-email-horms@verge.net.au>
 <1313489486-831-4-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1108161232520.13913@axis700.grange> <20110816115141.GE3110@verge.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110816115141.GE3110@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, 16 Aug 2011, Simon Horman wrote:

> On Tue, Aug 16, 2011 at 01:11:42PM +0200, Guennadi Liakhovetski wrote:
> > On Tue, 16 Aug 2011, Simon Horman wrote:
> > 
> > > Make use of per-source irq handles if the
> > > platform (data) has multiple irq sources.
> > > 
> > > Also, as suggested by Guennadi Liakhovetski,
> > > add and use defines the index or irqs in platform data.
> > > 
> > > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > Signed-off-by: Simon Horman <horms@verge.net.au>
> > > 
> > > ---
> > > 
> > > v3
> > > * Update for changes to "mmc: tmio: Provide separate interrupt handlers"
> > > * As suggested by Guennadi Liakhovetski:
> > >   - Merge in patch "mmc: sdhi: Add defines for platform irq indexes"
> > >   - Use an enum instead of defines for irq indexes
> > > 
> > > v2
> > > * Update for changes to "mmc: tmio: Provide separate interrupt handlers"
> > > * Make use of defines provided by
> > >   "mmc: sdhi: Add defines for platform irq indexes"
> > > * As suggested by Guennadi Liakhovetski:
> > >   - Don't use a loop to initialise irq handlers, the unrolled version
> > >     is easier on the eyes (and exactly the same number of lines of code!)
> > > ---
> > >  drivers/mmc/host/sh_mobile_sdhi.c  |   60 ++++++++++++++++++++++-------------
> > >  include/linux/mmc/sh_mobile_sdhi.h |    7 ++++
> > >  2 files changed, 45 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> > > index 774f643..d792705 100644
> > > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > > @@ -96,7 +96,9 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
> > >  	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
> > >  	struct tmio_mmc_host *host;
> > >  	char clk_name[8];
> > > -	int i, irq, ret;
> > > +	int irq, ret;
> > > +	irqreturn_t (*f)(int irq, void *devid);
> > > +	bool multi_irq = false;
> > >  
> > >  	priv = kzalloc(sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
> > >  	if (priv == NULL) {
> > > @@ -153,27 +155,33 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
> > >  	if (ret < 0)
> > >  		goto eprobe;
> > >  
> > > -	for (i = 0; i < 3; i++) {
> > > -		irq = platform_get_irq(pdev, i);
> > > -		if (irq < 0) {
> > > -			if (i) {
> > > -				continue;
> > > -			} else {
> > > -				ret = irq;
> > > -				goto eirq;
> > > -			}
> > > -		}
> > > -		ret = request_irq(irq, tmio_mmc_irq, 0,
> > > +	irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
> > > +	if (irq >= 0) {
> > > +		multi_irq = true;
> > > +		ret = request_irq(irq, tmio_mmc_sdio_irq, 0,
> > >  				  dev_name(&pdev->dev), host);
> > > -		if (ret) {
> > > -			while (i--) {
> > > -				irq = platform_get_irq(pdev, i);
> > > -				if (irq >= 0)
> > > -					free_irq(irq, host);
> > > -			}
> > > -			goto eirq;
> > > -		}
> > > +		if (ret)
> > > +			goto eirq_sdio;
> > >  	}
> > > +
> > > +	ret = irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
> > > +	if (irq >= 0) {
> > > +		multi_irq = true;
> > > +		ret = request_irq(irq, tmio_mmc_sdcard_irq, 0,
> > > +				  dev_name(&pdev->dev), host);
> > 
> > Sorry, I still don't understand why you check "CARD_DETECT" and request 
> > "sdcard_irq." Am I missing something or was my comment not clear enough in 
> > the previous review?
> > 
> > > +		if (ret)
> > > +			goto eirq_card_detect;
> > > +	} else if (multi_irq)
> > > +		goto eirq_card_detect;
> > 
> > ? Sorry, have you maybe missed my review?
> > 
> > > +
> > > +	ret = irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
> > > +	if (irq < 0)
> > > +		goto eirq_sdcard;
> > > +	f = multi_irq ? tmio_mmc_card_detect_irq : tmio_mmc_irq;
> > 
> > Same here
> 
> Sorry, that is a bug.
> 
> As the code seems to work on my board I think it should be fixed by
> inverting the values of SH_MOBILE_SDHI_IRQ_SDCARD and
> SH_MOBILE_SDHI_IRQ_CARD_DETECT.
> 
> I will check that and repost.

Right, SDIO works, /proc/interrupts has

  96:          5  sh7372-intca-level     sh_mobile_sdhi.0
  97:    4116138  sh7372-intca-level     sh_mobile_sdhi.0
  98:      44822  sh7372-intca-level     sh_mobile_sdhi.0

So, indeed, #0 is card-detect, #1 is sdcard, #2 is sdio, your enum is 
wrong and request_irq() swapped ISRs compensate for that mistake.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
