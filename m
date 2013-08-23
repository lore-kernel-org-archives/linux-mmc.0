From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: core: add ignorance case for CMD13 CRC error
Date: Fri, 23 Aug 2013 11:21:05 +0200
Message-ID: <CAPDyKFrGxbo46_uhJrWc-u0k1kJxXxeKePdoou3aFpwSBUY21g@mail.gmail.com>
References: <002301ce9e6b$e72da2a0$b588e7e0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48]:57334 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab3HWJVH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 05:21:07 -0400
Received: by mail-vb0-f48.google.com with SMTP id w16so258618vbf.35
        for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2013 02:21:06 -0700 (PDT)
In-Reply-To: <002301ce9e6b$e72da2a0$b588e7e0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On 21 August 2013 14:42, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> While speed mode is changed, CMD13 cannot be guaranteed.
> According to the spec., it is not recommended to use CMD13
> to check the busy completion of the timing change.
> If CMD13 is used in this case, CRC error must be ignored.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/core/mmc_ops.c |   23 ++++++++++++++++++++---
>  1 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 837fc73..f5dfa9c 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -23,6 +23,9 @@
>
>  #define MMC_OPS_TIMEOUT_MS     (10 * 60 * 1000) /* 10 minute timeout */
>
> +static inline int __mmc_send_status(struct mmc_card *card, u32 *status,
> +                                   bool ignore_crc);
> +

I suggest to move the implementation here as well. Thus no specific
pre-declaration is needed.

Otherwise it looks good!

Kind regards
Ulf Hansson

>  static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
>  {
>         int err;
> @@ -380,6 +383,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>         struct mmc_command cmd = {0};
>         unsigned long timeout;
>         u32 status;
> +       bool ignore_crc;
>
>         BUG_ON(!card);
>         BUG_ON(!card->host);
> @@ -408,10 +412,15 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
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
>         timeout = jiffies + msecs_to_jiffies(MMC_OPS_TIMEOUT_MS);
>         do {
> -               err = mmc_send_status(card, &status);
> +               err = __mmc_send_status(card, &status, ignore_crc);
>                 if (err)
>                         return err;
>                 if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
> @@ -449,7 +458,8 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>  }
>  EXPORT_SYMBOL_GPL(mmc_switch);
>
> -int mmc_send_status(struct mmc_card *card, u32 *status)
> +static inline int __mmc_send_status(struct mmc_card *card, u32 *status,
> +                                   bool ignore_crc)
>  {
>         int err;
>         struct mmc_command cmd = {0};
> @@ -461,6 +471,8 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
>         if (!mmc_host_is_spi(card->host))
>                 cmd.arg = card->rca << 16;
>         cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
> +       if (ignore_crc)
> +               cmd.flags &= ~MMC_RSP_CRC;
>
>         err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
>         if (err)
> @@ -475,6 +487,11 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
>         return 0;
>  }
>
> +int mmc_send_status(struct mmc_card *card, u32 *status)
> +{
> +       return __mmc_send_status(card, status, false);
> +}
> +
>  static int
>  mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
>                   u8 len)
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
