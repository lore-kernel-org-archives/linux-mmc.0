Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115E7C74A44
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Mar 2023 08:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCJIa1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Mar 2023 03:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjCJIa0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Mar 2023 03:30:26 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF4EE980F
        for <linux-mmc@vger.kernel.org>; Fri, 10 Mar 2023 00:30:18 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id k10so17214509edk.13
        for <linux-mmc@vger.kernel.org>; Fri, 10 Mar 2023 00:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678437016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pgYx2UGfTwFbl4TCcYTYMnoS1bTy+izVwo0DNp29p7Y=;
        b=TpPrFuhkRg6/JR1Q/Y/rDRt4vA2o3fQpjMNEWM5DXTB01lKEXzCMaA+8ZrgVRLh2Ho
         3uno5hha299c99A5JU/E578aNcGPZxfHTzqNlonTB24JKh/ywl60IEd0UNHN/gry1ahV
         YV0GV7P+7EZs7q8EWpXYNeZ0qpA+bfiRs2KOYOKZ2IX7NlqEN77jRaDRyz8cvVkZIiG0
         n+Oo+9lVq1yAhVEQx7Lly2BsHet0I7xPBgIp1BTm0h0nipYqXMb0qj0lcY/xki+hycCy
         I5573tGgDw36aCo3RAb3jBjfja67SdE4hq3mBJzptM79GvBQdXWYfrRqC6dtdolRNSfh
         /sIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgYx2UGfTwFbl4TCcYTYMnoS1bTy+izVwo0DNp29p7Y=;
        b=ETG6a8PBEAQDMVI9Fs5CkGazAOVWpeCtm9PfpQNTQcMA2aqJj1i9gwV/07A0eT27KL
         nlF4PYimtxlrgm2uNP8TfEeTiVM+bZygmMwMd3wWuXA0I3NlAT0LX+THsFu8ZCMDyhyX
         H0vtiWAr9T6VuoAGAzYk/o7TsP/SFSHWvMzPlosRymJQqYIAPi21ugYO0GZoPUTpLjW/
         +cZGMhb2da8QoaU+mj/nz/3DPaacv1IrTKt5jev51a+71G8ygBSGrNi3peCINgKvRxul
         38o6HWqdjO0RfnVR7ORyH9p/dM5obFfP+1S/tNe0/65WfuPBE86KA/F1KG73jU4ykFSL
         qysg==
X-Gm-Message-State: AO0yUKXxpq51o9i0FkNO0UQkmoCSAzD//mqGFz6tj85UcYpRfjcnD/jq
        3waMcCGeCa0xRG8uf7O1x0hC4A==
X-Google-Smtp-Source: AK7set8NOZrDKPAzmWgYGJhsw3eZjf+xuOWPeEVf+UIyE+dOuruW3yvUgVjy69Ef6oDeGn0Dx/0UAQ==
X-Received: by 2002:a17:907:1b1e:b0:8b2:8876:2a11 with SMTP id mp30-20020a1709071b1e00b008b288762a11mr1066346ejc.28.1678437016554;
        Fri, 10 Mar 2023 00:30:16 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id k7-20020a1709062a4700b008e385438c76sm676728eje.55.2023.03.10.00.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:30:16 -0800 (PST)
Message-ID: <86e0ee78-bc39-3dea-ca8a-7270362a71c2@linaro.org>
Date:   Fri, 10 Mar 2023 09:30:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 01/18] dt-bindings: watchdog: mediatek,mtk-wdt: add
 mt8365
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mmc@vger.kernel.org, Alexandre Bailon <abailon@baylibre.com>,
        devicetree@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
References: <20230203-evk-board-support-v2-0-6ec7cdb10ccf@baylibre.com>
 <20230203-evk-board-support-v2-1-6ec7cdb10ccf@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230203-evk-board-support-v2-1-6ec7cdb10ccf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 07/03/2023 14:17, Alexandre Mergnat wrote:
> Add binding description for mediatek,mt8365-wdt
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

