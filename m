Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D0CC0015E
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 10:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345274AbjFPKhY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 06:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345357AbjFPKer (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 06:34:47 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4445BB7
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 03:28:55 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5701e8f2b79so6516667b3.0
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 03:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686911312; x=1689503312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UFBKZNxqmuX+Sqe1P30p47ITzse6yIuxpmhDkKOdXE4=;
        b=sxQDW85XdEH3/LFYNzD0ZN2NWReezT26FBDJdLs79BZ+oeCDtW1mlW6Mw4WpMZ8rxg
         ZXuvbvAYCO4+iqxeC1TKLOigeanG85elCuP/mwTVOOOF+aZ/WfwTeLLop5yUV5N//S9Z
         0ggvNX22b9iWAuFLOtE3JcdmTRHNZsOZg6VC/dxX/7cQXT4JM6q8dVFJzoue3Ky8hB9z
         mhYx50aP9c13LzkR/yqhZGIS1kRe9ep9eVTEfDwiEA8H66YaDZ9u1JDNZnkAzgVw8kx0
         DLz1s+6bPoJ8X7XuEQPrHRx7NPT2SMTsalauSL683ICimTk0tJQstHBBEnAcjPTk9RhZ
         Itow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686911312; x=1689503312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFBKZNxqmuX+Sqe1P30p47ITzse6yIuxpmhDkKOdXE4=;
        b=gad+r/UsZjh0nXwhRwdL+21tlZHYDHaeSdSg7ZECtK8pbZYm80LgVrzpHfIyQswucT
         XnobEEfkMjRIJ0X7/3Lc7fKOTcvOdA7Q2WDZWfy2VjAb8EBLw1OyJUi5ZluINQx5rq+/
         lFb3kj/gdvkTVlH6gY+0gZQzWyFZUsRCCYuQmxI4P37ybcW1YlGIbg+MpOC1m9ZPEE3V
         n01GvdRM8quNIfWXizyI6irjFrLRPo/2Bgr1mLIgf51rOP1Endi2TRasgAoAxGBvLGr7
         4mdNIqKX9qYYLSQo6Lks0w3usFyyjYpy/Som6JTokTxDUPqaA04HZH1+rQhnZObsAMxh
         JuiA==
X-Gm-Message-State: AC+VfDxqNIbjAnIve763riwNPT2Nkzi2TOvwPXcSv8+amKQF31VZr8p+
        rsXVSC8FwZYVKuCKUyeHzmHKZACrdWL+xPq7liiRHzgaojvGW4A0yK8=
X-Google-Smtp-Source: ACHHUZ4P/5sZJt2zbkTX5cSoYxr4bfTHJBpJM3KirHpdpQg2/Bg3bGdh+F0r2+3tPlzmjG8XxmjePstXWpLbjGLxSWw=
X-Received: by 2002:a81:c201:0:b0:569:e7cb:cd4e with SMTP id
 z1-20020a81c201000000b00569e7cbcd4emr1383942ywc.48.1686911311664; Fri, 16 Jun
 2023 03:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v6-0-b850ec8019f3@linaro.org> <20230405-pl180-busydetect-fix-v6-5-b850ec8019f3@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v6-5-b850ec8019f3@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 16 Jun 2023 12:27:55 +0200
Message-ID: <CAPDyKFp=W2wzoQZFVRFfqKmPdMHsoOK-Virp9FhqMj+TxbO9Gw@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] mmc: mmci: Make busy complete state machine explicit
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

