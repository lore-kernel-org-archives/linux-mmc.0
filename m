Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACFFEB64D9
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jun 2023 12:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjFNMR3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Jun 2023 08:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243941AbjFNMR1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2023 08:17:27 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FB71FD8
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 05:17:24 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bc476bf5239so540173276.2
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686745043; x=1689337043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wiBlA+RDlH7R4OggHRWKj7Fxop5IItuK1n0fHDx4yHw=;
        b=c1l2fM4LaNmiHUX81AtW3b2A9JMGlFrJ8LxfZqVmmIWd1EBd1qDMYcDRFvGu/xnAQO
         dY37C0gCffbk6ulsMYXviKhf+nHrdxufHf+QBIzc15hf+ccSEHPZ3NFEgxTui6DBcqZY
         J0PqE9NHUt+XgDK5whgt6k0w0VdN3hsWBAoXSQt96ugh9LqenU9Eo2ghgFlyAzmXl0Yk
         dJVKmw7jTiPsnd84pkk/T3d6NvFGdlrkTrFq6cB5CHur598lzR1aVJciqIeIMIqY3GPP
         RkcCsw90F20Xa3c6m1ArBjJO+otmuSFzAvkQDjUTIqjrnr2U+aZGd15Ciqda2bCq5KB+
         efig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686745043; x=1689337043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiBlA+RDlH7R4OggHRWKj7Fxop5IItuK1n0fHDx4yHw=;
        b=iL/NrbwJKbXvY12+bZZwFoU5eMJh2xJhnpVPfiEhhst1VERXSqKpGJA1lPgYEBy6Av
         W5RifQTZE/qZ2VqugfUtrJ4O099JKcnuCsVk8hYaNKh5JWjrspZ/V5nNstGJ8laCWb6i
         IIhyuF6qF4HRikXmqJCnvXF9MFGjUYrSDcTvKfyb6VUUP4tZ5Wlo6JdlZzxomT1++Mcd
         e40e8YETCKVn32X0XySb3QNlkNAR8ZSfDCbou1irsA1kEI9dcUtUJMmVLl3EEM3/o5aR
         rJrAO9Hia9jKiWQtWF1qbEyIlwiQmGc+N8qgmzFI5065TYib13OLfBGGlZL2VoQIysBk
         qHzA==
X-Gm-Message-State: AC+VfDzsGBWvMYHNNMkdk510RrLSQZAMHXau09mcRkAsT7J8Y37jdn51
        jFQqFl6Xs6HKSgIBHevAXROTrD6YVD9v2xNsTNFYOC4tXEQtlu2FVwc=
X-Google-Smtp-Source: ACHHUZ5K7H9WPjQtqp24pEfxQtv8IPUZVJcyYIGqu0TLM/IkZzUn4XE/SMePAeC2AkTEc8wkcC21yhJ8fp8elq8xy1w=
X-Received: by 2002:a81:6654:0:b0:56d:d58:82b7 with SMTP id
 a81-20020a816654000000b0056d0d5882b7mr1518242ywc.23.1686745043025; Wed, 14
 Jun 2023 05:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org> <20230405-pl180-busydetect-fix-v4-10-df9c8c504353@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v4-10-df9c8c504353@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Jun 2023 14:16:46 +0200
Message-ID: <CAPDyKFrq2doTP-7Pdi3cAUtGy9fhqi9mjDZDEhSAdaEd_y+YpA@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] mmc: mmci: Add busydetect timeout
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 13 Jun 2023 at 22:34, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Add a timeout for busydetect IRQs using a delayed work.
> It might happen (and does happen) on Ux500 that the first
> busy detect IRQ appears and not the second one. This will
> make the host hang indefinitely waiting for the second
> IRQ to appear.
>
> Calculate the busy timeout unconditionally in
> mmci_start_command() using the code developed for STM32
> and use this as a timeout for the command.
>
> This makes the eMMC work again on Skomer.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Use the calculated command busy timeout from the core
>   or the same calculated default as for STM32.
> ChangeLog v2->v3:
> - Rebased.
> ChangeLog v1->v2:
> - No changes
> ---
>  drivers/mmc/host/mmci.c | 30 +++++++++++++++++++++++++++---
>  drivers/mmc/host/mmci.h |  1 +
>  2 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 478f71dc7f34..12df1c231177 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -37,6 +37,7 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/workqueue.h>
>
>  #include <asm/div64.h>
>  #include <asm/io.h>
> @@ -740,6 +741,8 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>                         host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
>                         writel(host->variant->busy_detect_mask, base + MMCICLEAR);
>                         host->busy_state = MMCI_BUSY_WAITING_FOR_END_IRQ;

