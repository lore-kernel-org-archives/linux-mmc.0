Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D978C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 31 May 2022 13:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344957AbiEaNvP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 May 2022 09:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344963AbiEaNvF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2022 09:51:05 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E319884A26
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2022 06:50:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so1242170wmz.2
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2022 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U4WzI4lbMxsj2AcBZqR5vJfiFGZXQzAZrwPqRI3jHz4=;
        b=b2zDiF5YOiseW/nuXuuY1Fytkg1NjykULZ6Hq3k0ECX4k4blxfNvKM85svhajUrUv4
         NMas0MJxswcK+uegrqPPzB+9HpE3HDll6zuJdAy0cKDy5dVGjHGRK8oVHa8SK9OuZyq9
         ZklXo6kN4SPbHbg8jAVuW61GvMcabXOc68x6JuTtRtmt6IpQlp5Vsp9PTkVYp/6Zh+S2
         3m67s1U9KYXFLM/NUMcMHxW1UjHZLLpNbL7KpwiyWIMg6TafVndkF7il3GILAPgr/QVl
         c/zKokPzg1iagW/fjsvVLJVcdmIGNn/ZaikG9L7yUR/uBLIWUok6ifW4BBpNy8mlRid7
         HKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4WzI4lbMxsj2AcBZqR5vJfiFGZXQzAZrwPqRI3jHz4=;
        b=U9QMXO0X9rSm1Ybetgkthty0drJ+x5SaaKNbGs8R+OHbRRy3p0ieqpu+W7pmk5gPIf
         rOalVMgzfYumBObT+8JpZrv2Nnf2zVkMMWLhPamZ7jhCHRZF9mzNDT8ZeBYDjV5N3Ecl
         Ko5sjv9xPBWz8oqdZGCDnRMM5ORsAQWnm5jHh93kmGxWiarbRT2VSWkQw3ArHSuY/WTF
         tkQIfmA4R3x5n2Hu4W82ZKrBkZAk2mXqLt5l1egxI83Plif7JV2nxBnlAe7DVkBOX/fD
         s31qdH1ou+gNpDxIVqxhs4g4/FwsI1SxUeYNjWAFExWHksYNyaVjRFbAymXWAHVF5D5h
         i8JA==
X-Gm-Message-State: AOAM5317I7jXHd3lYxQBKvf4YrW0P97+U6qiUG8rUJcKPceZKSuufZh5
        cEMKPG/XVRXo65iksj8j6zDRb73jcyCXMezE
X-Google-Smtp-Source: ABdhPJyi7nZ5n+1hvGyQP/JdQ+9YpIzvsYsMnZlfaurRInqkxVdBqpLhXF6CQGT2vWAFmxAa1ycrnA==
X-Received: by 2002:a05:600c:3c90:b0:39c:1f14:d2ba with SMTP id bg16-20020a05600c3c9000b0039c1f14d2bamr157154wmb.43.1654005049241;
        Tue, 31 May 2022 06:50:49 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b00394351e35edsm2404806wms.26.2022.05.31.06.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 06:50:48 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, qii.wang@mediatek.com, matthias.bgg@gmail.com,
        jic23@kernel.org, chaotian.jing@mediatek.com,
        ulf.hansson@linaro.org, srinivas.kandagatla@linaro.org,
        chunfeng.yun@mediatek.com, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        Lars-Peter Clausen <lars@metafoo.de>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 06/17] dt-bindings: iio: adc: mediatek: add MT8365 SoC bindings
Date:   Tue, 31 May 2022 15:50:15 +0200
Message-Id: <20220531135026.238475-7-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531135026.238475-1-fparent@baylibre.com>
References: <20220531135026.238475-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add binding for the ADC present in MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
index 65581ad4b816..364a23be73bc 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
@@ -37,6 +37,7 @@ properties:
               - mediatek,mt8186-auxadc
               - mediatek,mt8195-auxadc
               - mediatek,mt8516-auxadc
+              - mediatek,mt8365-auxadc
           - const: mediatek,mt8173-auxadc
 
   reg:
-- 
2.36.1

