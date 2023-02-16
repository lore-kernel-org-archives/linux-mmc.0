Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406CFC636CC
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Feb 2023 09:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjBPJSS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Feb 2023 04:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjBPJSP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2023 04:18:15 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE34321A30
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 01:18:10 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a3so3627375ejb.3
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 01:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0OaMl2j24ssPCY78+tQ9h2rBFC0lvbgjl9TBRcDzuE=;
        b=WSk8SkTl9EoyJJ6lWRhrOy4GIRLG55z7HOikjpJK9gD3ZnNWyV8WiBs28KD7Vxtvmf
         5JJfNhqL/frGPEeRE73OuIH2lc2P1S1yxBYBfZ+f2HZt846a+pViAAcQAb27QdlR94F0
         ppdwMJIYaskjEZbuXw3ZsZrvlmJCFC+k1+80ekw6jc+gHQrFQjIUOMSaW6CzG1VMgE6Y
         sTQ9bNByHWroLquA6MkenemTD0BrPDskjgOrWfxu1uaZeZm8eOEmkBFLAeN/AXJV7r9/
         lI6MQXztcBQjjuLsU/2KOLCMOxRxbIEc1JvqQMEoFSAy8n7PiYePWIsgzBrfG0mH2Rcj
         dwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0OaMl2j24ssPCY78+tQ9h2rBFC0lvbgjl9TBRcDzuE=;
        b=GyKlJFPXmEGfkxjp+gtEy09XY1neDsJBFTu5XkegY/uT47lrBpu8lax2shQF1cmDaW
         BW8UOhQYu09dyvgJeObDwJyls8IPfNmc+x3lEXovBPDT591041hu6RVX6mTj8p/LRCE/
         ututVjYN2mdZT4hQv0nZAmiFfyr4AXTQMrlFbt1ivux7lAXI+EpkyJk7LtjvL8jR+sWc
         IXS2pv0Y+8LZePWkA30dn2wMiRNfGh77It5zZhAwk1sscYQss58obPbQJttkJXTNxG0W
         62315CopLb5/jrkJQ5lsjxo9NMQ+yIE5SpwXiBhg8n8HzOijtdlgXXEeMXphoe1IGPgb
         LWkQ==
X-Gm-Message-State: AO0yUKVY9JbwTPy42Tc9xKj4c10zRknIavZPjlUDnjvBmGLsBtwZjEOH
        /UbjlxG3vgyghs0l4sIhvtpJ3A==
X-Google-Smtp-Source: AK7set/0yZSEl0O3Eolg3vrUoRP0zKyWipe/qhUAkIfNDz34VhzrmmAd1oAq71N9MXp54mBNbA5Kqw==
X-Received: by 2002:a17:906:379a:b0:88f:9f5e:f40 with SMTP id n26-20020a170906379a00b0088f9f5e0f40mr5071128ejc.68.1676539088937;
        Thu, 16 Feb 2023 01:18:08 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id md1-20020a170906ae8100b008b174ef3cdesm111131ejb.27.2023.02.16.01.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 01:18:08 -0800 (PST)
Message-ID: <b87003f6-02a8-64fc-80fb-b90ca6bec37c@linaro.org>
Date:   Thu, 16 Feb 2023 10:18:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: meson-gx: support specifying cd
 interrupt
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <15df9ef0-9b73-ca5a-d3cf-0585cd135bc5@gmail.com>
 <1c5996a5-491f-39d6-b120-bbef86473729@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1c5996a5-491f-39d6-b120-bbef86473729@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/02/2023 22:42, Heiner Kallweit wrote:
> Support passing a second interrupt as card detect interrupt.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> index 46e235bf2..c8c30300d 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> @@ -28,7 +28,7 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    maxItems: 1
> +    maxItems: 2

Wait, you now *require* (not support) cd interrupt, so this looks like
ABI break.

Second, you must describe the items.

Best regards,
Krzysztof

