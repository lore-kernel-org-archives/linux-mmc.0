Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1EAC6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 17:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjCLRJ7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 13:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjCLRJ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 13:09:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4D221A05
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 10:09:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x3so39716850edb.10
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678640994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SNL1F8ClNeNyXGoW6Ur+YWS8mHz6siwFKtbWI0zMS8M=;
        b=kNFAVNfKxzjh2/UNTnPWkrIfJxflcnKLQPEaW5eY6Dv6gdfekUpOoey3KH6n1V5spY
         6Vtxu/fTdxZAgVhAU+E5n4sxIdFRZPOyZ7rqUrOp/F0Le0Ur6bp4Svpe13eBe3mko0tW
         5SmXqA3dRzMGTef9j4p1622Pk81B55KmJgRuqt4or4M7lsp/vNtNMoXUXWrOtcFbQbPE
         yHuFQiAmwR3vKUPYKAj1P5qEIQKwdxCKXbWZdkgZCwgHj9AbCI6ijQEYgXAMIrVfYG4I
         yVUG6aTVUwUP086Q2sFHIaeJbP3X0a4t43l692/jmOtXsNN3Orw2a8S4FsZGJ94W4Q7Q
         wFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678640994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNL1F8ClNeNyXGoW6Ur+YWS8mHz6siwFKtbWI0zMS8M=;
        b=W3o/2TYaGfhscYx+qcBxK604WNrGZSyvvB+SCB3OVyxV4t6DFPsVMVfygN1/+PyA7T
         eILz9R032MXzUFHKxEXpoNANFJ5f1pyiqdu+PlIOl0Krx0mW3wLRBojLofBwDvKbnmcG
         Xp3AmVykT5jDSP3Oddur6IC9jigHunRmPz48PO7ZHfHuL9XynFjYutuIZ3RVBWd/RCtH
         Tc9XQ9Z/QvqyEGHcUqBHsCL3fCT9J8MvO6sNzG1/RiP9C76qHov1LZ60EhkVxe1fH2A6
         ZIlTC20LmcWVXqyT2UIzeSP2DkLDwR4rW/K9cVE6F7KsYOz4zJFNFx9cXGlx61GWqBE9
         EXwQ==
X-Gm-Message-State: AO0yUKX5nwbSW/PEG/FV4MhKEfItyCSfO5EDmQ2GAjEd1UhcRMvghO8y
        Cl6YPPeWtwdvDTYnZVPu24IIMw==
X-Google-Smtp-Source: AK7set//9cjL/RgrIm+IgF6wOVZTldVT9LbovBB9ac5/KnBJiTkwztVRWCOsh0sH8XBiM7A+4LODAg==
X-Received: by 2002:aa7:c69a:0:b0:4fb:4354:ab2e with SMTP id n26-20020aa7c69a000000b004fb4354ab2emr3373518edq.28.1678640994003;
        Sun, 12 Mar 2023 10:09:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id z2-20020a5096c2000000b004af7191fe35sm2329540eda.22.2023.03.12.10.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 10:09:53 -0700 (PDT)
Message-ID: <fd555393-0f9b-fbc3-ad9b-dcceb04080b3@linaro.org>
Date:   Sun, 12 Mar 2023 18:09:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/3] dt-bindings: exynos-dw-mshc-common: add exynos78xx
 variants
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1678640497.9030156-1-sleirsgoevy@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1678640497.9030156-1-sleirsgoevy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/03/2023 17:59, Sergey Lisov wrote:
> Some Samsung Exynos boards using the arm64 architecture have DW MMC
> controllers configured for a 32-bit data bus but a 64-bit FIFO. On these
> systems the 64-bit FIFO registers must be accessed in two 32-bit halves.
> 
> Add two new compatible strings, "samsung,exynos78xx-dw-mshc" and
> "samsung,exynos78xx-dw-mshc-smu" respectively, to denote exynos78xx
> boards that need this quirk. But it's very possible that all
> "samsung,exynos7-dw-mshc" boards are actually affected.
> ---
>  .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> index fdaa18481..a72a67792 100644
> --- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> @@ -22,6 +22,8 @@ properties:
>        - samsung,exynos5420-dw-mshc-smu
>        - samsung,exynos7-dw-mshc
>        - samsung,exynos7-dw-mshc-smu
> +      - samsung,exynos78xx-dw-mshc

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

