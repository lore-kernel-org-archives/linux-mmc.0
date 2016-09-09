From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 1/2] mmc: core: Factor out the alignment of erase size
Date: Fri, 9 Sep 2016 11:46:14 +0200
Message-ID: <CAPDyKFqikHyxS5KNdS7TpumqXREWibhMU0K9juW3Gb+4SNsQdw@mail.gmail.com>
References: <48ff46b96e01df36aa5d1c2daf1091d2ec2e729f.1473215578.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <48ff46b96e01df36aa5d1c2daf1091d2ec2e729f.1473215578.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, David Jander <david@protonic.nl>, Hans de Goede <hdegoede@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 7 September 2016 at 04:38, Baolin Wang <baolin.wang@linaro.org> wrote:
> In order to clean up the mmc_erase() function and do some optimization
> for erase size alignment, factor out the guts of erase size alignment
> into mmc_align_erase_size() function.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Changes since v4:
>  - Abandon the patch removing the checking if mmc can erase.
>  - Add missing validations in mmc_erase().
>
> Changes since v3:
>  - Split into 3 separate patches.
>  - Add test tag by Shawn.
>
> Changes since v2:
>  - Add nr checking and other optimization in mmc_erase() function.
>
> Changes since v1:
>  - Add the alignment if card->erase_size is not power of 2.
> ---
>  drivers/mmc/core/core.c |   48 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index e55cde6..11b4897 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2202,6 +2202,36 @@ out:
>         return err;
>  }
>
> +static unsigned int mmc_align_erase_size(struct mmc_card *card,
> +                                        unsigned int *from,
> +                                        unsigned int *to,
> +                                        unsigned int nr)
> +{
> +       unsigned int from_new = *from, nr_new = nr, rem;
> +
> +       rem = from_new % card->erase_size;
> +       if (rem) {
> +               rem = card->erase_size - rem;
> +               from_new += rem;
> +               if (nr_new > rem)
> +                       nr_new -= rem;
> +               else
> +                       return 0;
> +       }
> +
> +       rem = nr_new % card->erase_size;
> +       if (rem)
> +               nr_new -= rem;
> +
> +       if (nr_new == 0)
> +               return 0;
> +
> +       *to = from_new + nr_new;
> +       *from = from_new;
> +
> +       return nr_new;
> +}
> +
>  /**
>   * mmc_erase - erase sectors.
>   * @card: card to erase
> @@ -2240,26 +2270,12 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>                         return -EINVAL;
>         }
>
> -       if (arg == MMC_ERASE_ARG) {
> -               rem = from % card->erase_size;
> -               if (rem) {
> -                       rem = card->erase_size - rem;
> -                       from += rem;
> -                       if (nr > rem)
> -                               nr -= rem;
> -                       else
> -                               return 0;
> -               }
> -               rem = nr % card->erase_size;
> -               if (rem)
> -                       nr -= rem;
> -       }
> +       if (arg == MMC_ERASE_ARG)
> +               nr = mmc_align_erase_size(card, &from, &to, nr);
>
>         if (nr == 0)
>                 return 0;
>
> -       to = from + nr;
> -
>         if (to <= from)
>                 return -EINVAL;
>
> --
> 1.7.9.5
>
