Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CC8C32793
	for <linux-mmc@archiver.kernel.org>; Sat, 20 Aug 2022 19:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiHTT63 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 20 Aug 2022 15:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiHTT6X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Aug 2022 15:58:23 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A7F1C110
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:21 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y127so4080577pfy.5
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=wz9MsUwmI5n+ymksjYC4EkZBI5QAxatLdHbVurA5ZlI=;
        b=B8EI6enIRiLHMyZoWfn+OOYNPz31hR0ZY++Q94mK6NKM8A3wITa5OvTvgeINH8KgD4
         AmuRI/+HTkNFJtsvXt23x2KKRBDeiIDx5CIfhzmS9w3Gme000XD+BSvtAo9hQRwTZUr3
         MWC9RLksiznlY89PnUyIuGGUPD/9xLkT1fYwWsb9y7LRZTsm9e/Gj8FQsyut0jLf8CBs
         Gb/qfpwINSLdJDqNn8WGC988FtkhZKkAep2W+Cw4e3SS/8huflK49+9iiDiLZv9T3164
         EHpuw28I0pxqcuqerOIBOA99r0j7RkGTjWSbuqKI1U4ft3fcyU9qJbJVyGY0h4wZqxHi
         xqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=wz9MsUwmI5n+ymksjYC4EkZBI5QAxatLdHbVurA5ZlI=;
        b=5gEkRihX/X8Htg3TLIOB2TKPr6q+mGSDpRWOoDKPy0Kz6asr5RlDXclUQ4mcO/G9Ld
         eMcdFcD3uRNgFB0nl1/QRjgdY7GuOpF64t9Ju2cTNN/nqf686mKjtcX9dzmW0y+MAPjP
         e57lRgZRY+Vsi+HbK7DlfQt1esUK5FCfyXcUmbPx8zqzlBKCVxe64sOGAxPsAB1u5iuV
         FEqxoz9FusaTjUAnkyZGj9JgoRvYMOTwk8nfjRKlWwzx0nL+1QA8ame8rmfki6s9A9KM
         uRZXn/HbsxN1uD6O4dwi4DGXVdEq8owHNAV8BKMZoSuPuablH7GGbLPADzZpKYarSrI9
         SZvA==
X-Gm-Message-State: ACgBeo3XIq8wBG8K7IsUPZaQh0zzatpAzB8Ijisa+4ZjagE5cfV6SvaS
        5J5u64y/vZda8ZfclWyhL8M6AQ==
X-Google-Smtp-Source: AA6agR7hs5dMUXq2LiE7InqSQSJ3w32+PKzInx3oGBczozrPj5Qd2Ax7XXzFuEy4aAGPzi6V/t+b7Q==
X-Received: by 2002:a65:4501:0:b0:3fc:4895:283b with SMTP id n1-20020a654501000000b003fc4895283bmr11262902pgq.231.1661025500870;
        Sat, 20 Aug 2022 12:58:20 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:20 -0700 (PDT)
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
Subject: [PATCH v6 03/17] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
Date:   Sat, 20 Aug 2022 12:57:36 -0700
Message-Id: <20220820195750.70861-4-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220820195750.70861-1-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Document the cadence qspi controller compatible for AMD Pensando
Elba SoC boards.  The Elba qspi fifo size is 1024.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 4707294d8f59..b9e49e90e280 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -20,11 +20,23 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amd,pensando-elba-qspi
+    then:
+      properties:
+        cdns,fifo-depth:
+          enum: [ 128, 256, 1024 ]
+          default: 1024
+
 properties:
   compatible:
     oneOf:
       - items:
           - enum:
+              - amd,pensando-elba-qspi
               - ti,k2g-qspi
               - ti,am654-ospi
               - intel,lgm-qspi
-- 
2.17.1

