From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 2/2] mmc: core: Optimize the mmc erase size alignment
Date: Fri, 9 Sep 2016 11:46:21 +0200
Message-ID: <CAPDyKFqjoya_uwgvrqGjRQMhF7bvKwE76GZsKg1sMt=wcUSabg@mail.gmail.com>
References: <48ff46b96e01df36aa5d1c2daf1091d2ec2e729f.1473215578.git.baolin.wang@linaro.org>
 <bc52ccbc0c22e2d2f795d75faf748e4e68900e51.1473215578.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37426 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753817AbcIIJqY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Sep 2016 05:46:24 -0400
Received: by mail-wm0-f47.google.com with SMTP id w12so22835286wmf.0
        for <linux-mmc@vger.kernel.org>; Fri, 09 Sep 2016 02:46:23 -0700 (PDT)
In-Reply-To: <bc52ccbc0c22e2d2f795d75faf748e4e68900e51.1473215578.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, David Jander <david@protonic.nl>, Hans de Goede <hdegoede@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>

On 7 September 2016 at 04:38, Baolin Wang <baolin.wang@linaro.org> wrote:
> In most cases the 'card->erase_size' is power of 2, then the round_up/down()
> function is more efficient than '%' operation when the 'card->erase_size' is
> power of 2.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c |   34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 11b4897..4264ac6 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2209,19 +2209,37 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
>  {
>         unsigned int from_new = *from, nr_new = nr, rem;
>
> -       rem = from_new % card->erase_size;
> -       if (rem) {
> -               rem = card->erase_size - rem;
> -               from_new += rem;
> +       /*
> +        * When the 'card->erase_size' is power of 2, we can use round_up/down()
> +        * to align the erase size efficiently.
> +        */
> +       if (is_power_of_2(card->erase_size)) {
> +               unsigned int temp = from_new;
> +
> +               from_new = round_up(temp, card->erase_size);
> +               rem = from_new - temp;
> +
>                 if (nr_new > rem)
>                         nr_new -= rem;
>                 else
>                         return 0;
> -       }
>
> -       rem = nr_new % card->erase_size;
> -       if (rem)
> -               nr_new -= rem;
> +               nr_new = round_down(nr_new, card->erase_size);
> +       } else {
> +               rem = from_new % card->erase_size;
> +               if (rem) {
> +                       rem = card->erase_size - rem;
> +                       from_new += rem;
> +                       if (nr_new > rem)
> +                               nr_new -= rem;
> +                       else
> +                               return 0;
> +               }
> +
> +               rem = nr_new % card->erase_size;
> +               if (rem)
> +                       nr_new -= rem;
> +       }
>
>         if (nr_new == 0)
>                 return 0;
> --
> 1.7.9.5
>
