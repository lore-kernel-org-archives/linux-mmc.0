From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4] tmio_mmc_pio: prevent endless loop in tmio_mmc_set_clock()
Date: Fri, 19 Sep 2014 20:46:29 +0200
Message-ID: <CAPDyKFpZnkkDbUHX3HmcGK7+7NEnUU526RADFO+O1xS6mzUhnQ@mail.gmail.com>
References: <10228473.uOqbQ0oioV@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:37974 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756771AbaISSqa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Sep 2014 14:46:30 -0400
Received: by mail-qa0-f49.google.com with SMTP id j7so56169qaq.8
        for <linux-mmc@vger.kernel.org>; Fri, 19 Sep 2014 11:46:29 -0700 (PDT)
In-Reply-To: <10228473.uOqbQ0oioV@wasted.cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ian Molton <ian.molton@codethink.co.uk>, Chris Ball <chris@printf.net>, Linux-sh list <linux-sh@vger.kernel.org>

On 18 September 2014 21:33, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> I spent a couple of days with the driver just hanging due to me forgetting to
> specify the external crystal frequency,  so that clk_get_rate() returned 0 and
> thus the loop in tmio_mmc_set_clock() never ended. I don't think that's an
> acceptable behavior, so I suggest that the minimum frequency is checked for 0
> in tmio_mmc_host_probe().
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Ian Molton <ian.molton@codethink.co.uk>
> Cc: stable@vger.kernel.org

Thanks! Applied for next with a smaller change - adding a "mmc" prefix
for the commit message subject.

Kind regards
Uffe

>
> ---
> The patch is against Ulf Hansson's 'mmc.git' repo's 'next' branch.
>
> Changes in version 4:
> - rebased to the 'next' branch, resolving reject;
> - added Ian Molton's ACK.
>
> Changes in version 3:
> - added Cc: stable.
>
> Changes in version 2:
> - fixed grammar in the changelog.
>
>  drivers/mmc/host/tmio_mmc_pio.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> Index: mmc/drivers/mmc/host/tmio_mmc_pio.c
> ===================================================================
> --- mmc.orig/drivers/mmc/host/tmio_mmc_pio.c
> +++ mmc/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1091,6 +1091,15 @@ int tmio_mmc_host_probe(struct tmio_mmc_
>         }
>
>         /*
> +        * Check the sanity of mmc->f_min to prevent tmio_mmc_set_clock() from
> +        * looping forever...
> +        */
> +       if (mmc->f_min == 0) {
> +               ret = -EINVAL;
> +               goto host_free;
> +       }
> +
> +       /*
>          * While using internal tmio hardware logic for card detection, we need
>          * to ensure it stays powered for it to work.
>          */
>
