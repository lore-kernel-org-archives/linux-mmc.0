From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Wait for Vdd to settle on card power off
Date: Fri, 22 Sep 2017 11:38:40 +0200
Message-ID: <CAPDyKFru8b+gP+FYuuJ_TekA57mLfAuaFV7NKe2eZqik2FGa7Q@mail.gmail.com>
References: <20170921174754.13648-1-kyle.roeschley@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:48336 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbdIVJil (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 05:38:41 -0400
Received: by mail-it0-f41.google.com with SMTP id m123so795451ita.3
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2017 02:38:41 -0700 (PDT)
In-Reply-To: <20170921174754.13648-1-kyle.roeschley@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyle Roeschley <kyle.roeschley@ni.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 21 September 2017 at 19:47, Kyle Roeschley <kyle.roeschley@ni.com> wrote:
> The SD spec version 6.0 section 6.4.1.5 requires that Vdd must be
> lowered to less than 0.5V for a minimum of 1 ms when powering off a
> card. Increase our wait to 10 ms so that voltage has time to drain down
> to 0.5V and cards can power off correctly.
>
> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
> ---
>  drivers/mmc/core/core.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 66c9cf49ad2f..38630246de26 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1679,18 +1679,16 @@ void mmc_power_off(struct mmc_host *host)
>         mmc_set_initial_state(host);
>
>         /*
> -        * Some configurations, such as the 802.11 SDIO card in the OLPC
> -        * XO-1.5, require a short delay after poweroff before the card
> -        * can be successfully turned on again.
> +        * The SD spec requires at least 1 ms with Vdd at less than 0.5 V
> +        * before a card can be re-powered, but we need to wait longer so that
> +        * the voltage has time to drain.
>          */
> -       mmc_delay(1);
> +       mmc_delay(10);

No, this isn't the proper place of adding more "magic" delays.

Instead, make sure the related ->set_ios() callback in the mmc host
driver deals with this instead. In case it uses an external regulator,
via the regulator API, then this is something that should be
controlled with the definition of the regulator.

>  }
>
>  void mmc_power_cycle(struct mmc_host *host, u32 ocr)
>  {
>         mmc_power_off(host);
> -       /* Wait at least 1 ms according to SD spec */
> -       mmc_delay(1);

Ditto.

>         mmc_power_up(host, ocr);
>  }
>
> --
> 2.14.1
>

Kind regards
Uffe
