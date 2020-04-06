Return-Path: <SRS0=po4a=5W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC0C2BA19
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 11:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5141C206F8
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 11:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Drp2TIXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgDFLsz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:48:55 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37332 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgDFLsz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Apr 2020 07:48:55 -0400
Received: by mail-oi1-f195.google.com with SMTP id u20so12789248oic.4
        for <linux-mmc@vger.kernel.org>; Mon, 06 Apr 2020 04:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y6iEwopR5vGY3yjj+TBZb2xA/9nw+FEuq4W7E9kJfS0=;
        b=Drp2TIXi166ReHPdw3bMu/QZvdZlp9OMfQGSsIetEgFQbPg10U7dTpqzY5/wJjgiw2
         7yBudGa5zu2HqQDGY2sdkJ/uAXK+r9fz0yrMaUMVTCMDnggqL+x1ECuG2dBioOyYhHh9
         a1Oth5R67prxmqQV0Qf2gCqOACjMrCyxDhxiocdJNF3y2wz0pe+5L7V4X3tPgGBzh3RX
         YNfMnTFel67aQokH9HRZ2AKe+8qKKItKrZp2+Q4AeffdjyT7YN3JSaLFyh+EQiNR0A2F
         mveoobNtSgUOHBNRBP5aoeMUlF2cF951zfc5J1oJCeXsvVB87stYezyNoKKmKYIhbFyC
         jBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y6iEwopR5vGY3yjj+TBZb2xA/9nw+FEuq4W7E9kJfS0=;
        b=uCEXA05VvOzz2a7cTjRUDdzMO4zEJmGJiAQxZTMh7vkx4A7QCeblrgQ5bpP1Spcis7
         vYWUMl0LHOjKR6cWAfxsL5ZjNI/7bwD0GOlOAMQ6kg+KVQ+suZqmo6awjEh/1IcCUNig
         GPy5uz6WdF0kie+U7jJQxze2UaYsGZeM4u0Sc8DO1KJ1buzK+hoWtWjDKY2CgY1J30lm
         t1T7HVYMEK/BnJY4uvdtFAFvVXAsOo4mojhWmIlMQ7ZsbXMkqpER8y8So9JJc2MxWofE
         GmbYf6lmiRAJkTCp3ViWy5izxJ7Pol7Kgqr+uYrpWgiqITtkfUHurMejexdVYSmx6REt
         QvWg==
X-Gm-Message-State: AGi0PuZvUwX7a2MC4q7brvuKCTP+qhbeqeGjJD8PAPQZiA+41/b9SZkt
        kXZpT2X2DuzeJpr6nKs6ws21cWgpKHrgAgSMY/YmrRMx
X-Google-Smtp-Source: APiQypJ1s6vSm9nwpGokK3zJS4fjyvZIK3GqhH0JvX4ahBhyGHZTRhM6kyXcvdI7OLRfuxT1Rphy6LwsBl7kYsJHerY=
X-Received: by 2002:aca:3ad7:: with SMTP id h206mr11784275oia.169.1586173734742;
 Mon, 06 Apr 2020 04:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200406114337.8802-1-ulf.hansson@linaro.org>
In-Reply-To: <20200406114337.8802-1-ulf.hansson@linaro.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Mon, 6 Apr 2020 13:48:18 +0200
Message-ID: <CAOLZvyHxrJeG7ngzDyYVrr=TKBd34HfdB367Q9AKBhri1j0PgQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: au1xmmc: Drop redundant code in au1xmmc_send_command()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Apr 6, 2020 at 1:43 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The in-parameter "wait" is always set to 0 by the caller, hence just drop
> it and its corresponding code.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/au1xmmc.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
> index 8823680ca42c..9bb1910268ca 100644
> --- a/drivers/mmc/host/au1xmmc.c
> +++ b/drivers/mmc/host/au1xmmc.c
> @@ -259,7 +259,7 @@ static void au1xmmc_tasklet_finish(unsigned long param)
>         au1xmmc_finish_request(host);
>  }
>
> -static int au1xmmc_send_command(struct au1xmmc_host *host, int wait,
> +static int au1xmmc_send_command(struct au1xmmc_host *host,
>                                 struct mmc_command *cmd, struct mmc_data *data)
>  {
>         u32 mmccmd = (cmd->opcode << SD_CMD_CI_SHIFT);
> @@ -302,9 +302,6 @@ static int au1xmmc_send_command(struct au1xmmc_host *host, int wait,
>         __raw_writel(cmd->arg, HOST_CMDARG(host));
>         wmb(); /* drain writebuffer */
>
> -       if (wait)
> -               IRQ_OFF(host, SD_CONFIG_CR);
> -
>         __raw_writel((mmccmd | SD_CMD_GO), HOST_CMD(host));
>         wmb(); /* drain writebuffer */
>
> @@ -312,19 +309,6 @@ static int au1xmmc_send_command(struct au1xmmc_host *host, int wait,
>         while (__raw_readl(HOST_CMD(host)) & SD_CMD_GO)
>                 /* nop */;
>
> -       /* Wait for the command to come back */
> -       if (wait) {
> -               u32 status = __raw_readl(HOST_STATUS(host));
> -
> -               while (!(status & SD_STATUS_CR))
> -                       status = __raw_readl(HOST_STATUS(host));
> -
> -               /* Clear the CR status */
> -               __raw_writel(SD_STATUS_CR, HOST_STATUS(host));
> -
> -               IRQ_ON(host, SD_CONFIG_CR);
> -       }
> -
>         return 0;
>  }
>
> @@ -711,7 +695,7 @@ static void au1xmmc_request(struct mmc_host* mmc, struct mmc_request* mrq)
>         }
>
>         if (!ret)
> -               ret = au1xmmc_send_command(host, 0, mrq->cmd, mrq->data);
> +               ret = au1xmmc_send_command(host, mrq->cmd, mrq->data);
>
>         if (ret) {
>                 mrq->cmd->error = ret;
> --
> 2.20.1

Im fine with this, so:
Acked-by: Manuel Lauss <manuel.lauss@gmail.com>
