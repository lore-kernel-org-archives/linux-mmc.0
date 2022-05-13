Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F78C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 13 May 2022 20:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377434AbiEMUTu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 May 2022 16:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383936AbiEMUTs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 May 2022 16:19:48 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714433F326;
        Fri, 13 May 2022 13:19:47 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id l11so8454587pgt.13;
        Fri, 13 May 2022 13:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TAxjpCuf4Z57cSMNS8CJQhIeJ34hJFwnu+3W5yoBaxQ=;
        b=gA6EiPJzsMd+QopYUtkRB508DyVtiWHvcRmlGbjAuqNmKD85P+CVZKANmm/zo+lEOw
         XqqlX7Aq0KA5SpCnDVlsoQ5wqKLzKuzSmJnamV551wZ55w+XKKchq+Q8wiSt/I9Ec+uA
         /yGTxVbTv6RO+KCcAqFAwVbLdp3jQv00NTWY4D8EkgZ4MPiors4ceFvQq6XmUMhmpT9c
         RV1bpoZZ+KoE0tr+qKOxA8+CsUI82k7XiVLGBNUdOkfMwywb0C017Aj0GOZ2jFaVnMCB
         VO5AEoHeyZWL0t01kIinuov6QBqqWEqUcXFNn3Sv06EDu2iGBDMKTU56a6HkIdOUJm80
         Wr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TAxjpCuf4Z57cSMNS8CJQhIeJ34hJFwnu+3W5yoBaxQ=;
        b=eksftGV9ZMtO4bwCbxpL/mHnLECoqM+uBcAKzUSXMspw7oUEAqyhwb4WiINSBzcbB+
         DHrdItLurAsKN85rZfXF422U/I6Ze8e/+hPJfs4epg2rdi98+kgKMe06lNIzZtdJ9ucp
         O0Xtoeba2FadPlG/euU+av+aifYx3B2qUlIdhmnalNUL6e0/lscIk0siIXGH3s+dRQSc
         kWOVQa5Ltxzba/MK7rWMkdYjo6ndL0qE8DM9rNfz8yaQYBsM0eqLBc2mhHCGWue68xle
         QOer7bEiRRD8Jxvq7Imd7w/YjTZ/C6k2HF7VxsLcQqBjcu1VgJgL49rcCcONTNObxbBP
         IzEQ==
X-Gm-Message-State: AOAM531j87ENZrG9GdRBdnVLNgkYl7Ihyxsbai6NtTU4fxGwGQEkze4g
        XZIVMz5q/siPYy4Glf91KrnT9TvUy7Y=
X-Google-Smtp-Source: ABdhPJwM7oGdsaW7FdCnise0s4myBJBz2Uc6Oj97e02b5odr+lT+uVWe7RyxJS9+V/Pjto7XDuf48g==
X-Received: by 2002:a05:6a00:198a:b0:50e:a2a:32e9 with SMTP id d10-20020a056a00198a00b0050e0a2a32e9mr6244227pfl.82.1652473186978;
        Fri, 13 May 2022 13:19:46 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id b190-20020a621bc7000000b0050dc762819csm2182229pfb.118.2022.05.13.13.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 13:19:46 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH 1/2] dt-bindings: mmc: Add Broadcom optional sdio_freq clock
Date:   Fri, 13 May 2022 16:19:06 -0400
Message-Id: <20220513201907.36470-2-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220513201907.36470-1-kdasu.kdev@gmail.com>
References: <20220513201907.36470-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The 72116B0 has improved SDIO controllers that allow the max clock
rate to be increased from a max of 100MHz to a max of 150MHz.
Optional "sdio_freq" clock is used to drive the bus clock if present
optional property "max-frequency" specifies a base clock frequency
in Hz that overrides the base clock frequency in the CAPS registers.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 25 ++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index b672202fff4e..3a4f6e75bf5e 100644
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
@@ -42,23 +39,39 @@ properties:
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
+        - max-frequency
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

