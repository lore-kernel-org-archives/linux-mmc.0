Return-Path: <SRS0=4qKy=EL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0FBC4741F
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 13:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2433B206DB
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 13:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a2qltg2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgKENAF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 08:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731038AbgKENAB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 08:00:01 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B561AC0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 05:00:00 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id y1so472054uac.13
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 05:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7NcZx/oSdkYK9nn1pweWIk2stuxNmZW+6aZ8xIAheSA=;
        b=a2qltg2ZO2ve892U8tNPLNFReFupQUvEd+42PcGc3wyyE0rdCVDXLJo9Xy/NM2UgdR
         ybjgg1ik4ekokumzQ72UxxZe7zFZ4w0oT+4UE1zbNjuHtlu5VCsMqr/pHtBiKwV5RH8G
         C5cSPkBF9YdLpJEHAwja99I/V12g38cHvCqrt7KQ9js9BB++8nvgMHfbKm3I9tGEngtG
         HIKMBU2X+K+yG6NNTbA0XGSVNJT7pGwCGp+ActTQQRLCHOI9GufpGbI7Z2mNbQbDOBgU
         WWpC8cdMqHtMUDN7Z60ELLJAWumg8aMcA+Ql6y3HhlkLih3K+iGVPalHjboalGGbNRxy
         45fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7NcZx/oSdkYK9nn1pweWIk2stuxNmZW+6aZ8xIAheSA=;
        b=rk4Rj1dApXKsf+0URgkWg71ITnf18fBUiO/K36NWdNOlNpw77bH5ie30JEb9U8XWhY
         m1vqjIi7PKbh6VyUU4vBRe56SQGBP6WLOqwKhL4OX6dUTxL3eJ0coqGOZdrnTKh9PeEx
         y1YqYf7hcr84/BQTqW/aKWMFzyj42I3wDOrU7CQlx6b0YkjdVToGA3tTrrC1PuB5YU4s
         XK+pWRHtNDrBCVEprgvDOCmr0TRUXB8Jw3zFLEw79qM3nU4qHcF6yDZmnSDMm+ePuxLR
         5ZI4SyAQ6Tt5okQH3YSaGcXqgEw/Gxx46034A8v0mfYAfgAHYARBstgU0OvMZxJnzTNO
         0wcw==
X-Gm-Message-State: AOAM5334BUUYKGlOc7sRHIPFlWbtEAZ4XwrM0tm5yG4dDGp+XNPklX7V
        slF87rAnJqRX1iBTSm63i8cbd4mnIo/tFdjf5ht60g==
X-Google-Smtp-Source: ABdhPJyKvAtWA3o6fvZdEP1FXq5fTD1wQx5C/9iCOEtWf1JxjYK3WnwXGODCRXocBQ36+Iib8od5AOXX7f8O8Jguzrw=
X-Received: by 2002:ab0:140e:: with SMTP id b14mr886025uae.100.1604581199978;
 Thu, 05 Nov 2020 04:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20201103163046.14336-1-krzk@kernel.org>
In-Reply-To: <20201103163046.14336-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Nov 2020 13:59:21 +0100
Message-ID: <CAPDyKFoKt9pwu=GC0hE7ogVJv=h6NPUjSvk7uNVmnf=FDPWh5A@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: drop of_match_ptr from of_device_id table
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 3 Nov 2020 at 17:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).  This fixes
> compile warning (!CONFIG_OF && !CONFIG_MODULES):
>
>     drivers/mmc/host/meson-gx-mmc.c:1252:34: warning:
>         =E2=80=98meson_mmc_of_match=E2=80=99 defined but not used [-Wunus=
ed-const-variable=3D]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-=
mmc.c
> index 4ec41579940a..13f6a2c0ed04 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1265,7 +1265,7 @@ static struct platform_driver meson_mmc_driver =3D =
{
>         .driver         =3D {
>                 .name =3D DRIVER_NAME,
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> -               .of_match_table =3D of_match_ptr(meson_mmc_of_match),
> +               .of_match_table =3D meson_mmc_of_match,
>         },
>  };
>
> --
> 2.25.1
>
