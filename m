From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap_hsmmc: Reduce max_segs
Date: Tue, 20 Jun 2017 23:24:27 -0700
Message-ID: <20170621062427.GP3730@atomide.com>
References: <20170619093644.16054-1-willn@resin.io>
 <CAFbHwiSuAAophPr2tyHOq2iWrC1Uo2N+EOuvhiNcc9xERuvZZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:59286 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750753AbdFUGYc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 21 Jun 2017 02:24:32 -0400
Content-Disposition: inline
In-Reply-To: <CAFbHwiSuAAophPr2tyHOq2iWrC1Uo2N+EOuvhiNcc9xERuvZZA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: linux-omap@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ravikumar Kattekola <rk@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Will Newton <will.newton@gmail.com> [170620 05:39]:
> Just adding a few people to CC. I'd love to get some feedback as to
> whether this patch makes sense or not.
>
> On Mon, Jun 19, 2017 at 10:36 AM, Will Newton <will.newton@gmail.com> wrote:
> > Reduce max_segs to a value that allows allocation of an entire
> > descriptor list within a single page. This avoids doing a
> > higher order GFP_ATOMIC allocation when setting up a transfer
> > which can potentially fail and lead to I/O failures.

I recall we only ever have few SG entries so if there is no performance
impact I see no reason to lower it to save memory. Care to check
if that's the case still?

Regards,

Tony


> > Signed-off-by: Will Newton <willn@resin.io>
> > ---
> >  drivers/mmc/host/omap_hsmmc.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> > index 1438a72..d5f42d9 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -2864,9 +2864,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
> >                         host->use_adma = true;
> >         }
> >
> > -       /* Since we do only SG emulation, we can have as many segs
> > -        * as we want. */
> > -       mmc->max_segs = 1024;
> > +       /* Set this to a value that allows allocating an entire descriptor
> > +          list within a page (zero order allocation). */
> > +       mmc->max_segs = 64;
> >
> >         mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
> >         mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
> > --
> > 2.7.4
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
