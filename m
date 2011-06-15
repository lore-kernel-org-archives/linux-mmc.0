From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 4/4] mmc: sdhci-esdhc-imx: extend card_detect and
 write_protect support for mx5
Date: Wed, 15 Jun 2011 18:33:45 +0800
Message-ID: <20110615103344.GA3579@S2100-06.ap.freescale.net>
References: <1307702572-22066-5-git-send-email-shawn.guo@linaro.org>
 <1308034059-4014-1-git-send-email-shawn.guo@linaro.org>
 <20110614095129.GD5043@pengutronix.de>
 <20110614130610.GH30295@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:56676 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab1FOKa1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2011 06:30:27 -0400
Content-Disposition: inline
In-Reply-To: <20110614130610.GH30295@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Eric Benard <eric@eukrea.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Tue, Jun 14, 2011 at 09:06:11PM +0800, Shawn Guo wrote:
[...]
> > >  
> > > +static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
> > > +{
> > > +	struct esdhc_platform_data *boarddata =
> > > +			host->mmc->parent->platform_data;
> > > +
> > > +	if (gpio_is_valid(boarddata->wp_gpio))
> > > +		return gpio_get_value(boarddata->wp_gpio);
> > > +	else
> > > +		return !(readl(host->ioaddr + SDHCI_PRESENT_STATE) &
> > > +				SDHCI_WRITE_PROTECT);
> > > +}
> > 
> > Aren't you missing the NONE case here? Plus, I don't like having a
> > get_ro-function for the SIGNAL case, because in that case it is
> > superfluous. Though, I am not feeling strong about this if it makes the
> > rest of the code messier.
> > 
> OK, I will go back to the existing one, which only handles gpio case
> in esdhc_pltfm_get_ro and get it assigned to .get_ro only in case of
> ESDHC_WP_GPIO.
> 
Sorry.  I had some reason for moving esdhc_pltfm_get_ro around.  We
can not keep the existing approach (what I said above).  For mx51
babbage example, esdhc1 uses internal WP while esdhc2 uses gpio WP.
If we have esdhc_pltfm_get_ro handle gpio only and assign it to
sdhci_esdhc_ops.get_ro in .probe only when wp_type is ESDHC_WP_GPIO,
that works for esdhc2 but breaks esdhc1 WP function.  So no, I will
not change my code except adding NONE case handling there.

-- 
Regards,
Shawn

