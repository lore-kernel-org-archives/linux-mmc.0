From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND RFC v2] mmc: Change the max discard sectors and erase
 response if mmc host supports busy signalling
Date: Tue, 19 Jul 2016 13:57:46 +0200
Message-ID: <CAPDyKFoxMtMjzc4nXnhOvribUBAfzNjm+LbruSVkXgQW_bxgUA@mail.gmail.com>
References: <54f75bccac6e6e49d87a5122ea670038b508b33c.1465808036.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54f75bccac6e6e49d87a5122ea670038b508b33c.1465808036.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 13 June 2016 at 10:54, Baolin Wang <baolin.wang@linaro.org> wrote:
> When mmc host HW supports busy signalling (using R1B as response), We
> shouldn't use 'host->max_busy_timeout' as the limitation when deciding
> the max discard sectors that we tell the generic BLOCK layer about.
> Instead, we should pick one preferred erase size as the max discard
> sectors.
>
> If the host controller supports busy signalling and the timeout for
> the erase operation does not exceed the max_busy_timeout, we should
> use R1B response. Or we need to prevent the host from doing hw busy
> detection, which is done by converting to a R1 response instead.
>
> Changes since v1:
>   - Remove the 'MMC_CAP_WAIT_WHILE_BUSY' flag checking when deciding
>     the max discard sectors.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/mmc/core/core.c |   47 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8b4dfd4..edd43b1 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2060,7 +2060,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>                         unsigned int to, unsigned int arg)
>  {
>         struct mmc_command cmd = {0};
> -       unsigned int qty = 0;
> +       unsigned int qty = 0, busy_timeout = 0;
>         unsigned long timeout;
>         int err;
>
> @@ -2128,8 +2128,23 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>         memset(&cmd, 0, sizeof(struct mmc_command));
>         cmd.opcode = MMC_ERASE;
>         cmd.arg = arg;
> -       cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> -       cmd.busy_timeout = mmc_erase_timeout(card, arg, qty);
> +       busy_timeout = mmc_erase_timeout(card, arg, qty);
> +       /*
> +        * If the host controller supports busy signalling and the timeout for
> +        * the erase operation does not exceed the max_busy_timeout, we should
> +        * use R1B response. Or we need to prevent the host from doing hw busy
> +        * detection, which is done by converting to a R1 response instead.
> +        */
> +       if ((card->host->max_busy_timeout &&
> +           busy_timeout > card->host->max_busy_timeout) ||
> +           !(card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)) {

sdhci uses the max_busy_timeout, but doesn't always use MMC_CAP_WAIT_WHILE_BUSY.
I have probably asked Adrian about this before, but right now I can't
recall why this is the case.

Anyway, I don't think we need to check MMC_CAP_WAIT_WHILE_BUSY at this point.

> +               cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> +               cmd.busy_timeout = 0;
> +       } else {
> +               cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +               cmd.busy_timeout = busy_timeout;
> +       }
> +
>         err = mmc_wait_for_cmd(card->host, &cmd, 0);
>         if (err) {
>                 pr_err("mmc_erase: erase error %d, status %#x\n",

You also need to fix the loop for polling with CMD13 to get the card
status. In case of when R1B+MMC_CAP_WAIT_WHILE_BUSY is used, the
polling shall be avoided.

Moreover, the polling loop doesn't care about the earlier used
calculated erase timeout, but instead defaults to the
MMC_CORE_TIMEOUT_MS, this is wrong.

Finally, perhaps as an improvement step; I think we shall make use of
the host's ->card_busy() callback if implemented and when
R1B+MMC_CAP_WAIT_WHILE_BUSY isn't used. This in favour of issuing
CMD13 in the loop.

You can see the sequence in __mmc_switch(), we should apply this to
the erase case as well. Perhaps we can even split up some of the code
in __mmc_switch() to allow it to re-used for the erase case as well!?

> @@ -2321,23 +2336,39 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
>                                             unsigned int arg)
>  {
>         struct mmc_host *host = card->host;
> -       unsigned int max_discard, x, y, qty = 0, max_qty, timeout;
> +       unsigned int max_discard, x, y, qty = 0, max_qty, min_qty, timeout;
>         unsigned int last_timeout = 0;
>
> -       if (card->erase_shift)
> +       if (card->erase_shift) {
>                 max_qty = UINT_MAX >> card->erase_shift;
> -       else if (mmc_card_sd(card))
> +               min_qty = card->pref_erase >> card->erase_shift;
> +       } else if (mmc_card_sd(card)) {
>                 max_qty = UINT_MAX;
> -       else
> +               min_qty = card->pref_erase;
> +       } else {
>                 max_qty = UINT_MAX / card->erase_size;
> +               min_qty = card->pref_erase / card->erase_size;
> +       }
>
>         /* Find the largest qty with an OK timeout */

This comment needs to be updated.

>         do {
>                 y = 0;
>                 for (x = 1; x && x <= max_qty && max_qty - x >= qty; x <<= 1) {
>                         timeout = mmc_erase_timeout(card, arg, qty + x);
> -                       if (timeout > host->max_busy_timeout)
> +                       /*
> +                        * We should not only use 'host->max_busy_timeout' as
> +                        * the limitation when deciding the max discard sectors.
> +                        * We should set a balance value to improve the erase
> +                        * speed, and it can not get too long timeout at the
> +                        * same time.

I am not really sure I understand this comment. Could you try to
elaborate on what value that will be picked when the max_busy_timeout
isn't just as the limiter.

> +                        *
> +                        * Here we set 'card->pref_erase' as the minimal discard
> +                        * sectors when deciding the max discard sectors.
> +                        */
> +                       if (qty + x > min_qty &&
> +                           timeout > host->max_busy_timeout)
>                                 break;
> +
>                         if (timeout < last_timeout)
>                                 break;
>                         last_timeout = timeout;
> --
> 1.7.9.5
>

Again, sorry for the delay in response!

Kind regards
Uffe
