From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [PATCH v2 1/2] mmc: sdhci: add init_card callback
Date: Fri, 13 Jun 2014 14:09:26 +0200
Message-ID: <20140613120926.GF18414@pengutronix.de>
References: <1402655134-1189-1-git-send-email-s.trumtrar@pengutronix.de>
 <CAPDyKFrUp8=0HF2uGoAVWzv-ooi3SjAafOtsfd2irt6HDVizyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45875 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbaFMMJ2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jun 2014 08:09:28 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFrUp8=0HF2uGoAVWzv-ooi3SjAafOtsfd2irt6HDVizyA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Dong Aisheng <b29396@freescale.com>

On Fri, Jun 13, 2014 at 01:01:25PM +0200, Ulf Hansson wrote:
> On 13 June 2014 12:25, Steffen Trumtrar <s.trumtrar@pengutronix.de> wrote:
> > Currently host drivers using the sdhci-pltfm code can not configure the
> > host based on the type of card inserted.
> >
> > The sdio driver e.g. calls the card_init callback, so the host can now
> > know what card is used and configure itself accordingly.
> >
> > Provide a callback for users of the sdhci-pltfm code to use this callback
> > function.
> >
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> At the first glance, this seems like a reasonable approach to your problem.
> 
> Though I wonder if the mmc core really behaves as what a host expect
> in this context. More precisely, the mmc core _only_ invokes
> host_ops->init_card() from the sdio initialization path. Don't your
> host need to be invoked for the SD/eMMC case as well?
> 

For my use-case this is okay. Though it sounds like this is not generic
enough. I'm open for suggestions.

> Do note that the ->init_card() function is also used to handle
> non-standard SDIO devices.
> 

Hm, the problem occured with a card that can't handle single transfers.
So, sounds non-standard to me.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
