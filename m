Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F28C678D5
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Jan 2023 10:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbjAJKQj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Jan 2023 05:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238154AbjAJKQD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2023 05:16:03 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5848A45B
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2023 02:16:00 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r2so11175625wrv.7
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2023 02:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6m47pJ/58Hq8p7TJbcNCm8zVbjrhNNs4P/gWK+tMI8=;
        b=yHxzcr9U9WVUxu0CfdLJGsHZKmUX8EdHygpQCodC4TPZe7ChByni5EFoxjbKjG4CB9
         zqm1FtO4AMCKyq0Il3XcCB98mSSF+UxQzFR6zKgo61CPkTeI/xURnN2+tqVOYw7NZo54
         Vr4ovZm9fiTOSmhzRhi72hdQQD6PSFiFSwoVDDk5OGDB8l0r4f2PXxFLzF2MEcpb4eYt
         drNtDkBsghZyLBosolfbkSZr+S60rgUftMeDRiaKG6SRnrk+mZC5Xh2ID1lnQmx60heD
         bcNFTY2FGmCFiqqTxtnmQpx1XeujtQrzGmHje59EXXUQZpidvUvzlYTZpQPFaYrWdRD4
         EkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6m47pJ/58Hq8p7TJbcNCm8zVbjrhNNs4P/gWK+tMI8=;
        b=2ROnGXAPXkrvBxUsf1weO+BUzZlvDb6g4rCMY29ouFaB1em1z5uHdqbjaX86MpdZb4
         pwQb4Gkzrv1oQ0yIKFcBz49pq7rs5BEYIJUW6BP2YUqJ3hjQ+Z7F5halcZJbZa7AhESl
         K7VEiEQ3BPYcbuCD1W30Bq9sQtJIEopofm2WClPO4rJXVECqqHRzpeTmdf1/1YaLbL37
         NUM92S4l8sZzQ/u0BO8jrHzbsizB2l554GX0pZuJk6hnhytcn52rJg6JJYUQdRqjMkRN
         cbPZTFo3ePdhRhUdVRYSBn7ox+ewcs/YpycAmRdNmXFwJyaBNCe7PiSnlvkj+x1wjq+u
         n6yQ==
X-Gm-Message-State: AFqh2krBBochQgvIZOU2zjZ0ABbumwCUZwVH7uwq7YvV2JCHIVn1Xssl
        zzJWpKQxibG5tDE2oFMDGntJyw==
X-Google-Smtp-Source: AMrXdXungLocivNlI60dcFce730ob7mgkYD26Ohpn86HXP7EmMvFIO9LBoSeY/bYq+MnrHw4cCqeTQ==
X-Received: by 2002:a5d:51cc:0:b0:29d:f817:42d4 with SMTP id n12-20020a5d51cc000000b0029df81742d4mr19057934wrv.19.1673345759433;
        Tue, 10 Jan 2023 02:15:59 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d608a000000b0027cfd9463d7sm10822105wrt.110.2023.01.10.02.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 02:15:58 -0800 (PST)
Message-ID: <5c59d432-3785-8eaa-af77-03fee09b5fd3@linaro.org>
Date:   Tue, 10 Jan 2023 11:15:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 03/11] dt-bindings: nvmem: convert
 amlogic-meson-mx-efuse.txt to dt-schema
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org
References: <20221117-b4-amlogic-bindings-convert-v2-0-36ad050bb625@linaro.org>
 <20221117-b4-amlogic-bindings-convert-v2-3-36ad050bb625@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v2-3-36ad050bb625@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 09/01/2023 13:53, Neil Armstrong wrote:
> Convert the Amlogic Meson6 eFuse bindings to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/nvmem/amlogic,meson6-efuse.yaml       | 60 ++++++++++++++++++++++
>  .../bindings/nvmem/amlogic-meson-mx-efuse.txt      | 22 --------
>  2 files changed, 60 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml b/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
> new file mode 100644
> index 000000000000..11cace95d18c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/amlogic,meson6-efuse.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Meson6 eFuse
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> +
> +allOf:
> +  - $ref: nvmem.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson6-efuse
> +      - amlogic,meson8-efuse
> +      - amlogic,meson8b-efuse
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: core
> +
> +  secure-monitor:
> +    description: phandle to the secure-monitor node

Missing $ref

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
Best regards,
Krzysztof

