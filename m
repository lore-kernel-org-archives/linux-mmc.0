Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456CEC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  4 May 2022 10:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348218AbiEDKle (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 May 2022 06:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348211AbiEDKld (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2022 06:41:33 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F5428E00
        for <linux-mmc@vger.kernel.org>; Wed,  4 May 2022 03:37:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p12so1591975lfs.5
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2022 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXrHNwJC3BAV97iHU4og2HGxITVvzbeFV0KAKwYw/nI=;
        b=QTTdNNHxLgnl1v1dobnNNIk2xfsStVyPHrDEqovPV2KjeX8NQrpD0xCiZDb/x3oQFO
         LwKab/3vcamG1Nv6zhbuJiDlW4+pPxM3ynh8drc2LqBHXvAv6MztHHfeE/ns5yaBcZ0m
         ulSKV5CPTLVaKIjvaQVWxxIlfzvJRF/Uh2rF3/Bix5DaZoaJmUrMOtxjQHotAWoS9C0C
         yMc45JdckmSKuo9Qs4Xc/Y8Snz1ODJbFq2UBiN04hBiv9SeOHOW79fhgHqQIlsLUpy76
         6YLE3CxLBLsbYrToQL/1cLrNt7caLUc0XrHTiBAF90VQDXWsOGw5Vphlk7rIPgDPcGVl
         Jseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXrHNwJC3BAV97iHU4og2HGxITVvzbeFV0KAKwYw/nI=;
        b=l5ch++MO4KqK9wBs8Lv7HTeHNuki4oO2Gh9GWtsRqc/PD7EjJjwtXk8EV8UvOZUKSe
         UeDj8koRtnP67YaCpZcr3j0Q+RixWb/HE4xDRItrTWPOVrwilUIxNXfFEtc0NETPyzFS
         2X77+3J1IphXm9Rcp0KXS9/d9E9LmBcMyQqo+c2d0BFZLBWJ0sPjZL/g6AaoUSun33D4
         yuoAs0M34MuTsglonM36oXzmp64cV7Q86B9z/DJ8jLJsdX5KhdNE6/nY5c0dGdO0sqPV
         Cgl8M2O1FqXWwS5kbBkoEIzhbivs/5Pq4hsl+pF6rsRyThsKGhdx5caFA3IABHx0nZeV
         tS/A==
X-Gm-Message-State: AOAM531fq1CXD8GSRfrctV1cITtefBJn7KCHVQVCiI9miOzKD+dZ6pLp
        HYkKAatR/wnC7mIyq+ljapLXMFipAQS7hsvm9jY69fVSqns=
X-Google-Smtp-Source: ABdhPJyvrZpc1dvJUHpgzPqhSF7EzFjSFbIrL2BjM/E8E9i49RX6cCpueU1FHEwqnwkLycU6waf9TfwywbIR9IY7q7k=
X-Received: by 2002:a05:6512:5cb:b0:472:f7e:a5f5 with SMTP id
 o11-20020a05651205cb00b004720f7ea5f5mr13185193lfo.358.1651660675327; Wed, 04
 May 2022 03:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220425105339.3515368-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220425105339.3515368-1-chi.minghao@zte.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 12:37:18 +0200
Message-ID: <CAPDyKFporsmucBfHWN4vuBTmGNFKM028K6AWZu9k2rAb2cfZRw@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: use kobj_to_dev()
To:     cgel.zte@gmail.com
Cc:     axboe@kernel.dk, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 25 Apr 2022 at 12:53, <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Use kobj_to_dev() instead of open-coding it.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index b35e7a95798b..983151b7296d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -330,7 +330,7 @@ static struct attribute *mmc_disk_attrs[] = {
>  static umode_t mmc_disk_attrs_is_visible(struct kobject *kobj,
>                 struct attribute *a, int n)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
>         umode_t mode = a->mode;
>
> --
> 2.25.1
>
>
