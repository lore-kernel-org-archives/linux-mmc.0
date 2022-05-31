Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2496FC433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 31 May 2022 13:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345138AbiEaNv7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 May 2022 09:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345026AbiEaNv2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2022 09:51:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E564C985B2
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2022 06:50:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k19so10607720wrd.8
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2022 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lW0yAksGLkkUyy22NDdYQDHyZq2zc0vWqxg9iWVW56I=;
        b=0Rpx6jMIsXbKBWz1Z4MydcV9MC4lfQ3IYbK0315TxxRiBKVFtYDLzjN7CG4UB2UfWq
         06uhmo1Q6/Mi1Jb09Hw7bavVWC473lzLKiVfHrsQ5in01UXAMACueQStByBDdPzDrBqp
         twnBLWRJxnAEiZ0+mPXx6cIxmUygABTTEFKvNZa/MjJr/Y2grABaHGjDVverTv4ebyxt
         TnzynXxR7yWbhOz4huGXpOoRp1SIMztgg1r5aLLCiQ3CmPtGzWQoJt1KE4PCgOXkFwQg
         zaN3g5ow5FcEEOLYDOomGD2Td/iJJorkSyXXnQpmbUAJFuBArGG5g3rkIgU01hKSc2lm
         Z3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lW0yAksGLkkUyy22NDdYQDHyZq2zc0vWqxg9iWVW56I=;
        b=AJyMM2F3VmX3ZDijSQWQmByiQVABSdorjiumpSm3+TrO5TX/oUlhJDhjqUQYFqrEOX
         tYWmCaMAis5N0celjrlIIwMEvCXWdmYwrs1l5LUEscn/S0hC5tz9Zr21n6hcPPZxAAJB
         TGPAdMPOf0vye1OYEpSvTMCfYH0PluixgnbGho3bfopKPnvYnulSiEGWaRUnIRxOZi7L
         /9EQhgI6bVm/obffscnUz9kxP6WoSmcfTqWZq61uWnmU1ggegpixCFpH5bjlMmVcICLp
         OiOh2cN1jbObqyBnsrHBXZOBcuLDvFdYvD6YzJBE8GIddiJCMmFpVjJ6MrL+DFGAcRhR
         pkBA==
X-Gm-Message-State: AOAM532JfXpFyZctxoLC2zejRvZRfrtBcgIx2yOt9Of1dLHFySWI0Xi/
        NYQPQ7Kc22IeonFYGOCosgGA7Q==
X-Google-Smtp-Source: ABdhPJx92GIJhNJSvoi0FLCIeGZ8dl9Y3pv8+Zk660zC6fx9w1PvGGZpm6/Ia+aYM0mB7Jhr4qPWOw==
X-Received: by 2002:a5d:448d:0:b0:20d:744:7663 with SMTP id j13-20020a5d448d000000b0020d07447663mr50722292wrq.654.1654005055117;
        Tue, 31 May 2022 06:50:55 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b00394351e35edsm2404806wms.26.2022.05.31.06.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 06:50:54 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, qii.wang@mediatek.com, matthias.bgg@gmail.com,
        jic23@kernel.org, chaotian.jing@mediatek.com,
        ulf.hansson@linaro.org, srinivas.kandagatla@linaro.org,
        chunfeng.yun@mediatek.com, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        Leilk Liu <leilk.liu@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 09/17] dt-bindings: spi: mt65xx: add MT8365 SoC bindings
Date:   Tue, 31 May 2022 15:50:18 +0200
Message-Id: <20220531135026.238475-10-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531135026.238475-1-fparent@baylibre.com>
References: <20220531135026.238475-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
index 94ef0552bd42..d3d34a3a0b7f 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -18,6 +18,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt7629-spi
+              - mediatek,mt8365-spi
           - const: mediatek,mt7622-spi
       - items:
           - enum:
-- 
2.36.1

