Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A2CC43334
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jul 2022 15:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiGKPJU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jul 2022 11:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiGKPJO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2022 11:09:14 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DD025EB1
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 08:09:11 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id v1so3163719ilg.11
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjJyUrv/9KeAF4uwLYY03FcyF3s57OWw5tLe/ipLqOA=;
        b=ZgMqfivM/ulF9/76btxe6b02wCo/5qZWqIUWWwrSRzFcU6xI4UUMRgLgzZTgQ3xOTl
         TAxvsLCJ4AcY5KWdYyxsWoVb/zmhDp2kgVRPbcEkOuOdCuaN9d+7NKwAXlKE6XN9djX9
         qRu82BLQgsvTR6iC/z53I4Jf9lk4h6s6vL0fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjJyUrv/9KeAF4uwLYY03FcyF3s57OWw5tLe/ipLqOA=;
        b=Lf1YB5HX7qCtlESIUsXi/xyGLcRSaPwtTUQhAyEFLloqCCnroay0P3wN1gIHCnPLTv
         WErAzcc/fX6c3yyVfYEX8dZ8633BJ3rDIfqA1A72OzY9HWLrkWq/IHkcjkJ1D6vZ/ytq
         4VL2lhXIzp8y5dXzgfAQrGqH/k9oxCSv69suDGsV0JdUj8mLGsTzmpxC0UJMrT4SHuCC
         sSE9syIQXJh5cDxJh7vp2rzpGA/9IzdMFNEYFFFT4Gkc3s2jBNKe+z1VHBIogp12xMB0
         boHaSjRTiIVM32cUdfo+abo40Lo4D+ark2YGMptsqR23pRygKYPPixEFdBn8qvWA1SFc
         MBcg==
X-Gm-Message-State: AJIora//OUDzWAXK6YNWynGx1ZJ71Wyoj1ikKSBW5hftdmdhl7MJ1XF0
        lofAFQOKOut4EEcC4RwX0HsBijYyNFJl+59uX1A=
X-Google-Smtp-Source: AGRyM1src/NV2tgXk7Fa1MKU2J+oabEkNx1v6gwm2qOmGuKfPGOI/+ncBT0MoW1TaH5Zy6e0CTdWcQ==
X-Received: by 2002:a05:6e02:168c:b0:2dc:2c20:3cc9 with SMTP id f12-20020a056e02168c00b002dc2c203cc9mr10198107ila.249.1657552151225;
        Mon, 11 Jul 2022 08:09:11 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id k26-20020a02335a000000b00333fa7a642asm3015927jak.63.2022.07.11.08.09.09
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 08:09:09 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id p13so3196305ilq.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 08:09:09 -0700 (PDT)
X-Received: by 2002:a05:6e02:174a:b0:2dc:7bc5:f810 with SMTP id
 y10-20020a056e02174a00b002dc7bc5f810mr3279673ill.254.1657552149101; Mon, 11
 Jul 2022 08:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220711082709.39102-1-krzysztof.kozlowski@linaro.org> <20220711082709.39102-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711082709.39102-2-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 08:08:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W7BCMTByC9xn2iRsxoB9RzRENz5zuTy1Sgmhjbw3aQMw@mail.gmail.com>
Message-ID: <CAD=FV=W7BCMTByC9xn2iRsxoB9RzRENz5zuTy1Sgmhjbw3aQMw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-msm: add MSM8998 SDCC specific compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Mon, Jul 11, 2022 at 1:27 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Add a MSM8998-specific SDCC compatible, because using only a generic
> qcom,sdhci-msm-v4 fallback is deprecated.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index e395411fb6fd..bb169c1c2b5e 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2447,6 +2447,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
>         {.compatible = "qcom,msm8992-sdhci", .data = &sdhci_msm_mci_var},
>         {.compatible = "qcom,msm8994-sdhci", .data = &sdhci_msm_mci_var},
>         {.compatible = "qcom,msm8996-sdhci", .data = &sdhci_msm_mci_var},
> +       {.compatible = "qcom,msm8998-sdhci", .data = &sdhci_msm_mci_var},

FWIW I'm _against_ this change.

In my mind while it is correct to specify both the specific and
generic compatible string in the device tree, the driver itself should
rely on just the generic compatible string until there is a reason to
use the specific one (like we needed to for sdm845 and sc7180).

I think I pointed that out before, but somehow all of the specific
device tree strings have snuck their way into the driver without me
paying attention. :(

-Doug
