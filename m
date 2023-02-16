Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB760C636CC
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Feb 2023 10:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjBPKX0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Feb 2023 05:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjBPKXZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2023 05:23:25 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907ED42BEE
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 02:23:22 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id t24so4000780eji.4
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 02:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQPmFYlzbC7KvPA9vOp38pjRFiHeLAnLDwoDfy/DHCQ=;
        b=G+3SK83ZR+HwM9/pu4pN5BF9nCzAAVMNouC4FBsdvrBx/CahgW9lfHK94lhACaEZ5Q
         tqC7+DWQZXXgTWKiSH9amNNGRs45HJ3yC983P8DQwUARHzT8F269RqvWGGybRLke1vEC
         VFVjsLaY7Hjxia/B5LHgftlTN5STrzqIwP52AGpNfCyLhMuE+TFqdFTEkBVuqpwAZuE+
         qP8CiWZOxCsfjVsoNGHIUslW8B/ozITvXANUiKYg9arfgeOqzNuMQOEwEigN7uxBLkJ/
         NaPsqvFRc8FtQP75N00Uw1mDjGiz9irCKX17djHPjqy8Jp8CXJZgyXADQ/lUkQ3bX33X
         VoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQPmFYlzbC7KvPA9vOp38pjRFiHeLAnLDwoDfy/DHCQ=;
        b=xDe4AH3nYjC/i2CP8kNmu1Jt3NzYZX5ptFkuUM2Hwac959XdTaDLumfXRDiOM2p4Nr
         NWvl/ZCd1mrDDSyyr0VDA9Vss/bYban/i29Okh0UeAjANzKFTGN3fHPOdWGfRZdrcl2l
         0cYt2Sr1f7HRP27Jk3ytS/52y7d0ApArhN2s27K7sES9vDWg6vWYbd+ayfrBfez3kY7D
         I2DLQkMm1haqAsThE85WgHDIS4DegWPJ53VDIBMgfPu5+R6E9OIn+F7pIYyKbGGTbFs0
         kFvoO17REtJXwm9YkUuJEWd6gsHyO3QJLbFRgjQBcJifYj992wFktCzGjBkNNEGJVtV9
         S0yg==
X-Gm-Message-State: AO0yUKWIe0dgxhObVwUEKSc9kx8TUdZT5ZzE4fgtJ1bCIjmgJO2zsWq9
        hd8SAwINEohgA12lFWV+6mxE0A==
X-Google-Smtp-Source: AK7set8RV32dZOV4847Uqa2HdLcRmRKN2CKjNW0l1ybJNPeIB6ipclW+lCXzwJkdnZR3ULc1QG2mWg==
X-Received: by 2002:a17:907:78c1:b0:8b1:32dd:3b0 with SMTP id kv1-20020a17090778c100b008b132dd03b0mr5426062ejc.57.1676543001076;
        Thu, 16 Feb 2023 02:23:21 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709063b4f00b008878909859bsm617630ejf.152.2023.02.16.02.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:23:06 -0800 (PST)
Message-ID: <41bcc545-6eda-6c30-c600-d97ef009abf2@linaro.org>
Date:   Thu, 16 Feb 2023 11:23:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230215113249.47727-5-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/02/2023 12:32, William Qiu wrote:
> Add documentation to describe StarFive System Controller Registers.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---

Thank you for your patch. There is something to discuss/improve.

> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - starfive,jh7110-stg-syscon
> +          - starfive,jh7110-sys-syscon
> +          - starfive,jh7110-aon-syscon

Maybe keep them ordered alphabetically?

> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@10240000 {
> +        compatible = "starfive,jh7110-stg-syscon", "syscon";
> +        reg = <0x10240000 0x1000>;
> +    };

Keep only one example. All others are the same.


Best regards,
Krzysztof

