Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0639C43217
	for <linux-mmc@archiver.kernel.org>; Fri, 20 May 2022 18:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352765AbiETSb5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 May 2022 14:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352741AbiETSbx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 May 2022 14:31:53 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC7133EA7;
        Fri, 20 May 2022 11:31:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id x12so8403222pgj.7;
        Fri, 20 May 2022 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iO2fsPEYlQDVIZ7lQbZaJ20cTBcTRTZy5qAAh7ygKlw=;
        b=ElaW/bNy9MYn5dDTQY1NdS7ysepHanfeFKkEUsNW0pkWDxH6vU6ie6Ar15TG24IAw8
         KvKIl/HtBdRS2/KehJEFHWQqHh5MeEFA+vfBiED0USOmBE5yXfWS9Wvffw/0AbrpVtbU
         mPfQt00ethvn27cHUNGEjR5bmUrc5nmnuvqQ2pJdjHK3X2u8A5w4fwQihySTH0vC6IbN
         jp94SMNXHyWziVGB79Od1bBqWhCwI2oT+OgRkok8dxtV5bBQn1SfyXtAXLMfMWQQqD8R
         vCgTi6nDZ2ZcAHX+S57c3wOZ0GxMgNTR1M4DJRyFDMc/E2Q5i3T+w4NT+rvIICfW+k0A
         uZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iO2fsPEYlQDVIZ7lQbZaJ20cTBcTRTZy5qAAh7ygKlw=;
        b=A+d68B1psDy8WGuDYfyIM81eo4DmIn+xFVVuId41HCRggkt2tBkyCddSitAoT/hF4Y
         0zDb0xxjbiWojHH+aSNsZ481hH7gRLEjZKo0W831HxguTz4Yd39A7o8OUN/U2T9bT89u
         8DEkYuWIkpm3bAymkHXaBYPhsfulD8O2YtV43Z1f0aFqmvUkA8crwNwae/77KI7Fltha
         CgcNffy80pJkGE3N/l0McSVP0AXl4Uxn6rRLtabKSEulnjKHhUxDIYGmreuE9YdQA8tl
         bdlfQTIqsZI/mTP5ZO2bRkaaeTbmSyUugR6y5YichV8soEtMht8v+A2AKjd9HdIaw6nD
         NknQ==
X-Gm-Message-State: AOAM5311hz6N4MIfUv061zUugg6dRbkf0uCgwC3XNanA13hPaMaed9uw
        vf9FaZUkTjFl/nrSYWy9Vqc=
X-Google-Smtp-Source: ABdhPJzlYBXhoGS1RkVSAv1iowtzHG6oaqlqF4zDokBBmUHNjpObKmyWvTYKGPZEXZ6CDfy1Ud4GoQ==
X-Received: by 2002:a05:6a00:14c8:b0:518:7789:d33b with SMTP id w8-20020a056a0014c800b005187789d33bmr2131553pfu.36.1653071482505;
        Fri, 20 May 2022 11:31:22 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b0016168e90f3fsm87476pla.5.2022.05.20.11.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:31:22 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: mmc: Add Broadcom optional sdio_freq clock
Date:   Fri, 20 May 2022 14:31:07 -0400
Message-Id: <20220520183108.47358-2-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220520183108.47358-1-kdasu.kdev@gmail.com>
References: <20220520183108.47358-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The 72116B0 has improved SDIO controllers that allow the max clock
rate to be increased from a max of 100MHz to a max of 150MHz.
Optional "sdio_freq" clock is used to drive the bus clock if present
optional property "clock-frequency" specifies a base clock frequency
in Hz that overrides the base clock frequency in the CAPS registers.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 32 +++++++++++++++----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index b672202fff4e..c92bfd4eb83a 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -10,9 +10,6 @@ maintainers:
   - Al Cooper <alcooperx@gmail.com>
   - Florian Fainelli <f.fainelli@gmail.com>
 
-allOf:
-  - $ref: mmc-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -42,23 +39,46 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
-    description:
-      handle to core clock for the sdhci controller.
+    minItems: 1
+    items:
+      - description: handle to core clock for the sdhci controller
+      - description: handle to improved 150Mhz clock for sdhci controller (Optional clock)
 
   clock-names:
+    minItems: 1
     items:
       - const: sw_sdio
+      - const: sdio_freq # Optional clock
+
+  clock-frequency:
+    description:
+      Maximum operating frequency of sdio_freq sdhci controller clock
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 100000000
+    maximum: 150000000
 
   sdhci,auto-cmd12:
     type: boolean
     description: Specifies that controller should use auto CMD12
 
+allOf:
+  - $ref: mmc-controller.yaml#
+  - if:
+      properties:
+        clock-names:
+          contains:
+            const: sdio_freq
+
+    then:
+      required:
+        - clock-frequency
+
 required:
   - compatible
   - reg
   - interrupts
   - clocks
+  - clock-names
 
 unevaluatedProperties: false
 
-- 
2.17.1

