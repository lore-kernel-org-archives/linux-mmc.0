Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E35AEB64D7
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 09:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjFTJnB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 05:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFTJm7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 05:42:59 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92430CD
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 02:42:58 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bb15165ba06so3381780276.2
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 02:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687254178; x=1689846178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hBMol6/hGHeHYW7OGmkEtJNx7wCTy1iL+1vIYrRigGM=;
        b=P03nQAvKJGq5irnGLROcYSYaTKa+o2rmxmsqFmVd5ZMnkYjohtIl5Pcw6rSLb2AdYn
         hSgCiRcyLy4FrB/Vrk3rZBBm3Ums9fIh46dsH0uNoPw3h3cQdrO7fGojQIhW7VgRrzAE
         WxkOHHsIC/DZcYW4j4og74PgKEotUeUI0Nzxu0/yFoXA0Q+mpp4W47X9uVcQ8taa74Rd
         wTOhYfku2n/u5ojvkDr3AM9yoV5aLIqJ3P1Y7t4eUEQYLuwQXInKgYvJsc8yJ3VFA9ac
         tMLJKJRGN2cfee5H6wRYUlROEFvn0ymdi6nhsEbt9gdCr/1K2iIyLAUdTBY2mDFuu5gL
         YG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687254178; x=1689846178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBMol6/hGHeHYW7OGmkEtJNx7wCTy1iL+1vIYrRigGM=;
        b=VHlz2xaEGJesS1FE5xF5gUIgrkulULVZsCXiI4zOpfjZkcxrr11gY6sxauI7y9lpIZ
         b+Nux/BeNHAvvM4G/bXqgWrM+pJp7ssa40L1uiXZtBeKMAOvWFEqA2XUgH9Es12ivqik
         7XVcCasbvghhyA0SQ5e3wBvOPOQs9YeXgJI0GqP0ZtFkeybI9OUSqMXUk17+rtOn3HlJ
         WBfO2DxzBSkxDwrbji4IaoaE68ZC7zJuVU3dGgR6fixaSOGRqTYl8Fgs9jMclMLc3i1t
         p0+D4CQm4lSrl3bvX6PANtFe1gkEquFF8aP4gskzKiuJINFo07rHg3DKgd1tVxq8m8AN
         wJOA==
X-Gm-Message-State: AC+VfDwnMOiXe+DWiJ1VOFzqTppA/6j5VwbqcJ5g7KL0AOeAHdCA4Cb5
        +5NMxKCvmOcmppMDcoE/fCsu8O1U99R3nznbnvTpug==
X-Google-Smtp-Source: ACHHUZ6vUQu4TwWQoVY1RJuHFtzHPsMlPQtyNoowlDIS+PYM7r8ITwbjEkO1y79OaWOZRDlCxr8h2S1CPcS3rlz+Oxc=
X-Received: by 2002:a25:b1a3:0:b0:bcb:c3d6:2b1d with SMTP id
 h35-20020a25b1a3000000b00bcbc3d62b1dmr2760505ybj.34.1687254177746; Tue, 20
 Jun 2023 02:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230620091113.33393-1-ulf.hansson@linaro.org> <a09b7efa-c74d-bc5a-44c0-5710c1aa078b@foss.st.com>
