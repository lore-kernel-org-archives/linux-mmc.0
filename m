From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RESEND RFC v2] mmc: Change the max discard sectors and erase
 response if mmc host supports busy signalling
Date: Mon, 18 Jul 2016 19:17:10 +0800
Message-ID: <CAMz4kuLsk1pU4870Gv85_BANPg2q-pBT99jY0HqZ9B1t0MtMpA@mail.gmail.com>
References: <54f75bccac6e6e49d87a5122ea670038b508b33c.1465808036.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33967 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbcGRLRM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2016 07:17:12 -0400
Received: by mail-yw0-f174.google.com with SMTP id i12so155406127ywa.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2016 04:17:12 -0700 (PDT)
In-Reply-To: <54f75bccac6e6e49d87a5122ea670038b508b33c.1465808036.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, rmk+kernel@arm.linux.org.uk, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, David Jander <david@protonic.nl>, hdegoede@redhat.com, linux-mmc <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Baolin Wang <baolin.wang@linaro.org>

Hi Ulf,

On 28 June 2016 at 15:25, Baolin Wang <baolin.wang@linaro.org> wrote:
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

Do you have any comments about this patch? Thanks.

-- 
Baolin.wang
Best Regards
