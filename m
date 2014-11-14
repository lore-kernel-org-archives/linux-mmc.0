From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [RESEND PATCH 2/2] mmc: atmel-mci: introduce probe deferring
Date: Fri, 14 Nov 2014 16:14:18 +0100
Message-ID: <20141114151418.GX3639@ldesroches-Latitude-E6320>
References: <1415975785-30303-1-git-send-email-ludovic.desroches@atmel.com>
 <1415975785-30303-2-git-send-email-ludovic.desroches@atmel.com>
 <546617D1.5060904@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:4133 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965374AbaKNPOE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Nov 2014 10:14:04 -0500
Content-Disposition: inline
In-Reply-To: <546617D1.5060904@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org

On Fri, Nov 14, 2014 at 03:55:13PM +0100, Nicolas Ferre wrote:
> On 14/11/2014 15:36, Ludovic Desroches :
> > Return probe defer if requesting a dma channel without a dma controller
> > probed. Using late_initcall is no more needing.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> > 
> > Sorry for the noise, typo in cc list.
> > 
> >  drivers/mmc/host/atmel-mci.c | 52 +++++++++++++++++++++++++-------------------
> >  1 file changed, 30 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> > index de2287c..caddbbd 100644
> > --- a/drivers/mmc/host/atmel-mci.c
> > +++ b/drivers/mmc/host/atmel-mci.c
> > @@ -2272,37 +2272,40 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
> >  	mmc_free_host(slot->mmc);
> >  }
> >  
> > -static bool atmci_configure_dma(struct atmel_mci *host)
> > +static int atmci_configure_dma(struct atmel_mci *host)
> >  {
> >  	struct mci_platform_data	*pdata;
> >  	dma_cap_mask_t mask;
> > +	int ret = 0;
> >  
> >  	if (host == NULL)
> > -		return false;
> > +		return -EINVAL;
> >  
> >  	pdata = host->pdev->dev.platform_data;
> >  
> >  	dma_cap_zero(mask);
> >  	dma_cap_set(DMA_SLAVE, mask);
> >  
> > -	host->dma.chan = dma_request_slave_channel(&host->pdev->dev, "rxtx");
> > -	if (!host->dma.chan) {
> > -		dev_warn(&host->pdev->dev, "no DMA channel available\n");
> > -		return false;
> > -	} else {
> > -		dev_info(&host->pdev->dev,
> > -					"using %s for DMA transfers\n",
> > -					dma_chan_name(host->dma.chan));
> > -
> > -		host->dma_conf.src_addr = host->mapbase + ATMCI_RDR;
> > -		host->dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> > -		host->dma_conf.src_maxburst = 1;
> > -		host->dma_conf.dst_addr = host->mapbase + ATMCI_TDR;
> > -		host->dma_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> > -		host->dma_conf.dst_maxburst = 1;
> > -		host->dma_conf.device_fc = false;
> > -		return true;
> > +	host->dma.chan = dma_request_slave_channel_reason(&host->pdev->dev, "rxtx");
> > +	if (IS_ERR(host->dma.chan)) {
> > +		ret = PTR_ERR(host->dma.chan);
> > +		if (ret != -EPROBE_DEFER)
> > +			dev_warn(&host->pdev->dev, "no DMA channel available\n");
> > +		return ret;
> >  	}
> > +
> > +	dev_info(&host->pdev->dev,
> > +			"using %s for DMA transfers\n",
> > +			dma_chan_name(host->dma.chan));
> > +
> > +	host->dma_conf.src_addr = host->mapbase + ATMCI_RDR;
> > +	host->dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +	host->dma_conf.src_maxburst = 1;
> > +	host->dma_conf.dst_addr = host->mapbase + ATMCI_TDR;
> > +	host->dma_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +	host->dma_conf.dst_maxburst = 1;
> > +	host->dma_conf.device_fc = false;
> > +	return ret;
> >  }
> >  
> >  /*
> > @@ -2419,7 +2422,10 @@ static int __init atmci_probe(struct platform_device *pdev)
> >  
> >  	/* Get MCI capabilities and set operations according to it */
> >  	atmci_get_cap(host);
> > -	if (atmci_configure_dma(host)) {
> > +	ret = atmci_configure_dma(host);
> > +	if (ret == -EPROBE_DEFER)
> > +		goto err_dma_probe_defer;
> > +	if (ret == 0) {
> >  		host->prepare_data = &atmci_prepare_data_dma;
> >  		host->submit_data = &atmci_submit_data_dma;
> >  		host->stop_transfer = &atmci_stop_transfer_dma;
> > @@ -2506,6 +2512,7 @@ err_init_slot:
> >  	del_timer_sync(&host->timer);
> >  	if (host->dma.chan)
> >  		dma_release_channel(host->dma.chan);
> > +err_dma_probe_defer:
> >  	free_irq(irq, host);
> >  	return ret;
> >  }
> > @@ -2573,6 +2580,7 @@ static const struct dev_pm_ops atmci_dev_pm_ops = {
> >  };
> >  
> >  static struct platform_driver atmci_driver = {
> > +	.probe		= atmci_probe,
> >  	.remove		= __exit_p(atmci_remove),
> >  	.driver		= {
> >  		.name		= "atmel_mci",
> > @@ -2583,7 +2591,7 @@ static struct platform_driver atmci_driver = {
> >  
> >  static int __init atmci_init(void)
> >  {
> > -	return platform_driver_probe(&atmci_driver, atmci_probe);
> > +	return platform_driver_register(&atmci_driver);
> >  }
> >  
> >  static void __exit atmci_exit(void)
> > @@ -2591,7 +2599,7 @@ static void __exit atmci_exit(void)
> >  	platform_driver_unregister(&atmci_driver);
> >  }
> >  
> > -late_initcall(atmci_init); /* try to load after dma driver when built-in */
> > +subsys_initcall(atmci_init);
> 
> If deferring probe is activated, so I don't know why a special initcall
> function is still needed.
> 

Right, initcall is still a constraint I can remove, I'll replace it with
module_platform_driver().

> >  module_exit(atmci_exit);
> >  
> >  MODULE_DESCRIPTION("Atmel Multimedia Card Interface driver");
> > 

Ludovic
