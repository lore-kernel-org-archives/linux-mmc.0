Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D003FC77B7A
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 12:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjFMMI3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 08:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjFMMI2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 08:08:28 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001ECE56
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 05:08:26 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-56ce6bbe274so37170677b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 05:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686658106; x=1689250106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ArJBZBiSCycQL9sHnvzcinYezPRGuB1JNtNlNcpo7ME=;
        b=RpUixOH0iJeRceB0M89qFmTJXKjgHynLZhyf0F5CqKC9lkNqlWyb5YuRHF/Tp3LyxM
         NqHa3ukNQbCaVH3BCiPpo1epxqUJsf3uyyTfQOXTlDZ+AYe8JGGku/BaQInuNIE5Ry/o
         PTRuBMpEiOy2JU5jCeIM9bobweVJJ2eCbBH+rTnln3cddBwsLjODVIS7iTG92iP8wmUG
         bH+me40jLYRBfVWwNFsWMS7L1vQWXw6z8cfF8GUyCJp4pB94nJkwNXqd29mxdISqbCEf
         xsc8CyafR8Vm1EcOWOU9uj4ykcBmqRbyF8UUiJw4ds7/hjoD+U4HWuAmrWzZjRlLu0xa
         LeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686658106; x=1689250106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ArJBZBiSCycQL9sHnvzcinYezPRGuB1JNtNlNcpo7ME=;
        b=WQ2TPigLEHM6DuIsElsjAq4nFwqXrZXWGO6g2AIqH/YkCUT33LO9WzJ/tvZHOkJkgb
         hBnvxoCuybaWQGSH8utzfNl2ONg08Zd7vihRE513tYB6UeD7K1X51Ii81P39+SZGMKj3
         5pcVJMpfRc3oFipODt42UYPQ57ZRXlr5cIw8NDwmLQPjfsJPkRenbuzphcYyeoXmOpz7
         ZThoMJGuJ4EMNlTjoeDuv+5FReDXNnDuM1NyT1LmVg006XiZ1fmLuyM1JF5BhkyDvUuX
         1LPwpI05F6XmCoKFnpsvzgi4Nk0Vi1h1sOKhkCWbk6x8ApgnLR/i9s1XtrGsVPKEpOdg
         S+KQ==
X-Gm-Message-State: AC+VfDwrOLa6XcCV6dSxkspnU+AAPE/gQNJkxP9GXoV1830nSO0lXdqD
        NZujOkmbHkIlod7h5Li5LlxsJtcd2spGTSbwdLDJMgo3wTxhEa0bL/Q=
X-Google-Smtp-Source: ACHHUZ67DWmIIo0zbOpvhIaW6gPil6QfFopK0/7D1kWR4Z3TSN/H/b7MWJmvhOr0752Bk9+2D/q0c9+61pXg0Tv/PTM=
X-Received: by 2002:a25:b181:0:b0:bcb:7428:789 with SMTP id
 h1-20020a25b181000000b00bcb74280789mr1278679ybj.64.1686658106113; Tue, 13 Jun
 2023 05:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org> <20230405-pl180-busydetect-fix-v3-10-cd3d5925ae64@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v3-10-cd3d5925ae64@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 13 Jun 2023 14:07:50 +0200
Message-ID: <CAPDyKFqxvNxFqLdpj15Gz+zDNT04YzxEAh-svKvRuaM52dCV3g@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] mmc: mmci: Add busydetect timeout
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

On Sun, 11 Jun 2023 at 21:41, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Add a timeout for busydetect IRQs using a delayed work.
> It might happen (and does happen) on Ux500 that the first
> busy detect IRQ appears and not the second one. This will
> make the host hang indefinitely waiting for the second
> IRQ to appear.
>
> Fire a delayed work after 10ms and re-engage the command
> IRQ so the transaction finishes: we are certainly done
> at this point, or we will catch an error in the status
> register.

A fixed value of 10ms doesn't work. We have lots of commands that are
associated with way longer timeouts than this.

Typically, the cmd->busy_timeout contains the current value of the
timeout that should be used for the commands that have the flags
MMC_RSP_BUSY set for it.

The stm variant already uses cmd->busy_timeout, but also assigns a
default timeout, just to make sure if the core has failed to set
cmd->busy_timeout (it shouldn't but who knows).

A few more more comments to code, see below.

>
> This makes the eMMC work again on Skomer.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Rebased.
> ChangeLog v1->v2:
> - No changes
> ---
>  drivers/mmc/host/mmci.c | 23 +++++++++++++++++++++++
>  drivers/mmc/host/mmci.h |  1 +
>  2 files changed, 24 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 05b8fad26c10..7e40b8f2dbf3 100644
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
> @@ -741,6 +742,8 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>                         host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
>                         writel(host->variant->busy_detect_mask, base + MMCICLEAR);
>                         host->busy_state = MMCI_BUSY_WAITING_FOR_END_IRQ;
> +                       schedule_delayed_work(&host->busy_timeout_work,
> +                                             msecs_to_jiffies(10));
>                 } else {
>                         dev_dbg(mmc_dev(host->mmc),
>                                 "lost busy status when waiting for busy start IRQ\n");
> @@ -752,6 +755,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>                 if (status & host->variant->busy_detect_flag) {
>                         host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
>                         writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> +                       cancel_delayed_work_sync(&host->busy_timeout_work);
>                         ux500_busy_clear_mask_done(host);
>                 } else {
>                         dev_dbg(mmc_dev(host->mmc),
> @@ -1487,6 +1491,22 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>         }
>  }
>
> +/*
> + * This busy timeout worker is used to "kick" the command IRQ if a
> + * busy detect IRQ fails to appear in reasonable time. Only used on
> + * variants with busy detection IRQ delivery.
> + */
> +static void busy_timeout_work(struct work_struct *work)
> +{
> +       struct mmci_host *host =
> +               container_of(work, struct mmci_host, busy_timeout_work.work);
> +       u32 status;
> +
> +       dev_dbg(mmc_dev(host->mmc), "timeout waiting for busy IRQ\n");
> +       status = readl(host->base + MMCISTATUS);
> +       mmci_cmd_irq(host, host->cmd, status);

There's no locking here. I assume that's because we call
cancel_delayed_work_sync() from an atomic context and we don't want
that to hang.

However, can't the call to mmci_cmd_irq() race with a proper irq being
managed in parallel?

> +}
> +
>  static int mmci_get_rx_fifocnt(struct mmci_host *host, u32 status, int remain)
>  {
>         return remain - (readl(host->base + MMCIFIFOCNT) << 2);
> @@ -2300,6 +2320,9 @@ static int mmci_probe(struct amba_device *dev,
>                         goto clk_disable;
>         }
>
> +       if (host->variant->busy_detect && host->ops->busy_complete)
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

Kind regards
Uffe