On Fri, 16 Jun 2023 at 10:30, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This refactors the ->busy_complete() callback currently
> only used by Ux500 and STM32 to handle busy detection on
> hardware where one and the same IRQ is fired whether we get
> a start or an end signal on busy detect.
>
> The code is currently using the cached status from the
> command IRQ in ->busy_status as a state to select what to
> do next: if this state is non-zero we are waiting for
> IRQs and if it is zero we treat the state as the starting
> point for a busy detect wait cycle.
>
> Make this explicit by creating a state machine where the
> ->busy_complete callback moves between three states.
>
> The Ux500 busy detect code currently assumes this order:
> we enable the busy detect IRQ, get a busy start IRQ, then a
> busy end IRQ, and then we clear and mask this IRQ and
> proceed.
>
> We insert debug prints for unexpected states.
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
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v4->v6:
> - When waiting for the busy end IRQ, what we expect is that
>   the IRQ should trigger right after the busy signal ends, and
>   thus thes busy indication should be de-asserted (low). We
>   invert the logic such that this is what we expect, and
>   the error case is if the busy detect status is still high
>   when we get the busy end IRQ.
> ChangeLog v3->v4:
> - Assign state MMCI_BUSY_DONE outside the if()-clause for
>   the busy detect initialization.
> ChangeLog v2->v3:
> - Drop surplus states and merge IDLE and DONE states into one,
>   we start out DONE. Name states *_WAITING_FOR_* so it is clear
>   what is going on.
> - Rebase on other changes.
> - Reword commit message.
> ChangeLog v1->v2:
> - No changes
> ---
>  drivers/mmc/host/mmci.c             | 55 +++++++++++++++++++++++++------------
>  drivers/mmc/host/mmci.h             | 14 ++++++++++
>  drivers/mmc/host/mmci_stm32_sdmmc.c |  6 +++-
>  3 files changed, 56 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index d632658d9d20..ccfca055f9a1 100644
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
> +       if (host->busy_state == MMCI_BUSY_DONE) {
>                 status = readl(base + MMCISTATUS);
>                 if (status & host->variant->busy_detect_flag) {
>                         writel(readl(base + MMCIMASK0) |
> @@ -695,6 +696,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>                                base + MMCIMASK0);
>
>                         host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
> +                       host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
>                         return false;
>                 }
>         }
> @@ -710,25 +712,40 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>          * both the start and the end interrupts needs to be cleared,
>          * one after the other. So, clear the busy start IRQ here.
>          */
> -       if (host->busy_status &&
> -           (status & host->variant->busy_detect_flag)) {
> -               host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
> -               writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> -               return false;
> +       if (host->busy_state == MMCI_BUSY_WAITING_FOR_START_IRQ) {
> +               if (status & host->variant->busy_detect_flag) {
> +                       host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
> +                       writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> +                       host->busy_state = MMCI_BUSY_WAITING_FOR_END_IRQ;
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
>         }
>
> -       /*
> -        * If there is a command in-progress that has been successfully
> -        * sent and the busy bit isn't set, it means we have received
> -        * the busy end IRQ. Clear and mask the IRQ, then continue to
> -        * process the command.
> -        */
> -       if (host->busy_status) {
> -               writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> -
> -               writel(readl(base + MMCIMASK0) &
> -                      ~host->variant->busy_detect_mask, base + MMCIMASK0);
> -               host->busy_status = 0;
> +       if (host->busy_state == MMCI_BUSY_WAITING_FOR_END_IRQ) {
> +               if (!(status & host->variant->busy_detect_flag)) {
> +                       host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
> +                       host->busy_state = MMCI_BUSY_DONE;
> +                       return false;
> +               } else {
> +                       dev_dbg(mmc_dev(host->mmc),
> +                               "busy status still asserted when handling busy end IRQ\n");
> +                       /* Force clear the spurious IRQ */

It may certainly be a spurious IRQ, but I am not sure that the below
is the correct thing to do in this case. I think it would be better to
continue to wait for another IRQ that could be the busy end IRQ.

Note that, the ->busy_detect_flag-bit in the status register can not
be trusted to be the root cause of the spurious IRQ. In fact, that bit
may not be linked to an IRQ at all, as it's dynamically updated and
can be polled too. See mmci_card_busy().

> +                       writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> +                       writel(readl(base + MMCIMASK0) &
> +                              ~host->variant->busy_detect_mask, base + MMCIMASK0);
> +                       host->busy_state = MMCI_BUSY_DONE;
> +                       host->busy_status = 0;
> +                       return true;
> +               }
>         }
>

[...]

> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 60bca78a72b1..a805647b6664 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c

After a second thought, I think we should leave mmci_stm32_sdmmc as
is. There is no point in assigning the ->busy_state, unless we really
make use of it.

Moreover, I think sdmmc_busy_complete() is already quite simple to follow.

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
> +               host->busy_state = MMCI_BUSY_WAITING_FOR_END_IRQ;
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

Kind regards
Uffe
