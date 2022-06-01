Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3C6C4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jun 2022 10:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351961AbiFAKOT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jun 2022 06:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351938AbiFAKOR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2022 06:14:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78DA60B88
        for <linux-mmc@vger.kernel.org>; Wed,  1 Jun 2022 03:14:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q1so2698715ejz.9
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2022 03:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SCHPOUMOkaORGlqy58IkS3kpUvVCYFXurWLIORn2AWE=;
        b=oX8r6cnrONYzWQLu1cF62jtFMmRaDtC+21kXez97YRlUf2Jyl95FPKczr8mU/ReGly
         z7P5u8WAp44O21UUQdIFPB3x02sIUSU455RtDaEN2mTOmsPbDwD47tE5o9T63Gu4+baq
         pivfLM87zuWSFgT4oifuhfEBZBVaKCFKlxjKPatZ8TIGdefR5KTbYFY+1xMFzDY4xIkJ
         JviF+hXQ4JzcCjIg3Fe/gVxaPTzp+c0zlUhym1l/XZZNOGGsDM0u/Wo7J2JhMx1/cPOT
         nhJDMR4Hv9hM0PzxtGVLbYH4UzwjPC5nsi6rp3lU7SfipwtBuZAKGErF2HN6FyFoYUj6
         pduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SCHPOUMOkaORGlqy58IkS3kpUvVCYFXurWLIORn2AWE=;
        b=0WADlqS8H+0wBMHq5h66OegQ6OEhff9XaROuVY/dkNsInloI0BgqZQWWH1fdoGn5qI
         OOY0c7u44Om02Ap/SpmuaLczh5fsiTaLQJzrpeZ2QD4Fsv2qWGUUiYgLdnRikI8iQhH4
         X1hgP//w0XKJ2CbWf4tJM/kZdLFd24GFrwpcQFAS18i+cUbG16dUR7h+BZGBDQume7TG
         ecImV94XWamj61Ipme8RKJsUHN4o5BidIl4jp3Q3KgJMkPD+N3wbVsbT8K8ndQsJCleS
         6cETeKd1xWcvyC9bY+cTk8a4DBe137At5h9Npt2ekszbw/ULEOayRs5EtXwUG/2Ts+w5
         GjMw==
X-Gm-Message-State: AOAM5304377EiTcu6ToR34xyYdEXlYlYK2v24Bgx+oUd+/1G7zoCyAfe
        NsEqAIZ3ABC0NUjtYkXqcHzO5w==
X-Google-Smtp-Source: ABdhPJzMkbxIhAeW21y7ln5GeDvi3qB8U4YRq1CXipmYvF+91NCu8s1GPlnzeIwRmBixBHGimPBd6Q==
X-Received: by 2002:a17:906:600c:b0:6fe:9204:959b with SMTP id o12-20020a170906600c00b006fe9204959bmr56268746ejj.417.1654078452767;
        Wed, 01 Jun 2022 03:14:12 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j12-20020a170906254c00b0070759e37183sm485130ejb.59.2022.06.01.03.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:14:12 -0700 (PDT)
Message-ID: <6f41d28b-640b-f335-dade-f4fa4a88cb65@linaro.org>
Date:   Wed, 1 Jun 2022 12:14:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 13/17] dt-bindings: usb: mediatek,mtu3: add MT8365 SoC
 bindings
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-14-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-14-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
