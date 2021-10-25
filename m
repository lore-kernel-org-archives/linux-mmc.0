Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F62C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Oct 2021 01:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB6D61002
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Oct 2021 01:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhJYByf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 24 Oct 2021 21:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhJYByd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Oct 2021 21:54:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B178C061224
        for <linux-mmc@vger.kernel.org>; Sun, 24 Oct 2021 18:52:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o4-20020a17090a3d4400b001a1c8344c3fso8055161pjf.3
        for <linux-mmc@vger.kernel.org>; Sun, 24 Oct 2021 18:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gRd+RlVLZdu2e4cewW0/Ur3V/oVt9QlpNhBXQEbtHVc=;
        b=meCBAmuRcaBBzXvw2aIzrz5WcBDbY4G4NP0hyRptI7+H1CduSFxgamDAS47gpgtYu4
         eeZigcteWARCfs6adcNJ/JrxfCgH6tImH25tjPhyLkhus8kxtbP8c0//4jzVJ88nNFyb
         lPKmiPxWk/gugRegCg553xppYKAL8liZkOhKLhk5e2z8k5FvsoklpqT1XSU41BcylUsI
         juXXoUttyyuXkBUa6i5rGjInZlUTxLQyT8Lb6ldti+1R0QcBhOyKDlSsMOFywVurzgdP
         vX/JI92XRazZK2phbuppB0yfnNPwLj5DLfO/WaYvlSpvuBOG8AmQ53EPPn5ybaQzzdKj
         ajJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gRd+RlVLZdu2e4cewW0/Ur3V/oVt9QlpNhBXQEbtHVc=;
        b=M/laxhsn7aPWjff66hB6JfnWOxCoTKBvD/+17bIzo/oX9eYELvV5OwogpKOb3iuCxP
         ZxIWL/Y1EZmM+KnN1aQ3kxL0/NyqZevcIiWc7eGRw/z9RJ/sU3U31GZQAkcKup/C0xZA
         rJB9v+Kv2lWb8dvXWvOrh9guZvTubaq+cIIEuxclFEMyeEf2X3Q41YcoWgzoKs346Qf8
         mwgkvijaOJjQ9PtQ6bExoJqrJ7DNPcx1LfR3/MWyWKDHWKx0rH7VWyg0WFSMCyTwEJqe
         3+vWwRwHKMxzs0Y0eR/ezqXhwQ/gXPN658/Qm9abWqW+hltshm/8j0lZ53tMM8FlLMLK
         kauw==
X-Gm-Message-State: AOAM5335RXhsBaDjMFUf4No7ghR5Z7AxyT0KH3vASCfUf1App96GpppM
        eNWFBPvmPtwvz+1bqiOEhgYhxZ2Mcc+HSoTuj/4=
X-Google-Smtp-Source: ABdhPJxuUmAc+grc3TitHnXVwBQJMnHzMIBQfbm+w4plWIkTkOTL/0HHOucMVEz0h2CNOcR+M9qUVg==
X-Received: by 2002:a17:90a:6b0a:: with SMTP id v10mr31822835pjj.130.1635126731699;
        Sun, 24 Oct 2021 18:52:11 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q10sm14855225pgn.31.2021.10.24.18.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 18:52:11 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/11] dt-bindings: mmc: Add Pensando Elba SoC binding
Date:   Sun, 24 Oct 2021 18:51:48 -0700
Message-Id: <20211025015156.33133-4-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025015156.33133-1-brad@pensando.io>
References: <20211025015156.33133-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Pensando Elba ARM 64-bit SoC is integrated with this IP and
explicitly controls byte-lane enables resulting in an additional
reg property resource.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml         | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index af7442f73881..6c68b7b5abec 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -15,13 +15,16 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - socionext,uniphier-sd4hc
-      - const: cdns,sd4hc
+    oneOf:
+      - items:
+        - enum:
+            - socionext,uniphier-sd4hc
+            - pensando,elba-emmc
+        - const: cdns,sd4hc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     maxItems: 1
-- 
2.17.1

