Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F076EC001E0
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Jul 2023 12:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbjG1Mmi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Jul 2023 08:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjG1Mmg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Jul 2023 08:42:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507EF30E1
        for <linux-mmc@vger.kernel.org>; Fri, 28 Jul 2023 05:42:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9922d6f003cso301839166b.0
        for <linux-mmc@vger.kernel.org>; Fri, 28 Jul 2023 05:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690548146; x=1691152946;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+KbO4xdPKJxm7Y0Oug/f+rZlfVccGAPsaII8ga9t1IE=;
        b=vjrwpTRqUy2wlGKrIoJwZG5PcfakgQE7OkxTehJXyQnMzMuH/KomDE7HxoYSO+LJ7S
         /bCYtJd93SaBwor/cOS/JoPjJZSyG3HKi4j50VpTaxRJgdZc5GZnsvmjDhLccOBqRDpy
         hjrImt0C0jpF4a7eC84I2gOvU/sDq7bF+RNekBFCzdC6ONkHJc2LqyEsL00XFdazJMWT
         1Qb/1Y6yRiJm2AYyCEX7TAbDuJ29g3/U5vS0wS+CzWXvLGYdUWOaCjozY6sRoMSPMawo
         SwRlnNQPcwf8zXxoSijQOjV0eWlfJpRkeineEfa0zvfq5yHwOGxa9TeBj430cw53vP+P
         Ifzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690548146; x=1691152946;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KbO4xdPKJxm7Y0Oug/f+rZlfVccGAPsaII8ga9t1IE=;
        b=NjMsi3WQo89GSnhSPs8Q/+OWIgc0TkxCsWqBH6HFt2enJJ80RPMiXHH01ZDAy4QuL9
         HYKiCDAnHcTZ3b7s+lyEKIe3Wmid0aGje3HDCqyES97T1J9DoLW74yGuHzXGuraEBzjK
         r5tjnwEr0JvjaEqIBUU8//TvOE3dPCiNBSh72mZfhwvvYEe6fLXfzZi9jf+thmOoOCXB
         FS95l0oBX42YuP/tzuGsfyjPVHSGHk2Lub5Br+ZFD9kRIiaRtxbBzsU+m1NUL7IEyIs0
         4FPnvHYnrUfGckM5uKzYeIfeP67d5tW2uAhFpu4KDcShoQU741AKhelUJIccAVTboMk/
         fodA==
X-Gm-Message-State: ABy/qLZqPKVL0u0CjVJ9tHVtblr2o15wE88ZUIDDKDgNNz/aeNp+Zxdz
        YH8POwF2sCD9JYkOM+4o5/zpxVPsp7XCVinWHP8uYw==
X-Google-Smtp-Source: APBJJlEbH3li+eeUrEvnIvtZqxvXF5f76Uz3szFx86grPDRc1mLQ/Zl9p+vNHsqSRyk1MjkK6rxqLw==
X-Received: by 2002:a17:906:95:b0:99b:c7dc:b02 with SMTP id 21-20020a170906009500b0099bc7dc0b02mr2295644ejc.57.1690548146740;
        Fri, 28 Jul 2023 05:42:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id cw25-20020a170906c79900b0098d2d219649sm2041956ejb.174.2023.07.28.05.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 05:42:26 -0700 (PDT)
Message-ID: <c28e3f10-0df5-ddd6-490e-7c644c71b861@linaro.org>
Date:   Fri, 28 Jul 2023 14:42:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 19/50] dt-bindings: sdhci-of-at91: add
 microchip,sam9x7-sdhci
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230728102616.266235-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102616.266235-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 28/07/2023 12:26, Varshini Rajendran wrote:
> Add microchip,sam9x7-sdhci to DT bindings documentation.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-atmel.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

