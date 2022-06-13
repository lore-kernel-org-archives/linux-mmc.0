Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5E9CCA47F
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jun 2022 20:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242821AbiFMUqy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350523AbiFMUqE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2022 16:46:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D244827B
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2022 12:57:26 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 129so6511063pgc.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2022 12:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KlpSKj9JOxZWHiDBe4+ujhnALAH7aoziqzJ/soAilmk=;
        b=qA9A4Fka8Wr2+BYttjs3IXzbkv10TKHVOFBIwcQb402ENC23qLAb96PDlp0HKFtHBH
         gDn+EHjSB7rG1NrjM3fc+UPI7M4UaryOzbZTzN9dePt5MZX8Zt8qNc/gPUU5fqPBW3ZN
         VAw6uNCQxKRg6aj/KdwWkJlIzXQI6o4ZpYvzgYIAAWL/+S7hygXB8d4kporCLmEXflT2
         TaAmtyCZeXZHTZklEHwGuUctzGtnA/kWBeA72Wqku9EPOKs8kLdPJGW3ULmR86feFpI3
         zxFMLUez4AQcauxfanrHS0k5QqGdbfh8MUPF5vICDRmYX1oxgmLcJ0twh10uuY5tEvzu
         j3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KlpSKj9JOxZWHiDBe4+ujhnALAH7aoziqzJ/soAilmk=;
        b=1E0hGCyN8IEM56xg87a9dxCmJKOxgucOWX9VyOdLSxroB79ugnFrMEYLgCUZnsb2cF
         0IxxWFKEpqoeoeWsaZymiREhldLl6MJ5mLXmgbxvMFcQDimO5QCgTZxTJVdxnYkeYNje
         ePNXUvds191cKtw3a01jiP5SGP5hlAfiay16aMf94smvvvLFvsmmAY4YnNMtom3SgJXX
         vO3Q/2NP5FbkbxFlZNpYNjev2HoIJW3TFctgU0FQpW041SxTPN3Fa2WJuZQ3t/JtZUM8
         mv6dG+Y4suZ+j9nV+N+kD1ozsd6lp+e2pBSfqrPRptBQnSpa+7iv9spVXT0+lY/k0jnV
         Q3iA==
X-Gm-Message-State: AOAM530ADUXkquMbwJu83TBj4Qa3BwXEdB4K8OlOlpZ2pXhBckRPLYDc
        nZltgJFbnZ8fDudFKPj5DL8jyA==
X-Google-Smtp-Source: ABdhPJwbv7pRTFzk4+nbaX7oGqRi9qzhXvoemRqwa0xYJcXUwR3JB4aRyw3D7Z04QgbHW03QXG4fdw==
X-Received: by 2002:a63:234f:0:b0:405:3981:be7 with SMTP id u15-20020a63234f000000b0040539810be7mr1085120pgm.15.1655150246205;
        Mon, 13 Jun 2022 12:57:26 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902edd500b0016797c33b6csm5509357plk.116.2022.06.13.12.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:57:25 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC binding
Date:   Mon, 13 Jun 2022 12:56:45 -0700
Message-Id: <20220613195658.5607-3-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613195658.5607-1-brad@pensando.io>
References: <20220613195658.5607-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Brad Larson <blarson@amd.com>

AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
explicitly controls byte-lane enables.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml        | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 4207fed62dfe..35bc4cf6f214 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -13,10 +13,24 @@ maintainers:
 allOf:
   - $ref: mmc-controller.yaml
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amd,pensando-elba-sd4hc
+    then:
+      properties:
+        reg:
+          items:
+            - description: Cadence host controller registers
+            - description: Byte-lane control register
+          minItems: 2
+
 properties:
   compatible:
     items:
       - enum:
+          - amd,pensando-elba-sd4hc
           - microchip,mpfs-sd4hc
           - socionext,uniphier-sd4hc
       - const: cdns,sd4hc
-- 
2.17.1

