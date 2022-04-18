Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C618C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Apr 2022 11:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbiDRLqN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Apr 2022 07:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbiDRLqL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2022 07:46:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFD61582F
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2022 04:43:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id t11so26337336eju.13
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2022 04:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=K5VFTkItBhPN90YMdU8CWhA6XeIV4gqA7vd7xl6JZvs=;
        b=IIOonIr6w+EOL7nEdJx1+v5w8AjbfrzABOsF2hgt/cGhEcnJUSN1e7xq2gGEZnJRpW
         y/sTz/qBzkUN7FijyoN0QMG/NjifiR3aRXMsCgq2HnNun+hqblYT/GfZIyOejR2SySPv
         0gKrAJsMYx8DvIVpfOi/ljQ8VAer9qZscUS1A002a1k1hMeUbBFWXQZSI2I3yd/AfZSd
         ncKVOqbDgSrWdtoAw4r1KS32CbIkLYr1iwwYV3EBDdpYsMQHN2ew5iBzf+3c0JiRqLJD
         ZCuCbLWUKYK+XvP2o7BqGAsngxT56uxWCvuYaj5FdJym5G3yyXNLTTlZVLR4c0YwOAip
         jo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K5VFTkItBhPN90YMdU8CWhA6XeIV4gqA7vd7xl6JZvs=;
        b=HTzQD/cY5AxmZnXlcegqldyfFdnFEMcJnLnk/pJYg7RHoPtY6Qx40inPX4ScqbstuY
         ftABANqr8EHL6pzKeXCPoA/73YXoL1fH+LOlFbES6Wx46PeseBMW4FlXflxJqR1IV67A
         35E8cnEEt9wJfeQZoU9TAPenpWZXyEJ3z274dhhpwQ9HsRAfJvpLSFKzZsAqZqPsBGFr
         taHXo9M8X+lOIjo0VIsDiEyLK1m3g3r1dUTU8WYDNU3F1/PPL/0nOt6TxrNhBI3o/JpD
         fGhv7m+kJQtHKNp10X979l0WP3Ago9NcEinHvN+Oafi2xUPdIV2AZZypwAfn3WnlyR+b
         TdIw==
X-Gm-Message-State: AOAM532Wb4TJG4m9PaWQOg6ar1J1v5ULM6fTs4IOLnBW+IZfexIqJQ0B
        3sUjiNSqTR3D8W74D2Tfdqvfew==
X-Google-Smtp-Source: ABdhPJxjYZY985v8Pfrex1Cnl+eJoXXj6gpnlZklI4bIIFwGaCNeV6NELuvZ0KWRcpU1IjSmuy37Mg==
X-Received: by 2002:a17:906:52c7:b0:6ce:a880:50a3 with SMTP id w7-20020a17090652c700b006cea88050a3mr8643692ejn.437.1650282211473;
        Mon, 18 Apr 2022 04:43:31 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n14-20020a50934e000000b0042053e79386sm6936955eda.91.2022.04.18.04.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 04:43:30 -0700 (PDT)
Message-ID: <1e3ede4e-994b-4d87-b907-ec68661fb958@linaro.org>
Date:   Mon, 18 Apr 2022 13:43:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/4] dt-bindings: mmc: convert sdhci-dove to JSON schema
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220414230603.567049-1-chris.packham@alliedtelesis.co.nz>
 <20220414230603.567049-5-chris.packham@alliedtelesis.co.nz>
 <YlivMII9rDCcB6lk@lunn.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YlivMII9rDCcB6lk@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/04/2022 01:33, Andrew Lunn wrote:
> Hi Chris
> 
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/mmc/host/sdhci-dove.c#L78
> 
> https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/dove.dtsi#L344
> 
> Dove does actually have a clock. It looks like it is optional in the
> driver, but the .dtsi file has it. It is not documented in the current
> .txt file, so i can understand you missing it.
> 
> I'm surprised the DT tools didn't complain about an unexpected
> property.

They did. :)

It seems binding is a bit out of date, so Chris should extend/update it.

Same comments about maintainer as for patch #3.

Best regards,
Krzysztof
