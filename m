Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAB5C32771
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Sep 2022 17:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiI1RQ6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiI1RQg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2022 13:16:36 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F9AEEB60
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2022 10:15:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u18so21331827lfo.8
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2022 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yvPLxoKxASU1oV0ydqT/WaUJJZ+f2nyTFfImwwyybhM=;
        b=gZyEjk+n32pMC2gI++dHQxgG17ROlFc/Rvb3c+K/AU/nl1uoFy1H+qW8pkv5UpGjat
         yRPMAize2tCACO120SCUKuMSbs91+q47z684UJUN+g7du2TnFk9W/GJrlxKFg5i7gavZ
         qiIrM2WqXYGW4dJhFlcDFKrOzX1DyoV3Auae5yQUg+F/gYwv5bgnxnjCn5WEk4O595Wo
         ft6MEtg6k0x2ScwiLtw269gdKeVxZkYWxChZnCKuP7JVU+lNz7gZD5zFdPP6oXMSguDb
         uNsqKomugM/GpErZEuvJnUIKZWjI7md5ngpT9GaGkzSlZ/t1qSRNoOtOxejjFG3uo1Sj
         Zv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yvPLxoKxASU1oV0ydqT/WaUJJZ+f2nyTFfImwwyybhM=;
        b=7QYhZ3e0zJS6b9k+mJFaHVVvunqlGJnX7vQsrpTdt1tzhtRDkh50NQQp3bFHayaAGz
         iWMuRBJoYZI97ap0/9eDjbhTkli9EtR6yXjJ5rdL4IAveZ9O8tYZtIJ73bf6hZ/YfVLO
         GSEzCI39aVhVZ3YNq78TLegiobhDt8/fNJt1nTx6S+4mtsY+fyh2Ecw6dMPF+z3dEE+c
         8XXB9Vn51EAIFsqW9Tm/vET/1dJIfKZDTc6tjeRBLBWw/U68oRxuR8mmqwwelusZfYB5
         ZjZYSeVlqIJaoE188cRfayx5hUqJOxeacz65MrAOkjL0F/ccgIzqaGjvGZw0V3tkftau
         9FGA==
X-Gm-Message-State: ACrzQf1N9K0CimNe3nf5uOPKkPR2W6c60INxUUdrNU/KJWjotNNmWA46
        Zoxe42I2cckQSkbEE9m7BYxgtA==
X-Google-Smtp-Source: AMsMyM6CMlioEhHvKg/S6bggNWBpvr4jWCPRIj3BoalVJONNliyV8cxuDdIf4DcvQdjpOTg7fZti5g==
X-Received: by 2002:a05:6512:401f:b0:49e:ea65:cd49 with SMTP id br31-20020a056512401f00b0049eea65cd49mr13368705lfb.419.1664385353790;
        Wed, 28 Sep 2022 10:15:53 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q6-20020a2eb4a6000000b00264b292232asm476672ljm.63.2022.09.28.10.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:15:52 -0700 (PDT)
Message-ID: <ef396764-af53-8e5a-5203-f3e103bbb7a3@linaro.org>
Date:   Wed, 28 Sep 2022 19:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv4 1/3] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>, jh80.chung@samsung.com
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220928165420.1212284-1-dinguyen@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928165420.1212284-1-dinguyen@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 28/09/2022 18:54, Dinh Nguyen wrote:
> Document the optional "altr,sysmgr-syscon" binding that is used to
> access the System Manager register that controls the SDMMC clock
> phase.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---

Thank you for your patch. There is something to discuss/improve.

> +
> +allOf:
> +  - $ref: "synopsys-dw-mshc-common.yaml#"
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const:
> +              - altr,socfpga-dw-mshc

It still should not be an array, even if there is no warning.

> +    then:
> +      required:
> +        - altr,sysmgr-syscon
> +    else:
> +      properties:
> +        altr,sysmgr-syscon: false

Best regards,
Krzysztof

