From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] omap_hsmmc: Reduce max_segs
Date: Tue, 20 Jun 2017 13:39:04 +0100
Message-ID: <CAFbHwiSuAAophPr2tyHOq2iWrC1Uo2N+EOuvhiNcc9xERuvZZA@mail.gmail.com>
References: <20170619093644.16054-1-willn@resin.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34467 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbdFTMjL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2017 08:39:11 -0400
In-Reply-To: <20170619093644.16054-1-willn@resin.io>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ravikumar Kattekola <rk@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

Just adding a few people to CC. I'd love to get some feedback as to
whether this patch makes sense or not.

Cheers,

On Mon, Jun 19, 2017 at 10:36 AM, Will Newton <will.newton@gmail.com> wrote:
> Reduce max_segs to a value that allows allocation of an entire
> descriptor list within a single page. This avoids doing a
> higher order GFP_ATOMIC allocation when setting up a transfer
> which can potentially fail and lead to I/O failures.
>
> Signed-off-by: Will Newton <willn@resin.io>
> ---
>  drivers/mmc/host/omap_hsmmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 1438a72..d5f42d9 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2864,9 +2864,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>                         host->use_adma = true;
>         }
>
> -       /* Since we do only SG emulation, we can have as many segs
> -        * as we want. */
> -       mmc->max_segs = 1024;
> +       /* Set this to a value that allows allocating an entire descriptor
> +          list within a page (zero order allocation). */
> +       mmc->max_segs = 64;
>
>         mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
>         mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
> --
> 2.7.4
>
