Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0062CC433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Nov 2022 16:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiKPQSV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiKPQSJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 11:18:09 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA1356EC2
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 08:18:04 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r18so17098632pgr.12
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 08:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bd0COEi28GaR5qVUIh2S/Ew7aeN34DlRxwUBGbg/CGY=;
        b=hlLacOTftqqiUGenMMy9GE95nEg0etFTC7acSnh0jvkPVprvV5tr8kdtKIW2oMVd+5
         97RAU7aQL2jdtWnVvnBdivgsnSbKprd9tRFmWylZU6K0eogQBw69sF7eqOqxtDZlUJsv
         YJnsJnma5RqtIbnyHnhSMOVvEgDoBwhZjgeXMG25HZleYN8v6sBDP62rGGr5SQ1cI9J4
         sWHxnFSLHaKSOfVBTvvIih0CgRwBCg8G9obrDV2H8rbveeDb3PnKL+3gseDglfxRPIvS
         pG5C4Pxc02qyZ725b28c5j8Z44E7S8gZEGQ878KGc/rpoThzfrRQYXL67YW4LXPGmdvy
         sXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bd0COEi28GaR5qVUIh2S/Ew7aeN34DlRxwUBGbg/CGY=;
        b=7uYrt12ihh1VlHt7zChNRmuneBBjG2XgSaT64FPCt5QrSHOeQkmPnzmkU8ou7Cqhhc
         TxUly7o9mN/DAaUn2PhA17l1rmjn8lIG24du8zNK/NEqVVXhplthXHLNGP0eRoqwK61o
         vsZGtGTNx1TBFkBhWE2ru4T/5/we5UgM5Efcuq3CEicf01HrwywUMN6uZE0Z+cMGqUHi
         NswpWBBKXnLzLVJZXy4d7LYdyZsCDbPB1ypIFX1o0niLzufh+YdhvvZFI6QkDNYokKUg
         QEytZRFNR+MfAWNjuDzjK70eNyroIrTJfRnVE0b6lgkNTqUjro4QXLznSwZiJ2qQO/nD
         BGvA==
X-Gm-Message-State: ANoB5pkOdIWaGrPql9/Yv6gFW8MZeCGJetY4T7bfa+tXQKUOGKVfNzVE
        49JpDd901lz+WM3fsuZlVDAfEYNgnEEnzZwO0/0mKFLy9lA=
X-Google-Smtp-Source: AA0mqf6II4S+jJ+0aJrXQHZ7x+CchFGfz3DhyJ/x2Hwvs+TvhBY3ALOAgQ2AzXc+COvAgCGGoML02axiB7Si+QUGQ04=
X-Received: by 2002:a63:5b12:0:b0:470:18d5:b6a3 with SMTP id
 p18-20020a635b12000000b0047018d5b6a3mr20632190pgb.541.1668615484318; Wed, 16
 Nov 2022 08:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20221109133539.3275664-1-yangyingliang@huawei.com>
In-Reply-To: <20221109133539.3275664-1-yangyingliang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 17:17:27 +0100
Message-ID: <CAPDyKFoBB6AVo5hWAtBq8sdHQmgnUBeKpU=T6aopaR4BuXuC1g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: fix return value check of mmc_add_host()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 9 Nov 2022 at 14:37, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> mmc_add_host() may return error, if we ignore its return value,
> it will lead two issues:
> 1. The memory that allocated in mmc_alloc_host() is leaked.
> 2. In the remove() path, mmc_remove_host() will be called to
>    delete device, but it's not added yet, it will lead a kernel
>    crash because of null-ptr-deref in device_del().
>
> So fix this by checking the return value and goto error path which
> will call mmc_free_host().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 012aa85489d8..b9e5dfe74e5c 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -2256,7 +2256,9 @@ static int mmci_probe(struct amba_device *dev,
>         pm_runtime_set_autosuspend_delay(&dev->dev, 50);
>         pm_runtime_use_autosuspend(&dev->dev);
>
> -       mmc_add_host(mmc);
> +       ret = mmc_add_host(mmc);
> +       if (ret)
> +               goto clk_disable;
>
>         pm_runtime_put(&dev->dev);
>         return 0;
> --
> 2.25.1
>
