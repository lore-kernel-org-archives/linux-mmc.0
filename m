From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Subject: Re: [PATCH] mxcmmc: Add the ability to bind a regulator to manage
 the MMC card voltage
Date: Tue, 09 Nov 2010 11:03:08 +0100
Message-ID: <1289296988.3020.19.camel@realization>
References: <1288656337.29881.13.camel@realization>
	 <AANLkTi=oKHTmLS=xiNi9CJKttBGzMHjhZ3q_KWvi+xta@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54237 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966Ab0KIKDP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2010 05:03:15 -0500
In-Reply-To: <AANLkTi=oKHTmLS=xiNi9CJKttBGzMHjhZ3q_KWvi+xta@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Daniel Mack <daniel@caiaq.de>, Andrew Morton <akpm@linux-foundation.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Fabio Estevam <fabioestevam@yahoo.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On lun, 2010-11-08 at 23:12 +0100, Linus Walleij wrote:
> 2010/11/2 Alberto Panizzo <maramaopercheseimorto@gmail.com>:
> 
> > +static inline void mxcmci_init_ocr(struct mxcmci_host *host)
> > +{
> > +#ifdef CONFIG_REGULATOR
> > +       host->vcc = regulator_get(mmc_dev(host->mmc), "vmmc");
> > +
> > +       if (IS_ERR(host->vcc)) {
> > +               host->vcc = NULL;
> > +       } else {
> > +               host->mmc->ocr_avail = mmc_regulator_get_ocrmask(host->vcc);
> > +               if (host->pdata && host->pdata->ocr_avail)
> > +                       dev_warn(mmc_dev(host->mmc),
> > +                               "pdata->ocr_avail will not be used\n");
> > +       }
> > +#endif
> 
> You don't need these #ifdef CONFIG_REGULATOR guardposts
> anymore. I implemented stub functions for the ocrmask functions
> for 2.6.37.

Ehm.. thank you really for pointing me this, because I've also used the
old API breaking the build in the -next branch..

A Fix will be posted as soon as possible!

Thanks Linus!
Best regards,

-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)