In-Reply-To: <a09b7efa-c74d-bc5a-44c0-5710c1aa078b@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Jun 2023 11:42:21 +0200
Message-ID: <CAPDyKFpAL3QzY-us-=d-WQjCFwrHFmRDi2fOwPni6=PV-Bb-eA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Add support for SW busy-end timeouts
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 20 Jun 2023 at 11:27, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> On 6/20/23 11:11, Ulf Hansson wrote:
> > The ux500 variant doesn't have a HW based timeout to use for busy-end IRQs.
> > To avoid hanging and waiting for the card to stop signaling busy, let's
> > schedule a delayed work, according to the corresponding cmd->busy_timeout
> > for the command. If work gets to run, let's kick the IRQ handler to
> > completed the currently running request/command.
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >   drivers/mmc/host/mmci.c             | 50 ++++++++++++++++++++++++++---
> >   drivers/mmc/host/mmci.h             |  3 +-
> >   drivers/mmc/host/mmci_stm32_sdmmc.c |  3 +-
> >   3 files changed, 49 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index 8a661ea1a2d1..61d761646462 100644
> > --- a/drivers/mmc/host/mmci.c
> > +++ b/drivers/mmc/host/mmci.c
> > @@ -37,6 +37,7 @@
> >   #include <linux/pinctrl/consumer.h>
> >   #include <linux/reset.h>
> >   #include <linux/gpio/consumer.h>
> > +#include <linux/workqueue.h>
> >
> >   #include <asm/div64.h>
> >   #include <asm/io.h>
> > @@ -682,7 +683,8 @@ static void ux500_busy_clear_mask_done(struct mmci_host *host)
> >    *                     |                 |
> >    *                    IRQ1              IRQ2
> >    */
> > -static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
> > +static bool ux500_busy_complete(struct mmci_host *host, struct mmc_command *cmd,
> > +                             u32 status, u32 err_msk)
> >   {
> >       void __iomem *base = host->base;
> >       int retries = 10;
> > @@ -726,6 +728,8 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
> >                                      host->variant->busy_detect_mask,
> >                                      base + MMCIMASK0);
> >                               host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
> > +                             schedule_delayed_work(&host->ux500_busy_timeout_work,
> > +                                   msecs_to_jiffies(cmd->busy_timeout));
> >                               goto out_ret_state;
> >                       }
> >                       retries--;
> > @@ -753,6 +757,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
> >               } else {
> >                       dev_dbg(mmc_dev(host->mmc),
> >                               "lost busy status when waiting for busy start IRQ\n");
> > +                     cancel_delayed_work(&host->ux500_busy_timeout_work);
> >                       ux500_busy_clear_mask_done(host);
> >               }
> >               break;
> > @@ -761,6 +766,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
> >               if (!(status & host->variant->busy_detect_flag)) {
> >                       host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
> >                       writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> > +                     cancel_delayed_work(&host->ux500_busy_timeout_work);
> >                       ux500_busy_clear_mask_done(host);
> >               } else {
> >                       dev_dbg(mmc_dev(host->mmc),
> > @@ -1277,6 +1283,7 @@ static void
> >   mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
> >   {
> >       void __iomem *base = host->base;
> > +     bool busy_resp = cmd->flags & MMC_RSP_BUSY;
> >       unsigned long long clks;
> >
> >       dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
> > @@ -1304,10 +1311,11 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
> >       host->busy_status = 0;
> >       host->busy_state = MMCI_BUSY_DONE;
> >
> > -     if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
> > -             if (!cmd->busy_timeout)
> > -                     cmd->busy_timeout = 10 * MSEC_PER_SEC;
> > +     /* Assign a default timeout if the core does not provide one */
> > +     if (busy_resp && !cmd->busy_timeout)
> > +             cmd->busy_timeout = 10 * MSEC_PER_SEC;
> >
> > +     if (busy_resp && host->variant->busy_timeout) {
> >               if (cmd->busy_timeout > host->mmc->max_busy_timeout)
> >                       clks = (unsigned long long)host->mmc->max_busy_timeout * host->cclk;
> >               else
> > @@ -1448,7 +1456,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
> >
> >       /* Handle busy detection on DAT0 if the variant supports it. */
> >       if (busy_resp && host->variant->busy_detect)
> > -             if (!host->ops->busy_complete(host, status, err_msk))
> > +             if (!host->ops->busy_complete(host, cmd, status, err_msk))
> >                       return;
> >
> >       host->cmd = NULL;
> > @@ -1495,6 +1503,34 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
> >       }
> >   }
> >
> > +/*
> > + * This busy timeout worker is used to "kick" the command IRQ if a
> > + * busy detect IRQ fails to appear in reasonable time. Only used on
> > + * variants with busy detection IRQ delivery.
> > + */
> > +static void ux500_busy_timeout_work(struct work_struct *work)
> > +{
> > +     struct mmci_host *host = container_of(work, struct mmci_host,
> > +                                     ux500_busy_timeout_work.work);
> > +     unsigned long flags;
> > +     u32 status;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> > +
> > +     if (host->cmd) {
> > +             dev_dbg(mmc_dev(host->mmc), "timeout waiting for busy IRQ\n");
> > +
> > +             /* If we are still busy let's tag on a cmd-timeout error. */
> > +             status = readl(host->base + MMCISTATUS);
> > +             if (status & host->variant->busy_detect_flag)
> > +                     status |= MCI_CMDTIMEOUT;
> > +
> > +             mmci_cmd_irq(host, host->cmd, status);
> > +     }
> > +
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +}
> > +
> >   static int mmci_get_rx_fifocnt(struct mmci_host *host, u32 status, int remain)
> >   {
> >       return remain - (readl(host->base + MMCIFIFOCNT) << 2);
> > @@ -2309,6 +2345,10 @@ static int mmci_probe(struct amba_device *dev,
> >                       goto clk_disable;
> >       }
> >
> > +     if (host->variant->busy_detect)
> > +             INIT_DELAYED_WORK(&host->ux500_busy_timeout_work,
> > +                               ux500_busy_timeout_work);
>
> Hi Ulf,
>
> STM32 variants also have busy_detect = true.
> Could that be an issue to initialize this work, which seem dedicated to
> ux500?

The work will not be used for the STM32 variants
(sdmmc_variant_init()), so it's not a problem as it's just an
initialization.

> I haven't tested the patch yet. Will do that soon.

Looking forward to your feedback, thanks!

Kind regards
Uffe

>
>
> Yann
>
> > +
> >       writel(MCI_IRQENABLE | variant->start_err, host->base + MMCIMASK0);
> >
> >       amba_set_drvdata(dev, mmc);
> > diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> > index 12a7bbd3ce26..69b2439842dd 100644
> > --- a/drivers/mmc/host/mmci.h
> > +++ b/drivers/mmc/host/mmci.h
> > @@ -393,7 +393,7 @@ struct mmci_host_ops {
> >       void (*dma_error)(struct mmci_host *host);
> >       void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
> >       void (*set_pwrreg)(struct mmci_host *host, unsigned int pwr);
> > -     bool (*busy_complete)(struct mmci_host *host, u32 status, u32 err_msk);
> > +     bool (*busy_complete)(struct mmci_host *host, struct mmc_command *cmd, u32 status, u32 err_msk);
> >       void (*pre_sig_volt_switch)(struct mmci_host *host);
> >       int (*post_sig_volt_switch)(struct mmci_host *host, struct mmc_ios *ios);
> >   };
> > @@ -451,6 +451,7 @@ struct mmci_host {
> >       void                    *dma_priv;
> >
> >       s32                     next_cookie;
> > +     struct delayed_work     ux500_busy_timeout_work;
> >   };
> >
> >   #define dma_inprogress(host)        ((host)->dma_in_progress)
> > diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> > index 953d1be4e379..f07cfbeafe2e 100644
> > --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> > +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> > @@ -372,7 +372,8 @@ static u32 sdmmc_get_dctrl_cfg(struct mmci_host *host)
> >       return datactrl;
> >   }
> >
> > -static bool sdmmc_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
> > +static bool sdmmc_busy_complete(struct mmci_host *host, struct mmc_command *cmd,
> > +                             u32 status, u32 err_msk)
> >   {
> >       void __iomem *base = host->base;
> >       u32 busy_d0, busy_d0end, mask, sdmmc_status;
>
