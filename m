From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: core: Optimize the mmc erase size alignment
Date: Fri, 2 Sep 2016 11:43:08 +0200
Message-ID: <CAPDyKFpzjEydLX94DmYhtMkKp8PTZia-wh1+Oy_ovP65s1=jYA@mail.gmail.com>
References: <9de99671750430d7d80a8f351c0ec7a7088c9b00.1472635587.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9de99671750430d7d80a8f351c0ec7a7088c9b00.1472635587.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, David Jander <david@protonic.nl>, Hans de Goede <hdegoede@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 31 August 2016 at 11:32, Baolin Wang <baolin.wang@linaro.org> wrote:
> Before issuing mmc_erase() function, users always have checked if it can
> erase with mmc_can_erase/trim/discard() function, thus remove the redundant
> erase checking in mmc_erase() function.
>
> This patch also optimizes the erase start/end sector alignment with
> round_up()/round_down() function, when erase command is MMC_ERASE_ARG.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v2:
>  - Add nr checking and other optimization in mmc_erase() function.
>
> Changes since v1:
>  - Add the alignment if card->erase_size is not power of 2.
> ---
>  drivers/mmc/core/core.c |   82 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 53 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index e55cde6..52156d4 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2202,6 +2202,51 @@ out:
>         return err;
>  }
>
> +static unsigned int mmc_align_erase_size(struct mmc_card *card,
> +                                        unsigned int *from,
> +                                        unsigned int *to,
> +                                        unsigned int nr)
> +{

How about make one patch that starts by moving the existing code into
a separate function, then on top as a new change, start playing with
the optimizations!?
That would be more easy to review.

> +       unsigned int from_new = *from, nr_new = nr, rem;
> +
> +       if (is_power_of_2(card->erase_size)) {

I would like some comment in the code, to understand what/why we do this.

> +               unsigned int temp = from_new;
> +
> +               from_new = round_up(temp, card->erase_size);
> +               rem = from_new - temp;
> +
> +               if (nr_new > rem)
> +                       nr_new -= rem;
> +               else
> +                       return 0;
> +
> +               nr_new = round_down(nr_new, card->erase_size);
> +       } else {

Ditto.

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
> +
> +       if (nr_new == 0)
> +               return 0;
> +
> +       /* 'from' and 'to' are inclusive */
> +       *to = from_new + nr_new - 1;
> +       *from = from_new;
> +
> +       return nr_new;
> +}
> +
>  /**
>   * mmc_erase - erase sectors.
>   * @card: card to erase
> @@ -2217,13 +2262,6 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>         unsigned int rem, to = from + nr;
>         int err;
>
> -       if (!(card->host->caps & MMC_CAP_ERASE) ||
> -           !(card->csd.cmdclass & CCC_ERASE))
> -               return -EOPNOTSUPP;
> -
> -       if (!card->erase_size)
> -               return -EOPNOTSUPP;
> -

I agree with Shawn here, please try to have one patch taking care of
one thing. If we find out that things goes wrong later, then it's
easier to drop/revert a change which causes the regression.

Moreover, for the above particular change, I don't think you should
remove these validations, as this is an API being exported. You may
convert to use mmc_can_erase() though.

Regarding all the mmc erase related exported APIs, there are certainly
a need for some clean-ups. For example, I think too many APIs are
being exported and we could probably also restructure the code a bit
so it becomes more readable. Although, of course this deserves a
standalone clean-up series. :-)

>         if (mmc_card_sd(card) && arg != MMC_ERASE_ARG)
>                 return -EOPNOTSUPP;
>
> @@ -2240,31 +2278,17 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
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
> -
>         if (nr == 0)
>                 return 0;
>
> -       to = from + nr;
> -
> -       if (to <= from)
> -               return -EINVAL;
> -
> -       /* 'from' and 'to' are inclusive */
> -       to -= 1;
> +       if (arg == MMC_ERASE_ARG) {
> +               nr = mmc_align_erase_size(card, &from, &to, nr);
> +               if (nr == 0)
> +                       return 0;
> +       } else {
> +               /* 'from' and 'to' are inclusive */
> +               to -= 1;
> +       }
>
>         /*
>          * Special case where only one erase-group fits in the timeout budget:
> --
> 1.7.9.5
>

Kind regards
Uffe
