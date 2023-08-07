Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265E5C001DB
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Aug 2023 06:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjHGG36 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Aug 2023 02:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjHGG3c (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2023 02:29:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFABE170A
        for <linux-mmc@vger.kernel.org>; Sun,  6 Aug 2023 23:29:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-317744867a6so3098957f8f.1
        for <linux-mmc@vger.kernel.org>; Sun, 06 Aug 2023 23:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691389764; x=1691994564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7rnWNHFUneQ3py2i1MBfIqg4WaLvrT3ZVmHSN5iKRs=;
        b=f8insg7X86ppQ5F6Ftef+QhplHoXoRQAMzFMVl2RdeVQ2Cn675LFV6uigapurhe9JF
         HldFfIEGHpm9b5MvBSH7/C8CfgQfXb8onmWizItMbRzFPNLH3NxRQxq2YoAxV/QUj+gj
         Xq/Plk9HWec7x3LlQUT7TSRVzSUprBMMD8NPtiMDhZybAJ00NaRZGmqzJvPR8Gk0Lxbr
         Uyl7qo33UrJBbDk3TSZiA2siPMr1VQVzjZH8dyblNByvz3N/Qc/V+KcDivWTUqazW/N+
         k8TCdZah0Ccmqhavl0s9AF+IwPvXKNFH+mx+WROAMFNaWNvOy4uRJJ1zIA+VaI+NQv/q
         Qlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691389764; x=1691994564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7rnWNHFUneQ3py2i1MBfIqg4WaLvrT3ZVmHSN5iKRs=;
        b=PiYv+55juayFrCdzmS+vLyFZCQkVusVGLOPajo/hIur4RE4b0tHYtwteqiHXuXewgz
         vVcHyGzMC+Y5Tze7fruoOXx4sGaj1CHxlHMW1wxgXyJHpDmquDyjGF6ixwtAS/+VLI50
         VgLY/YGM0fWouSUEEwbSd9dncbLQqEXpnhPjEw8S4PMcHFyuLQI3KPBQKPXBPpatdQsH
         o7aJXpYIEv6igSQWLi1YsfQT4Twn2zWjIy7bXwgNg2vuPXDoZnUSuiZMlyfBqEwvWNta
         zH0tGlnK5/CLv9q8fbB85YAaDmt0Z/nQfGk4fVIO46Qm0XcSQqJ5jQuWO1e87EHHBtqU
         CzBQ==
X-Gm-Message-State: AOJu0YzshbvuddawzwUjZDPND4RNC1MLyXTzWHEQDiTD7bqTmcdCbEUl
        60e8+CUJZZa6yhMehEoP5RTsbg==
X-Google-Smtp-Source: AGHT+IHoV4+y4ygwE201jI1n35hdg8Xn3ESUU/xDOlVSMzH8Nm0HJsqGqZvTNuNydoy+mLFZinL9WQ==
X-Received: by 2002:a5d:6509:0:b0:313:ef57:5bde with SMTP id x9-20020a5d6509000000b00313ef575bdemr4758869wru.42.1691389764237;
        Sun, 06 Aug 2023 23:29:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id b3-20020adfee83000000b0031773e3cf46sm9393070wro.61.2023.08.06.23.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 23:29:23 -0700 (PDT)
Message-ID: <ca0b9a19-d7d7-80e5-f47e-f74615cdac86@linaro.org>
Date:   Mon, 7 Aug 2023 08:29:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC v2 1/4] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head
 TH1520 support
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
References: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
 <20230724-th1520-emmc-v2-1-132ed2e2171e@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230724-th1520-emmc-v2-1-132ed2e2171e@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 05/08/2023 05:14, Drew Fustini wrote:
> Add compatible value for the T-Head TH1520 dwcmshc controller and
> thead,io-fixed-1v8 and thead,pull-up properties.
> 
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index a43eb837f8da..57602c345cab 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -19,6 +19,7 @@ properties:
>        - rockchip,rk3568-dwcmshc
>        - rockchip,rk3588-dwcmshc
>        - snps,dwcmshc-sdhci
> +      - thead,th1520-dwcmshc
>  
>    reg:
>      maxItems: 1
> @@ -60,6 +61,14 @@ properties:
>      description: Specify the number of delay for tx sampling.
>      $ref: /schemas/types.yaml#/definitions/uint8
>  
> +  thead,io-fixed-1v8:
> +    description: SoC PHY pad is fixed 1.8V
> +    type: boolean

Isn't this duplicating existing properties for MMC modes with 1.8 V?

> +
> +  thead,pull-up:
> +    description: True if pull-up, false if pull-down

This explains me nothing. No clue what you are pulling and why do you
need it. Pin pulls should be done via pin controller, not MMC.

Anyway you should have here allOf:if:then (move the allOf: from top to
behind "required:") which will disallow these properties for other variants.

> +    type: boolean
> +
>  
>  required:
>    - compatible
> 

Best regards,
Krzysztof

