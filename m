Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E58AC636D4
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Feb 2023 15:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBMPnR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Feb 2023 10:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMPnQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2023 10:43:16 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0E9E069
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 07:43:15 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o18so12720046wrj.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 07:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grZOW/8aqAxwWW1v+gy6Pklv/5DczNl6MJ8KfdGTD48=;
        b=Mn0epFcPhTHPvPIiTCKz49cfIAIM+YjqM9xB6cayrF/pkYdfjOIHLc/xGZGhBMVE2X
         1FVAmEk7CYrsaIzgV01uHkXgmnVZceRHE9SYeB0Otpxsd37gxUa2ZAeBAVHESnp9iNwI
         qeawgugiKeIuqjajD0obzmYzQ13jcEzo9gc59pN65kx+0euEYDnM8XmT3mTzQxegoptM
         QUQZ+mwp46/thb1S44mhedYlAkOVuOwnqAGAkdyTps8DgUFH92F7Jz8OLBUnKwJ84ty3
         IYrCywkjd5TuUfWpeTOAYYrOpBeSNtVsRAmyFiU1bu+zSJ8vCa5DYc1X6SbXSL/16+O9
         sp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grZOW/8aqAxwWW1v+gy6Pklv/5DczNl6MJ8KfdGTD48=;
        b=JCt/I6F/u77pwZo3y0Dpo5Hufc9kvZ5/41dWMB6Bb73WLNFgxAhZWQdnMWMvpTdxDP
         iGiy6SSU36xAoKrS02pd8uLET5EJsyfaaB94840/H4qFJZ1oVhghRnrV6gXjC9LUTbbb
         K3oYqZtMZRqsBhqECH+x5KtFpduh5+JT3un/CCIIT7yh1/qhtJXYe9sUGxGZflia1Psq
         WvzDj0p8W/sXBSMdCGOFlCuZJVvAmlRwWdp1GuX4c/2HXiiZCRguh8zcItFvGFoxmUOj
         27EOWQKfKHPZ90Pr6EVkh/AvAnAkM43c8BhloAA48CZEH43z2TVrod01NE1F1RPMGjM/
         cUkw==
X-Gm-Message-State: AO0yUKVQbefnc2TILT7Uu5qaz3ekA/rh8PJjOUm1M2kJUmxBcGZ2/E+h
        lb86m77MEdQQN7OaKekRuO3s1A==
X-Google-Smtp-Source: AK7set/fv3IfkRhQdb43GUNWPWUP+KWdabW3q7k8WpoMLDKXd9GZktRrSRP+huAK9bzTxI9M3fP0XQ==
X-Received: by 2002:adf:ec83:0:b0:2c5:56f6:52ce with SMTP id z3-20020adfec83000000b002c556f652cemr4737026wrn.26.1676302993959;
        Mon, 13 Feb 2023 07:43:13 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a4-20020adfeec4000000b002bfc0558ecdsm10735081wrp.113.2023.02.13.07.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:43:13 -0800 (PST)
Message-ID: <ea8b3ed4-2a94-5378-8c93-4bff1f58c70b@linaro.org>
Date:   Mon, 13 Feb 2023 16:43:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: mmc: rockchip-dw-mshc: Add RK3588
 compatible string
Content-Language: en-US
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230213152740.359055-1-lucas.tanure@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213152740.359055-1-lucas.tanure@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/02/2023 16:27, Lucas Tanure wrote:
> Add RK3588 compatible string for SD interface.
> 
> Co-developed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

