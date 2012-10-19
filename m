From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2] mmc: sdhci-s3c: fix the card detection in runtime-pm
Date: Fri, 19 Oct 2012 10:10:48 +0200
Message-ID: <201210191010.48776.heiko@sntech.de>
References: <004801cdad17$498d9140$dca8b3c0$%jun@samsung.com> <201210181302.30843.heiko@sntech.de> <006501cdadd0$548d1f70$fda75e50$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:44570 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916Ab2JSIKx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 19 Oct 2012 04:10:53 -0400
In-Reply-To: <006501cdadd0$548d1f70$fda75e50$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chander Kashyap' <chander.kashyap@linaro.org>, 'Chris Ball' <cjb@laptop.org>

Am Freitag, 19. Oktober 2012, 10:04:14 schrieb Seungwon Jeon:
> On Thursday, October 18, 2012, Heiko Stuebner <heiko@sntech.de>
> 
> > If host clock is disabled, host cannot detect a card
> > in case of using the internal or gpio card-detect for detection.
> > 
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > I've added the SDHCI_CD_GPIO to the conditional. With this change it
> > works on my machine. But I'm not sure if this would also be necessary
> > for the external card detect.
> 
> Card detection will be asserted out of host in case of using SDHCI_CD_GPIO.
> Adding SDHCI_CD_GPIO to the conditional seems unnecessary.

But it _was_ necessary :-) . Because only then did the problem go away. You 
might be right, that there exists a better solution for this, but something in 
the original patch is at least still missing to fix the problem.

Heiko


> >  drivers/mmc/host/sdhci-s3c.c |    8 ++++++--
> >  1 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> > index 0cabf18..649dc32 100644
> > --- a/drivers/mmc/host/sdhci-s3c.c
> > +++ b/drivers/mmc/host/sdhci-s3c.c
> > @@ -750,7 +750,9 @@ static int __devinit sdhci_s3c_probe(struct
> > platform_device *pdev)
> > 
> >  		sdhci_s3c_setup_card_detect_gpio(sc);
> >  
> >  #ifdef CONFIG_PM_RUNTIME
> > 
> > -	clk_disable(sc->clk_io);
> > +	if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL &&
> > +	    pdata->cd_type != S3C_SDHCI_CD_GPIO)
> > +		clk_disable(sc->clk_io);
> > 
> >  #endif
> >  
> >  	return 0;
> > 
> > @@ -797,7 +799,9 @@ static int __devexit sdhci_s3c_remove(struct
> > platform_device *pdev)
> > 
> >  		gpio_free(sc->ext_cd_gpio);
> >  
> >  #ifdef CONFIG_PM_RUNTIME
> > 
> > -	clk_enable(sc->clk_io);
> > +	if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL &&
> > +	    pdata->cd_type != S3C_SDHCI_CD_GPIO)
> > +		clk_enable(sc->clk_io);
> > 
> >  #endif
> >  
> >  	sdhci_remove_host(host, 1);
> > 
> > --
> > 1.7.2.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

