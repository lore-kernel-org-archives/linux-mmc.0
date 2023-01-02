Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4EBC4708E
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Jan 2023 15:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbjABPIR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Jan 2023 10:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbjABPH6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2023 10:07:58 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E971D9FF3
        for <linux-mmc@vger.kernel.org>; Mon,  2 Jan 2023 07:07:49 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b2so29760157pld.7
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jan 2023 07:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q4eiz17zYWFcsLU8LgZ3JmmwVszEJijgO0C7KmiFnMo=;
        b=Acy33xnC3xVDiC8hpliYuEApI7KuDFSSfMVLsLQY3yhw6ReV6ZP4EVhieSuOR31xpY
         8wj6SXn3tRtu2U7+UXNfmIzQa11PDycs8RruXRcao+LfG99oH+5nxm8ptn04ScatAPTs
         iwArRP4nTN0VOr6bo+q9Yhx/Y3Rp4qncW/5RLDX9UZ5n1W1lR309JPaAzHXaua97jvtw
         IxBYMvJ22tX0Yw8cKst1ZmhrF+htOk7+VrifcdRn2QWvGisk8sqHGKKPEutocNMU3/aP
         0BvPLr6GrK5VTgc7+npbA4yzLKdY4Z8i24qlUQXMILPvuCmdLnamqyNp4gelRgXRlOr/
         XVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4eiz17zYWFcsLU8LgZ3JmmwVszEJijgO0C7KmiFnMo=;
        b=Sti/Bzgs8H59GQxTUp1Mwx+kV37NVG3SNX31R3vL4BLEkbOawgHFNi1eTHWj1/+0e6
         cVkNsnkEq1jOzgqb6uOpKPnMNXKnJz8d9CHb4iVF68iy2DCnt8kBbeg3ZpQMlPsa+29k
         2Lvvhuzm/Q9Snnqi9XnFWWmLpBMwYR12HE8906BN0JJFFQv710ZDx4gm3mB2U5ogs+G6
         XZQ5UgDsP/vzww2CrErtwH5U2ivGy/z9fVgtgx7A5lhBclqe4HNbWJdw/iBgbttEJ3er
         g89JvCFOjfZJSRKUP07WaEKhZPOw+P2LCp9W8Bq6VFMmXVdbUbMA2gFNT5WOhaLTOCVy
         p8Ug==
X-Gm-Message-State: AFqh2kp7YdPzGI1XpGzC1heG6rHy1O4za1miQi9hfY9RMVue2YbRlYLk
        RoGKb1FDIGuJYoUVdi0TIiSh0+avV5IVPvunW54ElGWuc6XOuA==
X-Google-Smtp-Source: AMrXdXsy5of6YTLqzo6ernQeH/ddTrVBG9zhDdTuJuUotle+0oU6XymxbVMV7VMWDu0HvhEkTbLqiO0R8ZJyuVRYbWQ=
X-Received: by 2002:a17:90a:c083:b0:226:6c53:fc27 with SMTP id
 o3-20020a17090ac08300b002266c53fc27mr330858pjs.202.1672672069275; Mon, 02 Jan
 2023 07:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20221228142354.28454-1-tom@tom-fitzhenry.me.uk>
In-Reply-To: <20221228142354.28454-1-tom@tom-fitzhenry.me.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 16:07:12 +0100
Message-ID: <CAPDyKFre7C1YrdJMQ10HtoVCSBm1pMT7_9xrkGAHR2jE8OHkoA@mail.gmail.com>
Subject: Re: [PATCH] mmc: pwrseq_simple: include deferred probe reasons
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 28 Dec 2022 at 15:24, Tom Fitzhenry <tom@tom-fitzhenry.me.uk> wrote:
>
> This adds a reason to /sys/kernel/debug/devices_deferred, which makes
> it easier to debug deferred probes such as [0].
>
> 0. https://lore.kernel.org/all/20221228140708.26431-1-tom@tom-fitzhenry.me.uk/
>
> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/pwrseq_simple.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index 988467fbb621..3bac1e71411b 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -119,14 +119,14 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
>
>         pwrseq->ext_clk = devm_clk_get(dev, "ext_clock");
>         if (IS_ERR(pwrseq->ext_clk) && PTR_ERR(pwrseq->ext_clk) != -ENOENT)
> -               return PTR_ERR(pwrseq->ext_clk);
> +               return dev_err_probe(dev, PTR_ERR(pwrseq->ext_clk), "external clock not ready\n");
>
>         pwrseq->reset_gpios = devm_gpiod_get_array(dev, "reset",
>                                                         GPIOD_OUT_HIGH);
>         if (IS_ERR(pwrseq->reset_gpios) &&
>             PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
>             PTR_ERR(pwrseq->reset_gpios) != -ENOSYS) {
> -               return PTR_ERR(pwrseq->reset_gpios);
> +               return dev_err_probe(dev, PTR_ERR(pwrseq->reset_gpios), "reset GPIOs not ready\n");
>         }
>
>         device_property_read_u32(dev, "post-power-on-delay-ms",
>
> base-commit: c76083fac3bae1a87ae3d005b5cb1cbc761e31d5
> --
> 2.38.1
>
