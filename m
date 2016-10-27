From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 3/8] mmc: core: remove BUG_ONs from mmc
Date: Thu, 27 Oct 2016 10:14:35 +0200
Message-ID: <CAPDyKFoNeWvs3rfwSZCYYgVHK5xQR-HmPkgqxxMM+ic8io84OA@mail.gmail.com>
References: <1476792192-6265-1-git-send-email-shawn.lin@rock-chips.com> <1476792244-6390-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35322 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934883AbcJ0PIt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2016 11:08:49 -0400
Received: by mail-wm0-f42.google.com with SMTP id e69so40856787wmg.0
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2016 08:08:48 -0700 (PDT)
In-Reply-To: <1476792244-6390-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 18 October 2016 at 14:04, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> BUG_ONs doesn't help anything except for stop the system from
> running. If it occurs, it implies we should deploy proper error
> handling for that. So this patch is gonna discard these meaningless
> BUG_ONs and deploy error handling if needed.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/mmc/core/mmc.c     | 24 ++++++++++++++----------
>  drivers/mmc/core/mmc_ops.c | 20 ++++++--------------
>  2 files changed, 20 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 39fc5b2..8f63b59 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1477,7 +1477,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>         u32 cid[4];
>         u32 rocr;
>
> -       BUG_ON(!host);
> +       if (!host)
> +               return -EINVAL;
> +

Not needed, just remove.

>         WARN_ON(!host->claimed);
>
>         /* Set correct bus mode for MMC before attempting init */
> @@ -1867,8 +1869,8 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
>   */
>  static void mmc_remove(struct mmc_host *host)
>  {
> -       BUG_ON(!host);
> -       BUG_ON(!host->card);
> +       if (!host)
> +               return;
>

Ditto.

>         mmc_remove_card(host->card);
>         host->card = NULL;
> @@ -1889,8 +1891,8 @@ static void mmc_detect(struct mmc_host *host)
>  {
>         int err;
>
> -       BUG_ON(!host);
> -       BUG_ON(!host->card);
> +       if (WARN_ON(!host))
> +               return;
>

Ditto.

>         mmc_get_card(host->card);
>
> @@ -1917,8 +1919,8 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>         unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
>                                         EXT_CSD_POWER_OFF_LONG;
>
> -       BUG_ON(!host);
> -       BUG_ON(!host->card);
> +       if (WARN_ON(!host))
> +               return -EINVAL;
>

Ditto.

>         mmc_claim_host(host);
>
> @@ -1976,8 +1978,8 @@ static int _mmc_resume(struct mmc_host *host)
>  {
>         int err = 0;
>
> -       BUG_ON(!host);
> -       BUG_ON(!host->card);
> +       if (WARN_ON(!host))
> +               return -EINVAL;
>

Ditto.

>         mmc_claim_host(host);
>
> @@ -2111,7 +2113,9 @@ int mmc_attach_mmc(struct mmc_host *host)
>         int err;
>         u32 ocr, rocr;
>
> -       BUG_ON(!host);
> +       if (!host)
> +               return -EINVAL;
> +

Ditto.

>         WARN_ON(!host->claimed);
>
>         /* Set correct bus mode for MMC before attempting attach */
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index ad6e979..ceb41eb 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -60,9 +60,6 @@ static inline int __mmc_send_status(struct mmc_card *card, u32 *status,
>         int err;
>         struct mmc_command cmd = {0};
>
> -       BUG_ON(!card);
> -       BUG_ON(!card->host);
> -
>         cmd.opcode = MMC_SEND_STATUS;
>         if (!mmc_host_is_spi(card->host))
>                 cmd.arg = card->rca << 16;
> @@ -92,7 +89,8 @@ static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
>  {
>         struct mmc_command cmd = {0};
>
> -       BUG_ON(!host);
> +       if (!host)
> +               return -EINVAL;
>

Ditto.

>         cmd.opcode = MMC_SELECT_CARD;
>
> @@ -109,7 +107,6 @@ static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
>
>  int mmc_select_card(struct mmc_card *card)
>  {
> -       BUG_ON(!card);
>
>         return _mmc_select_card(card->host, card);
>  }
> @@ -181,8 +178,6 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>         struct mmc_command cmd = {0};
>         int i, err = 0;
>
> -       BUG_ON(!host);
> -
>         cmd.opcode = MMC_SEND_OP_COND;
>         cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
>         cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
> @@ -221,8 +216,8 @@ int mmc_all_send_cid(struct mmc_host *host, u32 *cid)
>         int err;
>         struct mmc_command cmd = {0};
>
> -       BUG_ON(!host);
> -       BUG_ON(!cid);
> +       if (!cid)
> +               return -ENOMEM;

Remove as not needed, as mmc_all_send_cid() is internal to the mmc
core. We know all callers already provide the cid.

>
>         cmd.opcode = MMC_ALL_SEND_CID;
>         cmd.arg = 0;
> @@ -241,9 +236,6 @@ int mmc_set_relative_addr(struct mmc_card *card)
>  {
>         struct mmc_command cmd = {0};
>
> -       BUG_ON(!card);
> -       BUG_ON(!card->host);
> -
>         cmd.opcode = MMC_SET_RELATIVE_ADDR;
>         cmd.arg = card->rca << 16;
>         cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> @@ -257,8 +249,8 @@ mmc_send_cxd_native(struct mmc_host *host, u32 arg, u32 *cxd, int opcode)
>         int err;
>         struct mmc_command cmd = {0};
>
> -       BUG_ON(!host);
> -       BUG_ON(!cxd);
> +       if (!cxd)
> +               return -ENOMEM;

For the same reasons as above, let's remove this.

>
>         cmd.opcode = opcode;
>         cmd.arg = arg;
> --

Kind regards
Uffe
