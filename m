From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: Change the max discard sectors and erase response
 if mmc host supports busy signalling
Date: Mon, 25 Jul 2016 11:26:32 +0200
Message-ID: <CAPDyKFoRj-ry=Rg=vGnw88b29bcZfxfYL0on0BbgN1oY-Oh6fg@mail.gmail.com>
References: <01d645020004fe135bb5374ecb9f5f6ac0884b6b.1469436431.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <01d645020004fe135bb5374ecb9f5f6ac0884b6b.1469436431.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, David Jander <david@protonic.nl>, Hans de Goede <hdegoede@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 25 July 2016 at 10:48, Baolin Wang <baolin.wang@linaro.org> wrote:
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
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Thanks, applied for next! I took the liberty to update the change-log
a bit to clarify things!

Thanks a lot for working on this long outstanding problem!

In the next step I plan to remove the MMC_CAP_ERASE and instead enable
it by default, although let's leave that for v4.9.

Kind regards
Uffe

> ---
> Changes since v2:
>   - Remove the 'MMC_CAP_WAIT_WHILE_BUSY' flag checking when deciding
>   if we can use R1B response.
>   - Avoid polling CMD13 when using R1B response.
>   - Use earlier calculated erase timeout as the polling time.
>
> Changes since v1:
>   - Remove the 'MMC_CAP_WAIT_WHILE_BUSY' flag checking when deciding
>     the max discard sectors.
> ---
>  drivers/mmc/core/core.c |   60 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 50 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8b4dfd4..b4c08d1a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2060,7 +2060,8 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>                         unsigned int to, unsigned int arg)
>  {
>         struct mmc_command cmd = {0};
> -       unsigned int qty = 0;
> +       unsigned int qty = 0, busy_timeout = 0;
> +       bool use_r1b_resp = false;
>         unsigned long timeout;
>         int err;
>
> @@ -2128,8 +2129,22 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
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
> +       if (card->host->max_busy_timeout &&
> +           busy_timeout > card->host->max_busy_timeout) {
> +               cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> +       } else {
> +               cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +               cmd.busy_timeout = busy_timeout;
> +               use_r1b_resp = true;
> +       }
> +
>         err = mmc_wait_for_cmd(card->host, &cmd, 0);
>         if (err) {
>                 pr_err("mmc_erase: erase error %d, status %#x\n",
> @@ -2141,7 +2156,14 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>         if (mmc_host_is_spi(card->host))
>                 goto out;
>
> -       timeout = jiffies + msecs_to_jiffies(MMC_CORE_TIMEOUT_MS);
> +       /*
> +        * In case of when R1B + MMC_CAP_WAIT_WHILE_BUSY is used, the polling
> +        * shall be avoided.
> +        */
> +       if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
> +               goto out;
> +
> +       timeout = jiffies + msecs_to_jiffies(busy_timeout);
>         do {
>                 memset(&cmd, 0, sizeof(struct mmc_command));
>                 cmd.opcode = MMC_SEND_STATUS;
> @@ -2321,23 +2343,41 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
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
> -       /* Find the largest qty with an OK timeout */
> +       /*
> +        * We should not only use 'host->max_busy_timeout' as the limitation
> +        * when deciding the max discard sectors. We should set a balance value
> +        * to improve the erase speed, and it can not get too long timeout at
> +        * the same time.
> +        *
> +        * Here we set 'card->pref_erase' as the minimal discard sectors no
> +        * matter what size of 'host->max_busy_timeout', but if the
> +        * 'host->max_busy_timeout' is large enough for more discard sectors,
> +        * then we can continue to increase the max discard sectors until we
> +        * get a balance value.
> +        */
>         do {
>                 y = 0;
>                 for (x = 1; x && x <= max_qty && max_qty - x >= qty; x <<= 1) {
>                         timeout = mmc_erase_timeout(card, arg, qty + x);
> -                       if (timeout > host->max_busy_timeout)
> +
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
