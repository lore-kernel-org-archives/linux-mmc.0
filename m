Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C689C64EC7
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Feb 2023 10:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjB1KzY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Feb 2023 05:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjB1Kya (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Feb 2023 05:54:30 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453C12ED60
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2023 02:53:55 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso3938428wmo.0
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2023 02:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677581634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOZCIzKrLTMqexjdZ2+a46sW/ksovWEJrh6b6pkknJY=;
        b=DG4VdlFfrwoslciGBpeJ/7K5UmtLc/A6qW3CwFQsEWI8/MquKTXwdV/ulHNNICofqI
         N0sOkqVwtlb9sGSdZRivdyLNxHdnLBhEiK0UWEFH9pVtNsmoyLgELrXGXTwFyGunCzHw
         KsjzNUtXix+SJzFcYgQf4QQ1NZUtW24vCmyJveJrHOY+2e4wb5CcBsoymRC0+WYIAHrH
         rMwVT7Fg2KBjd9x2yRAx34yYSyMPF9/ayvb9JsbaANMJpdtdS7MpzPx+JkCmnh+q/kju
         AeK/4I0A6kHVzcDNdM9XubvCfaEQZQq86/4UYiZoUYVyABvJUEOwzxTh+ORGrEwHxtGA
         quHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677581634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOZCIzKrLTMqexjdZ2+a46sW/ksovWEJrh6b6pkknJY=;
        b=ozmhtWDqgCBKcmrOkeaLFS8ACPEtIbeKEYG+FSd75CtTFtU75SrFfXvuArS5yUegKU
         uRNsWrQ2UmUdQnwK518Rh/MmAuYD9kOsU+r6+E34eDxC87b9i93eIQhtidXpXICOjuEu
         dbrcf3kD8Y62OYLs9VtMB2IZs2J2CGlxH0n8Gp9w8QZPGT4bQPlUvXTKKCbzwSvmtbtC
         fhNQuMWSvWMkZ455NGKexNKsDMQIAZ7m6wnwxUTpxdfmn3XjzEim/HKxWtOxNusgr06P
         VtvSot3ZPwfvc7FQqEjVT+kLQqoJWnhm6hAk/P82d4CrlW1n+SLv6kd6GXQ8ybv9YcEs
         vtgg==
X-Gm-Message-State: AO0yUKXoPfR7+xfFkZGdW8y9rWQtQgoNOvFTI8YWEsu8ijOKBhV/dl0w
        MDIQqIrDlIEc3sD8utd7mf467g==
X-Google-Smtp-Source: AK7set9K/cJjOM6W7cKYRxtYxRSV69UDHU0t2RPlCILopPormRrRmhWgL1FNrkSC4+RMxrZ2z8podw==
X-Received: by 2002:a05:600c:35d4:b0:3eb:3945:d3fd with SMTP id r20-20020a05600c35d400b003eb3945d3fdmr1671382wmq.14.1677581633700;
        Tue, 28 Feb 2023 02:53:53 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ja6-20020a05600c556600b003dfefe115b9sm12251903wmb.0.2023.02.28.02.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 02:53:53 -0800 (PST)
Message-ID: <90b332b7-ba62-d9b5-2d94-5d2e70fad4af@linaro.org>
Date:   Tue, 28 Feb 2023 11:53:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 5/6] dt-bindings: mmc: sdhci-cadence: SD6 support
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com
References: <20230227183151.27912-1-pmalgujar@marvell.com>
 <20230227183151.27912-6-pmalgujar@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230227183151.27912-6-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/02/2023 19:31, Piyush Malgujar wrote:
> From: Jayanthi Annadurai <jannadurai@marvell.com>
> 
> Add support for SD6 controller support.
> 
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 24 +++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 8b1a0fdcb5e3e2e8b87d8d7678e37f3dad447fc1..0dba17c4f17f82c8ae68e46225ed72418e8361ff 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
> +title: Cadence SD/SDIO/eMMC Host Controller (SD4HC, SD6HC)
>  
>  maintainers:
>    - Masahiro Yamada <yamada.masahiro@socionext.com>
> @@ -18,7 +18,9 @@ properties:
>        - enum:
>            - microchip,mpfs-sd4hc
>            - socionext,uniphier-sd4hc
> -      - const: cdns,sd4hc
> +      - enum:
> +          - cdns,sd4hc
> +          - cdns,sd6hc

I see here rather random set of changes in each version of this patch.
This does not really make sense. You are saying that existing (!!!)
mpfs-sd4hc is compatible with sd6hc. I think you wanted oneOf here, but
not sure. Can you explain what is your intention? Your commit msg is
just one line saying the same as subject, so not really helpful.


Best regards,
Krzysztof

