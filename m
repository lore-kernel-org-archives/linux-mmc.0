Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB585C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 22:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5BDD60FED
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 22:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbhI0Weo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbhI0Wen (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2021 18:34:43 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2334EC061604
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 15:33:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g41so83801862lfv.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I15WPZIIpocs3G+JmlLPOy9NymMqM29RVT5hOe2pQ/I=;
        b=vSDbSgUP2Di4FwmkQvN5iGnb4Hk8Cgsc/2exc8E7ZVUr8RLiXT36Nl0Eqx8GKT9CBA
         P9tcUzUWQTqnYKbbDun5StBCWZTKUDW4OwG6WZwEJg28ucGk77PR/E5ftDqrjmBf+Q2a
         DMExwu3LEynnZUE8N9O3eTZ1rzHxMx56LpMzUTnUNvcnk76ACZHjl9aXyLYUY+9jjqRi
         PMY1QpVshdG5XEYo4Kh6UOnBeT6ml+Ra1Yv6DQv6u49nui3wcEDhe6Xq4BBJrxW4zNM0
         Lmpxz95XtW3Z1KVeGh9aQJbZWscyKt50/9btqvgqL9MEEO/CQaIWCvezCHf///gzxAbM
         OyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I15WPZIIpocs3G+JmlLPOy9NymMqM29RVT5hOe2pQ/I=;
        b=5a7rqiElMBYznEEWiqyp4U6KySMsDrIENCw4YbWhSuNLs/66KJn0x/QNcwcCZ/by+Q
         qY5KkGzuiXXf88zEGZGqdwR2Okkk9ILEuMPm/l8ha3Ret4JZjM04vAgq7HovwLFoJcOj
         zUFMqNLsebi3JOKfag2n8yxqigDqpSKeMP1I/uQTp3KsD0b5OGENbvP4J/rM9WNDq+zg
         D9O7/IDBPY931RyrPF1kkcJh41iMDl+0zYjdMZNqINW7iM8rLzm6w9qgSU++aG7qxGwQ
         yB37am81L8MK4nqoshlMx2KDswxtIf//JaSgIxGSt9byly76DoLjG8MtMGUbME88rDdw
         3HzQ==
X-Gm-Message-State: AOAM531N5VrPdnHdxwWIkfUAbHUzvT0UgBpgRLnqPB6QNUzcV5iMfDqM
        tkMST2sShw/VAR7XRfjRmDbvMXfI2DJ0Fgrj9cE9qw==
X-Google-Smtp-Source: ABdhPJyxBGWiBc4Azjidi9rycgneWjrmFFuGJT4rTG0L/rzqF2tXs/eZ6AtBTZQFKQpWUQ8wE3izb/7yQauawTmc4qs=
X-Received: by 2002:a2e:898c:: with SMTP id c12mr2434278lji.16.1632781983522;
 Mon, 27 Sep 2021 15:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210927015759.30855-1-xiongx18@fudan.edu.cn>
In-Reply-To: <20210927015759.30855-1-xiongx18@fudan.edu.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Sep 2021 00:32:27 +0200
Message-ID: <CAPDyKFoeA01fy6pAcSu2qaqs9U2VcgTLSvhzvNObhhprPdDT9g@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/mmc: fix reference count leaks in moxart_probe
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 27 Sept 2021 at 04:00, Xin Xiong <xiongx18@fudan.edu.cn> wrote:
>
> The issue happens in several error handling paths on two refcounted
> object related to the object "host" (dma_chan_rx, dma_chan_tx). In
> these paths, the function forgets to decrement one or both objects'
> reference count increased earlier by dma_request_chan(), causing
> reference count leaks.
>
> Fix it by balancing the refcounts of both objects in some error
> handling paths.
>
> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

The code looks good to me! However, checkpatch is complaining about
the format. Please run it and fixup the reported warnings/errors.

Kind regards
=C3=9Cffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.=
c
> index 6c9d38132..e27ab3446 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -621,6 +621,14 @@ static int moxart_probe(struct platform_device *pdev=
)
>                         ret =3D -EPROBE_DEFER;
>                         goto out;
>                 }
> +        if (!IS_ERR(host->dma_chan_tx)) {
> +            dma_release_channel(host->dma_chan_tx);
> +            host->dma_chan_tx =3D NULL;
> +        }
> +        if (!IS_ERR(host->dma_chan_rx)) {
> +            dma_release_channel(host->dma_chan_rx);
> +            host->dma_chan_rx =3D NULL;
> +        }
>                 dev_dbg(dev, "PIO mode transfer enabled\n");
>                 host->have_dma =3D false;
>         } else {
> @@ -675,6 +683,10 @@ static int moxart_probe(struct platform_device *pdev=
)
>         return 0;
>
>  out:
> +    if (!IS_ERR_OR_NULL(host->dma_chan_tx))
> +        dma_release_channel(host->dma_chan_tx);
> +    if (!IS_ERR_OR_NULL(host->dma_chan_rx))
> +        dma_release_channel(host->dma_chan_rx);
>         if (mmc)
>                 mmc_free_host(mmc);
>         return ret;
> --
> 2.25.1
>
