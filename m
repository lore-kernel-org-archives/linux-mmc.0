Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29072C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 11:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F306561994
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 11:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350349AbhI3LQT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Sep 2021 07:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350271AbhI3LQT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2021 07:16:19 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95776C06176C
        for <linux-mmc@vger.kernel.org>; Thu, 30 Sep 2021 04:14:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z24so23605074lfu.13
        for <linux-mmc@vger.kernel.org>; Thu, 30 Sep 2021 04:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJy8rE6zmEhX4hcf3qv1ndfW23x/yb8hlbRxX9xSBaQ=;
        b=R5J4RI2sYKFf8FYhkRoaK32Tdo16lFEKm1T/3FfArpim46zwaKeh0TMMKc6bFs4xqO
         QFW+JsKdiqNvwwMrD1jsIa2ifbm0j71PHYVFKqNpiHopXAFJJ88Jf7F9oNidx87Ok6Nv
         jgOwfILRJ5iZe92YLcvW8fgpVvaBnMvIA1u412AJRgA+Fq197mZVwUDi6+rE03JwSkje
         ZCrHjISvrrOzibauqAb0fEq2tZHkT2gczuWFexa03Ote/Seustcs5gkE1TM2RN5ew4HA
         8XzN+vXi5qDgvD8kH5Fp3/V6Tzj2CEL8SG0YQ3DctOslJBC5fTGjVzO9YZr8Smj8cNcn
         P/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJy8rE6zmEhX4hcf3qv1ndfW23x/yb8hlbRxX9xSBaQ=;
        b=RPI4SNThomeUsvNuloSYXkgJACOKaNIIm1PnHwqwN6sEZ+Il3a4/CqmwoSsmDQkJ3i
         HtPKf0fFu5dQD60dQ5EHo/tc6SQZx9nXw92sw8xoMPAt2u3ipVs/YYXzoSJrX1Qx5ymJ
         r+VGTME+oemZjEd/pbzUTgJiqqYFIotu6jDMZG04fgId+1dvugzeZ6UYMcl8Vq7pJrau
         O/JtrQz5aYaqbZYHSJAc9Q0smqnHXPSI4yTkNWnZy1Q03Otq/n/DDCwmCf2F1y1BR8Uo
         /sywo5/m6Pgvqb0qwQznhMZJC2+zpn/ZqxTg5+KwLo23fU1ON0y6xOGczmPLqRfY6OiP
         3Akw==
X-Gm-Message-State: AOAM531mXhedj3y9yx6y1JNj83YxatlTWtZ7EXc/y6r71/Mj0mZmP7nv
        gYIzJVxzb6e10oMpoSa2PKailmyCI7Gttd5Hyx9qHA==
X-Google-Smtp-Source: ABdhPJzpvQSrEfqijhwBTwrlWrZFBoL/UDHz6+BMY8/8tCkJScD5DKbm2x5ESqdPVMznwydRAzuroutQMCebonsSgMg=
X-Received: by 2002:ac2:4157:: with SMTP id c23mr5064360lfi.184.1633000474975;
 Thu, 30 Sep 2021 04:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210928021337.2359-1-xiongx18@fudan.edu.cn>
In-Reply-To: <20210928021337.2359-1-xiongx18@fudan.edu.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Sep 2021 13:13:59 +0200
Message-ID: <CAPDyKFobTze665JuBYYfVyXg3F9CkBVbw7A-PqBcj2WOk194Pw@mail.gmail.com>
Subject: Re: [PATCH v3] drivers/mmc: fix reference count leaks in moxart_probe
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 28 Sept 2021 at 04:15, Xin Xiong <xiongx18@fudan.edu.cn> wrote:
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
> ---
>  drivers/mmc/host/moxart-mmc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index 6c9d38132..f421be7ce 100644
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

This looks much better! However, it seems like we also need to deal
with the NULL case in moxart_remove(), similar to as above.

Kind regards
Uffe
