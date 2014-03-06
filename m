From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 4/7] mmc: dw_mmc: fix minor coding style.
Date: Thu, 6 Mar 2014 08:31:32 +0100
Message-ID: <CAPDyKFoZxSL4wPrrJAYzEyUXmFxWWXxqJTVJgEu6aMjOKk8ziQ@mail.gmail.com>
References: <5313EABC.7070200@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:49995 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbaCFHbd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Mar 2014 02:31:33 -0500
Received: by mail-qc0-f172.google.com with SMTP id i8so2473589qcq.3
        for <linux-mmc@vger.kernel.org>; Wed, 05 Mar 2014 23:31:33 -0800 (PST)
In-Reply-To: <5313EABC.7070200@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>

On 3 March 2014 03:36, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Fixed the coding style.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
> Changelog V4:
>         - None
> Changelog V3:
>         - None
> Changelog V2:
>         - None
>
>  drivers/mmc/host/dw_mmc.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 9bac3ed..ac16308 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -257,9 +257,8 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>             (cmd->opcode == SD_IO_RW_DIRECT &&
>              ((cmd->arg >> 9) & 0x1FFFF) == SDIO_CCCR_ABORT))
>                 cmdr |= SDMMC_CMD_STOP;
> -       else
> -               if (cmd->opcode != MMC_SEND_STATUS && cmd->data)
> -                       cmdr |= SDMMC_CMD_PRV_DAT_WAIT;
> +       else if (cmd->opcode != MMC_SEND_STATUS && cmd->data)
> +               cmdr |= SDMMC_CMD_PRV_DAT_WAIT;
>
>         if (cmd->flags & MMC_RSP_PRESENT) {
>                 /* We expect a response, so set this bit */
> --
> 1.7.9.5