Shouldn't we schedule the work at the point when we move to
MMCI_BUSY_WAITING_FOR_START_IRQ instead?

At least, it's from that point in time that we detect that the card
signals busy. Moreover, at least theoretically, we could end up
hanging/waiting for the busy start irq too, right?

> +                       schedule_delayed_work(&host->busy_timeout_work,
> +                                             msecs_to_jiffies(host->cmd->busy_timeout));
>                 } else {
>                         dev_dbg(mmc_dev(host->mmc),
>                                 "lost busy status when waiting for busy start IRQ\n");
> @@ -751,6 +754,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>                 if (status & host->variant->busy_detect_flag) {
>                         host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
>                         writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> +                       cancel_delayed_work_sync(&host->busy_timeout_work);
>                         ux500_busy_clear_mask_done(host);
>                 } else {
>                         dev_dbg(mmc_dev(host->mmc),
> @@ -1295,10 +1299,11 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>         host->busy_status = 0;
>         host->busy_state = MMCI_BUSY_DONE;
>
> -       if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
> -               if (!cmd->busy_timeout)
> -                       cmd->busy_timeout = 10 * MSEC_PER_SEC;
> +       /* Assign a default timeout if the core does not provide one */
> +       if (!cmd->busy_timeout)
> +               cmd->busy_timeout = 10 * MSEC_PER_SEC;
>
> +       if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
>                 if (cmd->busy_timeout > host->mmc->max_busy_timeout)
>                         clks = (unsigned long long)host->mmc->max_busy_timeout * host->cclk;
>                 else
> @@ -1486,6 +1491,22 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>         }
>  }
>
> +/*
> + * This busy timeout worker is used to "kick" the command IRQ if a
> + * busy detect IRQ fails to appear in reasonable time. Only used on
> + * variants with busy detection IRQ delivery.
> + */
> +static void busy_timeout_work(struct work_struct *work)

In a way to try to be consistent with naming functions, perhaps add
the prefix "ux500_*?

> +{
> +       struct mmci_host *host =
> +               container_of(work, struct mmci_host, busy_timeout_work.work);
> +       u32 status;
> +
> +       dev_dbg(mmc_dev(host->mmc), "timeout waiting for busy IRQ\n");
> +       status = readl(host->base + MMCISTATUS);
> +       mmci_cmd_irq(host, host->cmd, status);
> +}
> +
>  static int mmci_get_rx_fifocnt(struct mmci_host *host, u32 status, int remain)
>  {
>         return remain - (readl(host->base + MMCIFIFOCNT) << 2);
> @@ -2299,6 +2320,9 @@ static int mmci_probe(struct amba_device *dev,
>                         goto clk_disable;
>         }
>
> +       if (host->variant->busy_detect && host->ops->busy_complete)

The ->busy_detect bool, mandates the ->busy_complete() callback. There
is no need to check for it too.

> +               INIT_DELAYED_WORK(&host->busy_timeout_work, busy_timeout_work);
> +
>         writel(MCI_IRQENABLE | variant->start_err, host->base + MMCIMASK0);
>
>         amba_set_drvdata(dev, mmc);
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 12a7bbd3ce26..95d3d0a6049b 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -451,6 +451,7 @@ struct mmci_host {
>         void                    *dma_priv;
>
>         s32                     next_cookie;
> +       struct delayed_work     busy_timeout_work;
>  };
>
>  #define dma_inprogress(host)   ((host)->dma_in_progress)
>

Other than the above, I am still not convinced that we don't have a
locking issue, as we discussed for the previous version. However,
let's continue that discussion in the other thread, separately.

Kind regards
Uffe
