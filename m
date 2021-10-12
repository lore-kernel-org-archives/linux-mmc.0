Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE614C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Oct 2021 08:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C777460E97
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Oct 2021 08:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhJLIaT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Oct 2021 04:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbhJLIaS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2021 04:30:18 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8651BC061570
        for <linux-mmc@vger.kernel.org>; Tue, 12 Oct 2021 01:28:16 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so84734585lfu.5
        for <linux-mmc@vger.kernel.org>; Tue, 12 Oct 2021 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TqrU2cFlasxqkRqpiYWWW8WqiL3iPrIO9687ezTTKRI=;
        b=hJfcN/qDfclUWPP4E7Tyb36Msq1t/iAmwmHBv7DcB4/3+nOkvGPjBnpx24dfLCX14W
         4wCqaAfftoH3aRqdcW+Br6QcSjj2Jhk6KVdzqgchJRGl2zaFbumb0vfvs0xEO8HBwvY0
         zuJrnAo+kkgO1JGHW+b8PmR59LJjgzVfAa3/hZNyxorAbcYoCBOQ4KxgZoJF2X+MZ2YW
         wEjKZ+Z6e6pl/zBljPxZli2EkOQwQlFhU+KAejWJ3qTkTAT51aZ5fkbEk86sSdA3hXS9
         +icaZt4VmL+UL5PpzajC6AvDptZnzdO2u1KXeuVjPP+KUISew4C+7A0rLTBnpHPJD/36
         7Fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TqrU2cFlasxqkRqpiYWWW8WqiL3iPrIO9687ezTTKRI=;
        b=ea5Ul5GT1qrchc8DAfr09w91MvpRuc7xAvukDcwOqBe4SbLAdDmaDUrOSDHDzcVTxL
         4YGqPh0x8iMJpKLF+/3fpx+cz9Z39HAr5LxU8OjCF5djYaPoK6wD+9SZy/jz7BsCVlhp
         Kut/ueH5PnX+2mRcVHz+j75luKXtn5+YRKPY+hCZAu0RX9pJnHlXo5mbOpiDwPJsrJFt
         EpvagQXQf1My2cNhGFC4yinVs91NaaC18PsEH5fqc8adcmW4P8DprcSjABZnit3xsLJI
         hTyYfSphXMgs7Ui02eGzPhab09CLzp6qGRgCkwOe/ylXnz2lCiaifOACmWuqLZU6NkXb
         mYaw==
X-Gm-Message-State: AOAM530I/w2Prh6wc/wgBsNw81AdNKQaMzJ9AyIloExD7H5VD+V52DPH
        nxukgd8nCNyQ+Sq+3FSd4haT2yyBsdsXBr450khRtg==
X-Google-Smtp-Source: ABdhPJxgFFm23/W0H3AeChVmx6tYmbVLkmEarDtdQaV1AerU2A94yipRaSPVs1z1DCtqoWswDxAdZ7vS3zkCIYAp4ms=
X-Received: by 2002:a19:6a16:: with SMTP id u22mr31250288lfu.254.1634027294895;
 Tue, 12 Oct 2021 01:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211009041918.28419-1-xiongx18@fudan.edu.cn>
In-Reply-To: <20211009041918.28419-1-xiongx18@fudan.edu.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Oct 2021 10:27:38 +0200
Message-ID: <CAPDyKFpnQWeKdxc1oMWj+i9hBq0oqjZ9vvgXWdct+oNnR4dndg@mail.gmail.com>
Subject: Re: [PATCH v4] drivers/mmc: fix reference count leaks in moxart_probe
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 9 Oct 2021 at 06:20, Xin Xiong <xiongx18@fudan.edu.cn> wrote:
>
> The issue happens in several error handling paths on two refcounted
> object related to the object "host" (dma_chan_rx, dma_chan_tx). In
> these paths, the function forgets to decrement one or both objects'
> reference count increased earlier by dma_request_chan(), causing
> reference count leaks.
>
> Fix it by balancing the refcounts of both objects in some error
> handling paths. In correspondence with the changes in moxart_probe(),
> IS_ERR() is replaced with IS_ERR_OR_NULL() in moxart_remove() as well.
>
> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index 6c9d38132..7b9fcef49 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -621,6 +621,14 @@ static int moxart_probe(struct platform_device *pdev)
>                         ret = -EPROBE_DEFER;
>                         goto out;
>                 }
> +               if (!IS_ERR(host->dma_chan_tx)) {
> +                       dma_release_channel(host->dma_chan_tx);
> +                       host->dma_chan_tx = NULL;
> +               }
> +               if (!IS_ERR(host->dma_chan_rx)) {
> +                       dma_release_channel(host->dma_chan_rx);
> +                       host->dma_chan_rx = NULL;
> +               }
>                 dev_dbg(dev, "PIO mode transfer enabled\n");
>                 host->have_dma = false;
>         } else {
> @@ -675,6 +683,10 @@ static int moxart_probe(struct platform_device *pdev)
>         return 0;
>
>  out:
> +       if (!IS_ERR_OR_NULL(host->dma_chan_tx))
> +               dma_release_channel(host->dma_chan_tx);
> +       if (!IS_ERR_OR_NULL(host->dma_chan_rx))
> +               dma_release_channel(host->dma_chan_rx);
>         if (mmc)
>                 mmc_free_host(mmc);
>         return ret;
> @@ -687,9 +699,9 @@ static int moxart_remove(struct platform_device *pdev)
>
>         dev_set_drvdata(&pdev->dev, NULL);
>
> -       if (!IS_ERR(host->dma_chan_tx))
> +       if (!IS_ERR_OR_NULL(host->dma_chan_tx))
>                 dma_release_channel(host->dma_chan_tx);
> -       if (!IS_ERR(host->dma_chan_rx))
> +       if (!IS_ERR_OR_NULL(host->dma_chan_rx))
>                 dma_release_channel(host->dma_chan_rx);
>         mmc_remove_host(mmc);
>         mmc_free_host(mmc);
> --
> 2.25.1
>
