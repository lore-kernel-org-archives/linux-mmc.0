Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62183EB64DA
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Jul 2023 09:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbjGNJuU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 14 Jul 2023 05:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbjGNJtr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Jul 2023 05:49:47 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD4B3A98
        for <linux-mmc@vger.kernel.org>; Fri, 14 Jul 2023 02:49:41 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5701eaf0d04so15044567b3.2
        for <linux-mmc@vger.kernel.org>; Fri, 14 Jul 2023 02:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689328180; x=1691920180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pVRCcYI6KU6X2B0QhZtXZV8P/Bq4K8WpsLsWqaeiYCY=;
        b=gckjdvJRp7dj9kX3fVv1PBsM74FxOMPv7eGl7UHbw1mKUmPJBuLDyZ1FAr4eVA4o1v
         rBibOLpivXX/JCTEEjCrpLdnqJsMYOsn1FzkSTAV6okwfMODHbpyTON+1Az87iHfHJsY
         XPB8k6zzS738KAS9EG9otMF5gcnA7YktUltPe2QFwij/5nvM4gtlTxtbEkPrVivZL6wC
         6xk8Lk8n1YZlmXpMwFurWfGRESRMaQZeX2TtzW0d89Z+/A905x2Pbez3JAAyDBpSVRHK
         RzCadUngjUi5FP5+Q3XE/Tclu+hIAVzQ5QBTYthZ9FeJ2qP06Oydu9Cl/kJC+5oFmjtF
         i3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328180; x=1691920180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVRCcYI6KU6X2B0QhZtXZV8P/Bq4K8WpsLsWqaeiYCY=;
        b=iPru9KL4uTFGj4fSMNxh4IWSSwTR7QGeiY3RMutq3bvWtyEXdacDQ9LJ21iFZd5Onh
         03AU32PbLBAPWysouUtiwqdsabVJ+OGdi1M0iMvOwRlxj+Bc2bO4dqV5tK84472gkZyG
         7D0YiNcvCjLVBhEK6bLeimd964z4bTSoRl7BLKsiXs30t2wTOYnKMEcVC54ivJ8Q0E/m
         wQeArZUeN47SC8ZAVSRJNIWLMFblHUJs1bPSiw2EZG1sucLKGwaMTDWE0K5pylv1oeHC
         PNnHIp9I0uVX/QwkH8yHsU6QwpqQ042664hTVrhT7LV42DStOXuH0sakjkZ56xnPtt/I
         mxOw==
X-Gm-Message-State: ABy/qLa0oecnw8+SVvv/sXs6F8mTHKEzE93++KWq9wvUVSfE45sTd/n4
        snrWDZ+BNDoH0Ylq5WE8mWrs2YyR8AidGH6eRBmQyrm31PtD8YVE
X-Google-Smtp-Source: APBJJlFca572uyzN1V9nYArOEOjIGhR/em7iLkLtW0EDTtrrbLU4GkrmLpU04a4+yN1UuV1I+6cTxksR5yc7sbgM3ww=
X-Received: by 2002:a0d:eec3:0:b0:577:3fb4:f245 with SMTP id
 x186-20020a0deec3000000b005773fb4f245mr4757025ywe.19.1689328180403; Fri, 14
 Jul 2023 02:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <8b57db8d-1d3a-883e-eb8f-ddf15f19d823@gmail.com>
In-Reply-To: <8b57db8d-1d3a-883e-eb8f-ddf15f19d823@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Jul 2023 11:49:04 +0200
Message-ID: <CAPDyKFpUV=Ko5J1nQOgZGYJUuifMFGYe_xwBJtK3zkFNFQ=GRA@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci: Make SDIO irq truly optional
To:     Julien Delbergue <j.delbergue.foss@gmail.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        brgl@bgdev.pl
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 13 Jul 2023 at 11:31, Julien Delbergue
<j.delbergue.foss@gmail.com> wrote:
>
> The following error is printed on Logic PD's DA850 EVM:
>   davinci_mmc 1c40000.mmc: error -ENXIO: IRQ index 1 not found
>
> Depending on the board, the SDIO interrupt may not be present, so use
> the correct function to reflect that and prevent logging an error.
>
> Signed-off-by: Julien Delbergue <j.delbergue.foss@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 7138dfa065bf..fb686c0d171c 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1257,7 +1257,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
>
>         host->use_dma = use_dma;
>         host->mmc_irq = irq;
> -       host->sdio_irq = platform_get_irq(pdev, 1);
> +       host->sdio_irq = platform_get_irq_optional(pdev, 1);
>
>         if (host->use_dma) {
>                 ret = davinci_acquire_dma_channels(host);
> --
> 2.34.1
