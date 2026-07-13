Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F00334CFA1
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965127; cv=none; b=AzAS8lnO3T3LHehGcqBov/MpeZ7Mh6eH4k+5SJixUtxojuSB+TEGQbXWp0rqJmQjY6OYgkgJ9B29BqPr7ICt89e9UZ7pMc3s+HyfI1SniAvfZMEqIFW76VsN9ueINUFbuiJxMVEFBpJ2Fh+9MPz+sobMoEMaglUa9FpUVC0l63I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965127; c=relaxed/simple;
	bh=JAiqAxkcwnnqDSaNuZpYNFoN5e4I5rBW7k+/R1zI/wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgoGnhLWkEtObdb2GS3BjtKmpkS3K8M3P6r83D+4W3wtieTkil6hcZQfUdFupWLzsFXemVrReDGEYGQ3VKv5LC7um5e7+Z6Xa9NG8hAiJo2rldjhvGWgmS7xvoL3Y0EPaUJIV9BVqkhMfQwlzzxiVgivj1kiUHm1nnuG8OXYrcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhZso2GH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhZso2GH"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47d6c634f45so1830655f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965124; x=1784569924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6XgOLzsrb24W2iBPumJJf1NiQ0JSKLBfdmOgsqRSs9Q=;
        b=RhZso2GHYAPDR/Q+xb33d3g5y8PA6X8iH5CoDlVHjya6INtaytMZnuB5Ma5DJqNaoa
         RiVnznZo3t8uSB8bZBBV0fgiZJ/7iHmML0R6mpYjCkcsNOhg58FjCxcrRnlwKa1SM7zs
         yxtdNRf0cUxj6ufWfxpJJD/Kj3NrZfdcHTHctg/7z07mBraBkNx1SRs5haIhILDvfRGf
         d8XFyNz1vE+P0HdVez+aauMPh0dk1coS8LfPnxDuVwBZyr2f40GHesAy+leGOEKBLYli
         JFrBNvo3MPMtgmnhEVvUvWXUSqAmB5/epJ2sKptgwQYpX4OV75VvoGrC5ZNGWknjvZXJ
         CaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965124; x=1784569924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6XgOLzsrb24W2iBPumJJf1NiQ0JSKLBfdmOgsqRSs9Q=;
        b=PKSbxkIEcGNmrJ2RWsH+98bzhFk5OoaPUmxp08LZdbc+kJ6oZnjc54ZZGanQBG9D27
         ylk483TDD216tWztIqCd1V8DEbrlKqbjeTR4K4Nrz2BlfYS0CW6TkqWBGdEXips8sLr2
         WA3olI2oh+LXFgXTa+JOmighSmbgtWFBLBcCXXYVoFWqoZInCSoO7IYSQ8ZDay+9Dpr1
         7hqVsQV3QaBxwiwSIvO/7aVkHAM2uKRbYx5xeBJ1r78WZJOyLpdQzNRHjw55fpX3drYX
         u77YkSkKyEVyDPP17V92aooZyfKv4y+4H/f2BvfBUkq3igaICyobWmUKX2nOzt6OJbc1
         JGSw==
X-Forwarded-Encrypted: i=1; AHgh+RqwyRYc7SQ0W3vVK5hlSJodm1jJ/Wy1H/SDg8a0/D4nIXCgT7Eb1AaFkfhkd5bmg7Na7/VH1FjPmBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzINLW8PSJp8yZZo6fC4TAQBt65wR2ehSwHmypQz02JPjL/wnjp
	42aSanB8eCBdND7JFAg/01HV46BFZgf5LAICow/XAMFW61Q0NXk3ZlJl
X-Gm-Gg: AfdE7clg4fpUgTq8LAec6G0wAB/bK2UEj8zeYRSrO4Hu2q8Qrfs7UBFhtzlb27RhFzD
	QWBLDenn5iXo8J9cS76ez42dbpG60Dk1HIYWIbSyKAn2hcS3hPniaF22YqZQMVZHejQaShB+tNA
	JjK9+j/YHQ1bSgbnp5FKsAOrzxPWl9ag2eeVMk87RrPWIT2AJ9dS7xnG7SrbeNF185C/7Vu3HN4
	WuQHyvk6WAjO/gvgLPpyG6Dr+8V56C0mLBe1hO/vCGXcmQQi8pFGoh6GVYkgIK14Tonb6ccuyTe
	0mGhCOGJqiotg2Rjo5R3CVD+UejBK6XkmIjpo5jHFLMJLcPCEffZ11qMTwmPsJTIFc6WNJWBNuI
	L1plX9AosWd+kyzn1AHnLN4LK5jfB1Xt/OXDYBxeU17pAEPSBi3JGjz58DULPIrsaf2/PugBWpc
	8W6EqyAfxTYCnnus5jYDhpyRZIqQxf7EO+iwlFbQ==
X-Received: by 2002:a5d:5f83:0:b0:475:cb71:a344 with SMTP id ffacd0b85a97d-47f2dcc63aamr10574540f8f.37.1783965123536;
        Mon, 13 Jul 2026 10:52:03 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c899:4fec:2bdb:b719])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm1011037f8f.37.2026.07.13.10.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:52:03 -0700 (PDT)
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
Subject: [PATCH v20 01/12] dt-bindings: mmc: renesas,sdhi: Document RZ/G3L (r9a08g046) SoC
Date: Mon, 13 Jul 2026 18:51:42 +0100
Message-ID: <20260713175159.138334-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
References: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
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

