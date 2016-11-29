From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/8] mmc: core: remove BUG_ONs from sdio
Date: Tue, 29 Nov 2016 13:40:54 +0100
Message-ID: <CAPDyKFq8gecsiAHyQWVpjNt46Gx1VWyCEYeJiiYxRtFaONwa1g@mail.gmail.com>
References: <1478071440-12689-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38702 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755684AbcK2Mk5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2016 07:40:57 -0500
Received: by mail-wm0-f46.google.com with SMTP id f82so186845274wmf.1
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2016 04:40:56 -0800 (PST)
In-Reply-To: <1478071440-12689-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 2 November 2016 at 08:24, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> BUG_ONs doesn't help anything except for stop the system from
> running. If it occurs, it implies we should deploy proper error
> handling for that. So this patch is gonna discard these meaningless
> BUG_ONs and deploy error handling if needed.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/core/sdio.c     | 17 ++---------------
>  drivers/mmc/core/sdio_cis.c |  3 ++-
>  drivers/mmc/core/sdio_irq.c | 12 +++++++-----
>  3 files changed, 11 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index bd44ba8..ecbc529 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -63,7 +63,8 @@ static int sdio_init_func(struct mmc_card *card, unsigned int fn)
>         int ret;
>         struct sdio_func *func;
>
> -       BUG_ON(fn > SDIO_MAX_FUNCS);
> +       if (WARN_ON(fn > SDIO_MAX_FUNCS))
> +               return -EINVAL;
>
>         func = sdio_alloc_func(card);
>         if (IS_ERR(func))
> @@ -555,7 +556,6 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>         u32 rocr = 0;
>         u32 ocr_card = ocr;
>
> -       BUG_ON(!host);
>         WARN_ON(!host->claimed);
>
>         /* to query card if 1.8V signalling is supported */
> @@ -791,9 +791,6 @@ static void mmc_sdio_remove(struct mmc_host *host)
>  {
>         int i;
>
> -       BUG_ON(!host);
> -       BUG_ON(!host->card);
> -
>         for (i = 0;i < host->card->sdio_funcs;i++) {
>                 if (host->card->sdio_func[i]) {
>                         sdio_remove_func(host->card->sdio_func[i]);
> @@ -820,9 +817,6 @@ static void mmc_sdio_detect(struct mmc_host *host)
>  {
>         int err;
>
> -       BUG_ON(!host);
> -       BUG_ON(!host->card);
> -
>         /* Make sure card is powered before detecting it */
>         if (host->caps & MMC_CAP_POWER_OFF_CARD) {
>                 err = pm_runtime_get_sync(&host->card->dev);
> @@ -916,9 +910,6 @@ static int mmc_sdio_resume(struct mmc_host *host)
>  {
>         int err = 0;
>
> -       BUG_ON(!host);
> -       BUG_ON(!host->card);
> -
>         /* Basic card reinitialization. */
>         mmc_claim_host(host);
>
> @@ -970,9 +961,6 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
>  {
>         int ret;
>
> -       BUG_ON(!host);
> -       BUG_ON(!host->card);
> -
>         mmc_claim_host(host);
>
>         /*
> @@ -1063,7 +1051,6 @@ int mmc_attach_sdio(struct mmc_host *host)
>         u32 ocr, rocr;
>         struct mmc_card *card;
>
> -       BUG_ON(!host);
>         WARN_ON(!host->claimed);
>
>         err = mmc_send_io_op_cond(host, 0, &ocr);
> diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
> index dcb3dee..f8c3728 100644
> --- a/drivers/mmc/core/sdio_cis.c
> +++ b/drivers/mmc/core/sdio_cis.c
> @@ -262,7 +262,8 @@ static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)
>         else
>                 prev = &card->tuples;
>
> -       BUG_ON(*prev);
> +       if (*prev)
> +               return -EINVAL;
>
>         do {
>                 unsigned char tpl_code, tpl_link;
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 91bbbfb..f1faf9a 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -214,7 +214,9 @@ static int sdio_card_irq_put(struct mmc_card *card)
>         struct mmc_host *host = card->host;
>
>         WARN_ON(!host->claimed);
> -       BUG_ON(host->sdio_irqs < 1);
> +
> +       if (host->sdio_irqs < 1)
> +               return -EINVAL;
>
>         if (!--host->sdio_irqs) {
>                 if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD)) {
> @@ -261,8 +263,8 @@ int sdio_claim_irq(struct sdio_func *func, sdio_irq_handler_t *handler)
>         int ret;
>         unsigned char reg;
>
> -       BUG_ON(!func);
> -       BUG_ON(!func->card);
> +       if (!func)
> +               return -EINVAL;
>
>         pr_debug("SDIO: Enabling IRQ for %s...\n", sdio_func_id(func));
>
> @@ -304,8 +306,8 @@ int sdio_release_irq(struct sdio_func *func)
>         int ret;
>         unsigned char reg;
>
> -       BUG_ON(!func);
> -       BUG_ON(!func->card);
> +       if (!func)
> +               return -EINVAL;
>
>         pr_debug("SDIO: Disabling IRQ for %s...\n", sdio_func_id(func));
>
> --
> 2.3.7
>
>
