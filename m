Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFD8C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jul 2022 11:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiGRLj1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jul 2022 07:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbiGRLjW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2022 07:39:22 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5B72640
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 04:39:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d12so18768335lfq.12
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 04:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqFXW47liSOgWesWbe3iscDHgm0d6lPu0OfhHoTpb8s=;
        b=SoVQbmGoIB6Z/dtwpH7n/SQrerMa3pXvL0gHXILbEQwBPwXkFg7GVSDa83vCgSk0zG
         /yqA6JsW03ZcoesOeaNM19e9y9Rp298gtecbH2tD1k2+L7GOlg0idzWMc0IfzO+1tnAE
         VHeqGN4YGW8NL35VrjCIlugLpyC6H12R/Xg4QHXZCbFlfHfmQ9eVIb7f7zNPTeqcmR4T
         yxe4bi7jC5a5QpPPlugweahFIPmDZqaj6CyY8bD17p+usfO3NFsdj8OoUqjWm5eJbIQV
         ymk86s103R6B7DebZMoYbHdZrySBF+E9ztxt2sW8WYBZkf55pT106obiy8IRuX7w/Gt3
         bK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqFXW47liSOgWesWbe3iscDHgm0d6lPu0OfhHoTpb8s=;
        b=v0qymc6WUogXatr28RcwnmWWUH4BBMdj/6U5tmCtGBxLqwrHCv9JzyTCsB4gEUVn7Q
         D7/p1OZ6pxzgSb3ptAJDTMk00VGJc/83PjVAY4CHrMAgDq+VdLqAfxIBNT1TwLOosJWl
         dXEplSQ1lLp6SIYChL+VCYy7GU2xtxGos/DO4yXz8tRWKq5zvyxMyEzfCOAE8yC+N3VW
         08yl/2x2Q3Lbex+fdUx2RxplJNbZSbjTS8bk73Q55cHo2AjdwkLFmGSQDY6+dlRmxpod
         ZBNDX0r309vj8mCXuKGVj+slYJp22XGOgg8QBdUUbfOWWr4L/f7ppl0HcVyKWVyI4aIV
         apfg==
X-Gm-Message-State: AJIora+XvirOS7mdxYL+pJfAZe097ieYp2LQo/5kkDppsSqcpdSA0+xN
        g9m6evnMjEsURX4qb2+M56EOpMcphvZbF1fWU/7bRQ==
X-Google-Smtp-Source: AGRyM1uEYzo8g//JsgAfnPoniIwTL3KHWTaTOY9Ti9xQSb52AIAMymbZg32JURDjMsYeRRM3xXhppYzIL6cij+p5n8o=
X-Received: by 2002:a05:6512:aca:b0:48a:1a70:d0d8 with SMTP id
 n10-20020a0565120aca00b0048a1a70d0d8mr11175523lfu.167.1658144359079; Mon, 18
 Jul 2022 04:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220714123406.1919836-1-konrad.dybcio@somainline.org> <20220714123406.1919836-2-konrad.dybcio@somainline.org>
In-Reply-To: <20220714123406.1919836-2-konrad.dybcio@somainline.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Jul 2022 13:38:42 +0200
Message-ID: <CAPDyKFqx5oxNpih-u0icLD0o59wAdDnpGGNSn=ZNteYupWGZ5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: mmc: sdhci-msm: Document the SM8450 compatible
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 14 Jul 2022 at 14:34, Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
> Document the compatible for SDHCI on SM8450.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes since v1:
> * Add this forgotten snowflake
>
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index e4236334e748..4b65d0497fd6 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -38,6 +38,7 @@ properties:
>                - qcom,sm6350-sdhci
>                - qcom,sm8150-sdhci
>                - qcom,sm8250-sdhci
> +              - qcom,sm8450-sdhci
>            - enum:
>                - qcom,sdhci-msm-v4 # for sdcc versions less than 5.0
>                - qcom,sdhci-msm-v5 # for sdcc version 5.0
> --
> 2.37.0
>
