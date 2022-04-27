Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E90DC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Apr 2022 18:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244667AbiD0SNO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244727AbiD0SNK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2022 14:13:10 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3B71DA46;
        Wed, 27 Apr 2022 11:09:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p6so2148094pjm.1;
        Wed, 27 Apr 2022 11:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DhDEOGzyYb9G9W/Ih5nKdhPS0DtnHgoSg/tqlnDUmxQ=;
        b=IaDd2rrWQIS7uiZBU4ssser2L4FmpszX7h5IIzB9lYo3FpnQCSUQqXkS9WKOvDNJJd
         M+X/bAn8Kwq6GOLUjkCOXvRNKWt6BkFyzF/KmzCeln6bDSaWfFM2nxNteh+S+ISqLDaZ
         gC0iusiE41nDfRT6oX6eq37yUw5mImMTRbrZSd1xLW/+HLUqMeOK+2Ti73nWRUFRWk+l
         asMg+UoCCObXpKjUKNl9BkUtxZ2FZ03kpC+wSDmoSgx0KGiEKdBJmZY+AjJNjY6DHRSY
         A4ly/1+TurEixBoM9CQlm6jwnTn2YyowriCzeI+6w7JRzrR9Lg3tClv6XOhjwrSnDo0e
         UefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DhDEOGzyYb9G9W/Ih5nKdhPS0DtnHgoSg/tqlnDUmxQ=;
        b=7nxY+7251mSgzryM+emfggrsXNMfxKSWGw0GB4EslJTglPKRo2sKlEXnCEnqnxSm2m
         BJMTKif0qOW3LnonOGYWdA/kJZpxP1NSz1rwg7FlKtN01Y/6HmY+p3HDDOzQ3KeGPmPY
         Adq/WnplDuF2PZDb4ejl4wSYDHhgFZGWBMXeZDDdMouvP5u5DxwQ42uNo9sadGQYG6k+
         kqaviFi6r3baDSisVu9ahNcJgKilIPFePRXf8IF7wHvZfmqgu1P3d4ef6wCg13pOjla6
         743fkTcdimEF4MDzCr7j6h0ZTgUlEFQaedSaz5qWDLzpYC44powJ17l3acubpxl1yzgu
         /pcg==
X-Gm-Message-State: AOAM533Pk5SgzSYTBW2mEnK/rgeXws+AhvgmI149dTWNliug7NfGefxq
        dlsUgOKZq95MS/NYhznS1xk=
X-Google-Smtp-Source: ABdhPJxobOaSK/Wr/ZaH1v9haLS9wKEynarvNVjK2dORpQmy5KjaZxjBuEOEVwXr4MymO7T1dNlJkw==
X-Received: by 2002:a17:902:cec4:b0:15d:50ba:d9bf with SMTP id d4-20020a170902cec400b0015d50bad9bfmr4886679plg.28.1651082983837;
        Wed, 27 Apr 2022 11:09:43 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78399000000b00505f75651e7sm19076859pfm.158.2022.04.27.11.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:09:43 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v2 3/4] dt-bindings: mmc: Add Broadcom optional sdio_freq clock
Date:   Wed, 27 Apr 2022 14:08:52 -0400
Message-Id: <20220427180853.35970-4-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427180853.35970-1-kdasu.kdev@gmail.com>
References: <20220427180853.35970-1-kdasu.kdev@gmail.com>
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
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 24 +++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index dccd5ad96981..bf716c0cf096 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -10,8 +10,6 @@ maintainers:
   - Al Cooper <alcooperx@gmail.com>
   - Florian Fainelli <f.fainelli@gmail.com>
 
-allOf:
-  - $ref: mmc-controller.yaml#
 
 properties:
   compatible:
@@ -42,23 +40,39 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
-    description:
-      handle to core clock for the sdhci controller.
+    minItems: 1
+    items:
+      - description: handle to core clock for the sdhci controller
+      - description: improved 150Mhz clock for sdhci controller (Optional clock)
 
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
+  - then:
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

