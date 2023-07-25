Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288DFC0015E
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Jul 2023 05:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGYFkn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Jul 2023 01:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjGYFki (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Jul 2023 01:40:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E5F19A1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jul 2023 22:40:34 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-522382c4840so1962679a12.2
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jul 2023 22:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690263633; x=1690868433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OfroF1JF/XJ6mPsu87A6GDB5zqWzLmB48tKx25k/bTA=;
        b=yrI4YLBQj6H0kT0aJ0MtbeCd1lVLBgOvIhkGL/uktBODBu9jESbkvGWjzjEFqZw2Co
         bIf9/SUWvye+uV+6HH5p3rKLCAxU8GKxlidhyGivOc64aRIAYDXDhbh51QSA/bhm16n3
         8akc3dCcyyTfBjqtU+ZlIAuYXY1+k8YUfMQakFOrolJGiTO6CkW34FarX0i+cwoD5u4j
         gKJpXxfxEmLVffIVTTeGUYKsvXEGAG8jdyvbY0vt3FUDCbj0tL5c5471dhmmPKNvDJwR
         m4cODdWrYSx5MxjVUCIkUOIR2h4kuQG67nWfCvJSmLxOmbhATuprr581KHkOx3n0O5RC
         QOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690263633; x=1690868433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfroF1JF/XJ6mPsu87A6GDB5zqWzLmB48tKx25k/bTA=;
        b=GBHeLprtPncgqaxaVQDXYI1kgonO/yv/U6iLWqRl+EERw6AtXZshzz8/qW93fjmoxP
         I728ET1ERyHIBQp2JNDVULwa3AU/VC7jct5sckkQ9O+XsLJhgXjYhLuCwccSJjPGlsZL
         FLVOO09w6Uq7aHxG3Rra+WIqXvdcodkgFlGYxsMq7dyHFf5dm8G68gOJD9pCTQvP4UC4
         Vy9vAfvT0Ttezsk2DCRH/Xb1ot2wa+szQBqupYKdx5FynpuBVaD+ugwsxEdyZONmzktl
         gyj4dtdBYQ5hobVtuOZ2ogAni1sxUjQhJ8WEzMeMM9zOsJ2CXMJcBJrHiKI0AQVpVNG4
         dZwA==
X-Gm-Message-State: ABy/qLaSDHC901PwRcnmOOIPeNLCl3J2OuJrM780bcXdepJ0VzU7Si2n
        6K4Mbadu0VvpEinVPQzAE2Synw==
X-Google-Smtp-Source: APBJJlEW/3ztfXZS/OG3QYLoj4rG16uxGq7HMDWca0xP36s6SbxzuY4oqrIPd+ZX6loTBq0oGyJ65A==
X-Received: by 2002:a17:907:7759:b0:992:630f:98b6 with SMTP id kx25-20020a170907775900b00992630f98b6mr11680527ejc.37.1690263633124;
        Mon, 24 Jul 2023 22:40:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id si1-20020a170906cec100b00992d70f8078sm7729498ejb.106.2023.07.24.22.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 22:40:31 -0700 (PDT)
Message-ID: <2385928f-1cc1-04f2-7a56-18eb99bf90cc@linaro.org>
Date:   Tue, 25 Jul 2023 07:40:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC 1/4] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head
 TH1520 compatible
Content-Language: en-US
To:     Drew Fustini <dfustini@baylibre.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
References: <20230724-th1520-emmc-v1-0-cca1b2533da2@baylibre.com>
 <20230724-th1520-emmc-v1-1-cca1b2533da2@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230724-th1520-emmc-v1-1-cca1b2533da2@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/07/2023 02:59, Drew Fustini wrote:
> Add compatible value for the T-Head TH1520 dwcmshc controller.
> 
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

