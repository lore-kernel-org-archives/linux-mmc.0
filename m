From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] tmio_mmc: Revise a limit of the data size
Date: Wed, 25 Aug 2010 23:19:28 +0100
Message-ID: <20100825231928.51355c34@linux-g6p1.site>
References: <4C33DFF0.3040804@renesas.com>
	<20100708144647.1e77364b.akpm@linux-foundation.org>
	<4C3BD041.3020705@renesas.com>
	<20100825225208.02a906f7@linux-g6p1.site>
	<20100825150502.33649ff0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:49718 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751748Ab0HYWTa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Aug 2010 18:19:30 -0400
In-Reply-To: <20100825150502.33649ff0.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Ian Molton <ian@mnementh.co.uk>

On Wed, 25 Aug 2010 15:05:02 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> Actually I don't know what happened with this.  I merged it on July 8
> and appear to have dropped it on July 27, but I can't find its
> removed-from-mm email so I don't know why I dropped it.  Weird.

Oh, interesting.

> Oh well, I merged it again.  Is 2.6.37 an appropriate merge schedule?

I'll defer that to Goda and Paul but that seems reasonable to me.

> > Yusuke, have I interpreted your changelog correctly? Also note that
> > your patch should remove the comment above the conditional that says,
> > "Hardware cannot perform 1 and 2 byte requests in 4 bit mode".
> 
> this?
> 
> --- a/drivers/mmc/host/tmio_mmc.c~tmio_mmc-revise-a-limit-of-the-data-size-fix
> +++ a/drivers/mmc/host/tmio_mmc.c
> @@ -660,7 +660,6 @@ static int tmio_mmc_start_data(struct tm
>  	pr_debug("setup data transfer: blocksize %08x  nr_blocks %d\n",
>  		 data->blksz, data->blocks);
>  
> -	/* Hardware cannot perform 1 and 2 byte requests in 4 bit mode */
>  	if (data->blksz < 2 && host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
>  		pr_err("%s: %d byte block unsupported in 4 bit mode\n",
>  		       mmc_hostname(host->mmc), data->blksz);
> _
> 

I was thinking more like changing the comment to say "Hardware cannot
perform 1 byte requests in 4 bit mode" but that's evident from the
check. So sure, removing it seems sane.
