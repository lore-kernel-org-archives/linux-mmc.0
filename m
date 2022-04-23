Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096CEC4332F
	for <linux-mmc@archiver.kernel.org>; Sat, 23 Apr 2022 10:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbiDWKHB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 23 Apr 2022 06:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiDWKG7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Apr 2022 06:06:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9346419980E
        for <linux-mmc@vger.kernel.org>; Sat, 23 Apr 2022 03:03:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bv19so20696434ejb.6
        for <linux-mmc@vger.kernel.org>; Sat, 23 Apr 2022 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0Icd0QAbAtveEL91sUdo5gIKdYCb50RUGDVuACnzMBA=;
        b=y0U6kKeTSJrRSx3RwWcQ0eQL1CpI9mjhmBG/0ir83Tb/3Sauck6I4DwtmPT3GdkTEM
         TEff/fbyESPUovuRvnrVa21nS49D6kctnFlvdJtJ/UA+aLOez9oCL7OQCK4jKpCmSQj3
         v6qTIkhxDTPoWAXQUOxfzHkr6Kj6vVHIMZYE7404AUgjroqkDNZhtwGmp06SGYIEVp0a
         Nj37KgaVzGivlCYYk3c8mq0mdDvBxGMKordQJoxkFliqPA2+TVFfPxmzf0AfcPOY8b3R
         edjDlnq0ZusqEQfdvu9VCC0Zbx7uoTPRUEKJQ3xKbOypA6S02LhE2Na9Z66E0Aibb8Ta
         1Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0Icd0QAbAtveEL91sUdo5gIKdYCb50RUGDVuACnzMBA=;
        b=YErh2pyTCpIGT5pPYZ8C5lrDVc6Hc0G2NQSBAcyrgxE5ZGg0l7HpWYaXDhAH+aV3Db
         bPtfX5WWcFVqgOzR4Hn+tvY13d1HG7oTCWD9vhXgonGX4KWwAE6FC0slPaKp13UXVYbJ
         hjy/tWXECwtckb/lmiGidy2MlvBVJDoSWaX7GuC+Wbrv1WxdEgoSQSG+/sgtvDS/7Wo1
         lkhcg9gjRG97Dzuy9mLHM0ho9RNNooZB7ewfOIctI7wndFftuxRJhkRkjvBwg1LCzm3X
         e+C31sfUyc5uRqaaUXmKpM0p9SGvc3pd+AWriFmS2JBVZlTKjTZ2AiCooe/2TwQNXlNX
         dRTQ==
X-Gm-Message-State: AOAM532qqz4j5lgMEwtfdWDCaZ4pTfIpR7itgBuXcflxWiPwMnfZq8TJ
        t9ZJJ4T76AR3TSTBuGqiPogisg==
X-Google-Smtp-Source: ABdhPJwwvzUM3czsC7y+DnJmlUATBP02rRRtHr6o+QLgSRIt2B1L09BhY9Em2/0XG1XFFaH+X/rp5A==
X-Received: by 2002:a17:907:168a:b0:6da:9177:9fdd with SMTP id hc10-20020a170907168a00b006da91779fddmr7833441ejc.757.1650708227007;
        Sat, 23 Apr 2022 03:03:47 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g3-20020a1709063b0300b006e8872f6585sm1564265ejf.175.2022.04.23.03.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:03:46 -0700 (PDT)
Message-ID: <2e2f5a33-0286-7a89-3842-10d8cd3fdc65@linaro.org>
Date:   Sat, 23 Apr 2022 12:03:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv1 16/19] dt-bindings: soc: rockchip: add initial rk3588
 syscon compatibles
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        kernel@collabora.com
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
 <20220422170920.401914-17-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422170920.401914-17-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22/04/2022 19:09, Sebastian Reichel wrote:
> Add IOC and PHP GRF syscon compatibles for RK3588.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

You don't need to adjust anything in allOf:if:then: parts?

Best regards,
Krzysztof
