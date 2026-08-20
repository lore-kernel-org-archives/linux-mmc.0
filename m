Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9647F76C
	for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2026 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246224; cv=none; b=j3KEVByaRcB1h99gahe3ybTdESv1zaQbMwH7kL8ZJKkc2bwnegcRwNnKhongrZ+B/LMs7DrZibMrOcHqdjMrASedT32WsRFRHO3E8jT8iy/fDr4vlBIx4CrQhCitr20RTTfKYVilf+HtlZE6SbcBOXrV2hKi+9aSmJ0pdUNqAcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246224; c=relaxed/simple;
	bh=LeJpvsmE8/8oIBqIo77XO1N7ZMpxYFIy1g4h/XeP6k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8MDpVC1J562sTln+mqQjRFraRvkwlGJaLF3M2va7YmLz91Dx+lImc8RtW0Q+ruHc0jYV+xj+H8sA+3XkYiQ+Sj4Vw1V6GxdUMkqC04aRJJT6MNjrTxKw1QV54YHwAy31g2s5TtBdSgFDU6NMxA+tOq74eHoijZUqcLfo0CbMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqtgzFvC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqtgzFvC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso785585e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2026 10:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787246221; x=1787851021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LF21JGxH17vVW7bu66t9RUZbiTMUiqLzjDtcuysGx8g=;
        b=EqtgzFvC/8tZwSIQeZ3NNUYmSPpWX99V0e/Gt71iqqI9VMA7aCbgxRy/oRwXfOE1+G
         Ja7rlwRkm5LHoKpNvubzzdPXjEi31BwHDK5wWGIPTGgc9HqKKlAVuR6va6uMQspv/Er7
         9t7D+a9vAIOpS+JS/CLZvIz4ePEcyLHxAmYA0dwiqxq1W9pjXvHfzuEw3FLNadKXL/5p
         PeyvNuSVYeqw4s76vxMgE7rl0etGisRS6QO9qFgUqGYxV2uPZKWVwPykEczXtEfsStH3
         lB4goOmmK8Sm/6blHFyQXaFOhMfRbmej1m4RC1dX77vDSpS9oEJOc07xWF+LM6duG8gd
         Q0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787246221; x=1787851021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LF21JGxH17vVW7bu66t9RUZbiTMUiqLzjDtcuysGx8g=;
        b=LJ1S60YSGuQLryvVkTyIO21C4UlL4ZvDNj9bRJfYyYXP5MvunJ9MRKuwIfaXOi+jwB
         3tV/WPSTTTRnpnXBZLkuQFTwtNiqnfNScIJbCdQFQHBTljL1B0ri0BH1GTYCxgeJ+Qaj
         hdRuXoHH5z/kGIXVnB2qMgjtJElEeiR2V8f9mcxbIvGti+piwhYA2HeD4X0JSgTyI0dk
         OZJz0rcrtIVUBFPoFjwvLJIsvuhwQjQX2JVctI5hJ9tOOry4w2Cl9bMA/EjQ4mdBTfAh
         kemOnWjqDGjfsPxFAYWJ8Y6jZJzLA5ufRurZCEVjmG8MJjgCW0oNH7S00RlN/smQU/FU
         6dBw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9LtT2OHL9zftrwYSxWoZ7DN1+UTDgV3vA2TWvx16OaHaoHl8NO+Ix/NPFzo0+dVx+o7GneD3UnK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNAoUd9a+zTdjUIhyzEnzxVtR/exrn3W6M7d2oXgYL34hU6mMv
	4hUReiHdhrS0L/OGHh3zaG/W8n+4SmTNaGLUPlsgKVntUHab6nBahOoQ
X-Gm-Gg: AR+sD13MUhdGcfVSK5LinveNpMe7uPWxNu+peYi15xZ7er9VS8laZfK77RJO/ZL6e5Q
	hjNsTg8NVtsj6ZlZWx9mZaA/gHi5v2JmUG9jFdQBiKUmeOvL4heC8UrbzucL57B+LLdgQo4xC47
	fnemt6O+xFCykkq7Bo2TfPGzZq9+q1kgkos4+XC8V+WorArfMFMeZKxHyoZcHW+obmeJr7ebCy1
	DjU3w0bwlC6++wkdaea2JZzYfQCRiboV0S74gXhTo3Mv+gOFEQw5EtVAKl4DLVHaVG+2WLXx5yX
	V6qTdewKllWZwXj2RAVqvatDQFIyr4WmSHXdsDvf7fIAR4h2EaQGgMJtgxtXzMJXyRKtmOdsMkH
	HXocfxnEXBJ6GIRVSeDVUSLG8vG2e13OoathVdKyPVFsrZ2t85u1E5irCxV0pnZ2ddbQmP+ZxPS
	njCidhVQWSAgCp+dob4nGyc1/Z3+/viycQ8m4b9sg+iPEchWMABBjJ3MEJzTCLe9S6v5w9Fw==
X-Received: by 2002:a05:600c:6211:b0:499:621a:2ec2 with SMTP id 5b1f17b1804b1-499b82e8e9dmr9581305e9.3.1787246220686;
        Thu, 20 Aug 2026 10:17:00 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:eda0:8ef1:e1ab:c2b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fd728sm219313495e9.3.2026.08.20.10.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 10:17:00 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v24 01/15] dt-bindings: mmc: renesas,sdhi: Document RZ/G3L (r9a08g046) SoC
