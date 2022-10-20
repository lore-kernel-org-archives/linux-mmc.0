Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4048C43217
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Oct 2022 18:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJTSUW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJTSUV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Oct 2022 14:20:21 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E89F037F
        for <linux-mmc@vger.kernel.org>; Thu, 20 Oct 2022 11:20:19 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o2so463543qkk.10
        for <linux-mmc@vger.kernel.org>; Thu, 20 Oct 2022 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vfRqvICwFOrLHDo6+IXFWjGDmS/WdT8jBtA79yR0Wyc=;
        b=RnpwSu+KDOp0ZqfM1F6m8caLR9vvpt4m+OzCNdCSddvc4eP3GbifY0n0thFN/VBRKB
         h3OI4VAUhvKoEmnNENnGlbaE6Sz19B5ITzgbvpXT61u4nw5pNlWrZACa9C4gWjWVjVEg
         VZ83c0aSRjm9HB6k4n7M8DR5JeMBys96HXLRvnJMD79Sgi4js8z9yXbaeeOS97FzOC47
         mkMjVYYWQFbOSqzRzO3mJL7nwwXPD/8et1quMd2oSZDxTcrcxrUh0arU5L0D7KH0Xor9
         RXF/1BO1WA/qLt6vfwCYRY4GEFG5jWnCxKXXhggi7JmN4aS6PyrWbDw8SAsETJgQ2K3v
         qNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfRqvICwFOrLHDo6+IXFWjGDmS/WdT8jBtA79yR0Wyc=;
        b=BM6DwfYEmW3iZ2Jpf4KFOR7LA6Sf5OwjmTUbAVrZm9KqZLp3b/IjS3amDyzcJiIqqv
         Tzsm09KluP8g/8NmW2gxLk5z81eTVVr+MJxwluLmMehQVgO6wBfSOWeFZnuXJWFljzeA
         2jte3sJxOW1DJIC1g5Ye4YtZM1vEt8/IppjMfGVvOu53CJNaZ9Ig8XF8b21t6ofd7TKG
         W6ggyYr+f5nYMZQmv/OzUYPAO/bvLvZmDy692JeyyHuNUZioAbaPMn5fLMN6h+4ssiTk
         R/zSvkV+kMAdkmZvvEWapLRP8mG62lseAhABZ3A7BSz2v2SbAke34JC1CnsBohlDyZDt
         Z1CQ==
X-Gm-Message-State: ACrzQf3dVniHwzlutH2YS2VbRvGE6oGMQ+W1yiFWzRJ/dL1T4HmOXKrC
        NXhUT71axXZlmAW/CPLjwCJohg==
X-Google-Smtp-Source: AMsMyM4PlzDbHD1dIL5dUIXCQJz0wfI6IwENSHLqeWgeyo6sB2dd5Ccvzmp43BYMOwtZyFPcxznJbw==
X-Received: by 2002:a05:620a:254e:b0:6c9:cc85:c41a with SMTP id s14-20020a05620a254e00b006c9cc85c41amr10515136qko.260.1666290017554;
        Thu, 20 Oct 2022 11:20:17 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id h24-20020ac85158000000b00304fe5247bfsm6443656qtn.36.2022.10.20.11.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 11:20:16 -0700 (PDT)
Message-ID: <bc0a9297-7adb-7cdb-e5ee-1d6e80eddb04@linaro.org>
Date:   Thu, 20 Oct 2022 14:20:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCHv5 1/6] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>, jh80.chung@samsung.com
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20221019170657.68014-1-dinguyen@kernel.org>
 <20221019170657.68014-2-dinguyen@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019170657.68014-2-dinguyen@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/10/2022 13:06, Dinh Nguyen wrote:

Thank you for your patch. There is something to discuss/improve.

> -allOf:
> -  - $ref: "synopsys-dw-mshc-common.yaml#"
> -
>  maintainers:
>    - Ulf Hansson <ulf.hansson@linaro.org>
>  
> @@ -38,6 +35,35 @@ properties:
>        - const: biu
>        - const: ciu
>  
> +  altr,sysmgr-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to the sysmgr node
> +          - description: register offset that controls the SDMMC clock phase
> +          - description: register shift for the smplsel(drive in) setting
> +    description:
> +      Contains the phandle to System Manager block that contains
> +      the SDMMC clock-phase control register. The first value is the pointer
> +      to the sysmgr, the 2nd value is the register offset for the SDMMC
> +      clock phase register, and the 3rd value is the bit shift for the
> +      smplsel(drive in) setting.
> +
> +allOf:
> +  - $ref: "synopsys-dw-mshc-common.yaml#"

If there is going to be resend, please drop quotes here.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

