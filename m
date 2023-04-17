Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD286C77B76
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Apr 2023 14:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjDQOpU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Apr 2023 10:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDQOpU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Apr 2023 10:45:20 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAF44687
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 07:45:18 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54fe82d8bf5so106158107b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681742717; x=1684334717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4FzwEmXCbLWkDqPKTIh/nkoj4HCKQ0guZR5zz+6K+8=;
        b=UAt8CkCWKymPJxTMqsOXGGIqQPoR9Gv1LM0ejR0A4FCOlvgWZy8ZJH1j4h9I82XGFb
         XU6coHvaKbwHU5tIJ7ya3KyCYve5k6G/yFUoN4Ewe2JNKgS2M8Ym1pdXxk4h1iQDO/tN
         qvXvLWSA1rTLyRId5BtxQBrhF6DtqqLaO/CwBqoi4FUk+UOIXqgVNOeTxiHwxAx2GLwk
         z2OuC2K2xNXxWy2x2K03rOSVfD4eb/I2rQ/t9Xkv3MGCjIBxYiLCdxY9RHKEgNY5qh+q
         ntC+QJvnAsYIyjbCGOztQVzQStOU6ePp3T9uLN2JuNNJ56fb3tBGpK1yHK0mFfTszukJ
         B68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681742717; x=1684334717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4FzwEmXCbLWkDqPKTIh/nkoj4HCKQ0guZR5zz+6K+8=;
        b=T95+Vc1joaOYoFmJ5uS+pGr0FFR6/hezR4O3QyRxsESgNHrFLVS6RqsIZX/Cw47Qmk
         d7oIdg5KfZXH/QRV37XOki9WpfnUqDpMwsGKyZLsgWvlIRRDY/KF5hmTf955GgRP2MIx
         3+FcE4dX1+l3djyYCpHyDWlFriWWxvtUQIMw2qNQd08P0ZAX7I9a7Z7Rg86TL7k/TDGU
         xRwehLaAYhCn6qhFjJLqfg+hezLUqjsWqsryWUvk9lD+3mZR9dCUT6r0V+bfvc1WNoyk
         INVUfgZZfyCmw44vRCcEXDBbk28PYF65Lmqq6wJ4X8JMtvl6bzk3KD7RqhlNl5D6Iq5E
         HXyQ==
X-Gm-Message-State: AAQBX9fuN1e4J1y76/v/3NNEyjqLB4AYtaKEqzp+p2JySdpr9lTd2dGp
        PSzN/J/7I0anyhH76+f2Eyp+hBtuWRidMPzz0D/tNg==
X-Google-Smtp-Source: AKy350Y1VOmPkjLQAICiz3zrAWRrax3arHCfhHoshAEA18nmx8Jnxmo4jV8sMGUGj5IOTTm6cYY1fxg5osjZyIOgoo8=
X-Received: by 2002:a81:ac19:0:b0:53c:6fda:835f with SMTP id
 k25-20020a81ac19000000b0053c6fda835fmr9043046ywh.0.1681742717316; Mon, 17 Apr
 2023 07:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org> <20230405-pl180-busydetect-fix-v2-5-eeb10323b546@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v2-5-eeb10323b546@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 16:44:41 +0200
Message-ID: <CAPDyKFrdgktJo8=rLCsvTgbY8qyoBqdJQEduV_uHKE5ptZHgsQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] mmc: mmci: Make busy complete state machine explicit
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

On Sun, 9 Apr 2023 at 00:00, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This refactors the ->busy_complete() callback currently
> only used by Ux500 to handle busy detection on hardware
> where one and the same IRQ is fired whether we get a
> start or an end signal on busy detect.

Nitpick: The callback is being used by the mmci_stm32_sdmmc variant too.

>
> The code is currently using the cached status from the
> command IRQ in ->busy_status as a state to select what to
> do next: if this state is non-zero we are waiting for
> IRQs and if it is zero we treat the state as the starting
> point for a busy detect wait cycle.
>
> Make this explicit by creating a state machine where the
> ->busy_complete callback moves between four states:
> MMCI_BUSY_NOT_STARTED, MMCI_BUSY_WAITING_FOR_IRQS,
> MMCI_BUSY_START_IRQ and MMCI_BUSY_END_IRQ.

