Return-Path: <SRS0=0j+4=CX=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1163BC433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Sep 2020 09:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24FB2192A
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Sep 2020 09:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xc0rm+Ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgINJt2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Sep 2020 05:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgINJt1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2020 05:49:27 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BEFC06174A
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2020 02:49:27 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id y190so590208vsy.1
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2020 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZI9hWs9di1kI2Awll+JevFT5wlTin0rF6zp9GvGxF9A=;
        b=Xc0rm+KsVi2+td2U7W+TciA3zrMCHvT1844h3a+1lSMscTiGMENuRgteAD8/oZZtoY
         XKzB1ROyjE2CEHo0x7D1jYVsL8+/lj9eTpbPf0jjUXi2OiVFxb3N1mPN8LbpsK4gy6Pb
         d2qIaN0qDRbhwk4DpqogvavJnkckvG54cnQ3UnJUSHhAr8GGctQ8DbiZApw4IdbSLocu
         NVgGBMibLpCzYjf1rQ14W8LkrrwS/c2/62BjFHmQKMa/KfcIY4Aolc3BGMt98b/9wHl6
         wy3PUB1V3wXpj2PMJRkF/zIzjJ/VaRKfnjQo16/cct63jTxToHR+n0EOjyWT9HCLv61J
         MWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZI9hWs9di1kI2Awll+JevFT5wlTin0rF6zp9GvGxF9A=;
        b=aFs1tUiowP9AKfMEJmM8mXo/TAwIn6bd9t2Vh022qKe86ZaFvE/yLJd5VmsJY9zGR5
         YleixDode1BCgG/djMSV1nSCsiXPmWn3sGp6Sk/RUowhL9cct8Hs5b7Sgv2s0sUHqovl
         P6UbRLLeoyDnCd0s9Bkg0A9PQD1wccVgnzhAOq/a4TmT6DwGQhLG81AbPy9bF4WVClcF
         uBcTNgX+v2ulhm8rZ8X52YJwvLci5bdCaDakuhvnhmkwnTx8jGxc5kR6yhlVEjlmhMmh
         H2HQZAGB0aQ4DM5YmLuMVwAd7rG2nBPZ5CRvW7LkZxM++Et1L6XV4Rm438Q/5A+DCHq/
         k9Dw==
X-Gm-Message-State: AOAM530L9dgxfSA8TST31TZXzJvy2WtQQ0RImzQ0a6JRmnVpUE061EQ8
        QZVmtnYGHjyXAfF+reotXTXOI/YRTXCic16bFhIHyg==
X-Google-Smtp-Source: ABdhPJxMkp7gENPAvak1I3oKE+Q3eWPr9M9QVxG1ASm7GjKPnle3ZMAvGkHmOFvy9Wprr9nAyKTNIOEdb1gjWex5SK4=
X-Received: by 2002:a05:6102:2085:: with SMTP id h5mr7077307vsr.26.1600076966162;
 Mon, 14 Sep 2020 02:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200914094243.3912-1-geert@linux-m68k.org>
In-Reply-To: <20200914094243.3912-1-geert@linux-m68k.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Sep 2020 11:48:49 +0200
Message-ID: <CAPDyKFon7ymJ2LR-fraAujdY4PW4HsZyZfRZAm7LDFRX_t27bg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_spi: Fix mmc_spi_dma_alloc() return type for !HAS_DMA
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 14 Sep 2020 at 11:42, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> If CONFIG_NO_DMA=3Dy (e.g. Sun-3 allmodconfig):
>
>     drivers/mmc/host/mmc_spi.c:1323:15: warning: return type defaults to =
=E2=80=98int=E2=80=99 [-Wreturn-type]
>      static inline mmc_spi_dma_alloc(struct mmc_spi_host *host) { return =
0; }
>                    ^~~~~~~~~~~~~~~~~
>
> Fix this by adding the missing return type.
>
> Fixes: a395acf0f6dc6409 ("mmc: mmc_spi: Allow the driver to be built when=
 CONFIG_HAS_DMA is unset")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Geert, my mistake, thanks for helping out and fixing it!

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmc_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 5055a7eb134ac13f..18a850f37ddce27e 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1320,7 +1320,7 @@ static void mmc_spi_dma_free(struct mmc_spi_host *h=
ost)
>                          DMA_BIDIRECTIONAL);
>  }
>  #else
> -static inline mmc_spi_dma_alloc(struct mmc_spi_host *host) { return 0; }
> +static inline int mmc_spi_dma_alloc(struct mmc_spi_host *host) { return =
0; }
>  static inline void mmc_spi_dma_free(struct mmc_spi_host *host) {}
>  #endif
>
> --
> 2.17.1
>
