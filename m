From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/8] mmc: core: remove BUG_ONs from sd
Date: Tue, 29 Nov 2016 13:41:13 +0100
Message-ID: <CAPDyKFrMiJp4AJZrc5RTjXQh+bbyoCBEoYc4yYQ6iVRruv+amQ@mail.gmail.com>
References: <1478071440-12689-1-git-send-email-shawn.lin@rock-chips.com> <1478071548-12816-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36942 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755684AbcK2MlQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2016 07:41:16 -0500
Received: by mail-wm0-f44.google.com with SMTP id t79so186176420wmt.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2016 04:41:15 -0800 (PST)
In-Reply-To: <1478071548-12816-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 2 November 2016 at 08:25, Shawn Lin <shawn.lin@rock-chips.com> wrote:
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
>  drivers/mmc/core/sd.c     | 14 --------------
>  drivers/mmc/core/sd_ops.c | 27 ++++-----------------------
>  2 files changed, 4 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 73c762a..deb90c2 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -927,7 +927,6 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>         u32 cid[4];
>         u32 rocr = 0;
>
> -       BUG_ON(!host);
>         WARN_ON(!host->claimed);
>
>         err = mmc_sd_get_cid(host, ocr, cid, &rocr);
> @@ -1043,9 +1042,6 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>   */
>  static void mmc_sd_remove(struct mmc_host *host)
>  {
> -       BUG_ON(!host);
> -       BUG_ON(!host->card);
> -
>         mmc_remove_card(host->card);
>         host->card = NULL;
>  }
> @@ -1065,9 +1061,6 @@ static void mmc_sd_detect(struct mmc_host *host)
>  {
>         int err;
>
> -       BUG_ON(!host);
> -       BUG_ON(!host->card);
> -
>         mmc_get_card(host->card);
>
>         /*
> @@ -1091,9 +1084,6 @@ static int _mmc_sd_suspend(struct mmc_host *host)
>  {
>         int err = 0;
>
> -       BUG_ON(!host);
> -       BUG_ON(!host->card);
> -
>         mmc_claim_host(host);
>
>         if (mmc_card_suspended(host->card))
> @@ -1136,9 +1126,6 @@ static int _mmc_sd_resume(struct mmc_host *host)
>  {
>         int err = 0;
>
> -       BUG_ON(!host);
> -       BUG_ON(!host->card);
> -
>         mmc_claim_host(host);
>
>         if (!mmc_card_suspended(host->card))
> @@ -1221,7 +1208,6 @@ int mmc_attach_sd(struct mmc_host *host)
>         int err;
>         u32 ocr, rocr;
>
> -       BUG_ON(!host);
>         WARN_ON(!host->claimed);
>
>         err = mmc_send_app_op_cond(host, 0, &ocr);
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index 16b774c..de125a4 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -27,8 +27,8 @@ int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
>         int err;
>         struct mmc_command cmd = {0};
>
> -       BUG_ON(!host);
> -       BUG_ON(card && (card->host != host));
> +       if (WARN_ON(card && card->host != host))
> +               return -EINVAL;
>
>         cmd.opcode = MMC_APP_CMD;
>
> @@ -72,8 +72,8 @@ int mmc_wait_for_app_cmd(struct mmc_host *host, struct mmc_card *card,
>
>         int i, err;
>
> -       BUG_ON(!cmd);
> -       BUG_ON(retries < 0);
> +       if (retries < 0)
> +               retries = MMC_CMD_RETRIES;
>
>         err = -EIO;
>
> @@ -122,9 +122,6 @@ int mmc_app_set_bus_width(struct mmc_card *card, int width)
>  {
>         struct mmc_command cmd = {0};
>
> -       BUG_ON(!card);
> -       BUG_ON(!card->host);
> -
>         cmd.opcode = SD_APP_SET_BUS_WIDTH;
>         cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
>
> @@ -147,8 +144,6 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>         struct mmc_command cmd = {0};
>         int i, err = 0;
>
> -       BUG_ON(!host);
> -
>         cmd.opcode = SD_APP_OP_COND;
>         if (mmc_host_is_spi(host))
>                 cmd.arg = ocr & (1 << 30); /* SPI only defines one bit */
> @@ -224,9 +219,6 @@ int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca)
>         int err;
>         struct mmc_command cmd = {0};
>
> -       BUG_ON(!host);
> -       BUG_ON(!rca);
> -
>         cmd.opcode = SD_SEND_RELATIVE_ADDR;
>         cmd.arg = 0;
>         cmd.flags = MMC_RSP_R6 | MMC_CMD_BCR;
> @@ -249,10 +241,6 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
>         struct scatterlist sg;
>         void *data_buf;
>
> -       BUG_ON(!card);
> -       BUG_ON(!card->host);
> -       BUG_ON(!scr);
> -
>         /* NOTE: caller guarantees scr is heap-allocated */
>
>         err = mmc_app_cmd(card->host, card);
> @@ -307,9 +295,6 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
>         struct mmc_data data = {0};
>         struct scatterlist sg;
>
> -       BUG_ON(!card);
> -       BUG_ON(!card->host);
> -
>         /* NOTE: caller guarantees resp is heap-allocated */
>
>         mode = !!mode;
> @@ -352,10 +337,6 @@ int mmc_app_sd_status(struct mmc_card *card, void *ssr)
>         struct mmc_data data = {0};
>         struct scatterlist sg;
>
> -       BUG_ON(!card);
> -       BUG_ON(!card->host);
> -       BUG_ON(!ssr);
> -
>         /* NOTE: caller guarantees ssr is heap-allocated */
>
>         err = mmc_app_cmd(card->host, card);
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
