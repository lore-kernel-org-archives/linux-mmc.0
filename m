Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9F8C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Apr 2022 18:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391350AbiDUSbZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391346AbiDUSbY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 14:31:24 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CFA2BCC;
        Thu, 21 Apr 2022 11:28:34 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t13so5329944pgn.8;
        Thu, 21 Apr 2022 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DL6DI5feuJoMlU44P61YM6Wgo//JlAhCvPdBp3CmZdI=;
        b=qzaGT9qBstujuIErvgj5N/ijlSkXXKv1dd4yHvyPK5vMRZDLH0sQ4QgkfVIJHZqDSh
         ulxtbFjtU3b6rQVgtH7v6XRVBICdlTWzpSXYoUfDYLo69d1BzrIptOjfsx0aH8NANPbI
         UnBBTN/1kY+lmSccneUBAaxPSeeXV7QnvEggxiOiGWl4YMblpvIhhRkpGe0TKQ5/e+fA
         zLHDC2YOI9nK8AQZuBZndvGpt1hq29+wfpJWQ0oRkGCJ4cbjqU7U6Q82y0FkjBT4IZgX
         XKieTOg/lz4RPntmdRdEZrMs8VMvTMJgML4B4nCNhwpL1BY+nVx8eZqMaR/AWe72y0y6
         8v5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DL6DI5feuJoMlU44P61YM6Wgo//JlAhCvPdBp3CmZdI=;
        b=dUNANhcHeAfwyL2SDDzpbCrZEYlY0uUt2dybFiFVwPiPTtcC/EylauI+tN9w3KnuA9
         AlZQD0lV+FNVYBJBsGuSRpb09TdTl9I4WWQv6reDuuTfS4O/OwV4ok+0WPtnxmeSSm+X
         F+x/AknTbEtIUULWfJ7Cf+eKYR1GCkBighEXLgnzIlDp9JUKIoAsMbMP3Mni5W4p6KXO
         JPCbLQFOO+152kr0ym3WFC9m8NLzugHe5XYzo7m11eRn6knrz9pSglT+vV1sktyI5xKr
         iGlcyGGJflFsvU83y5giOuDBCEkdMHiW1WtiC/hz1AONng2hBbqjzWF+mNnT3tn/1tiJ
         fWcw==
X-Gm-Message-State: AOAM530odaaL8AaFwGJVBWHoqARf6tr5bfka7OelAkKuTAit1bVJBgAG
        BslZDQO1v0pRaUz6AX7PQPY=
X-Google-Smtp-Source: ABdhPJyoK0byw8pr/pHJ1F1wx9N4DUcklZjDJIgldLfZhneMCmESqNGOx0SWSjlONpCtT3CGqKFTag==
X-Received: by 2002:a05:6a00:198c:b0:505:c18b:3184 with SMTP id d12-20020a056a00198c00b00505c18b3184mr795725pfl.82.1650565713816;
        Thu, 21 Apr 2022 11:28:33 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id s62-20020a635e41000000b003a9eb7f65absm6509333pgb.85.2022.04.21.11.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:28:33 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH 4/5] dt-bindings: mmc: Add Broadcom optional sdio_freq clock
Date:   Thu, 21 Apr 2022 14:28:02 -0400
Message-Id: <20220421182803.6495-5-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421182803.6495-1-kdasu.kdev@gmail.com>
References: <20220421182803.6495-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The 72116B0 has improved SDIO controllers that allow the max clock
rate to be increased from a max of 100MHz to a max of 150MHz.
Optional "sdio_freq" clock is used to drive the bus clock if present
optional property "clock-frequency" specifies a base clock frequency
in Hz that overrides the base clock frequency in the CAPS registers.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index dccd5ad96981..1b45a918400a 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -10,8 +10,6 @@ maintainers:
   - Al Cooper <alcooperx@gmail.com>
   - Florian Fainelli <f.fainelli@gmail.com>
 
-allOf:
-  - $ref: mmc-controller.yaml#
 
 properties:
   compatible:
@@ -42,23 +40,44 @@ properties:
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
+
+  clock-frequency:
+    description: Should be the frequency (in Hz) of the base controller clock
+    minimum: 400000
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
+  - then:
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

