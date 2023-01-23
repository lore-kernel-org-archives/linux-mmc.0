Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A23C636CC
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Jan 2023 18:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjAWS5D (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjAWS4m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jan 2023 13:56:42 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDB034C0C
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jan 2023 10:56:34 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q8so9795993wmo.5
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jan 2023 10:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7P5hcEaheNNmOvOI92M/UaXJ9usXWngKAfzU751Q808=;
        b=Dh+IPZrC81ABHdlrTFXxjKVt2deQLm6OYqnMWLhyblF2Vs9es46cOfQ3Zssfyg0b4Z
         iCS7aLuxdeNS39SCSFy6TFKLWwYYwz6quXz2vEUw4jCxvjFVAQvGTTobkcOoJi3HXYL4
         Trt48iGMnCaDgwgcLp+ZAegL5JUSDNYp1v6u93XzqrFZXpdtdY89DJQt2nUqMqxWSS+s
         vDHRmHU7UtP1P6OuXyrQhAjlBV7+TK3ps6nQxFvLAVxR7Es14xqVDh4JPFlYWWETCNWn
         qoRM57JktCazOv6GwRFxGE4wQDgHc9Zdj/9lDM2I5k7R98bgcvq5C2aO+70W0jpI5JbP
         cxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7P5hcEaheNNmOvOI92M/UaXJ9usXWngKAfzU751Q808=;
        b=WkBbePQe72rabVfjCCHoSZ/vPN4sI4Pb3TeVSne3ewv+w5dztQTvb3bZ4jjcvEV047
         34+1yGisgFqsf2x7aSuKpSxsw4DLYUi/pyWmX2hDvwczhnf5aSJdHAlLOH5cDIElXJoo
         j9t+S2iGMrs/4Xv3uj8lJe9fx0wEAWggjLao6W7c3an3mS3QmOst0tjgN4mLHkn6pYy4
         FVaV30UbEaTAX/zXoxAk1dLk7+Zc8dxERKbZ8GqS+jnyJjbRx5+taPKkEuJlymBAItQZ
         4ObFBDwYrIZabyxgaE3Mk+rUsKiAsRp8sMiFTe+ZojYhrS7vJKcgQfXa2DDc1yA2Op3w
         Wzqw==
X-Gm-Message-State: AFqh2kptMZTs6enogv+q/9x8dihvJkxMvK6CLezO7isix1lMyrWQcLKM
        HcS4juyNxKU9q43/XuqGB26qlQ==
X-Google-Smtp-Source: AMrXdXsHIotgqdwCyduVSCyhPS8Cv15rRVIPuogNv2CC3YO5vKSQ9gSFrBNp+pSjVYcFJknpowzMmA==
X-Received: by 2002:a05:600c:3296:b0:3cf:82b9:2fe6 with SMTP id t22-20020a05600c329600b003cf82b92fe6mr26077571wmp.8.1674500191948;
        Mon, 23 Jan 2023 10:56:31 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c439100b003dafa04ecc4sm16964wmn.6.2023.01.23.10.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 10:56:31 -0800 (PST)
Message-ID: <2b5c823f-16a2-297e-5f0f-04e4a7f20dc9@linaro.org>
Date:   Mon, 23 Jan 2023 19:56:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 2/7] dt-bindings: nvmem: convert
 amlogic-meson-mx-efuse.txt to dt-schema
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org
References: <20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org>
 <20221117-b4-amlogic-bindings-convert-v3-2-e28dd31e3bed@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v3-2-e28dd31e3bed@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/01/2023 11:09, Neil Armstrong wrote:
> Convert the Amlogic Meson6 eFuse bindings to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

