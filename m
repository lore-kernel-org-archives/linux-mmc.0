Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256E6EB64D9
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Jun 2023 12:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344659AbjFOMCi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Jun 2023 08:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239131AbjFOMCV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jun 2023 08:02:21 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5BE5246
        for <linux-mmc@vger.kernel.org>; Thu, 15 Jun 2023 04:57:35 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5704ddda6dfso223627b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 15 Jun 2023 04:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686830254; x=1689422254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=afkr67MqCl1yPE9cbHl8BgAKnwQMyZRs7BFufFtFzas=;
        b=fj9ORj7RuqkrvPG3UrJz2q+kPp1+5z4Yz+XFHJIHBcokRNKvOUNKqrG9VRJirnJxq1
         tDc/9zdRC2xsDED9EcqQdTWHGiRddKoaYFW4b/mr93x9vjcqPZPib0U1NvZ6to+YXG5P
         lQBXc185CUCFeNqyXmPzFUs1t6zhEM02eTL9sFZlVakYv67xHMmGKAqB+lt/haMkBjhF
         fAYM2l+rQgM+qZ+SPcZun2s85N0Zmpz6DjotKml8WIWWKfRofVtwSNRjkfiGkAQNAXfc
         UQ2yvmnG1NNDbZs6MOaiBRuiYYe+YeR5rK+gqFJsVdOosl/PjAHETq59uNFuZJ7WpMtV
         t7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686830254; x=1689422254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afkr67MqCl1yPE9cbHl8BgAKnwQMyZRs7BFufFtFzas=;
        b=cKuCGANDiUSPq44BmZKrygqxLecqhpvLE6JBFLtI6eTx/9Jc7Proe+WTL6kf2GTxUW
         hOJYoFzueES+0TL1o8LK2fRdkozjr+sm/qZCY02yGMQs+/A8VGFoOw4xvoR93BKqAvtg
         T+krhr1m+rwcdkKJQb9K62Ies46BUTEk8AENjWTohNR/Nt8ixV6Z9grghE7zlwZbsIDl
         0Ztqb0JKNq7zxUZxLLN4j87RzzY+IoMIh1Qvebf0ULofg5YljHxNs2vT+htxq+PDmokw
         DxbdLgAFhqeJ14gCaCsUPQFIWtprP1c36m+pRYdsaWwMuEg5L+12Ji978gbHcjk12IJ3
         Uc8g==
X-Gm-Message-State: AC+VfDyeywE4M5ld3DObtbN6r5XnT9rtNL0GtqMmet9tIqeeZm6hkR09
        7eKIyQOENlRhbtELdkKC4EASCsa0C+5vegUoHzuvfA==
X-Google-Smtp-Source: ACHHUZ6JdnDMBk7tsimj6J3FPVLtSWWc6Ee+HQ5b2tze37LEZa+JkI93oFT/sSy6KmGG4jLNZSUBGlWcAsGCQJEAaYA=
X-Received: by 2002:a81:4fc5:0:b0:570:eb7:3db3 with SMTP id
 d188-20020a814fc5000000b005700eb73db3mr5132585ywb.37.1686830254318; Thu, 15
 Jun 2023 04:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org> <20230405-pl180-busydetect-fix-v4-5-df9c8c504353@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v4-5-df9c8c504353@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Jun 2023 13:56:58 +0200
Message-ID: <CAPDyKFp36G6StCVeihOefWuaeNBEe9uC6cfQi3nh8T-HLfh7uQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] mmc: mmci: Make busy complete state machine explicit
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
> index d632658d9d20..3b1a23e4ec1c 100644
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
> +               if (status & host->variant->busy_detect_flag) {

I realize that I have already queued up $subject patch, but I haven't
been able to test this myself yet.

However, I wonder if the above is really correct? More precisely, did
you confirm that the variant->busy_detect_flag-bit becomes set for the
ux500 variant, when the card stops signaling busy? If not, we will
always end up in the else clause below?

> +                       host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
> +                       writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> +                       host->busy_state = MMCI_BUSY_DONE;
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

[...]

Kind regards
Uffe
