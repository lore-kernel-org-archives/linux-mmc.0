Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45379C433FE
	for <linux-mmc@archiver.kernel.org>; Sat, 23 Apr 2022 10:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiDWKEl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 23 Apr 2022 06:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbiDWKEj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Apr 2022 06:04:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F000716C15C
        for <linux-mmc@vger.kernel.org>; Sat, 23 Apr 2022 03:01:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b24so13134733edu.10
        for <linux-mmc@vger.kernel.org>; Sat, 23 Apr 2022 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hwSE7TDc6cFAJaZEfJMscDdMHu75MY/lCb9p7EVlJQM=;
        b=eKVlG0S5gFmB0DrWoxFQqgFXu+ghvX31Kgv3S3YxydkVIY5AIvTvSdjBvZ+mM/GI0o
         m1a4sM4CX2Ajaxzy4ED8eKYeoP5MQokiq4IyLjpvUbjVAiDv4AAR3ymDYwOV1YsEoGht
         eV1HZImAsWkTLH04ic5Z9s540rwlVpVuugWpY94GOcXM0ZZSNYB9aDQ4h0dD+Go8Q3aX
         fdFBTjXp9eQ6GoRDf8/1fs8z0DzE+liSWz2iyjWjPOVVjtvOKS9LmpchEtNSFjggePgZ
         QY33TmJGbtURKKG0hbMuwHpsfW+RrrrSJegkYNXmyqT/c7S17sMBeZ6a4D7EabN2uJCT
         ezsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hwSE7TDc6cFAJaZEfJMscDdMHu75MY/lCb9p7EVlJQM=;
        b=RQ3Z2YE1+L6+E3wMhQP/kOLREIltWStpWb0M+XOsp8kG7bl8o5lzLCVpr3bppH98qt
         z8rERJbuGK9lUZSwa8PIWVdOiGnLDxOp/e1jvboF2H/AusJcTuO2niTPX1Ma4aTZPS/p
         21ewKFCEDwYl8//6a/epLvxR3wEzokqNe42pRqF4TZWldV+Zz0SxzXqz+N3IGrb9ae4X
         2nYyojbFPno3CG0kar+SfQBJQYE5b+IS1OZTbeyNNpfDg8wMnC3E6ZdPQvgNe9eTLQW8
         OExvFsp8BhP5zFFh16BeVn6yPO4Ks/eElBqylYbv0wfooQIaVfwqpagQ2wIXauBEtvy7
         9xKA==
X-Gm-Message-State: AOAM530TOnE5xrtuzugMom9xN89Xcds+pYAjWb53xbID8FoeFLAj3xxy
        fmigt6s/yiOWhRJisjQZKlKB4w==
X-Google-Smtp-Source: ABdhPJzENh0r45+mF7Yc1XCr0LaVa3RPTBAzJvk8WTJfvb2ZwRvgYOxp/O+nQamFJVQ3evuGuO+cAw==
X-Received: by 2002:a05:6402:254c:b0:423:e51b:e1b2 with SMTP id l12-20020a056402254c00b00423e51be1b2mr9448917edb.161.1650708100556;
        Sat, 23 Apr 2022 03:01:40 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7cb83000000b0041b573e2654sm2003756edt.94.2022.04.23.03.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:01:39 -0700 (PDT)
Message-ID: <38c0cb0d-a678-d249-5d90-ea55a95a3898@linaro.org>
Date:   Sat, 23 Apr 2022 12:01:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv1 07/19] dt-bindings: mmc: sdhci-of-dwcmhsc: Add rk3588
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
 <20220422170920.401914-8-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422170920.401914-8-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22/04/2022 19:09, Sebastian Reichel wrote:
> Add compatible value for the Rockchip rk3588 dwcmshc controller.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
