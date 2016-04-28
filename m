From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: core: remove the invalid message in mmc_select_timing
Date: Thu, 28 Apr 2016 11:24:07 +0200
Message-ID: <CAPDyKFqvXTtbZsaWJ1gr7gm-jTpWwL0hAYxDje+LsC4ScyF2bQ@mail.gmail.com>
References: <1461171092-30631-1-git-send-email-aisheng.dong@nxp.com>
	<1461171092-30631-2-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38342 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbcD1JYI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2016 05:24:08 -0400
Received: by mail-wm0-f49.google.com with SMTP id g17so30683260wme.1
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2016 02:24:08 -0700 (PDT)
In-Reply-To: <1461171092-30631-2-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawnguo@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <dongas86@gmail.com>

On 20 April 2016 at 18:51, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> mmc_select_hs200() and mmc_select_hs() will keep the timing
> as before if switch fails. So it's meaningless to print the
> failed switched mode outside based on the current host timing.
>
> Furthermore, the original print is wrong, it should be:
> pr_warn("%s: switch to %s failed\n",
>         mmc_hostname(card->host),
>         mmc_card_hs(card) ? "high-speed" :
>         (mmc_card_hs200(card) ? "hs200" : ""));
>
> Since we already have error message in mmc_select_hs200(),
> simply remove it outside.
>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/mmc/core/mmc.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f6683a9..55c8201 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1321,21 +1321,13 @@ static int mmc_select_timing(struct mmc_card *card)
>         if (err && err != -EBADMSG)
>                 return err;
>
> -       if (err) {
> -               pr_warn("%s: switch to %s failed\n",
> -                       mmc_card_hs(card) ? "high-speed" :
> -                       (mmc_card_hs200(card) ? "hs200" : ""),
> -                       mmc_hostname(card->host));
> -               err = 0;
> -       }
> -

No, this is not correct.

First, in patch1/3, you change to return an error code immediately
when __mmc_set_signal_voltage() fails, instead of using the "goto
err". Thus there will be no error printed for this case any more.

Second, mmc_select_hs() may fail and there is no print done within
that function which is why above print is also needed.

On the other hand I agree with you, it doesn't seems necessary to
print two messages when mmc_select_hs200() fails. One should be
enough. Can we change this so *only* mmc_select_timing() will deal
with the print at all errors?

>  bus_speed:
>         /*
>          * Set the bus speed to the selected bus timing.
>          * If timing is not selected, backward compatible is the default.
>          */
>         mmc_set_bus_speed(card);
> -       return err;
> +       return 0;
>  }
>
>  /*
> --
> 1.9.1
>

Kind regards
Uffe
