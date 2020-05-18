Return-Path: <SRS0=SyG0=7A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B01BC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 12:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC302065F
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 12:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ef51Q9OJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgERMqm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 May 2020 08:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgERMqm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2020 08:46:42 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2478AC061A0C
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2020 05:46:41 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id r11so1093895vkf.11
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2020 05:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6SXYknbSWZlo39yzXrKywXPYhHotTPUe8ppOdMptyE=;
        b=ef51Q9OJN6Ky1XE2CFWmx5G9H/KgUnc9nx+mJRWUeUcZ1lRm0z23d+f2NXWIIpfTkd
         EbKStZWMLyT/LJxQVESXr3KerItwrFBkUVQ4prPeKTdBEYMCv6/cVIUqQbCr3G7N482P
         VDH7FSa3ICrRt/jw0jG6GyuslN8WC9FZ+iPLAIU375wReVSMk0aYmcdI1Y+cElY/mJdC
         rDZ/jCu5CzRDpwyxjgu91RGRamvvDTZOYT6eh7sDEk8KimzpGFCN9knHQv14FsjeDUIx
         6t6BIkODpjVygtSPSf1wDw94fx4tt0T4D7dsDSfXxsMRVK62SJ8DW5/Alf8xNQYNn2Fz
         C7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6SXYknbSWZlo39yzXrKywXPYhHotTPUe8ppOdMptyE=;
        b=Z4ghucW30syinP9MehxMTuCO7nxqVdFbEYxVDzcmwzTbJgHHYvJetraEbYUQpmisho
         VIQmB+SK3EGRZoDy9QG4ynKZFZGW0ejZeqFqBDbGy9KgU0CRyPjNC/sywM99rBysW0ui
         PiooX3rlsU+ct9fMrx7tuqqwlmlZtaAiyBX0eunMTpW2z+UlU250D084rRoz8uyMobSg
         3XE9Ac4X6BxIPQhuLWIdm2lagmhIwVHnmRyYBHeKSVjLoc6ixNQo6Vah27K3hFz8oUkh
         oB0FdK64575ab2Sq/O9QbvYBCe17ygO5G1hDMIIpquAD3DG5SMa1hFAEiEV6hD35hcEA
         R5EQ==
X-Gm-Message-State: AOAM531y8UMbe9iyJ94GoovLNoejWPPQ9AN1jb80WS0eAFPmzTDMllOi
        Gxshr53x+RAow9uNB7N+NyU0xFxyAewv4hPqscTb8lfv
X-Google-Smtp-Source: ABdhPJwqTeGMr5s/tn9+V5yYUaiW2zwe7DeKH5UC4LMjmEIyNyFMb6yJWGQU912ArsXxaHqtr8BXeLj8qwKBKyVkstI=
X-Received: by 2002:a1f:25d7:: with SMTP id l206mr10736330vkl.53.1589806000276;
 Mon, 18 May 2020 05:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200518120939.1399-1-adrian.hunter@intel.com>
In-Reply-To: <20200518120939.1399-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 May 2020 14:46:04 +0200
Message-ID: <CAPDyKFqZZ91G+28TmFMg-7UwaR-dxrc6tos627uHaignC1u_NQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Fix SDHCI_QUIRK_BROKEN_CQE
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 18 May 2020 at 14:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Previous to commit 511ce378e16f07 ("mmc: Add MMC host software queue
> support"), removing MMC_CAP2_CQE was enough to disable command queuing, but
> now the cqe_ops must also be NULL otherwise ->cqe_enable() will be
> called. Fix SDHCI_QUIRK_BROKEN_CQE to do that.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: 511ce378e16f07 ("mmc: Add MMC host software queue support")

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9864e877e105..682ca8f0be8c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4131,9 +4131,6 @@ int sdhci_setup_host(struct sdhci_host *host)
>                        mmc_hostname(mmc), host->version);
>         }
>
> -       if (host->quirks & SDHCI_QUIRK_BROKEN_CQE)
> -               mmc->caps2 &= ~MMC_CAP2_CQE;
> -
>         if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>                 host->flags |= SDHCI_USE_SDMA;
>         else if (!(host->caps & SDHCI_CAN_DO_SDMA))
> @@ -4662,6 +4659,12 @@ int __sdhci_add_host(struct sdhci_host *host)
>         struct mmc_host *mmc = host->mmc;
>         int ret;
>
> +       if ((mmc->caps2 & MMC_CAP2_CQE) &&
> +           (host->quirks & SDHCI_QUIRK_BROKEN_CQE)) {
> +               mmc->caps2 &= ~MMC_CAP2_CQE;
> +               mmc->cqe_ops = NULL;
> +       }
> +
>         host->complete_wq = alloc_workqueue("sdhci", flags, 0);
>         if (!host->complete_wq)
>                 return -ENOMEM;
> --
> 2.17.1
>
