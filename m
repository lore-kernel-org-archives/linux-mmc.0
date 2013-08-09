From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH V2] mmc:sdhci: Wait longer for command with busy flags
Date: Fri, 9 Aug 2013 14:39:03 +0800
Message-ID: <CAGsJ_4xjsoqwhRjt+xjqcnfDyjKejk2EXZHGWX4x7X1kvnMaSw@mail.gmail.com>
References: <1376006647-23073-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f47.google.com ([209.85.128.47]:34244 "EHLO
	mail-qe0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030396Ab3HIGqL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Aug 2013 02:46:11 -0400
Received: by mail-qe0-f47.google.com with SMTP id b10so2174924qen.20
        for <linux-mmc@vger.kernel.org>; Thu, 08 Aug 2013 23:46:10 -0700 (PDT)
In-Reply-To: <1376006647-23073-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, cbouatmailru@gmail.com, cjb@laptop.org

2013/8/9 Haijun Zhang <Haijun.Zhang@freescale.com>:
> When command with busy flags send and also data busy end interrupt
> will be generate, the command will be finished when data transfer
> complete or data busy state end, Sometimes this will expend more than
> 10*Hz time to finish this command, so we should wait longer to detect
> command complete timeout err.
>
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> ---
> changes for V2:
>         - Correct the timer
>
>  drivers/mmc/host/sdhci.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a78bd4f..8888578 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -986,6 +986,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>         int flags;
>         u32 mask;
>         unsigned long timeout;
> +       u32 timer = 10;
>
>         WARN_ON(host->cmd);
>
> @@ -1014,7 +1015,18 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>                 mdelay(1);
>         }
>
> -       mod_timer(&host->timer, jiffies + 10 * HZ);
> +       /*
> +        * When send a commmand with busy state and also the data busy end
> +        * interrupt can be generate, the command will be finished when date
> +        * transfer complete or busy state end. Sometimes this will expend
> +        * more than 10*HZ, In this case whe should wait longer to detect
> +        * command complete timeout err.
> +        */
> +       if ((host->cmd->flags & MMC_RSP_BUSY) &&
> +                       !(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ))
> +               timer = 1000;
> +
> +       mod_timer(&host->timer, jiffies + timer * HZ);

haojun, do you mean we need to wait for 1 minutes and 40 seconds for
timeout? it seems it is too large for a kernel.

>
>         host->cmd = cmd;
>
> --
> 1.8.0
>

-barry
