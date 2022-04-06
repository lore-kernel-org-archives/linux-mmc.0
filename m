Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02DCC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Apr 2022 23:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbiDFXjU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Apr 2022 19:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbiDFXjR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2022 19:39:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB7A1FD2F1
        for <linux-mmc@vger.kernel.org>; Wed,  6 Apr 2022 16:37:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id kw18so3964780pjb.5
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2022 16:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vbl0tI5xWg5AbixL0vHnmPtEGDrnQab/dcpQD6r+8gY=;
        b=lz4NLZqcbFnGC7NhpX3Lae6m6aNJN8k/gEoTYdschgXlHu6O6EOfvqWnLyJ2cCIfdQ
         zg3Pevrwe8qeihORSIEva+g+tiakkbGcenhQKaqJarxzZ1vz0Fi/Ej7yv5Z9Rt2Dvgib
         t1Yzo7LVZHrxMmmRU7+IvC6AkrEPgAxurGHO7sA1h9aYOK2d0IagsOxHfbjlSFnFo9Lb
         XLUISq3b+lJe8Rl4YOem0xLXPK7wZXEr+fyruSKRzReiwFr837+08CQqzymNJU8zxluH
         a1x+w0KoazDUm7ueKBF72kCKsxrpKEnShQhYA5EJ9kdrPmSjida07C6DhJcXnEENKv3a
         hJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vbl0tI5xWg5AbixL0vHnmPtEGDrnQab/dcpQD6r+8gY=;
        b=PY6ueKFV8GOY/jSUmBM/3FB2m1DABMOoR2XELYIgXlxGIcaX1casqb2SESJhlH4r4U
         ioQpfhDuIlKKkoMEbVqNw7R+t+hLvgObfwMZXOPv/8e+ib7VbWD/KZNz0tBhAI5p48TJ
         F8JaIh8h3OniazoWE3XKuzkWlhtcdRlB8Jv0/SNbqyK+FQRm+KKjNjal6QFzbG1HDf5m
         TbwldIgTjgMiPvqUeJ0F2lwg9+Y5t5SZJT/LTQPFsf2phIUDSxbPiJNqgXjE+ZCZlyJe
         JV+BhmXSuFRA1BEezmJ94r6tkqAmbQnYfmfyGMDoB+S7LPASjokpNWwQAkQQ6gaGWog5
         704w==
X-Gm-Message-State: AOAM532izOSYzq3biZ1sCD+tuit13f+llj16GWaY1w0ohB3vO5pn8RKO
        v2dB/TSxJzU9AkmENjb2Qp9DVTsxfRsstw==
X-Google-Smtp-Source: ABdhPJzNbeu9YbyTYgQk5M1AHgqT1izjhc3Ykg1Y14Qdk9e6F6VJyciuXGztQIPXioXWLdqBuiLAXw==
X-Received: by 2002:a17:90a:4897:b0:1c7:5fce:cbcd with SMTP id b23-20020a17090a489700b001c75fcecbcdmr12753579pjh.45.1649288231948;
        Wed, 06 Apr 2022 16:37:11 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm6903667pjl.39.2022.04.06.16.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 16:37:11 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] dt-bindings: spi: Add compatible for Pensando Elba SoC
Date:   Wed,  6 Apr 2022 16:36:41 -0700
Message-Id: <20220406233648.21644-5-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406233648.21644-1-brad@pensando.io>
References: <20220406233648.21644-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document the cadence qspi controller compatible for Pensando Elba SoC
boards.  The Elba qspi fifo size is 1024.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 0a537fa3a641..bc298e413842 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -30,6 +30,7 @@ properties:
               - intel,lgm-qspi
               - xlnx,versal-ospi-1.0
               - intel,socfpga-qspi
+              - pensando,elba-qspi
           - const: cdns,qspi-nor
       - const: cdns,qspi-nor
 
@@ -48,7 +49,7 @@ properties:
     description:
       Size of the data FIFO in words.
     $ref: "/schemas/types.yaml#/definitions/uint32"
-    enum: [ 128, 256 ]
+    enum: [ 128, 256, 1024 ]
     default: 128
 
   cdns,fifo-width:
-- 
2.17.1

