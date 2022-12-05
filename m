Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FFFC4708C
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Dec 2022 13:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiLEN2p (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Dec 2022 08:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiLEN2m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2022 08:28:42 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4C6D2C7
        for <linux-mmc@vger.kernel.org>; Mon,  5 Dec 2022 05:28:41 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id d6so18521500lfs.10
        for <linux-mmc@vger.kernel.org>; Mon, 05 Dec 2022 05:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PwSI9VpSC/SnPqRCsbFXKJqXLt4ZCxc6QuP46DNYcMY=;
        b=WVnAq+lZ2HiSrilXWp2Ul3M6gr5yHOz1Yq8pokBcsMHzLha9GSfvDl78s3x9BXjGYd
         DiPU8Z/mZrbGo/txLqzd8Yo5AgXsi81ZBFVsfGrvTdS61NfzgfHcNekhTv6cQzXiAf50
         JO6bE1EbcOPjOBXD/EbOW/KGRmtqJ5Dbaw7uLrIfCttC339iHa64yCzp4xAA7U1UYmSU
         T0+oJbEA33Hy64hHoUrEVGWD7gTjJVeDYzaX1xwuHQVodJRgslnUJh5uaLa2iSli3mYP
         IQwXnaIP8VPynZqTAhTvOy961TRRWE9WzObJ6ykn4c75RJqJKuBoUxrHXNc7LfESqEQ0
         tTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PwSI9VpSC/SnPqRCsbFXKJqXLt4ZCxc6QuP46DNYcMY=;
        b=i8n2YQdKskJkxBWriD8CdzDDh+QldYwkQouL+8DQs+5Yh57or7FrK8qtYty74MiJkk
         26V9CCpDotJXoygk9NAkJjuApVpwgcr+4RwyNX8N7FFyrkpiSPSV/fJllJ44xxZl40K+
         k1a3kssPXco/9mtGp7gSzTKsYKT5xInQYhnuH2467puazjyqwnHUIEKSivLkGfz5cXpJ
         V4wsfm4Z1K61wHT/jZNo6Vf1KZSbMKg/SPu8ihP5R+yKDvf14DS1wWa16FM8pATEf/7c
         jz9X+AaXRhJhei0pV390hiXtyndsylYBvh0Fs6lo5FndsfmqckK+0uVPNWO1lWM2REW1
         bj4w==
X-Gm-Message-State: ANoB5pkl6O2J6pfVkYyoHqC0LPyyAmWV8WMdk+05f8RQLNILq1lMI47G
        MIcGuFU0oeNKys8XMUVTeCp9hg==
X-Google-Smtp-Source: AA0mqf47eVeP3XuAAV0TjUHuoggvWzWVGid4sHibX3LLyBqIrfuIWHZOpQLOPwzwcboLQEHLMq0lKw==
X-Received: by 2002:a05:6512:3187:b0:4b3:ec7a:6752 with SMTP id i7-20020a056512318700b004b3ec7a6752mr26025043lfe.79.1670246919654;
        Mon, 05 Dec 2022 05:28:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k14-20020ac257ce000000b004b5284a92f9sm2129447lfo.208.2022.12.05.05.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 05:28:39 -0800 (PST)
Message-ID: <f2d7a6f0-2816-2bf3-efbb-015b43bbb686@linaro.org>
Date:   Mon, 5 Dec 2022 14:28:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: xenon: Add compatible string for
 AC5 SoC
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
References: <20221205105931.410686-1-vadym.kochan@plvision.eu>
 <20221205105931.410686-2-vadym.kochan@plvision.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221205105931.410686-2-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 05/12/2022 11:59, Vadym Kochan wrote:
> AC5 SoC has Xenon SDHCI IP, but with a limitation of maximum
> 2G DMA address range.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> v3:
>    #1 Put compatible string in alphabetical order in the yaml file
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

