From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: add ignorance case for CMD13 CRC error
Date: Tue, 3 Sep 2013 14:58:47 +0200
Message-ID: <CAPDyKForsH3rsLevSiCfm4nkYHV_FvFVH=YhSsvb=bqLgCtBwA@mail.gmail.com>
References: <002301ce9e6b$e72da2a0$b588e7e0$%jun@samsung.com>
	<CAPDyKFrGxbo46_uhJrWc-u0k1kJxXxeKePdoou3aFpwSBUY21g@mail.gmail.com>
	<002901cea22c$af778730$0e669590$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f53.google.com ([209.85.212.53]:63065 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab3ICM6s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 08:58:48 -0400
Received: by mail-vb0-f53.google.com with SMTP id i3so3971887vbh.12
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2013 05:58:47 -0700 (PDT)
In-Reply-To: <002901cea22c$af778730$0e669590$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On 26 August 2013 09:20, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> While speed mode is changed, CMD13 cannot be guaranteed.
> According to the spec., it is not recommended to use CMD13
> to check the busy completion of the timing change.
> If CMD13 is used in this case, CRC error must be ignored.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> Change in v2:
>  - Removed function declaration.(From Ulf Hansson)
>
>  drivers/mmc/core/mmc_ops.c |   70 ++++++++++++++++++++++++++-----------------
>  1 files changed, 42 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index ef18348..1464c1e 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -23,6 +23,40 @@
>
>  #define MMC_OPS_TIMEOUT_MS     (10 * 60 * 1000) /* 10 minute timeout */
>
> +static inline int __mmc_send_status(struct mmc_card *card, u32 *status,
> +                                   bool ignore_crc)

Is there any specific reason to you made this function inline?

> +{
> +       int err;
> +       struct mmc_command cmd = {0};
> +
> +       BUG_ON(!card);
> +       BUG_ON(!card->host);
> +
> +       cmd.opcode = MMC_SEND_STATUS;
> +       if (!mmc_host_is_spi(card->host))
> +               cmd.arg = card->rca << 16;
> +       cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
> +       if (ignore_crc)
> +               cmd.flags &= ~MMC_RSP_CRC;
> +
> +       err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
> +       if (err)
> +               return err;
> +
> +       /* NOTE: callers are required to understand the difference
> +        * between "native" and SPI format status words!
> +        */
> +       if (status)
> +               *status = cmd.resp[0];
> +
> +       return 0;
> +}
> +
> +int mmc_send_status(struct mmc_card *card, u32 *status)
> +{
> +       return __mmc_send_status(card, status, false);
> +}
> +
>  static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
>  {
>         int err;
> @@ -380,6 +414,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>         struct mmc_command cmd = {0};
>         unsigned long timeout;
>         u32 status;
> +       bool ignore_crc;
>
>         BUG_ON(!card);
>         BUG_ON(!card->host);
> @@ -408,10 +443,15 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>         if (!use_busy_signal)
>                 return 0;
>
> -       /* Must check status to be sure of no errors */
> +       /*
> +        * Must check status to be sure of no errors
> +        * If CMD13 is to check the busy completion of the timing change,
> +        * disable the check of CRC error.
> +        */
> +       ignore_crc = (index == EXT_CSD_HS_TIMING) ? true : false;

You need to consider MMC_CAP_WAIT_WHILE_BUSY in the condition for
"ignore_crc" as well. Otherwise you will ignore CRC in cases where we
actually can detect it.

Kind regards
Ulf Hansson


>         timeout = jiffies + msecs_to_jiffies(MMC_OPS_TIMEOUT_MS);
>         do {
> -               err = mmc_send_status(card, &status);
> +               err = __mmc_send_status(card, &status, ignore_crc);
>                 if (err)
>                         return err;
>                 if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
> @@ -449,32 +489,6 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>  }
>  EXPORT_SYMBOL_GPL(mmc_switch);
>
> -int mmc_send_status(struct mmc_card *card, u32 *status)
> -{
> -       int err;
> -       struct mmc_command cmd = {0};
> -
> -       BUG_ON(!card);
> -       BUG_ON(!card->host);
> -
> -       cmd.opcode = MMC_SEND_STATUS;
> -       if (!mmc_host_is_spi(card->host))
> -               cmd.arg = card->rca << 16;
> -       cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
> -
> -       err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
> -       if (err)
> -               return err;
> -
> -       /* NOTE: callers are required to understand the difference
> -        * between "native" and SPI format status words!
> -        */
> -       if (status)
> -               *status = cmd.resp[0];
> -
> -       return 0;
> -}
> -
>  static int
>  mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
>                   u8 len)
> --
> 1.7.0.4
>
>
