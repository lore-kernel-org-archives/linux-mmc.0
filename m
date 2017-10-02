From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: Increase the timeout in mci_send_cmd to 5 sec
Date: Mon, 2 Oct 2017 09:13:19 +0200
Message-ID: <CAPDyKFojY21yTMu2E9M8tec6QPZfFuVwJMZO0vY8V2kG7=yRCg@mail.gmail.com>
References: <AM5PR0701MB2657301FD402EEAA4B83917CE47F0@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:56826 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbdJBHNU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Oct 2017 03:13:20 -0400
Received: by mail-it0-f45.google.com with SMTP id g18so6238410itg.5
        for <linux-mmc@vger.kernel.org>; Mon, 02 Oct 2017 00:13:20 -0700 (PDT)
In-Reply-To: <AM5PR0701MB2657301FD402EEAA4B83917CE47F0@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 30 September 2017 at 17:38, Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>

Why?

> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 80bc4f3..0489707 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -285,7 +285,7 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>
>         if (readl_poll_timeout_atomic(host->regs + SDMMC_CMD, cmd_status,
>                                       !(cmd_status & SDMMC_CMD_START),
> -                                     1, 500 * USEC_PER_MSEC))
> +                                     1, 5000 * USEC_PER_MSEC))
>                 dev_err(&slot->mmc->class_dev,
>                         "Timeout sending command (cmd %#x arg %#x status %#x)\n",
>                         cmd, arg, cmd_status);
> --
> 2.7.4

Kind regards
Uffe
