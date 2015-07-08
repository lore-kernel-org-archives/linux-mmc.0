From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/6] mmc: sdhci-esdhc-imx: add tuning-step seting support
Date: Wed, 8 Jul 2015 17:00:04 +0800
Message-ID: <20150708090004.GB28488@tiger>
References: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
 <1433926244-29244-3-git-send-email-haibo.chen@freescale.com>
 <20150703111017.GA17553@localhost>
 <BY1PR03MB138801E1ECE136F138F7D4A99A930@BY1PR03MB1388.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55669 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758256AbbGHJAQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Jul 2015 05:00:16 -0400
Content-Disposition: inline
In-Reply-To: <BY1PR03MB138801E1ECE136F138F7D4A99A930@BY1PR03MB1388.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen Bough <Haibo.Chen@freescale.com>
Cc: "Dong A.S." <Aisheng.Dong@freescale.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jul 06, 2015 at 03:05:47AM +0000, Chen Bough wrote:
> 
> > -----Original Message-----
> > From: Shawn Guo [mailto:shawnguo@kernel.org]
> > Sent: Friday, July 03, 2015 7:10 PM
> > To: Chen Haibo-B51421
> > Cc: linux-mmc@vger.kernel.org; Dong Aisheng-B29396;
> > ulf.hansson@linaro.org; chris@printf.net; shawn.guo@linaro.org; linux-
> > arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH 2/6] mmc: sdhci-esdhc-imx: add tuning-step seting
> > support
> > 
> > On Wed, Jun 10, 2015 at 04:50:40PM +0800, Haibo Chen wrote:
> > > @@ -969,6 +976,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device
> > *pdev,
> > >
> > >  	of_property_read_u32(np, "max-frequency", &boarddata->f_max);
> > >
> > > +	of_property_read_u32(np, "tuning-step", &boarddata->tuning_step);
> > > +
> > 
> > Where is the binding doc for this device tree property?
> > 
> > Shawn
> 
> I will add this in next version, Thanks for your review.

If this is a vendor specific property rather than generic one, do not
forget to have a vendor prefix for the property, i.e. "fsl,tuning-step".

Shawn
