Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF83C433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jun 2022 12:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353080AbiFAMrA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jun 2022 08:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353094AbiFAMq5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2022 08:46:57 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766B665BF
        for <linux-mmc@vger.kernel.org>; Wed,  1 Jun 2022 05:46:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a23so1860122ljd.9
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2022 05:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dK+WD5XiJYQao1gUbsLI8WBYkfdO7ClJ9IlBjdNlTYU=;
        b=Uf7e90gAF6tfZ96DnpWUuAKw5ev4Z0NSuKKA/kridTFVTdm3T8hGPr5dpfI9oXQ9O0
         4ahYXu0ipWBqR7Kef0IF8GnElxVp1Vw6sXwinHkLSPebgK1m3kOd9NnQcpX93y5EuWSR
         H7tN0HnLcj75vjyXpmkTlWGGQF2qrrToaPBcrCsVS18E60+F1L0r/gHpyCdjbLquvcHf
         izx2wd1YunKDJ3QYyTf3Lz/cE4fFp4HS0pIjqXx1yUYs+AwS76NTBHlcVcvBkMtWOrYo
         agX4+HAp+AvWl3IoM4scat8hKabUr+cQxMeom19c9avYQCYKiFdC3+qdYBxQfdvg1Pgo
         wGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dK+WD5XiJYQao1gUbsLI8WBYkfdO7ClJ9IlBjdNlTYU=;
        b=Wr1Z7pGJ1mWgg82UTSNXdvZw7ve9d5h2//8lzhFVVRTicMFZSDT+4sgOe6cT6Gopwx
         XqPDCDdTWAUmJBK1w+C/Yddg6S7ZG8g+XRTf+zo/x0UH+TllJ4IdPMwkuwbqLic8FmXz
         YWCIFX6CY4mY0VKrX6G6boGdOyYNSi4cCWa9jaR6lm1JlLw7mZ+6mGcDHxl2jDe/IGdS
         Sg1MngLaNhtT7/YSqZf8/ssn5oBqL/FJZ0MMzVy1jpaZsEMm7QUibYk5uD3cvY6pcjKt
         qdNpE/z0vsUFQc5ToX+iVXlZ2NHSLD0tXpKpGjmm0WqEtlZfmB2VaOzPzYfGokKoUIUS
         qKZw==
X-Gm-Message-State: AOAM530h7fcTisznyLfNKSW81PxcLhDO5lYxGwloLKMnbyMh+kClq2pW
        6a4QWvSScCkiq4xzkS/Z1zAA7XZib1TFqwLiRaReKQ==
X-Google-Smtp-Source: ABdhPJyVYivIyiBvSw8561fRU3HvL0Vkat8jPG14fKrabPQJT84ju1r6Ld9N3qe3Y7BV3RYbe++o/QzuTozjXT/zbH8=
X-Received: by 2002:a05:651c:a04:b0:253:f0b4:a406 with SMTP id
 k4-20020a05651c0a0400b00253f0b4a406mr26277427ljq.4.1654087613842; Wed, 01 Jun
 2022 05:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220526010022.1163483-1-festevam@gmail.com>
In-Reply-To: <20220526010022.1163483-1-festevam@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Jun 2022 14:46:17 +0200
Message-ID: <CAPDyKFqzwkvAz5W-UnS06EwGnDBW-kTcO4D20WbPFakz8SK5+A@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxc: Silence a clang warning
To:     Fabio Estevam <festevam@gmail.com>
Cc:     nathan@kernel.org, linux-mmc@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 May 2022 at 03:00, Fabio Estevam <festevam@gmail.com> wrote:
>
> Change the of_device_get_match_data() cast to (uintptr_t)
> to silence the following clang warning:
>
> drivers/mmc/host/mxcmmc.c:1028:18: warning: cast to smaller integer type 'enum mxcmci_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 8223e885e74b ("mmc: mxc: Convert the driver to DT-only")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Queued for v5.20 on the devel branch, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxcmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index de04b5afef2e..613f13306433 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -1025,7 +1025,7 @@ static int mxcmci_probe(struct platform_device *pdev)
>         mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
>         mmc->max_seg_size = mmc->max_req_size;
>
> -       host->devtype = (enum mxcmci_type)of_device_get_match_data(&pdev->dev);
> +       host->devtype = (uintptr_t)of_device_get_match_data(&pdev->dev);
>
>         /* adjust max_segs after devtype detection */
>         if (!is_mpc512x_mmc(host))
> --
> 2.25.1
>
