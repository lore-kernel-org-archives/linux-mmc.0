Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60A5C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 10:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5BF619C2
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 10:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhC3Kpq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Mar 2021 06:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbhC3KpO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Mar 2021 06:45:14 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07A3C061762
        for <linux-mmc@vger.kernel.org>; Tue, 30 Mar 2021 03:45:13 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id h34so4898334uah.5
        for <linux-mmc@vger.kernel.org>; Tue, 30 Mar 2021 03:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KA1n+JDKnSeg05rDwCgfj3wTUCCEx1+ImjZuwoLRDgY=;
        b=lqUF3G4msKNfNioFzkAXbXB/9SAof6IGX3RHcUtvUDyiOczBnzb74KMfGN73L0n+xl
         +Se0QtBcMXYJsRztsfF7UOrqpJcXMix3jUmxYGXYBwMvUjxhAosMPd0YaWls14J+9ANl
         GaK5tcXcd5mIypluCcqcK4PQy1ft21EGdDt7j5z7/IP3zhrd4qIVi8d1BhF5HblUYoZV
         MjXT4fuSXdkkda9Ww+nJ9klfpNfIQKXQgtk/swh/XaQP/z4febyDjOF4Ac1+InpHBsAQ
         bI5cCyFV0IdLGZLKKRLNSjKljsWzLSnkaLORsyASIJ86v2v/KoEQDfoAEVIh14IXUoiT
         60GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KA1n+JDKnSeg05rDwCgfj3wTUCCEx1+ImjZuwoLRDgY=;
        b=UBNt9HHitoN9KtSd6ZPwbPfn+hjYr0DXCWkPrtqep/HWIZnbRdk9scz+L3mNPJQZ9M
         cYp0cq0XDmh2dsTQd2sqE9OplYgE94SfPfUZq8SJg8E2tKamAgKONqaxjfthCwxUIvos
         +xhTZEmR7t6lg5xWGCTtBD6PkqDkTZMZH95gIQXnQmRrQz5ABVLZWrVYtseNc0w4KKTC
         9XAtwvVnSMOD26W7ytn3E2rWCwrGC3ifPMCCgJJhlRB9FWisc5kwbmlkqiR1aYky77ij
         9EFNnj39Q/uNKvOtXCZmCdg6KtlvyXgsneldJl7wElaIUkvW4dg/Ulhqa0mnzu02mR/i
         hT6w==
X-Gm-Message-State: AOAM533uEl9Hb8PHL/qytRw0sOSvG2WlJZ60ChCktefwesGZzX1Pjp8E
        eluvQZIZY+50+DBE7NIcqjw7XbR4Ec3VIBspbn0lxQtuG4kf0g==
X-Google-Smtp-Source: ABdhPJyOR+5TV2pxTV236HAkY2P9NZKgB08njxIqK1Qk0yQRhxuPkc+j+UWrnhJN6Tf+QS2H0FpObL5nq6gOoxKOZXE=
X-Received: by 2002:a9f:2843:: with SMTP id c61mr16130295uac.129.1617101112887;
 Tue, 30 Mar 2021 03:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210325192834.42955-1-alcooperx@gmail.com>
In-Reply-To: <20210325192834.42955-1-alcooperx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Mar 2021 12:44:36 +0200
Message-ID: <CAPDyKFpNB6-=35FqM=74Obv1KEDJg-XC9kgegQbCA0Q+rKT4_g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Remove CQE quirk
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 25 Mar 2021 at 20:28, Al Cooper <alcooperx@gmail.com> wrote:
>
> Remove the CQHCI_QUIRK_SHORT_TXFR_DESC_SZ quirk because the
> latest chips have this fixed and earlier chips have other
> CQE problems that prevent the feature from being enabled.
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index f9780c65ebe9..f24623aac2db 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -199,7 +199,6 @@ static int sdhci_brcmstb_add_host(struct sdhci_host *host,
>         if (dma64) {
>                 dev_dbg(mmc_dev(host->mmc), "Using 64 bit DMA\n");
>                 cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> -               cq_host->quirks |= CQHCI_QUIRK_SHORT_TXFR_DESC_SZ;
>         }
>
>         ret = cqhci_init(cq_host, host->mmc, dma64);
>
> base-commit: e138138003eb3b3d06cc91cf2e8c5dec77e2a31e
> --
> 2.17.1
>
