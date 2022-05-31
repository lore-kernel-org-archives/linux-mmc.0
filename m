Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922B0C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 31 May 2022 13:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344990AbiEaNvN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 May 2022 09:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344941AbiEaNvA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2022 09:51:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A6555373
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2022 06:50:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e2so18821677wrc.1
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2022 06:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84B5l6CLEYOYUre8rq3yJnmiSsiXoAiqgOdGcXH7KzA=;
        b=wjCDUvAzmwhW8ShvFMODKlOAJvENmeZCAsQFEBBjpmCjVefXiQwTBynBslAevnS/ar
         IXm4cXmqxylBQs193ugMlR1BjEOc3/Vk7U4T9LJteC5aqnNV4CXZ/jFlXuyrmnd+Hd5D
         VCNQQUjf1leoYsHvfEgfO63Psj1/Zace3a/H4c4v0Ewdmwjm2AWqWy+FkXHdgjohoAH1
         iYI0/ouaIN6JdlbiGEIUyAzSCsrHyrO24nEYivf97/369hIv7k81eCdJwjiidtXbLyUS
         /+R4GrIUqCJ7UoFADiWq/7vAKLkpPNArYC6LGy40/7qc4u3ixQEjvWKr2h+AZvt1+nts
         blQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84B5l6CLEYOYUre8rq3yJnmiSsiXoAiqgOdGcXH7KzA=;
        b=0YFv1Vauguk6dUXiSSZDQr27BDIAX/wstwoDh+ZqlKY1dSCuOcWedftNbz+cYK/GZe
         bkk5KMS8R6tXpdgboHd+1l/zipC87Op9gRd5YUerVqRwxWGS8G8mRAVLgm6OiG85Y67m
         hwY9tPynw+i45S1ylKiKq6ENRhXQwFQe1dpSWrb3fkgYK4Ru5URt9DdmL7gG0k53nwCs
         K4i8WFJ12Q4JhFzvCDlD3Uw53NwCUolWWVRxXsdIXrKOSWZZslkCO/96LZ7qtkA6rD9k
         Ffps3jiqO5WHwx4Pi+thoruwEG+OMZQf+EgzNb96LyEFSBeMzxS7vAwOdPk/xVy8Ab1E
         MFZA==
X-Gm-Message-State: AOAM533YCceckU0HY5N4CSOGx2afbu4WYAS80yRg5b4R6qMDt2NJepCb
        mhtc1AldGazLeI4Sx82ItDo//A==
X-Google-Smtp-Source: ABdhPJx1HdFDNNiPkbLkJv2ksIxQsCl1lQetWRtoVAAGpHCrR8geKFAxOVuea00BT4mrXnnAAW7uhg==
X-Received: by 2002:adf:ec84:0:b0:210:e87:113b with SMTP id z4-20020adfec84000000b002100e87113bmr20885976wrn.545.1654005047238;
        Tue, 31 May 2022 06:50:47 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b00394351e35edsm2404806wms.26.2022.05.31.06.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 06:50:46 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, qii.wang@mediatek.com, matthias.bgg@gmail.com,
        jic23@kernel.org, chaotian.jing@mediatek.com,
        ulf.hansson@linaro.org, srinivas.kandagatla@linaro.org,
        chunfeng.yun@mediatek.com, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        Long Cheng <long.cheng@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 05/17] dt-bindings: dma: mediatek,uart-dma: add MT8365 bindings
Date:   Tue, 31 May 2022 15:50:14 +0200
Message-Id: <20220531135026.238475-6-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531135026.238475-1-fparent@baylibre.com>
References: <20220531135026.238475-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add binding documentation in order to support the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
index 54d68fc688b5..19ea8dcbcbce 100644
--- a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
@@ -22,6 +22,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt2712-uart-dma
+              - mediatek,mt8365-uart-dma
               - mediatek,mt8516-uart-dma
           - const: mediatek,mt6577-uart-dma
       - enum:
-- 
2.36.1

