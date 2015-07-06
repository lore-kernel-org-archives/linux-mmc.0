From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-of-at91: introduce driver for the Atmel
 SDMMC
Date: Mon, 6 Jul 2015 09:33:52 +0200
Message-ID: <20150706073352.GB24167@odux.rfo.atmel.com>
References: <1435933037-12889-1-git-send-email-ludovic.desroches@atmel.com>
 <1435933037-12889-3-git-send-email-ludovic.desroches@atmel.com>
 <1435998628.20057.26.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435998628.20057.26.camel@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
List-Id: linux-mmc@vger.kernel.org

On Sat, Jul 04, 2015 at 10:30:28AM +0200, Paul Bolle wrote:
> A nit only: a license mismatch.

Thanks Paul, I'll correct it.

> 
> On vr, 2015-07-03 at 16:17 +0200, Ludovic Desroches wrote:
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-of-at91.c
> > 
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or (at
> > + * your option) any later version.
> 
> This states the license is GPL v2 or later.
> 
> > +MODULE_LICENSE("GPL v2");
> 
> And, according to include/linux/module.h, this states the license is
> (only) GPL v2. So I think that either the comment at the top of this
> file or the ident used in MODULE_LICENSE() needs to change.
> 
> Thanks,
> 
> 
> Paul Bolle
