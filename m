Return-Path: <SRS0=wlIT=6I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFD9C2BA1A
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Apr 2020 10:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1848C20767
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Apr 2020 10:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VpecBWsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgDXKKO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726614AbgDXKKO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Apr 2020 06:10:14 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0876AC09B045
        for <linux-mmc@vger.kernel.org>; Fri, 24 Apr 2020 03:10:14 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id t8so8864012uap.3
        for <linux-mmc@vger.kernel.org>; Fri, 24 Apr 2020 03:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/7X2G22ItV4Y4N+eb7B9/IPLptDWVPPgxbfXxVm6c0U=;
        b=VpecBWsDHCHHO0gD9i2Q+wOtC/bhPUTbFJumSZmGKAPLRyGV0WQNt+0aw3Fzkvd6Ky
         YNnA3xcIN+JKDZPwlTndqmO/W3+X8T5EaIskhnIvK0+od9Dh2G1TpQoC2ex4NIFslEOK
         wyph8U4lQiPX/EY1u7sdflAgmOPiWwOUC5I4uyYHIqebMO8tKeOL7F2+/v9KhWLuUlzp
         NE9K5KuDRaimnnq1rVRW40PPCD+1dh4R6OYSlpPJAY32uxr2mOz79SVJP6ttVM5dm6cn
         mf2rknK5IJWHhSWj3Gw8nyJLC3+q6iIszJNoLq7J7Ld+CRf3RvsCM8heQx0RJFLLcvN9
         KAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7X2G22ItV4Y4N+eb7B9/IPLptDWVPPgxbfXxVm6c0U=;
        b=pH65nW1XX8RDpBExXppbD1gm2oQJ7wFwT/f+btAhPYOUYel0Ixv2UAMm+Z8QBJNbp+
         QJD/8vj/chOl8oHBC3nZjItZ4EoXR7PN7ozTxdu6696rD+2ABx/rhWy60Zzn2xGwvY00
         E3a8HsLaEQJ4eEizhvWMA8fXIi5l8peE1oGC7j2Q8F+5vQsoaAoWPiTB6JaACqyRMNg+
         NKMKdHkqvprZ2vmKVGgP5K/rpNlQaN5tnQhLPOulNODtQjgzAY7on4icuy6pgsTxaefE
         GGT3Z2qVKvLpOQl9pLgLFifXgN7RmSQXg5k3QweidaPn7JdWP6jeRWGwrn/srdjDLlCD
         PV4w==
X-Gm-Message-State: AGi0PubxtpqVj8NiokOpppestjNujB+pgqzmoRaw9lwCw4tB1lCkcUO8
        oBxMiysaXnCPeHm0NjmYV7JQiwuM4FSWCPfThbu4mg==
X-Google-Smtp-Source: APiQypKPFxKbTuswyzazMAoKTL41AiVtC3nWpHcWL/JgaZTTZJKmyutS6k++bDb6ybJle6h4nW9ENAd6LSnZ1BI5+xw=
X-Received: by 2002:a67:8b46:: with SMTP id n67mr6857957vsd.35.1587723013211;
 Fri, 24 Apr 2020 03:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <1586835611-13857-1-git-send-email-yong.mao@mediatek.com> <1586835611-13857-2-git-send-email-yong.mao@mediatek.com>
In-Reply-To: <1586835611-13857-2-git-send-email-yong.mao@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Apr 2020 12:09:37 +0200
Message-ID: <CAPDyKFo40tBpowmWN3gxH8b=jMmCK8O5ALNQ7y6XZ5AosX=GUA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: core: need do mmc_power_cycle in mmc_sdio_resend_if_cond
To:     Yong Mao <yong.mao@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 14 Apr 2020 at 05:40, Yong Mao <yong.mao@mediatek.com> wrote:
>
> From: yong mao <yong.mao@mediatek.com>
>
> When mmc_sdio_resned_if_cond is invoked, it indicates the SDIO
> device is not in the right state. In this condition, the previous
> implementation of mmc_sdio_resend_if_cond can't make sure SDIO
> device be back to idle state. mmc_power_cycle can reset the SDIO
> device by HW and also make sure SDIO device enter to idle state
> correctly.
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> ---
>  drivers/mmc/core/sdio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index ebb387a..ada0a80 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -546,6 +546,7 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
>  static void mmc_sdio_resend_if_cond(struct mmc_host *host,
>                                     struct mmc_card *card)
>  {
> +       mmc_power_cycle(host, host->card->ocr);

This looks wrong to me. mmc_sdio_resend_if_cond() is called from two places.

1. In the case when mmc_set_uhs_voltage() fails in
mmc_sdio_init_card(), which means a call to mmc_power_cycle() has
already been done.

2. Wen sdio_read_cccr() fails and when we decide to retry the UHS-I
voltage switch. Then perhaps it could make sense to run a power cycle.
But if so, we better do it only for that path.

I will continue to look a bit, as I think there are really more issues
that we may want to look into while looking at this piece of code.
However, allow me some more time before I can provide some more ideas
of how to move forward.

>         sdio_reset(host);
>         mmc_go_idle(host);
>         mmc_send_if_cond(host, host->ocr_avail);
> --
> 1.9.1

Kind regards
Uffe
