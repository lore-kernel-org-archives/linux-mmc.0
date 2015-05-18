From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [PATCH 4/6] mmc: sh_mobile_sdhi: Add UHS-I mode support
Date: Mon, 18 May 2015 18:00:15 +0100
Message-ID: <1431968415.1970.4.camel@codethink.co.uk>
References: <1431822459.4222.166.camel@xylophone.i.decadent.org.uk>
	 <1431822549.4222.171.camel@xylophone.i.decadent.org.uk>
	 <87d21yu27f.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:34533 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbERRAU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2015 13:00:20 -0400
In-Reply-To: <87d21yu27f.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>

On Mon, 2015-05-18 at 01:05 +0000, Kuninori Morimoto wrote:
> Hi Ben
> 
> > Implement voltage switch, supporting modes up to SDR-50.
> > 
> > Based on work by Shinobu Uehara, Rob Taylor, William Towle and Ian Molton.
> > 
> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > ---
> 
> I have 1 concern about .start_signal_voltage_switch return value
> 
> > +static int sh_mobile_sdhi_start_signal_voltage_switch(
> > +	struct tmio_mmc_host *host, unsigned char signal_voltage)
> > +{
> > +	struct sh_mobile_sdhi *priv = host_to_priv(host);
> > +	struct pinctrl_state *state;
> > +	int min_uV, max_uV;
> > +	int ret;
> > +
> > +	if (IS_ERR(priv->pinctrl) || IS_ERR(host->mmc->supply.vqmmc))
> > +		return -EOPNOTSUPP;
> (snip)
> > @@ -239,6 +293,10 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
> >  	host->clk_enable	= sh_mobile_sdhi_clk_enable;
> >  	host->clk_disable	= sh_mobile_sdhi_clk_disable;
> >  	host->multi_io_quirk	= sh_mobile_sdhi_multi_io_quirk;
> > +
> > +	host->start_signal_voltage_switch
> > +				= sh_mobile_sdhi_start_signal_voltage_switch;
> > +
> 
> This sh_mobile_sdhi_start_signal_voltage_switch() will return -EOPNOTSUPP
> if IS_ERR(xx) cases, and it will be used on .tmio_mmc_start_signal_voltage_switch /
> mmc_set_signal_voltage. These will think it is error and goes to error case or try again.
> But, not supported is not error ?

It is if we need to switch to a lower voltage.

> Maybe we need this kind of code somewhere ? (ex. ALSA SoC has similar method)
> 
> 	/* EOPNOTSUPP is not error */
> 	if (ret == -EOPNOTSUPP)
> 		ret = 0;
> 
> I have no objection if my concern never happen.

I think the driver should do something like this if the requested
voltage is MMC_SIGNAL_VOLTAGE_330.  I'll fix that in the next version.

Ben.



