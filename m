Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95ECC77B61
	for <linux-mmc@archiver.kernel.org>; Sun, 16 Apr 2023 07:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjDPH0I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 16 Apr 2023 03:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDPH0H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Apr 2023 03:26:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E83FB3
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 00:26:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id xi5so56303366ejb.13
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 00:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681629963; x=1684221963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NIDABhyNbelgMCvJQQFAEuAhFdwIuaaK3cUB1/BFVsY=;
        b=OoLWftTrTEjmdMK4+RBWo01LVPwtpyj/XI8Wt6DCvbB486AxxOS9UeduZxxT/5rYaH
         rah08CUYw/eaE0FfPbNLz6S9cl/h+lOeyF7If32KIihBzZThBRJazguN2Nhk2Cq/ldXj
         uYMYZH3ce0dhDHeAjO7spMsxAJ4UOZI+ESUTeA0O0UPoDtEsXPe/8SgIF99un0HQq7MI
         Y9qMjNvCn8zkdvLx1yeqEc8k370THJS8xuF/R1nQ+vtH/Lx9cB0cfjsN0ohi2O8sir1F
         LYSknYBfjht66VzKcxep7JvlFC42R9BMy9aWeIAKxMRjEFQJ0/d3Dsv175eY03nyIS4A
         H1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629963; x=1684221963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NIDABhyNbelgMCvJQQFAEuAhFdwIuaaK3cUB1/BFVsY=;
        b=gOnQDMVVN9sB1rJW83B2Lj2WptiN4Y/g8/tONhA0FfcNpYHRzeBKJx5FRilOgvZsEn
         7Jx7Zzgi2c5tj5MzNVQMF2wwVjJG732Qjop919TVwvDxjMhV8ib7R62Lb/XGGUrQAxNO
         s1j5H7gdVfKc2ODyjJ5vwPX6hUXJIcJmhIVCp2CwMEZi1fYxi5STiBFjthwsf5wRL7qH
         E4zdJ/lhPI0tY+hPbmSHOEF1dQx/hTv1hfhdPlytk99DgHw4WspHFRUVMoXe2UWCecCv
         1wD0dWMnH1+NESfabyaHGf0TuPqmtKGZ06DNwrBQFLVV1ohZ1uBB5kQJGBVYnRqinrmF
         lEhA==
X-Gm-Message-State: AAQBX9fggHV93dS4rbU1FDr57xSJfFEeD7hL+gNbrq2ZdCeOcyCCUQ+d
        dInYsBs0RsHexpcJU7peKqlv8w==
X-Google-Smtp-Source: AKy350ZRJvvlLI0h3fWyko6hDelwGayM7z8cBsUxgjTR5sfrGgwJ3pC5RXpZ3TFrMP8rFWL0jaAHsw==
X-Received: by 2002:a17:906:708:b0:94e:fd61:8482 with SMTP id y8-20020a170906070800b0094efd618482mr3772799ejb.35.1681629963016;
        Sun, 16 Apr 2023 00:26:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id gy23-20020a170906f25700b0094f31208918sm1309523ejb.108.2023.04.16.00.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 00:26:02 -0700 (PDT)
Message-ID: <08156ff8-b627-56a8-e079-eb336c193808@linaro.org>
Date:   Sun, 16 Apr 2023 09:26:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 3/3] binding: mmc: hi3798cv200-dw-mshc: convert to
 YAML and rename to histb-dw-mshc, add compatible of hi3798mv200
Content-Language: en-US
To:     forbidden405@outlook.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230415-mmc-hi3798mv200-v1-0-db5b91d939d4@outlook.com>
 <20230415-mmc-hi3798mv200-v1-3-db5b91d939d4@outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230415-mmc-hi3798mv200-v1-3-db5b91d939d4@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/04/2023 16:18, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Hi3798MV200 has an extra clock, also document it here.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).


Subject: it is way too long. It should be just conversion. Don't
introduce new compatibles.

> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../bindings/mmc/hi3798cv200-dw-mshc.txt           | 40 ----------
>  .../devicetree/bindings/mmc/histb-dw-mshc.yaml     | 90 ++++++++++++++++++++++
>  2 files changed, 90 insertions(+), 40 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt
> deleted file mode 100644
> index a0693b7145f2a..0000000000000
> --- a/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -* Hisilicon Hi3798CV200 specific extensions to the Synopsys Designware Mobile
> -  Storage Host Controller
> -
> -Read synopsys-dw-mshc.txt for more details
> -
> -The Synopsys designware mobile storage host controller is used to interface
> -a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> -differences between the core Synopsys dw mshc controller properties described
> -by synopsys-dw-mshc.txt and the properties used by the Hisilicon Hi3798CV200
> -specific extensions to the Synopsys Designware Mobile Storage Host Controller.
> -
> -Required Properties:
> -- compatible: Should contain "hisilicon,hi3798cv200-dw-mshc".
> -- clocks: A list of phandle + clock-specifier pairs for the clocks listed
> -  in clock-names.
> -- clock-names: Should contain the following:
> -	"ciu" - The ciu clock described in synopsys-dw-mshc.txt.
> -	"biu" - The biu clock described in synopsys-dw-mshc.txt.
> -	"ciu-sample" - Hi3798CV200 extended phase clock for ciu sampling.
> -	"ciu-drive"  - Hi3798CV200 extended phase clock for ciu driving.
> -
> -Example:
> -
> -	emmc: mmc@9830000 {
> -		compatible = "hisilicon,hi3798cv200-dw-mshc";
> -		reg = <0x9830000 0x10000>;
> -		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&crg HISTB_MMC_CIU_CLK>,
> -			 <&crg HISTB_MMC_BIU_CLK>,
> -			 <&crg HISTB_MMC_SAMPLE_CLK>,
> -			 <&crg HISTB_MMC_DRV_CLK>;
> -		clock-names = "ciu", "biu", "ciu-sample", "ciu-drive";
> -		fifo-depth = <256>;
> -		clock-frequency = <200000000>;
> -		cap-mmc-highspeed;
> -		mmc-ddr-1_8v;
> -		mmc-hs200-1_8v;
> -		non-removable;
> -		bus-width = <8>;
> -	};
> diff --git a/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
> new file mode 100644
> index 0000000000000..05a435185e9da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/histb-dw-mshc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title:
> +  Hisilicon Hi3798CV200 specific extensions to the Synopsys Designware Mobile
> +  Storage Host Controller
> +
> +maintainers:
> +  - Yang Xiwen <forbidden405@outlook.com>
> +
> +description:
> +  The Synopsys designware mobile storage host controller is used to interface
> +  a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> +  differences between the core Synopsys dw mshc controller properties described
> +  by synopsys-dw-mshc.txt and the properties used by the Hisilicon Hi3798CV200
> +  specific extensions to the Synopsys Designware Mobile Storage Host Controller.

Drop the last sentence.

> +
> +allOf:
> +  - $ref: "synopsys-dw-mshc-common.yaml#"

Drop quotes.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: hisilicon,hi3798mv200-dw-mshc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 5
> +
> +        clock-names:
> +          minItems: 5

Entire allOf goes after required:.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - hisilicon,hi3798cv200-dw-mshc
> +      - hisilicon,hi3798mv200-dw-mshc

New compatibles are not related to conversion.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 4
> +    maxItems: 5
> +    description: A list of phandles for the clocks listed in clock-names

Drop description.

> +
> +  clock-names:
> +    minItems: 4
> +    items:
> +      - const: ciu
> +      - const: biu
> +      - const: ciu-sample
> +      - const: ciu-drive
> +      - const: sap-dll-mode

Only four clocks were in original document. Don't mix different changes
in one patch.

> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    emmc: mmc@9830000 {
> +            compatible = "hisilicon,hi3798cv200-dw-mshc";
> +            reg = <0x9830000 0x10000>;

Wrong indentation. Use 4 spaces for example indentation.

> +            interrupts = <35>;
> +            clocks = <&crg 1>,

> +
> 

Best regards,
Krzysztof

