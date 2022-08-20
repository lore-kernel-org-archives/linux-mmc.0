Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D80C25B08
	for <linux-mmc@archiver.kernel.org>; Sat, 20 Aug 2022 19:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiHTT6b (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 20 Aug 2022 15:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiHTT60 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Aug 2022 15:58:26 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D9D1D0F6
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 83so1336476pfw.6
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=3GkIT6pSt7j0OC2fKZRZbaBy0BVVdg7j70Ydfc3O5b0=;
        b=bGZx4rO7iu3DSa6SUqWyU3AuyXoBOtB9RgvJWW4H1B9dvgQ/r1rM4mM0xV3R5mcev7
         mJWtjla2wR9d0t8D8f9OrVhS3F2mNFPyJJtfACwiTrunpeDnWDvH+EcgqA+Js7z9KHzg
         nHc5OiuxSnY/CB2LJZCYxz7/k+3eOk+xf7wrjXFjMtfeALLcKJJcnfcC8wyMTg/hgcsl
         x7NnFn0h7Uq0GGC2JtewVlcLt3qhaQ1v0l2Qwvx9dwT+Lt3DY/g9fCl/qS5syw6vW6Mc
         CGHZ9skfauP7fKd1eGdb0xGHfQgOYMndDXV0kjoUwkOz4GmQEVHnH3D+4u7JhvVnPwR8
         mvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=3GkIT6pSt7j0OC2fKZRZbaBy0BVVdg7j70Ydfc3O5b0=;
        b=1B/mj7CPUq3+UuIDeJfVBnoa3xPEqoRqTtml5FRTFOiNJBbMnt6w1u+/ssXQq4SHLP
         mPoF4D6E60O594jPHKytas+93oYyej4/QJAfpmD4jzHCOHnUvXasPID/7AsfsvQIesd8
         bG5Y+1gtQEOiLA77lHbV8VIS7codnnDMxBZ6IVhXjn2exvm7AWC6girHa1NEqgdk44H7
         GIH1hB2uEJw7U23wQ3TgCHod23xDyqcTWoEbum6yP/kix4rQeCAJwdPKoBC8mmAsn9iv
         9Wafs+RUeWHTdqE62ICbqp/oOnv+PxHR+QENPLJyFSdeVxcAForC3WFjCut/UcyR3WkB
         wyxA==
X-Gm-Message-State: ACgBeo2LemjlJd+4LGnJ6hr3C5Kl+s1DK8X6HgisZgpY2/z2b1to8TPX
        +SBilvAQpLzxwz/M5UNc3rXsrw==
X-Google-Smtp-Source: AA6agR4gL6gKO9pMS9x34t0MspxWRnznEGmVYRa1mMugNaPpAaTZTz3beSLd1W5Qt7qFW3uWZ1ezrw==
X-Received: by 2002:a05:6a00:2906:b0:52a:bc7f:f801 with SMTP id cg6-20020a056a00290600b0052abc7ff801mr14080753pfb.49.1661025503484;
        Sat, 20 Aug 2022 12:58:23 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:22 -0700 (PDT)
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
Subject: [PATCH v6 04/17] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller bindings
Date:   Sat, 20 Aug 2022 12:57:37 -0700
Message-Id: <20220820195750.70861-5-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220820195750.70861-1-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Brad Larson <blarson@amd.com>

The AMD Pensando Elba SoC has integrated the DW APB SPI Controller

Signed-off-by: Brad Larson <blarson@amd.com>
---
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml      | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 37c3c272407d..403d6416f7ac 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -37,6 +37,15 @@ allOf:
     else:
       required:
         - interrupts
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amd,pensando-elba-spi
+    then:
+      required:
+        - amd,pensando-elba-syscon
 
 properties:
   compatible:
@@ -75,6 +84,8 @@ properties:
               - renesas,r9a06g032-spi # RZ/N1D
               - renesas,r9a06g033-spi # RZ/N1S
           - const: renesas,rzn1-spi   # RZ/N1
+      - description: AMD Pensando Elba SoC SPI Controller
+        const: amd,pensando-elba-spi
 
   reg:
     minItems: 1
-- 
2.17.1

