From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pwrseq_simple: Make reset-gpios optional to match doc
Date: Wed, 20 Jan 2016 12:36:32 +0100
Message-ID: <CAPDyKFpgCDHp1atgnZL6GtU9VwiJr0RR-4vW+m=uWHwnN3pz3A@mail.gmail.com>
References: <20160108090726.13066.66125.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35727 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbcATLgd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2016 06:36:33 -0500
Received: by mail-yk0-f176.google.com with SMTP id x67so6066261ykd.2
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2016 03:36:32 -0800 (PST)
In-Reply-To: <20160108090726.13066.66125.stgit@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>

+Tony, Javier, linux-omap

On 8 January 2016 at 10:07, Martin Fuzzey <mfuzzey@parkeon.com> wrote:
> The DT binding doc says reset-gpios is an optional property but the code
> currently bails out if it is omitted.
>
> Make the code match the documentation.

As Tony pointed out, this is actually a regression. Can you please
update the change-log according to that.

>
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>

Please add a fixes tag:
Fixes: ce037275861e ("mmc: pwrseq_simple: use GPIO descriptors array API")

> ---
>  drivers/mmc/core/pwrseq_simple.c |   21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index d10538b..4d2962b 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -29,15 +29,18 @@ struct mmc_pwrseq_simple {
>  static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
>                                               int value)
>  {
> -       int i;
>         struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
> -       int values[reset_gpios->ndescs];
>
> -       for (i = 0; i < reset_gpios->ndescs; i++)
> -               values[i] = value;
> +       if (!IS_ERR(reset_gpios)) {
> +               int i;
> +               int values[reset_gpios->ndescs];
>
> -       gpiod_set_array_value_cansleep(reset_gpios->ndescs, reset_gpios->desc,
> -                                      values);
> +               for (i = 0; i < reset_gpios->ndescs; i++)
> +                       values[i] = value;
> +
> +               gpiod_set_array_value_cansleep(
> +                       reset_gpios->ndescs, reset_gpios->desc, values);
> +       }
>  }
>
>  static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
> @@ -79,7 +82,8 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
>         struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
>                                         struct mmc_pwrseq_simple, pwrseq);
>
> -       gpiod_put_array(pwrseq->reset_gpios);
> +       if (!IS_ERR(pwrseq->reset_gpios))
> +               gpiod_put_array(pwrseq->reset_gpios);
>
>         if (!IS_ERR(pwrseq->ext_clk))
>                 clk_put(pwrseq->ext_clk);
> @@ -112,7 +116,8 @@ struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
>         }
>
>         pwrseq->reset_gpios = gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
> -       if (IS_ERR(pwrseq->reset_gpios)) {
> +       if (IS_ERR(pwrseq->reset_gpios) &&
> +           PTR_ERR(pwrseq->reset_gpios) != -ENOENT) {

You need to check also for != -ENOSYS, as otherwise when
CONFIG_GPIOLIB is unset we will treat that as an error.
This is also what the original code did.

>                 ret = PTR_ERR(pwrseq->reset_gpios);
>                 goto clk_put;
>         }
>

Kind regards
Uffe
