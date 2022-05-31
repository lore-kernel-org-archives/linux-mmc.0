Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1069C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 31 May 2022 13:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbiEaNvq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 May 2022 09:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344941AbiEaNvO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2022 09:51:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDFC8FFB2
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2022 06:50:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so1245626wms.3
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2022 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7hTkqdJSG32FEC0xJwQxsGaVxXfP9pn5uHosSEpvk/o=;
        b=8V4VsGA9OVOOn0SdJ25JIZGwaIM5LceU5cEeIikivz49vnnxZAGp7IY4ojZQryeGnJ
         DP2gZq2HIx2X9KjjPP97ub/aV8GnlaIzRYU2dyi4ll7AaU5prn6VHbRNOuIWY32qdXGP
         lfSx/5pavnyO2+V0r85FCrEZZcgYKBajNvaAwL2INiM/VWtWvlm85BJkhIyhGFv2WlnA
         bgv9mq8TOvr/DR/S/KyRMtMk/feIQVxxIsgVxNxdt57BbR1t/pFrt7PFL6/ATtanGSR2
         VQ114YE12cjm+Zs5zQGB67fBgQPSdash0s6aDAcmmp0Efp6dbTMc/oGaq8ZPhlmKU1vA
         No1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7hTkqdJSG32FEC0xJwQxsGaVxXfP9pn5uHosSEpvk/o=;
        b=2PYnNrfMMMex+18Ue5+Rwfg16ePpQqj5HcVOVJwmkzsmxMyZO1umXKyU35GZlSP/Wn
         Fn/ctYAACw49mU7qG5njHAELyd0UwgDfdQS0153N89WDYlCkjpP/eJkrv5ZM4O5BH0+D
         wY1yEa261X6fiBKgsGSNT1hX5kSUbtykm8eqal2Q2NvXiW+kF5mINFWWA8aL5ioPwQS9
         vIoyidCl0JeymH2IAwDG7VZFt0YrNACr/V+OKSwbJmSiVPedh9VHDqxIvPXLEfyPRvXw
         n/gBGOuc8kqcPPwPGJvfNA+cW9Oyz3AvhZ7kPoBsO5bO3qbvUGhFlG5ajUrrQFAeItJ9
         gKAg==
X-Gm-Message-State: AOAM531D6mmmkFERFjeN+wY5pr7LU9jqs7FHNmxwBRoZqWXwuq3J5/Ga
        7RB9APkBhQD/5qgy4oUQaGE16g==
X-Google-Smtp-Source: ABdhPJygJdWIMEqnFljSCeHyRbLD1v7vofyqs6EKiM1gktA+EiK+fDFmHMqxmTLq4ylJWgeaim7/yw==
X-Received: by 2002:a05:600c:354e:b0:397:7c1c:5b66 with SMTP id i14-20020a05600c354e00b003977c1c5b66mr23408175wmq.142.1654005051142;
        Tue, 31 May 2022 06:50:51 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b00394351e35edsm2404806wms.26.2022.05.31.06.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 06:50:50 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, qii.wang@mediatek.com, matthias.bgg@gmail.com,
        jic23@kernel.org, chaotian.jing@mediatek.com,
        ulf.hansson@linaro.org, srinivas.kandagatla@linaro.org,
        chunfeng.yun@mediatek.com, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 07/17] dt-bindings: nvmem: mediatek,efuse: add MT8365 bindings
Date:   Tue, 31 May 2022 15:50:16 +0200
Message-Id: <20220531135026.238475-8-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531135026.238475-1-fparent@baylibre.com>
References: <20220531135026.238475-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add bindings documentation for the efuse driver on MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index 7c7233e29ecf..444875264493 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -32,6 +32,7 @@ properties:
               - mediatek,mt8192-efuse
               - mediatek,mt8195-efuse
               - mediatek,mt8516-efuse
+              - mediatek,mt8365-efuse
           - const: mediatek,efuse
       - const: mediatek,mt8173-efuse
         deprecated: true
-- 
2.36.1

