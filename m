Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353B8C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Sep 2021 11:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220E2610FB
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Sep 2021 11:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhINLZ5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Sep 2021 07:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbhINLZ4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Sep 2021 07:25:56 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7A7C061574
        for <linux-mmc@vger.kernel.org>; Tue, 14 Sep 2021 04:24:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s12so23216605ljg.0
        for <linux-mmc@vger.kernel.org>; Tue, 14 Sep 2021 04:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXbax/1bglMzgg6o47IyNakKQ88KE4K/hGwmlnc25Ko=;
        b=N4100R/sVYI9xB+3RNF629B4s5ko7wLFiA6IUtn0oKfdFh4s/DVlj2FjWpH4EB0GWf
         nSMDgFuOB1FxKtOSkpd4KpnVn64T9GkSKp0EvH+DldoiZ0rVEhMOPAJHkgb89JuegEgT
         hVS0D/Osme/N8neVgiEaMNrlnQFqwSccnIyfqqQPfVokx/xmcLh3RCXL52xiIJzY6ZRq
         uMDG6zYAqhpcYdy+xr46dMDyzOciUPXIix6C8+tsMUz/w5rI2L27oVpcTqN6+X0BNIqO
         PTdm9tL+nnkFsidR6SB0wS361pbbavkKWyVqdsTpBqhCe/DQMVtEr1A3eR2VmWTrUc/4
         +zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXbax/1bglMzgg6o47IyNakKQ88KE4K/hGwmlnc25Ko=;
        b=JA3RjwYrO1FjJNGjuRZFmkVR3Q5cCK5ZWdtHySxbAC5ygNytdPefdbfr7aQpA5k6JZ
         NMaQ0K/nSpbCUPJo3SOMDkp8xVkgZ1qyTno081hRzeC0f56kGU7BpCq51Go1ZpbFgP5A
         ryE1m0nEESZQYAO689/KVEpf4cq7p69MDDlIr1sAA99s9/m0OXM7399zP+tAp/ba0DE/
         oK8bk2uw+GQykALyQlqeFEJp7bvGEaYIcb6yGdWP15OTb4QjaTMLlfVFIUQDsZpJ0KUp
         9mhZ9xhpVFPnkjXtHhSaqd9M2Njx5pc81J4GFi+xeA3Ki4lI44q4ZSELo0sdXAujwbTg
         jWWQ==
X-Gm-Message-State: AOAM532/MhWQGdBRBBKMe++BK+LzUQIW7K81IaqKb9ZpwkGmQcySUWKx
        nYjzpqRrF34+VQJ8wF23rxftCqOXcXYje7QBPDZlzqYMI7I=
X-Google-Smtp-Source: ABdhPJxNQjIx8LfDVzNm9Bxa8g8kduMXKBDzOD8rsarWhRJUMWWBpslN7FA28BAQA42mUmbJjsXpFhnu6cwrV9l1QHM=
X-Received: by 2002:a2e:9b0b:: with SMTP id u11mr14793392lji.463.1631618677115;
 Tue, 14 Sep 2021 04:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210911232707.259615-1-luca@z3ntu.xyz> <20210911232707.259615-3-luca@z3ntu.xyz>
In-Reply-To: <20210911232707.259615-3-luca@z3ntu.xyz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Sep 2021 13:24:00 +0200
Message-ID: <CAPDyKFr9k2dO8FJf4=ZUKZ6=WpDS2mOJ+BZbtK1m_-OWx_ehmA@mail.gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: mmc: sdhci-msm: Add compatible string
 for msm8226
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, bartosz.dudziak@snejp.pl,
        Rob Herring <robh+dt@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 12 Sept 2021 at 01:28, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Add msm8226 SoC specific compatible strings for qcom-sdhci controller.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 365c3fc122ea..50841e2843fc 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -13,6 +13,7 @@ Required properties:
>                 string is added to support this change - "qcom,sdhci-msm-v5".
>         full compatible strings with SoC and version:
>                 "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4"
> +               "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
> --
> 2.33.0
>
