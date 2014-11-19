From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [patch] mmc: toshsd: move dereference below check for NULL
Date: Wed, 19 Nov 2014 11:51:05 +0100
Message-ID: <CAPDyKFqhPS5JCk0asDV4-ts=PL1xbczXJq=aTnKBMAkuvSk0yQ@mail.gmail.com>
References: <20141115185641.GA6530@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:37696 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbaKSKvG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Nov 2014 05:51:06 -0500
Received: by mail-qc0-f179.google.com with SMTP id c9so191527qcz.10
        for <linux-mmc@vger.kernel.org>; Wed, 19 Nov 2014 02:51:05 -0800 (PST)
In-Reply-To: <20141115185641.GA6530@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Chris Ball <chris@printf.net>, Ondrej Zary <linux@rainbow-software.org>, linux-mmc <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org

On 15 November 2014 19:56, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> We check for NULL pointers after dereferencing so it's too late.  Oddly
> enough, Smatch misses this code but complains about the caller passing
> NULL pointers to this function:
>
>         drivers/mmc/host/toshsd.c:389 toshsd_irq()
>         error: we previously assumed 'host->cmd' could be null (see line 349)
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks! Applied for next.

Kind regards
Uffe

>
> diff --git a/drivers/mmc/host/toshsd.c b/drivers/mmc/host/toshsd.c
> index edb06d6..4666262 100644
> --- a/drivers/mmc/host/toshsd.c
> +++ b/drivers/mmc/host/toshsd.c
> @@ -206,14 +206,14 @@ static irqreturn_t toshsd_thread_irq(int irq, void *dev_id)
>  static void toshsd_cmd_irq(struct toshsd_host *host)
>  {
>         struct mmc_command *cmd = host->cmd;
> -       u8 *buf = (u8 *) cmd->resp;
> +       u8 *buf;
>         u16 data;
>
>         if (!host->cmd) {
>                 dev_warn(&host->pdev->dev, "Spurious CMD irq\n");
>                 return;
>         }
> -
> +       buf = (u8 *)cmd->resp;
>         host->cmd = NULL;
>
>         if (cmd->flags & MMC_RSP_PRESENT && cmd->flags & MMC_RSP_136) {