This makes perfect sense to me too. However, these don't really match
the names of enum types you eventually decided to use.

To be consistent, perhaps it's just easier to drop the actual enum
names from the commit message?

>
> The code currently assumes this order: we enable the busy
> detect IRQ, get a busy start IRQ, then a busy end IRQ, and
> then we clear and mask this IRQ and proceed.
>
> We insert dev_err() prints for unexpected states.
>
> Augment the STM32 driver with similar states for
> completeness.
>
> This works as before on most cards, however on a
> problematic card that is not working with busy detect, and
> which I have been debugging, this happens:
>
> [127220.662719] mmci-pl18x 80005000.mmc: lost busy status
>                 when waiting for busy end IRQ
>
> This probably means that the busy detect start IRQ has
> already occurred when we start executing the
> ->busy_complete() callbacks, and the busy detect end IRQ
> is counted as the start IRQ, and this is what is causing
> the card to not be detected properly.

I agree, this whole thing has been fragile. Your observations seem
reasonable to me too.

>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - No changes
> ---
>  drivers/mmc/host/mmci.c             | 55 +++++++++++++++++++++++++++++++------
>  drivers/mmc/host/mmci.h             | 16 +++++++++++
>  drivers/mmc/host/mmci_stm32_sdmmc.c |  6 +++-
>  3 files changed, 68 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 7d42625f2356..887b83e392a4 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -670,6 +670,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>                 writel(host->variant->busy_detect_mask, base + MMCICLEAR);
>                 writel(readl(base + MMCIMASK0) &
>                        ~host->variant->busy_detect_mask, base + MMCIMASK0);
> +               host->busy_state = MMCI_BUSY_DONE;
>                 host->busy_status = 0;
>                 return true;
>         }
> @@ -687,7 +688,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>          * while, to allow it to be set, but tests indicates that it
>          * isn't needed.
>          */
> -       if (!host->busy_status) {
> +       if (host->busy_state == MMCI_BUSY_IDLE) {
>                 status = readl(base + MMCISTATUS);
>                 if (status & host->variant->busy_detect_flag) {
>                         writel(readl(base + MMCIMASK0) |
> @@ -695,6 +696,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>                                base + MMCIMASK0);
>
>                         host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
> +                       host->busy_state = MMCI_BUSY_WAITING_FOR_IRQS;
>                         return false;
>                 }
>         }
> @@ -710,11 +712,40 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>          * both the start and the end interrupts needs to be cleared,
>          * one after the other. So, clear the busy start IRQ here.
>          */
> -       if (host->busy_status &&
> -           (status & host->variant->busy_detect_flag)) {
> -               host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
> -               writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> -               return false;
> +       if (host->busy_state == MMCI_BUSY_WAITING_FOR_IRQS) {
> +               if (status & host->variant->busy_detect_flag) {
> +                       host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
> +                       writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> +                       host->busy_state = MMCI_BUSY_START_IRQ;
> +                       return false;
> +               } else {
> +                       dev_dbg(mmc_dev(host->mmc),
> +                               "lost busy status when waiting for busy start IRQ\n");
> +                       writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> +                       writel(readl(base + MMCIMASK0) &
> +                              ~host->variant->busy_detect_mask, base + MMCIMASK0);
> +                       host->busy_state = MMCI_BUSY_DONE;
> +                       host->busy_status = 0;
> +                       return true;
> +               }
> +       }
> +
> +       if (host->busy_state == MMCI_BUSY_START_IRQ) {
> +               if (status & host->variant->busy_detect_flag) {
> +                       host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
> +                       writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> +                       host->busy_state = MMCI_BUSY_END_IRQ;
> +                       return false;
> +               } else {
> +                       dev_dbg(mmc_dev(host->mmc),
> +                               "lost busy status when waiting for busy end IRQ\n");
> +                       writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> +                       writel(readl(base + MMCIMASK0) &
> +                              ~host->variant->busy_detect_mask, base + MMCIMASK0);
> +                       host->busy_state = MMCI_BUSY_DONE;
> +                       host->busy_status = 0;
> +                       return true;
> +               }
>         }
>
>         /*
> @@ -723,11 +754,18 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>          * the busy end IRQ. Clear and mask the IRQ, then continue to
>          * process the command.
>          */
> -       if (host->busy_status) {
> -               writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> +       if (host->busy_state == MMCI_BUSY_END_IRQ) {
> +               if (status & host->variant->busy_detect_flag) {
> +                       /* We should just get two IRQs for busy detect */
> +                       dev_err(mmc_dev(host->mmc), "spurious busy detect IRQ\n");
> +                       return false;
> +               }
>
> +               writel(host->variant->busy_detect_mask, base + MMCICLEAR);
>                 writel(readl(base + MMCIMASK0) &
>                        ~host->variant->busy_detect_mask, base + MMCIMASK0);
> +
> +               host->busy_state = MMCI_BUSY_DONE;
>                 host->busy_status = 0;
>         }
>
> @@ -1258,6 +1296,7 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>         }
>
>         if (cmd->flags & MMC_RSP_BUSY) {
> +               host->busy_state = MMCI_BUSY_IDLE;
>                 host->busy_status = 0;
>
>                 if (host->variant->busy_timeout) {
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index e1a9b96a3396..82f3850325c8 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -261,6 +261,21 @@ struct clk;
>  struct dma_chan;
>  struct mmci_host;
>
> +/**
> + * enum mmci_busy_state - enumerate the busy detect wait states
> + *
> + * This is used for the state machine waiting for different busy detect
> + * interrupts on hardware that fire a single IRQ for start and end of
> + * the busy detect phase on DAT0.
> + */
> +enum mmci_busy_state {
> +       MMCI_BUSY_IDLE,

This state name is a bit confusing to me. If I understand correctly,
this state means that the sent command has a corresponding busy
signaling that should be checked for, right? Can we perhaps reflect
that in the name somehow?

> +       MMCI_BUSY_WAITING_FOR_IRQS,
> +       MMCI_BUSY_START_IRQ,
> +       MMCI_BUSY_END_IRQ,
> +       MMCI_BUSY_DONE,
> +};
> +
>  /**
>   * struct variant_data - MMCI variant-specific quirks
>   * @clkreg: default value for MCICLOCK register
> @@ -409,6 +424,7 @@ struct mmci_host {
>         u32                     clk_reg;
>         u32                     clk_reg_add;
>         u32                     datactrl_reg;
> +       enum mmci_busy_state    busy_state;
>         u32                     busy_status;
>         u32                     mask1_reg;
>         u8                      vqmmc_enabled:1;
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 60bca78a72b1..24831a1092b2 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -393,8 +393,10 @@ static bool sdmmc_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>         busy_d0 = sdmmc_status & MCI_STM32_BUSYD0;
>
>         /* complete if there is an error or busy_d0end */
> -       if ((status & err_msk) || busy_d0end)
> +       if ((status & err_msk) || busy_d0end) {
> +               host->busy_state = MMCI_BUSY_DONE;
>                 goto complete;
> +       }
>
>         /*
>          * On response the busy signaling is reflected in the BUSYD0 flag.
> @@ -408,6 +410,7 @@ static bool sdmmc_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>                         host->busy_status = status &
>                                 (MCI_CMDSENT | MCI_CMDRESPEND);
>                 }
> +               host->busy_state = MMCI_BUSY_END_IRQ;
>                 return false;
>         }
>
> @@ -416,6 +419,7 @@ static bool sdmmc_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>                 writel_relaxed(mask & ~host->variant->busy_detect_mask,
>                                base + MMCIMASK0);
>                 host->busy_status = 0;
> +               host->busy_state = MMCI_BUSY_DONE;
>         }
>
>         writel_relaxed(host->variant->busy_detect_mask, base + MMCICLEAR);
>

Overall, I have to admit that I think the code is getting harder to
follow again, even if the end result from the series looks really
nice.

Besides making sure that each step/patch compiles, I am also worried
that we may be breaking things on the way. That said, I wonder if it's
not better to actually squash some of the patches in the series, to
avoid churns - can you please look into that?

Kind regards
Uffe
