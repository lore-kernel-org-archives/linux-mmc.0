Return-Path: <SRS0=mNiq=AR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BD4C433DF
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307C120715
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uwd9QsHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgGFOt1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbgGFOt1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jul 2020 10:49:27 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569BBC061755
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2020 07:49:27 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id v1so20724831vsb.10
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2020 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fEE00lTxrbosdgIqIaqvUZI5lzQxeJC3uSrMdVGgH3c=;
        b=uwd9QsHx+hRawr7wbADUBvTDIvaEER2HMGv6b9WUptMf6iXVzo22U95mZQtdhq3SEL
         PZmHdPbMf7eS9ZMgkgnel/6Imc/Ty9Qs48CLmE0rC/41Mb4Pu7+HInvid1G1P3YDsRet
         aepYkrU0R3o/H37avjYFQbgmjoujgtJxz9i10YAZkpPgTc6X8rsSMLcUOKKYehrIdyvT
         Ql+vvIpoYrQp3gbZ1pkMnPWp9Cd/4Dmtm/YaiibIE5G/3u8OzwHFiYBXBc6DdaZzlQNB
         jLr9OBV4IwdSIa3qYdI4kaRU3MzHTO+fquVaa2kHBJMoEyuNpi88rcHNs/kgxGeXZDUv
         qHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fEE00lTxrbosdgIqIaqvUZI5lzQxeJC3uSrMdVGgH3c=;
        b=NnCRgq5ohiRihbix+mSYwyVmy9mImjFoN/uvr/pH8q6D7Fw8mXFjiUVJwpV87D1mlA
         fGAwTVxdcjcY9Nm7La1OFeTCmgfNGJtpf9bSvKbfEaoWa1iR3hHqrTrLOEdf9lkytLyZ
         6ow5erLxt63xx5Hsb4SuINtY5u4bzWMuMf+AzYNZhTkQQEmS3h9/5ZRGVy3vru6fnEcT
         kOp/8uob1ZHs8A5WwROx5AAR2Lol3qM4OdigsUhxbdHWmYHhI+IQovCI1qNYGyYO3ose
         tkEd+P8ZuxAJ/yMTm5hJFOn/HzvxqhG9/JbU3c7UFmL68NnyLdDFdTWxbCApOJ3gF04i
         +JBg==
X-Gm-Message-State: AOAM5321jgzZVMbLmC09w5tKSr/C9+hT5NKmykY3rp3vziehfsqDMEwC
        rZPKcatlMtlA/e4xi+48KinQRnZugb47Ha1M8boIGKtkVLY=
X-Google-Smtp-Source: ABdhPJxuUfHrM/YTSR1hVzXVVwk3ONsflJzRm5iISRLnO8jS/qXJkwuvAeWFCAS2pvPF43fihBlAw8aCgbv3ZZvugNs=
X-Received: by 2002:a05:6102:126a:: with SMTP id q10mr18464626vsg.35.1594046966597;
 Mon, 06 Jul 2020 07:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200618080321.16678-1-geert+renesas@glider.be>
In-Reply-To: <20200618080321.16678-1-geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Jul 2020 16:48:48 +0200
Message-ID: <CAPDyKFq2BV72hqqW0P0d+=+8Hy4oONhYc2gAf7U9nCvUfYxedA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sh_mmcif: Use "kHz" for kilohertz
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 18 Jun 2020 at 10:03, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> "K" stands for "kelvin".
>
> While at it, make the spacing before units consistent.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sh_mmcif.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 7e1fd557109c0476..9f53634aa41184c8 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -191,9 +191,9 @@
>                                  STS2_AC12BSYTO | STS2_RSPBSYTO |       \
>                                  STS2_AC12RSPTO | STS2_RSPTO)
>
> -#define CLKDEV_EMMC_DATA       52000000 /* 52MHz */
> -#define CLKDEV_MMC_DATA                20000000 /* 20MHz */
> -#define CLKDEV_INIT            400000   /* 400 KHz */
> +#define CLKDEV_EMMC_DATA       52000000 /* 52 MHz */
> +#define CLKDEV_MMC_DATA                20000000 /* 20 MHz */
> +#define CLKDEV_INIT            400000   /* 400 kHz */
>
>  enum sh_mmcif_state {
>         STATE_IDLE,
> --
> 2.17.1
>
