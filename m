Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB5AC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Apr 2022 08:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343926AbiD1IQk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Apr 2022 04:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiD1IQO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2022 04:16:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFD07C16F
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2022 01:13:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y3so7925934ejo.12
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2022 01:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D4oCxzRFXlzFb4EquDzVhE4rkJditmYiFd7ltTpGoyY=;
        b=tvfiaHMagceqKr7/DpjX41Hyv5lTrjlzfCaggv3jsnwxdIr8mK7xT48mgDGVBkLdeb
         OzZK3YaJmwX+uLSgALT+ZMsOwJmlHpDOmAPPgnqPCQYuHjmTG93dQhWYt/N6RpqoaF1p
         4gkTgrCrcnmLtt278WwioqUYPZ0ZgVmM/TkHAnNu+T+ubnghjkniIOxgBEWPV6O4rlPw
         pWqfBA3lUgMwonr8KvgfAucsMiDGQ0mlOZnnCY5S18ItmEU/aWJV8JWd89i0V9TfTo+L
         7/SdKNZnBE1p5Aciy155bg+ETEUJzvNSSveubimeqjShgxPjKAgM8GRRXJt76K+ZO8Tc
         KBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D4oCxzRFXlzFb4EquDzVhE4rkJditmYiFd7ltTpGoyY=;
        b=s61CNl3qfwq/aR0vZN00++pkVQghQZNgUco5Y9xvDbyx0xNyN4rTNHYGJGPUX23Yo5
         8jaaQz1nN+B0vWsPQrZh0sd4uywfd32ZPI4H94Q2EgLwfppgMI8xuRyx/HaA21Ws80ow
         UcFNkHwJOIm0/S9nBX04DPhEeuUSvhrgKaQ4yKfK6TFJmkiCVrIPXLaMlZpdQRn0G357
         i7oyFxskfQKB6iYTzSZkbCCrKx6tOAcQunBhgefZ0fZAF92siL6v065486KWulJbY38O
         tNXi4uTR866MluJ9TWxDq39re9yr+MUurYioYCqS1peNMOgKeVkm2MnxI/VHqC8hNUuT
         H1vg==
X-Gm-Message-State: AOAM531FUWssWm9MATaL61qDXSGsYwt2YCBa6qbMGWCXouRSY42uuRDP
        W3xTq+S26xf8aKay9kJEqN50AQ==
X-Google-Smtp-Source: ABdhPJzK06wInFNLQk053v3hrpwhhJMdYOSTWClNddC6Y9MOu/hDlBgc4sOn+tCpnBrLUecCVkbeuw==
X-Received: by 2002:a17:906:9c82:b0:6e1:1d6c:914c with SMTP id fj2-20020a1709069c8200b006e11d6c914cmr29611725ejc.769.1651133578760;
        Thu, 28 Apr 2022 01:12:58 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id dm11-20020a170907948b00b006cf488e72e3sm8052832ejc.25.2022.04.28.01.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 01:12:58 -0700 (PDT)
Message-ID: <e945cc6f-fd1b-5ba5-fab9-33672994d54b@linaro.org>
Date:   Thu, 28 Apr 2022 10:12:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/4] dt-bindings: mmc: Add Broadcom optional sdio_freq
 clock
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220427180853.35970-1-kdasu.kdev@gmail.com>
 <20220427180853.35970-4-kdasu.kdev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220427180853.35970-4-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/04/2022 20:08, Kamal Dasu wrote:

Thank you for your patch. There is something to discuss/improve.

>  
>    clocks:
> -    maxItems: 1
> -    description:
> -      handle to core clock for the sdhci controller.
> +    minItems: 1
> +    items:
> +      - description: handle to core clock for the sdhci controller
> +      - description: improved 150Mhz clock for sdhci controller (Optional clock)
>  
>    clock-names:
> +    minItems: 1
>      items:
>        - const: sw_sdio
> +      - const: sdio_freq # Optional clock
>  
>    sdhci,auto-cmd12:
>      type: boolean
>      description: Specifies that controller should use auto CMD12
>  
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +  - if:
> +      properties:
> +        clock-names:
> +          contains:
> +            const: sdio_freq
> +
> +  - then:

This won't work. Please test your bindings.


Best regards,
Krzysztof
