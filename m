From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/5] mmc: sdhci-esdhc-imx: add support for write
 protect on custom GPIO
Date: Fri, 11 Feb 2011 10:42:48 +0100
Message-ID: <20110211094248.GA2264@pengutronix.de>
References: <1297365291-1038-1-git-send-email-w.sang@pengutronix.de>
 <1297365291-1038-2-git-send-email-w.sang@pengutronix.de>
 <201102110924.38338.marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42011 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab1BKJm6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Feb 2011 04:42:58 -0500
Content-Disposition: inline
In-Reply-To: <201102110924.38338.marc@cpdesign.com.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marc Reilly <marc@cpdesign.com.au>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Zhu Richard-R65037 <r65037@freescale.com>, kernel@pengutronix.de, Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>

Marc,

On Fri, Feb 11, 2011 at 09:24:38AM +1100, Marc Reilly wrote:

> Tested-by: Marc Reilly <marc@cpdesign.com.au> 

Thanks a lot!

> > +	if (boarddata) {
> 
> Perhaps (boarddata && gpio_is_valid(boarddata->wp_gpio) as above?
> 
> For example what if someone sets up the boarddata for a card detect, but not 
> write protect.

Well, I couldn't do this here, because later the cd_pin-stuff will also
be added to the if-block. However, I see what you mean and that could
still be added before the gpio_request below. That would add another
level of indentation, though, for a case I'd consider to be more
theoretical (and definately not recommended). Maybe I will adjust the
warning message to be also understandable for the case a GPIO is preset
with an invalid number. I think the warning itself is justified.

> 
> > +		err = gpio_request_one(boarddata->wp_gpio, GPIOF_IN, "ESDHC_WP");
> > +		if (err) {
> > +			dev_warn(mmc_dev(host->mmc), "can't get wp_pin!\n");
> > +			boarddata->wp_gpio = err;
> > +		}
> > +	}

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
