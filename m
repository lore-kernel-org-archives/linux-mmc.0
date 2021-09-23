Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A6BC433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 18:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30323610C8
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 18:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242799AbhIWSPS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242855AbhIWSPC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2021 14:15:02 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D755C0613E7
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 11:13:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b15so28619015lfe.7
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 11:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EU9IPP096OeclFzFMM2Ay6h5ady4PhP3HzR9YloYxzA=;
        b=hUqI2ov2NiUzTKqx3J7nQLUSavcjKJdrwXscXXPegZOM38uXJGByC9gzUlpVCQ1eY6
         yob7s8ApRkuoLTuE75uwg8VXagYviziVattKKFwjFweM2pWRVBeJGyCz90l1gUj+GlzD
         Bkiq0A2Y9ZhYT4GnidJq+ZJxfORVovrYPUhDbpeXMrfi0mzR06/AM1aSQvyzZsSTB/L5
         qjTs9AH92IeIRoVhkUOz4d3jFye3c6fIYGDraAlT3HiKyJ9RrTu0+S9v698YkeAXh7Q5
         Ih9aMm+jVr6AC9iHbDSPpAFfkoFp0K9D1JxTnykKEPXl+JHUtQTC4R+wHbCfPKxUnpXy
         UQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EU9IPP096OeclFzFMM2Ay6h5ady4PhP3HzR9YloYxzA=;
        b=UjvUE159Oike7YGvsY3EC8E3QNbyDlAz/ubiwM50xNcqS5jJObq05lLcXgD3L7wqo0
         V4iIegqyKG7FgiRVSuCFXTPDNRQkJW3dUNkL4liGUWm31/0GsmL+UWsII/A2ZxO72gci
         rx7y5eX1qyrynwKUC4D/f4mMxzWlCvgwMAAarCVqMVmKVp7IapypxDXmMNU9wl9EhzED
         H06N+0FBiRC6d0ajIlFidAclEANPAfGhnYn+ifvMJvC2UnvctImPd/O1LW/VRFnRg5eS
         KM8n9uTtoDOEBlVr4Sx1Jfa0CbfDXvMazYrDiAyaLGZLVD+E4GT9BgGFLOW54KAiDVCK
         f0NA==
X-Gm-Message-State: AOAM530kJXJamk5Sg5Jph3mYpr5lRAhUw/mnTR71kelnXoPCg8x13IC2
        cmAojaZUYqNSFGW/hGvLQduwKp6pzf2BJZRfMsxktA==
X-Google-Smtp-Source: ABdhPJwdKxAIFgqFT76MuUcfsk2unbcW2af2CnUcD2lkSYJnkndGJ0sNbrvI2hqv9sK4stP3MupDcAVmXSRtsYQvC2c=
X-Received: by 2002:a19:6a16:: with SMTP id u22mr5421205lfu.254.1632420794094;
 Thu, 23 Sep 2021 11:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210916181808.2399-1-xiongx18@fudan.edu.cn>
In-Reply-To: <20210916181808.2399-1-xiongx18@fudan.edu.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Sep 2021 20:12:38 +0200
Message-ID: <CAPDyKFr8nkVCQB63rZ6ZcHeTrmQno7aYv2Pa3PmZwzW9Ei3HDQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/mmc: fix reference count leaks in moxart_probe
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Sept 2021 at 20:19, Xin Xiong <xiongx18@fudan.edu.cn> wrote:
>
> The issue happens in several error handling paths on two refcounted
> object related to the object "host" (dma_chan_rx, dma_chan_tx). In
> these paths, the function forgets to decrement the reference count of
> one or both objects' reference count increased earlier by
> dma_request_chan(), causing reference count leaks.
>
> Fix it by decreasing reference counts of both objects in each path
> separately.
>
> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  drivers/mmc/host/moxart-mmc.c | 38 ++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index 6c9d38132..b5aa1010c 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -606,7 +606,28 @@ static int moxart_probe(struct platform_device *pdev)
>         host->sysclk = clk_get_rate(clk);
>         host->fifo_width = readl(host->base + REG_FEATURE) << 2;
>         host->dma_chan_tx = dma_request_chan(dev, "tx");
> +       if (IS_ERR(host->dma_chan_tx)) {
> +               if (PTR_ERR(host->dma_chan_tx) == -EPROBE_DEFER) {
> +                       ret = -EPROBE_DEFER;
> +            goto out;
> +        }
> +    }
> +
>         host->dma_chan_rx = dma_request_chan(dev, "rx");
> +       if (IS_ERR(host->dma_chan_rx)) {
> +               if (!IS_ERR(host->dma_chan_tx))
> +                       dma_release_channel(host->dma_chan_tx);
> +               if (PTR_ERR(host->dma_chan_rx) == -EPROBE_DEFER) {
> +                       ret = -EPROBE_DEFER;
> +                       goto out;
> +        }
> +        dev_dbg(dev, "PIO mode transfer enabled\n");
> +        host->have_dma = false;
> +    } else if (IS_ERR(host->dma_chan_tx)) {
> +               dma_release_channel(host->chan_rx);
> +               dev_dbg(dev, "PIO mode transfer enabled\n");
> +               host->have_dma = false;
> +    }
>
>         spin_lock_init(&host->lock);
>
> @@ -615,15 +636,7 @@ static int moxart_probe(struct platform_device *pdev)
>         mmc->f_min = DIV_ROUND_CLOSEST(host->sysclk, CLK_DIV_MASK * 2);
>         mmc->ocr_avail = 0xffff00;      /* Support 2.0v - 3.6v power. */
>
> -       if (IS_ERR(host->dma_chan_tx) || IS_ERR(host->dma_chan_rx)) {
> -               if (PTR_ERR(host->dma_chan_tx) == -EPROBE_DEFER ||
> -                   PTR_ERR(host->dma_chan_rx) == -EPROBE_DEFER) {
> -                       ret = -EPROBE_DEFER;
> -                       goto out;
> -               }
> -               dev_dbg(dev, "PIO mode transfer enabled\n");
> -               host->have_dma = false;
> -       } else {
> +    if (!IS_ERR(host->dma_chan_tx) && !IS_ERR(host->dma_chan_rx)) {
>                 dev_dbg(dev, "DMA channels found (%p,%p)\n",
>                          host->dma_chan_tx, host->dma_chan_rx);
>                 host->have_dma = true;
> @@ -664,8 +677,13 @@ static int moxart_probe(struct platform_device *pdev)
>         }
>
>         ret = devm_request_irq(dev, irq, moxart_irq, 0, "moxart-mmc", host);
> -       if (ret)
> +       if (ret) {
> +               if (host->have_dma) {
> +                       dma_release_channel(host->dma_chan_tx);
> +                       dma_release_channel(host->dma_chan_rx);
> +               }
>                 goto out;
> +       }

You are right, that we should call dma_release_channel in some error
paths. Although, the above looks rather messy to me. May I suggest
that we add the error handling below the "out" label instead. Along
the lines of this:

if (!IS_ERR(host->dma_chan_tx))
     dma_release_channel(host->dma_chan_tx);
if (!IS_ERR(host->dma_chan_rx))
     dma_release_channel(host->dma_chan_rx);

>
>         dev_set_drvdata(dev, mmc);
>         mmc_add_host(mmc);
> --
> 2.25.1
>

Kind regards
Uffe