Date: Thu, 20 Aug 2026 18:16:31 +0100
Message-ID: <20260820171657.62815-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Document the RZ/G3L (r9a08g046) SDHI controller. The RZ/G3L SDHI
controller is similar to RZ/G2L but has five clocks (core, clkh,
cd, aclkm, aclks) and three resets (rst, axim, axis), so update the
clocks/clock-names maximum to 5 and resets/reset-names maximum to 3.
It has an internal divider for all modes except HS400, and a 2048-bit
divider compared to 512 on others.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v23->v24:
 * No change.
v22->v23:
 * No change.
v21->v22:
 * No change.
v20->v21:
 * No change.
v19->v20:
 * No change.
v18->v19:
 * Updated commit description
 * Updated clock and reset description with AXI master and AXI slave
 * Added else condition for reset and reset-names.
 * Renamed aclk->aclkm and reordered the axi clocks similar to resets.
 * Retained the tag as the changes are trivial.
v17->v18:
 * No change.
v1->v17:
 * Collected tag.
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 108 +++++++++++++-----
 1 file changed, 81 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 4d66966ce290..6d229a41a4b5 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -18,6 +18,7 @@ properties:
           - renesas,sdhi-r7s9210 # SH-Mobile AG5
           - renesas,sdhi-r8a73a4 # R-Mobile APE6
           - renesas,sdhi-r8a7740 # R-Mobile A1
+          - renesas,sdhi-r9a08g046 # RZ/G3L
           - renesas,sdhi-r9a09g057 # RZ/V2H(P)
           - renesas,sdhi-sh73a0  # R-Mobile APE6
       - items:
@@ -86,11 +87,11 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 4
+    maxItems: 5
 
   clock-names:
     minItems: 1
-    maxItems: 4
+    maxItems: 5
 
   dmas:
     minItems: 4
@@ -116,7 +117,12 @@ properties:
     maxItems: 1
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
+
+  reset-names:
+    minItems: 1
+    maxItems: 3
 
   pinctrl-0:
     minItems: 1
@@ -155,60 +161,106 @@ allOf:
         properties:
           compatible:
             contains:
-              enum:
-                - renesas,sdhi-r9a09g057
-                - renesas,rzg2l-sdhi
+              const: renesas,sdhi-r9a08g046
       then:
         properties:
           clocks:
             items:
               - description: IMCLK, SDHI channel main clock1.
               - description: CLK_HS, SDHI channel High speed clock which operates
-                             4 times that of SDHI channel main clock1.
+                             2 times that of SDHI channel main clock1.
               - description: IMCLK2, SDHI channel main clock2. When this clock is
                              turned off, external SD card detection cannot be
                              detected.
-              - description: ACLK, SDHI channel bus clock.
+              - description: IACLKM, SDHI channel AXI master bus clock.
+              - description: IACLKS, SDHI channel AXI slave bus clock.
           clock-names:
             items:
               - const: core
               - const: clkh
               - const: cd
-              - const: aclk
+              - const: aclkm
+              - const: aclks
+          resets:
+            items:
+              - description: rst, Core reset.
+              - description: axim, SDHI channel AXI master bus reset.
+              - description: axis, SDHI channel AXI slave bus reset.
+          reset-names:
+            items:
+              - const: rst
+              - const: axim
+              - const: axis
         required:
           - clock-names
           - resets
+          - reset-names
       else:
+        properties:
+          resets:
+            maxItems: 1
+          reset-names:
+            maxItems: 1
         if:
           properties:
             compatible:
               contains:
                 enum:
-                  - renesas,rcar-gen2-sdhi
-                  - renesas,rcar-gen3-sdhi
-                  - renesas,rcar-gen4-sdhi
+                  - renesas,sdhi-r9a09g057
+                  - renesas,rzg2l-sdhi
         then:
           properties:
             clocks:
-              minItems: 1
-              maxItems: 3
-            clock-names:
-              minItems: 1
-              uniqueItems: true
               items:
-                - const: core
-                - enum: [ clkh, cd ]
-                - const: cd
-        else:
-          properties:
-            clocks:
-              minItems: 1
-              maxItems: 2
+                - description: IMCLK, SDHI channel main clock1.
+                - description: CLK_HS, SDHI channel High speed clock which operates
+                               4 times that of SDHI channel main clock1.
+                - description: IMCLK2, SDHI channel main clock2. When this clock is
+                               turned off, external SD card detection cannot be
+                               detected.
+                - description: ACLK, SDHI channel bus clock.
             clock-names:
-              minItems: 1
               items:
                 - const: core
+                - const: clkh
                 - const: cd
+                - const: aclk
+            resets:
+              maxItems: 1
+          required:
+            - clock-names
+            - resets
+        else:
+          if:
+            properties:
+              compatible:
+                contains:
+                  enum:
+                    - renesas,rcar-gen2-sdhi
+                    - renesas,rcar-gen3-sdhi
+                    - renesas,rcar-gen4-sdhi
+          then:
+            properties:
+              clocks:
+                minItems: 1
+                maxItems: 3
+              clock-names:
+                minItems: 1
+                uniqueItems: true
+                items:
+                  - const: core
+                  - enum: [ clkh, cd ]
+                  - const: cd
+          else:
+            properties:
+              clocks:
+                minItems: 1
+                maxItems: 2
+              clock-names:
+                minItems: 1
+                items:
+                  - const: core
+                  - const: cd
 
   - if:
       properties:
@@ -247,7 +299,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,sdhi-r9a09g057
+            enum:
+              - renesas,sdhi-r9a08g046
+              - renesas,sdhi-r9a09g057
     then:
       properties:
         vqmmc-regulator:
-- 
2.43.0

