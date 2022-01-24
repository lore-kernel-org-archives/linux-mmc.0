Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19565C4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Jan 2022 14:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbiAXOlo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Jan 2022 09:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239690AbiAXOlo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jan 2022 09:41:44 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBB7C061747
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jan 2022 06:41:43 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x7so49928687lfu.8
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jan 2022 06:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDkr/Rong6odf/l1FFKK3Zb5bf9I7lsmuK7pJ15wG/8=;
        b=izNxEl4a4luZq6cAnVCYJYeJCBaH/+ylbFkis8xjyq2EVPulVDm/13IQnTAmpI/mus
         UhiOghVn5UaSRpWdmmql/c+kfngWx/b/He3B+uvxQh74afMny8DmnF6yRvkZJgEf0bRX
         c8SXS9Gavk67xeZ9D+czOQ6t6YuCXNrgAy/cLtsRwf2xeM4KXNqkgil1JoQooqS2nMzo
         fZBRRu8/nrdPYR6A+k/J4400eLhoydqKx9SyYJJL6zuW/g28dQrgMexNgW3KhaaM8uAj
         ClRMlU89W+PSqkYODhn1Kl74k3gyLEjXm+RzBQpAudOrqQIiDmYFGXfLgxo4vYz3ZePt
         JUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDkr/Rong6odf/l1FFKK3Zb5bf9I7lsmuK7pJ15wG/8=;
        b=63ZZbGRJgPTS31pfdUF7pmbXzvHpOuu2sdvmF85Wa8Pw1Lb18Fx3Rlfchdw4MxAoql
         IpBYqlUdfyPhesUSX+eQy4a+6l35c3F3sg2fbm6KCTE+e1rpyWtaIwgCH4OUc2v/f2pN
         Yt7u+2r32Gsy4wkIwfmjsjJ1YpqTKQS5yLHZQOKpH/unEghAvoKchrHmBpaXclwq+sih
         0mTR6jU/ksB5ddw/fP7UIqWkCieqSOfmjQmvPyhJhROl7cjQbOhh00pIDGzGv3bRonJI
         9uiUdxMOloI8VWggwKkBhXWLcSyh/TrJZDXcXsKeqKMWzlKIYVk83rVcbm0GKKnAOQQ4
         w7JA==
X-Gm-Message-State: AOAM532aCp2wg1nPppy722emXs5NYbgpS8czo+hlMHJd2uhphBYbLFJ0
        3wcJM8q9W+xrebBv7TNxZk6ffRK6jIoYZpngvs3Bag==
X-Google-Smtp-Source: ABdhPJzXA8eX9kSAZ+l1b4fqeGXQBWRlv4PCBNL3A0MBPY5wxd/KuKJMuGGcR+7kkjOsBL8YOX8Q+FuJkFMs3RAVtDk=
X-Received: by 2002:a05:6512:32c9:: with SMTP id f9mr12756249lfg.184.1643035301614;
 Mon, 24 Jan 2022 06:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20220112194118.178026-1-luca@z3ntu.xyz> <20220112194118.178026-6-luca@z3ntu.xyz>
In-Reply-To: <20220112194118.178026-6-luca@z3ntu.xyz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Jan 2022 15:41:05 +0100
Message-ID: <CAPDyKFr+BjF8_rEv0RG8aH3FmnKtngkrbfNmNSo=WPmz==uDfw@mail.gmail.com>
Subject: Re: [PATCH 05/15] dt-bindings: mmc: sdhci-msm: Add msm8953 compatible
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 12 Jan 2022 at 20:42, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Add msm8953 SoC specific compatible strings for qcom-sdhci controller.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 50841e2843fc..a62eaade5d97 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -14,6 +14,7 @@ Required properties:
>         full compatible strings with SoC and version:
>                 "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4"
> +               "qcom,msm8953-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
> --
> 2.34.1
>
