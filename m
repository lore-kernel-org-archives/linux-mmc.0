Return-Path: <SRS0=SyG0=7A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946E8C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 11:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7188A20758
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 11:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eh9JoMBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgERLYK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 May 2020 07:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgERLYG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2020 07:24:06 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49331C05BD09
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2020 04:24:05 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id c17so3305318uaq.13
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2020 04:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ihMF09VKlBBB7iEtXLgDNsN0VO2GK4psKZHbEHcxX9g=;
        b=Eh9JoMBpJXKyoYlldxMoq+oa5N0QUU44CzjatEv5ykrL04Hx5F3KLswZvR+mwI6tGn
         sqW0qwPrUIjW/XDQALITZaezfbEaf5jzx+IPgpbaresFLqcZqLa2/ppIs7evyGAbpAbS
         +4f8/kZY0fOaZcqMeuxtkxaiJ/GSDTzAhRdcWQlAXsRf7JPWWGZVDn02l+hgdc+eLYwS
         +y1p5y+Lkn5J4RSvu1fx+o4dhhehOOU8fDFZdriugaS3b7IPihJ+PRdYw9P2xACcj/a3
         JcUQN7TfaPAs3sD6rvI9bRopSXsMIBYEnV9fC9CBDXK6mSNKZDeyqc9+8wbYMhGjALfT
         wi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihMF09VKlBBB7iEtXLgDNsN0VO2GK4psKZHbEHcxX9g=;
        b=N+WG+iLWCf72Mls88U+stsB3syeHXsxMj1ry0yduj5rnSjtYxPFEMXcfLwqisDU6Fu
         uXAG0t6UFf02d/wiz36+a5WMDz9pq8Wpd+h8XQolwboHSaBc9yGYBtbiNHxnU8g2GLyn
         /IabAeOpJ3I+3ZfseonF0L76n6ys35yA3w7nF/T0Cmj+BwlA83RJvoz1tKqkHz8TNhGR
         8f/nxTNnm4/k++eZAYX4jOGARFLmVUIj9kZhzx7fHhzU9nue+qs2CkEeMrJxZIXb8T27
         Dvrl3N96qmm49rUK3WiXA+meYhC//WCUqRgFpaMtXFCwYrljydTi8VmBvMUsO17KXx6e
         9Ayw==
X-Gm-Message-State: AOAM530VnwojYkQeva9sEOvPnR3pdMiUm4RO4HlvePaiMzAe+tOgN2GM
        pEnPbUvjAUSCv+KqgPWVRcYgbjp1IYnOq6CRq7SkDA==
X-Google-Smtp-Source: ABdhPJwfQemLZ5bSu1/RpXBNHLL2sZZwNovu7aJRq0AKFUvPo6qhbafYRw9Ww3WxjuGOapLj5C0yWDsAsoMK4LMdr7Q=
X-Received: by 2002:ab0:7293:: with SMTP id w19mr10613493uao.129.1589801044397;
 Mon, 18 May 2020 04:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200517222907.1277787-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200517222907.1277787-1-martin.blumenstingl@googlemail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 May 2020 13:23:27 +0200
Message-ID: <CAPDyKFqmc53WLdsy2Wi4WYvVSNn6u=WXfN+guW8nrynqQa8PVA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: host: meson-mx-sdhc: fix manual RX FIFO flushing
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Graichen <thomas.graichen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 18 May 2020 at 00:29, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> For Meson8 and Meson8b SoCs the vendor driver follows the following
> pattern:
> - for eMMC and SD cards in .set_pdma it sets:
>   pdma->rxfifo_manual_flush = 1;
> - for SDIO cards in .set_pdma it sets:
>   pdma->rxfifo_manual_flush = 0;
> - before syncing the DMA read buffer is sets:
>   pdma->rxfifo_manual_flush |= 0x02;
>
> Set the second bit of MESON_SDHC_PDMA_RXFIFO_MANUAL_FLUSH without
> clearing the first bit before syncing the DMA read buffer. This fixes a
> problem where Meson8 and Meson8b SoCs would read random garbage from SD
> cards. It is not clear why it worked for eMMC cards. This manifested in
> the following errors when plugging in an SD card:
>   unrecognised SCR structure version <random number>
>
> Fixes: 53ded1b676d199 ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
> Cc: Thomas Graichen <thomas.graichen@gmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-mx-sdhc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdhc.c b/drivers/mmc/host/meson-mx-sdhc.c
> index 5c00958d7754..53e3f6a4245a 100644
> --- a/drivers/mmc/host/meson-mx-sdhc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc.c
> @@ -586,10 +586,17 @@ static irqreturn_t meson_mx_sdhc_irq_thread(int irq, void *irq_data)
>                     cmd->data->flags & MMC_DATA_READ) {
>                         meson_mx_sdhc_wait_cmd_ready(host->mmc);
>
> +                       /*
> +                        * If MESON_SDHC_PDMA_RXFIFO_MANUAL_FLUSH was
> +                        * previously 0x1 then it has to be set to 0x3. If it
> +                        * was 0x0 before then it has to be set to 0x2. Without
> +                        * this reading SD cards sometimes transfers garbage,
> +                        * which results in cards not being detected due to:
> +                        *   unrecognised SCR structure version <random number>
> +                        */
>                         val = FIELD_PREP(MESON_SDHC_PDMA_RXFIFO_MANUAL_FLUSH,
>                                          2);
> -                       regmap_update_bits(host->regmap, MESON_SDHC_PDMA,
> -                                          MESON_SDHC_PDMA_RXFIFO_MANUAL_FLUSH,
> +                       regmap_update_bits(host->regmap, MESON_SDHC_PDMA, val,
>                                            val);
>                 }
>
> --
> 2.26.2
>
