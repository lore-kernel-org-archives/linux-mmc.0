Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D212BCCA482
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jul 2022 10:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiGMKzm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jul 2022 06:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbiGMKzl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2022 06:55:41 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7B3FF58D
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 03:55:40 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id b12so6439367ilh.4
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 03:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=plZSlH+I5O8PlpsjQVgP55GuUwpIHXkHnkPiVS3vYiY=;
        b=B5OeBVGlVuvH+a4ow6PdXZ4coDwTfkRH0D5Zbh0wAKomf3JxsCXnRYmEb7MNyDOuKr
         YTMelfs6dC/HuIm8EcBpVA1rFGiKYD/7NgYfaBAc3M9KUXuf1ZM7USxuNwS+YQZCluSw
         mvX67g56k4vXLNaDzu8WDcsp3kuFHMkLcosF1x+YpDTNYK3OIr7SRQSrhPL+s7+YFCiP
         djQ1Kcim6noT9sttX4cPkoleoZC9tN7T4cgNi/H5zxLh/Qwf3hRFZwxzGTDIT6oiFgn4
         hAqJSHpA5wGNVK5kyKGWr3pDO+AkIU20rAdJQrgGRwC+MYSy1b3EWPCxJG6SAMVAjp0/
         7Srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=plZSlH+I5O8PlpsjQVgP55GuUwpIHXkHnkPiVS3vYiY=;
        b=RevStZLMAcuEq3Ur61Kf9bMYI9SO2XSMM9opPoXAwQlWRZyp9rIG6z/ei2bJ90SkoN
         fLFtrT6AgzbexlbCwO7aNKblzDPtYefs1QzVZsT4gg9C7UN4EmjD65SMt72/1BPIZOBw
         fqaV08OFoX8xyhT2c+UA/geUmHppGrpIPCVj0SDOnsXIn+/LgXNOjfAeKEcE0NA6Lo/j
         znVcgkEFp+FixWvJN3PPaZFGfyc73ae+upPDSOdUoVEymcqNMJgh+zRIGv3MG8KnjL3V
         xzWCerEvtSgnt1z8/HIL8h6NDm0bwvjkvpg8YYy+mtnDzuFpmtBz0a4amZFV1d1kHudi
         Y1Xg==
X-Gm-Message-State: AJIora+2V6b89rfcCKVdxMHLaZi6h2f+itBP/oxoPz3px06/hq+iCPZn
        UpRggMses+GTfCzclvmaccZy0Sz+0EqlQNrYYOJmDA==
X-Google-Smtp-Source: AGRyM1s9qYzsNvLD7gjbAFuTD/fV+NMhJpSkzOyRbmOcv8lTos3rKA267x/OYE4INghDUQXXPlc6Lk3HuREo6AEl6/I=
X-Received: by 2002:a05:6e02:20e9:b0:2dc:734b:d52b with SMTP id
 q9-20020a056e0220e900b002dc734bd52bmr1505139ilv.261.1657709739577; Wed, 13
 Jul 2022 03:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220712144245.17417-1-krzysztof.kozlowski@linaro.org> <20220712144245.17417-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712144245.17417-2-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jul 2022 12:55:03 +0200
Message-ID: <CAPDyKFodOTRavzy=+9WM0d9=UJQ2DTc2K+6iN531tRdFN=Rv9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: mmc: sdhci-msm: fix reg-names entries
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 12 Jul 2022 at 16:42, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Bindings before conversion to DT schema expected reg-names without
> "_mem" suffix.  This was used by older DTS files and by the MSM SDHCI
> driver.
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Fixes: edfbf8c307ff ("dt-bindings: mmc: sdhci-msm: Fix issues in yaml bindings")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 0853d0c32dc7..fc6e5221985a 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -60,22 +60,22 @@ properties:
>      maxItems: 4
>      oneOf:
>        - items:
> -          - const: hc_mem
> +          - const: hc
>        - items:
> -          - const: hc_mem
> -          - const: core_mem
> +          - const: hc
> +          - const: core
>        - items:
> -          - const: hc_mem
> -          - const: cqe_mem
> +          - const: hc
> +          - const: cqhci
>        - items:
> -          - const: hc_mem
> -          - const: cqe_mem
> -          - const: ice_mem
> +          - const: hc
> +          - const: cqhci
> +          - const: ice
>        - items:
> -          - const: hc_mem
> -          - const: core_mem
> -          - const: cqe_mem
> -          - const: ice_mem
> +          - const: hc
> +          - const: core
> +          - const: cqhci
> +          - const: ice
>
>    clocks:
>      minItems: 3
> --
> 2.34.1
>
