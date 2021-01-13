Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA50C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0B6233A2
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbhAML1I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbhAML1H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:27:07 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD7AC0617BD
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:26:01 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id j140so911971vsd.4
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+8zY4mAyzjmgjsrYvoqLVjDJOKDqaN1fkUOrBGLi4M=;
        b=OiN+OkGx7489GZZh0hmDDLNJvwzokz7n7baE1dAg2JdPLXWQH+eyBoKVNNUmD/UHzl
         LUtsej7UJpMuN3zRHOf/Pc6z0Dr/m/06kprtF/2UKtdvKV7hZS/NH57YOf7N89v5amU0
         yEdmZGuuygp01KoL/S4EO0Z4+9wvZHUjv2LyUlNdXtPgGXw+mQMZYBWJu+YmKTzLfI24
         +7esSdpJsGqkzAmrfqFg5NQyjUYW9q3jJ02mhTPW0dE6o9P9bJPzdSgqpzxS3IH/raUQ
         H3dQ98j7/SmsuINw5DviiUGLSvG/MughwrzB49oNI/9i6zuxRJNplu3BbLtHwM2y+WgW
         /DkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+8zY4mAyzjmgjsrYvoqLVjDJOKDqaN1fkUOrBGLi4M=;
        b=aWzTHVtI9SUlLAkjrxd2Jx/yL3NlzpK0Frq0kgyZmKV46A89kEqDLCnj5RTq2R8X4r
         Ccpps/H7SaJk4JKfdm3CDd3m70/eupZnO88NtPrsAm7Dy8VdXZ5Fiblw5khGPm9ovpOe
         N2d0EEICOfwsNz35vSvWLtxSZUjYUN+sr9niHCtk+NtKXVcfZ4NOYZbqDQN7qaJnUwiH
         19zEg+K//j4UcyEZpYXP8dw0robqRjQdK1u++F+pM2mGQXa3WZhMCRiVJ8g93TXTrWoJ
         6Wes1LzAk6C3Ya81lxyWcuXNtjjNWDdRKjuwz2skenY1fE1MBL0up+zwFNWUIQ3CO0eo
         tEfA==
X-Gm-Message-State: AOAM532QidxO64yOXmZy2LbG8qhNHgiJw4bKg1x7/XXqOA9iPI88dL8O
        U6ULvjclzlAlj5zjOG3L5sS/OJ5hmbFpCeDOHjHzow==
X-Google-Smtp-Source: ABdhPJyEXS/qxGhlAHcgztCWad9kvXwLG1Ay9RD3A+8qxnVUMWamsOhdl/W7h+uvCfYzaoMIXQ1TJLpGt8dfvFUfVoE=
X-Received: by 2002:a67:7f41:: with SMTP id a62mr1386085vsd.55.1610537160317;
 Wed, 13 Jan 2021 03:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:23 +0100
Message-ID: <CAPDyKFqFNq=GkcLS1dwx2rh5i2uMYP5Sum4Uu9udRkF8_-NbLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Document the SDX55 compatible
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 7 Jan 2021 at 15:31, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> The SDHCI controller on SDX55 is based on MSM SDHCI v5 IP. Hence,
> document the compatible with "qcom,sdhci-msm-v5" as the fallback.
> While at it, let's also sort the compatibles in ascending order.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 3b602fd6180b..9fa8a24fbc97 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -17,10 +17,11 @@ Required properties:
>                 "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"
> -               "qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
> -               "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
>                 "qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
>                 "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
> +               "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
> +               "qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
> +               "qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
>         NOTE that some old device tree files may be floating around that only
>         have the string "qcom,sdhci-msm-v4" without the SoC compatible string
>         but doing that should be considered a deprecated practice.
> --
> 2.25.1
>
