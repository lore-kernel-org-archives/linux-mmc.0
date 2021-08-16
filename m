Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA68C4338F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439D563305
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhHPOAy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhHPOAh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 10:00:37 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CF3C061224
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:59:45 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id g1so10995217vsq.7
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8F8ofHktK0D6sC8E2U990HPOVe8nFGr8wbj2x9k2ig=;
        b=CnxxuQatXNI1WrxxXkVztpJnkCXfS1HGlWNDPMm0pH8dx+OefH0jqta5U6iJ+ZD/KM
         5qB2kKOHo9wadf1Cxc/8Yk9emSVY61rr/I5GM/maMaSg5ADs7+DYV+rLdoHjooSRMto6
         uYmFBz2qSk9HCCKZ5ENc/iX4JwbbMxwt+DDp4zjEagoc8S/qLjIH5Z2Y4A0mIpQqBJMW
         Yi3P2H/BE5qjbp/4YQv86W8fFOtEwe3O3ECTs4AZpS908vIxDlr94PEzDa2X/ySE+2rG
         wEY1nazzTb8NqK3/JfUuMMMfPN6v7PVuIH8BthO2DwIZoAgdsJLMQFBcUP7CESg1NR3N
         ktDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8F8ofHktK0D6sC8E2U990HPOVe8nFGr8wbj2x9k2ig=;
        b=IjJJgvkTy4ou6Q7mJfiGQFXdffCmv17ZTJbIkTGe2JS4UFjSx179VPiqK9YJR3AHTk
         x6CgIc/5wzejOXowlHSCFkku29TJDpyAZUM2xMTXqC3afUew6B86inpM2IF4BoiYSuKD
         VzUBV3uyC9D0tUy5Y8GaAaDZUF3/QBq9L45YVBFurxTf7RLOsw8xst1OeD9d9ixJQTcQ
         f0scWzqPXk9FAhl7+04u2cHoj/pvY9rE38QqJy5/O3QnxRNAIjSi57pRkhwzlY40jZ8p
         jQDPygOc2n4e2MWZpklV72JzdfSVCYMZMfgiAhZZGWoJa6TaaFxB73wB8qFOOJos0YUK
         /WdA==
X-Gm-Message-State: AOAM530uOuKNYdbVbZRFU2Rv4CaqGdraPP3U4ZL5N0eAj18r4thB5N74
        gCr/9Rir8oa3+s21nJC3zOhx4ZxvIdbZ3ayrRpbsgw==
X-Google-Smtp-Source: ABdhPJyLhhY45yfFMWWubkJb/mweV4RrpZDMAc2LgnFag61Ctnu7Ktgvv3hHnmLdqcSXOBDgIoGmKtJ6y9lqdBE8c3k=
X-Received: by 2002:a05:6102:5f4:: with SMTP id w20mr3935366vsf.34.1629122385129;
 Mon, 16 Aug 2021 06:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com> <1628334401-6577-6-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1628334401-6577-6-git-send-email-stefan.wahren@i2se.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Aug 2021 15:59:09 +0200
Message-ID: <CAPDyKFr9UEO4TdieTYoR+UXgp70d4Axy7F2nYJc_qNb1dPho7A@mail.gmail.com>
Subject: Re: [PATCH V2 05/10] mmc: sdhci-iproc: Set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
 on BCM2711
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Maxime Ripard <maxime@cerno.tech>, iivanov@suse.de,
        DTML <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2835..." 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 7 Aug 2021 at 13:07, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> From: Nicolas Saenz Julienne <nsaenz@kernel.org>
>
> The controller doesn't seem to pick-up on clock changes, so set the
> SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN flag to query the clock frequency
> directly from the clock.
>
> Fixes: f84e411c85be ("mmc: sdhci-iproc: Add support for emmc2 of the BCM2711")
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-iproc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 032bf85..e7565c6 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -295,7 +295,8 @@ static const struct sdhci_ops sdhci_iproc_bcm2711_ops = {
>  };
>
>  static const struct sdhci_pltfm_data sdhci_bcm2711_pltfm_data = {
> -       .quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +       .quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 |
> +                 SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>         .ops = &sdhci_iproc_bcm2711_ops,
>  };
>
> --
> 2.7.4
>
