Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87F0C19F2B
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Aug 2022 07:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbiHBHek (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Aug 2022 03:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiHBHeh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Aug 2022 03:34:37 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE19101FF
        for <linux-mmc@vger.kernel.org>; Tue,  2 Aug 2022 00:34:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y11so20713675lfs.6
        for <linux-mmc@vger.kernel.org>; Tue, 02 Aug 2022 00:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=368JpS/36rpWybO7f4ScB1zDTWLXtrfKA8qyBV5OuNo=;
        b=PAW48wAwiZTpeP12dW/05hHrrHyEYFI0im9DNNF9Q1icROFPCIEb6M269XeZJ/MbV9
         5t2YxR+fMq4jgvEjANIcqMivgGJF29PZCnSzboOrNW+MBMK/EPhmD6KywOWoIpLszoRP
         2MCSDWoEriFDPYGELrXkSoaskNDFPu2DRWKIwXJqdxt0ZPPQiel/waz1N1RgyFPEc8Yb
         jlqJY/UTJ7/RQbPi9DQDvTyje7I/eb2hboyuTCyytIo/c58JUOEARUmiVwcVt3KSK1vT
         fin8GBGpmk2oD8H+CYqA8ukdX9l03o89vJAgdLCMn7uUYsAqnRRV1s+uQJX33SQeZD8b
         g06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=368JpS/36rpWybO7f4ScB1zDTWLXtrfKA8qyBV5OuNo=;
        b=ndiuBmP90gdkki3cSkn2fyWSDOg3WJGcdnPTAZzJH8kY8IrztVIsrgCW4PKHeju/ix
         VlsvDml1Q/vxQ82W2b3cTID1ak5E/GnYF/aQHetHiJ1e41wsLNeNfdtnpubtsh2cNqkX
         zaE6S2dH9/NTMhdrXRxRCMaiPGgNddzx21jG5G6mUtJNfzeKBnsE26tS3ZmG5pRvZ6z/
         PyP0wUQd73+ObOIgMhWG3uBkGudv60mfyKDytN859LKgpLWyqTVdZlDRE2780N2TZZSx
         7UQmIHMlwrZBKwAzzqk3sRtVHF2w53+9jd3Sy/gwOIYF13QIw2zNybol3jYwYz5y/eAv
         oyuA==
X-Gm-Message-State: AJIora8lH4Ev5nuIdbEYZ4teg84zwXgYMW2u7b/V1rkVQd69XSrCVyra
        aOLlX15XuNcW4ulZ5q7cgtmeJQ==
X-Google-Smtp-Source: AGRyM1uGrAhHXhNa8GumMf2zq7PU+wfp79kPHZ7PJ8Y8ijdAWAR4/sCz3QReeNWyA2joc0ixSYZ0KQ==
X-Received: by 2002:ac2:4f03:0:b0:481:50f7:ac07 with SMTP id k3-20020ac24f03000000b0048150f7ac07mr6416124lfr.422.1659425674316;
        Tue, 02 Aug 2022 00:34:34 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id l8-20020a194948000000b0048a9603399fsm2009441lfj.267.2022.08.02.00.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 00:34:33 -0700 (PDT)
Message-ID: <f6d7607f-dabf-9339-8d2d-7694a58e8427@linaro.org>
Date:   Tue, 2 Aug 2022 09:34:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/8] dt-bindings: dma: mediatek,uart-dma: Add binding for
 MT6795 SoC
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        fparent@baylibre.com, sam.shih@mediatek.com,
        sean.wang@mediatek.com, long.cheng@mediatek.com,
        wenbin.mei@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220729104441.39177-1-angelogioacchino.delregno@collabora.com>
 <20220729104441.39177-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220729104441.39177-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/07/2022 12:44, AngeloGioacchino Del Regno wrote:
> Add mediatek,mt6795-uart-dma to the compatibles list to support
> the MT6795 Helio X10 SoC's UART APDMA.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
