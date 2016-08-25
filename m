From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/2] mmc: sdio: deploy error handling instead of
 triggering BUG_ON
Date: Thu, 25 Aug 2016 11:37:15 +0200
Message-ID: <CAPDyKFqud91nrdRHfBs5p4DM4K_H2O29-a2k4RdrBDkbOdfZ8A@mail.gmail.com>
References: <1472110711-28083-1-git-send-email-shawn.lin@rock-chips.com> <1472110711-28083-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33165 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbcHYJhU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2016 05:37:20 -0400
Received: by mail-wm0-f46.google.com with SMTP id d196so37533281wmd.0
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2016 02:37:18 -0700 (PDT)
In-Reply-To: <1472110711-28083-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 25 August 2016 at 09:38, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> When using mmc_io_rw_extended, it's intent to avoid null
> pointer of card and invalid func number. But actually it
> didn't prevent that as the seg_size already use the card.
> Currently the wrapper function sdio_io_rw_ext_helper already
> use card before calling mmc_io_rw_extended, so we should move
> this check to there. As to the func number, it was token from
> '(ocr & 0x70000000) >> 28' which should be enough to guarantee
> that it won't be larger than 7. But we should prevent the
> caller like wifi drivers modify this value. So let's move this
> check into sdio_io_rw_ext_helper either.
>
> Also we remove the BUG_ON for mmc_send_io_op_cond since all
> possible paths calling this function are protected by checking
> the arguments in advance. After deploying these changes, we
> could not see any panic within SDIO API even if func drivers
> abuse the SDIO func APIs.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> ---
>
> Changes in v3:
> - remove more BUG_ONs for SDIO API and add error rountine
>   for either propagating error codes or casting warning before
>   return.
>
> Changes in v2: None
>
>  drivers/mmc/core/sdio_io.c  | 47 ++++++++++++++++++++++++++++++---------------
>  drivers/mmc/core/sdio_ops.c | 12 +++++-------
>  2 files changed, 36 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
> index 78cb4d5..0a2350d 100644
> --- a/drivers/mmc/core/sdio_io.c
> +++ b/drivers/mmc/core/sdio_io.c
> @@ -26,8 +26,8 @@
>   */
>  void sdio_claim_host(struct sdio_func *func)
>  {
> -       BUG_ON(!func);
> -       BUG_ON(!func->card);
> +       if (WARN_ON(!func || !func->card))

I think "if (WARN_ON(!func)" should be enough. Both the func->card and
func->card->host are implicit when ->func exists, so let's just ignore
to check them.

> +               return;
>
>         mmc_claim_host(func->card->host);
>  }
> @@ -42,8 +42,8 @@ EXPORT_SYMBOL_GPL(sdio_claim_host);
>   */
>  void sdio_release_host(struct sdio_func *func)
>  {
> -       BUG_ON(!func);
> -       BUG_ON(!func->card);
> +       if (WARN_ON(!func || !func->card))

Ditto.

> +               return;
>
>         mmc_release_host(func->card->host);
>  }
> @@ -62,8 +62,8 @@ int sdio_enable_func(struct sdio_func *func)
>         unsigned char reg;
>         unsigned long timeout;
>
> -       BUG_ON(!func);
> -       BUG_ON(!func->card);
> +       if (WARN_ON(!func || !func->card))

No need for a WARN_ON here, just return -EINVAL when !func.

> +               return -EINVAL;
>
>         pr_debug("SDIO: Enabling device %s...\n", sdio_func_id(func));
>
> @@ -112,8 +112,8 @@ int sdio_disable_func(struct sdio_func *func)
>         int ret;
>         unsigned char reg;
>
> -       BUG_ON(!func);
> -       BUG_ON(!func->card);
> +       if (WARN_ON(!func || !func->card))

Ditto.

> +               return -EINVAL;
>
>         pr_debug("SDIO: Disabling device %s...\n", sdio_func_id(func));
>
> @@ -307,6 +307,9 @@ static int sdio_io_rw_ext_helper(struct sdio_func *func, int write,
>         unsigned max_blocks;
>         int ret;
>
> +       if (!func || (!func->card) || (func->num > 7))

You could simplify this so it becomes like this:

if (!func || func->num > 7)

> +               return -EINVAL;
> +
>         /* Do the bulk of the transfer using block mode (if supported). */
>         if (func->card->cccr.multi_block && (size > sdio_max_byte_size(func))) {
>                 /* Blocks per command is limited by host count, host transfer
> @@ -367,7 +370,10 @@ u8 sdio_readb(struct sdio_func *func, unsigned int addr, int *err_ret)
>         int ret;
>         u8 val;
>
> -       BUG_ON(!func);
> +       if (WARN_ON(!func)) {

No need to WARN_ON.

> +               *err_ret = -EINVAL;
> +               return 0xFF;
> +       }
>
>         if (err_ret)
>                 *err_ret = 0;
> @@ -398,7 +404,10 @@ void sdio_writeb(struct sdio_func *func, u8 b, unsigned int addr, int *err_ret)
>  {
>         int ret;
>
> -       BUG_ON(!func);
> +       if (WARN_ON(!func)) {

Ditto.

> +               *err_ret = -EINVAL;
> +               return;
> +       }
>
>         ret = mmc_io_rw_direct(func->card, 1, func->num, addr, b, NULL);
>         if (err_ret)
> @@ -623,7 +632,10 @@ unsigned char sdio_f0_readb(struct sdio_func *func, unsigned int addr,
>         int ret;
>         unsigned char val;
>
> -       BUG_ON(!func);
> +       if (!func) {
> +               *err_ret = -EINVAL;
> +               return 0xFF;
> +       }
>
>         if (err_ret)
>                 *err_ret = 0;
> @@ -658,7 +670,10 @@ void sdio_f0_writeb(struct sdio_func *func, unsigned char b, unsigned int addr,
>  {
>         int ret;
>
> -       BUG_ON(!func);
> +       if (WARN_ON(!func)) {

Ditto.

> +               *err_ret = -EINVAL;
> +               return;
> +       }
>
>         if ((addr < 0xF0 || addr > 0xFF) && (!mmc_card_lenient_fn0(func->card))) {
>                 if (err_ret)
> @@ -684,8 +699,8 @@ EXPORT_SYMBOL_GPL(sdio_f0_writeb);
>   */
>  mmc_pm_flag_t sdio_get_host_pm_caps(struct sdio_func *func)
>  {
> -       BUG_ON(!func);
> -       BUG_ON(!func->card);
> +       if (!func || !func->card)

if (!func) is sufficient.

> +               return 0;
>
>         return func->card->host->pm_caps;
>  }
> @@ -707,8 +722,8 @@ int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags)
>  {
>         struct mmc_host *host;
>
> -       BUG_ON(!func);
> -       BUG_ON(!func->card);
> +       if (!func || !func->card)

Ditto.

> +               return -EINVAL;
>
>         host = func->card->host;
>
> diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
> index 34f6e80..279eba2 100644
> --- a/drivers/mmc/core/sdio_ops.c
> +++ b/drivers/mmc/core/sdio_ops.c
> @@ -24,8 +24,6 @@ int mmc_send_io_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>         struct mmc_command cmd = {0};
>         int i, err = 0;
>
> -       BUG_ON(!host);
> -
>         cmd.opcode = SD_IO_SEND_OP_COND;
>         cmd.arg = ocr;
>         cmd.flags = MMC_RSP_SPI_R4 | MMC_RSP_R4 | MMC_CMD_BCR;
> @@ -71,8 +69,8 @@ static int mmc_io_rw_direct_host(struct mmc_host *host, int write, unsigned fn,
>         struct mmc_command cmd = {0};
>         int err;
>
> -       BUG_ON(!host);
> -       BUG_ON(fn > 7);
> +       if (!host || (fn > 7))

There's no need to check for !host, as this is an internal mmc core
function and it should always be called with a valid host. If it's
not, the code would be broken anyway.

> +               return -EINVAL;
>
>         /* sanity check */
>         if (addr & ~0x1FFFF)
> @@ -114,7 +112,9 @@ static int mmc_io_rw_direct_host(struct mmc_host *host, int write, unsigned fn,
>  int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
>         unsigned addr, u8 in, u8 *out)
>  {
> -       BUG_ON(!card);
> +       if (!card)

There's no need to check for !card, as this is an internal mmc core
function and it should always be called with a valid card. If it's
not, the code would be broken anyway.

> +               return -EINVAL;
> +
>         return mmc_io_rw_direct_host(card->host, write, fn, addr, in, out);
>  }
>
> @@ -129,8 +129,6 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>         unsigned int nents, left_size, i;
>         unsigned int seg_size = card->host->max_seg_size;
>
> -       BUG_ON(!card);
> -       BUG_ON(fn > 7);
>         WARN_ON(blksz == 0);
>
>         /* sanity check */
> --
> 2.3.7
>
>

Kind regards
Uffe
