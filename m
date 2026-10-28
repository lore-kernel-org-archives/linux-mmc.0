Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191883;
	b=L/HtUmMA7HS2RSnTcESHwKDxdgh078XST6WGgJFSJU3oMbLaibrw4wH3HaJZ+QXfWL0L
	 2+11wx2Xd2SC/DBI9CAkB1KgbZZvTca3KHkeYafGGPxzi76RS1cnnYC9oT5GRLqQuD2Dz
	 hZNkhrhi0dTjVBdOk2i2xloj2y7eODymst/S/wUc07JBtzQXdQI6Vcx23dAC/vmTepS7N
	 04zi1jCuYum7Bc2l8eQwdBSM6UftVXEU/15AnEJ0IlMgXH6IJjw6pTveDO6dNU/g30YPC
	 0l/J0Lljepp3i1qlcdwuNBfyyG9TbHw41elvArUFnCCJKXY0/WSj247cmF3wgmzpSLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=vZqAF2vd+A7D5oOpAasydBGtPIEXlBigWjwMhyfI4Sw=;
	b=FCpChRObKb0esLjYPN7RAj+VXrmIus8a4I9tM0yJBVnmhaif/7wGHkqdQCsCMjITdXkw
	 OIy0Cu67mAXM4UOMG8WjhWmh0zB1CGLfPm6I6o0vIq0kKHj8izeLCzqK7POHvKUNLrwMu
	 lof/jTWOg5Vfc/2pNvoyTWDTG9EhiL8eLFHb47OIGoU9403jSy1BnI6GVIX/XXG6Qiv1R
	 85cXLHs0FWwqc1h96BC1pUcxwJlPAeYu89akEb2385Ki/gLEIi5znic9v3Skek6TFpOm9
	 E6M2pexyV9OgpwdJAYqMr4jrx7lIkFo5ocg/o9aVRVgKotNK8oQ8oFFjq99+8Z9Ariw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z00SL00r;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF09A606A329
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 12:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF09A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z00SL00r
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c45111bebso450007f8f.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 05:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793191881; x=1793796681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vZqAF2vd+A7D5oOpAasydBGtPIEXlBigWjwMhyfI4Sw=;
        b=z00SL00raAwzmoOMc7UsE300gGiKWelmwU+7iQP8bh7hefA9C1O1gHSVg9zc69Qke7
         eB9xajUSyGeqtWzO150qpOgSx1s87vjZ+0fdysoa27luBDIXiDMvRoSvo54jKGHUDtt2
         oAWvFGM8ctZuN/GompyQzQuyOP9ioOyN1am4iWq8Abzl005vixllPTTBa3J+ZoQTPj3Y
         UedR6kxpYfBZcyMSjufxuwnCGgfsSXrxwJkXFYfVbT0QX9FkkLO9WWQLgX/0QVl8xDeU
         eToxEguB5kFWjuh4D3aNxE6hWmTDtPr5w81VLLbkpllIlEpEt5YvGCdsr1OKN3I3lfg5
         NiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793191881; x=1793796681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vZqAF2vd+A7D5oOpAasydBGtPIEXlBigWjwMhyfI4Sw=;
        b=TAhFE+rRGgRLW6WLJta0D6q1c8eoad4XF/BYCVLqZTe28Iq8BaGU1HbRvIgJnqxNBB
         171qLKaGQoDXUz5wq4YFhgvhSJ1JDq1AcGuCJbYrcVz0IYBh3AwKV9oVsBQleZIvWoO6
         TyfGDmJ/87caCL6H6g7gVWQSVkdvtlEwp3f2bQb7dFYM26sAnm9r5cWyplY4FzjplAxM
         WRDTWUkKlK+GtRVxr34kuyk9XLYxw6UBVk03YhLV5MPS4Qyw183tJ6zPku1nSzGJ1xA9
         +kr2PeCFpnhNpIfC1pxk3GmZKgTS3qs/qOSJ1UlmGaNpUMqqnEOk7NyQb8JZnNN5Kq9G
         aDww==
X-Gm-Message-State: AFq9FYKONyPiwRncATzKTMm1rd51Q0TnHV5EhQptKIs+TroNFzqzNBO1
	rAVutKl7l6Nh9YQGIKkfO1viOTFu2+qAPKocn9rrW+RK1Pp4DCZmtouE
X-Gm-Gg: AYBFou2CugzWt+yWFKtuiFayi6USIpHG+XgqcsRnnK1a02os+FQlApBvLs86Jokm3Ox
	JII+tQy0KNuXx1/Cs71lPFVUmzDwgo1qpsxhvUD8xyyUkk3iCpxO41C8bvq/hEqVjAoiiTDupJA
	QRnLqQrLtTsrgFnwvsIPkHv2vgMTHWSS1OQgRBltwCdlpZc8Qk93oHxB0oZ2w1WVD9+TPTZLUG1
	95AUY9Ju4O93ASC228ebjHMeeoEUxVYSP213FlYgXobCNyoXTOeILTYVbTGh6Mr/GpGG/TyniZy
	ZBfFJ0x482m73KkTVO6/UH/KtUPSIn9SPn+CASWXHNGqyTl81/AF7Jod8vlSvy3MVJIhdbkCony
	FKbg9cSj32IY2CulipOYaOicfPPuOS3zODkrZeveQo5Je8ozMNBh6ci/EDGHi/bc89qoZ3MDcAP
	/sc9feZY+goCU+megsew6rRVNNWJd8nkZEUW+A6WHlM+6NL3fByKvKhVB52GXxJmdF0GxW0409P
	U7s9NSHroL1z8owRFD9qQ6RTDoQ03EBYogqdhUtBcV7CYkBCL9BKUk+G/cWvc8yOg//+nVxie18
	m20dHNm/cHED27RC4HJYXcJUUUMn0KP9Vev8p5ulGrhGbogo2uX6QbGmgdAX18tXDxw+9AwcFJD
	YHs96rR/TApZO
X-Received: by 2002:a05:6000:29cf:b0:48e:2a04:4ea3 with SMTP id ffacd0b85a97d-48e5d284e09mr3853369f8f.8.1793191881203;
        Wed, 28 Oct 2026 05:51:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:6bf5:6c0a:cf99:c9f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39b3sm29275016f8f.10.2026.10.28.05.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 05:51:20 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Wed, 28 Oct 2026 12:51:18 +0000
Subject: [PATCH v25 01/11] dt-bindings: mmc: renesas,sdhi: Document RZ/G3L
 (r9a08g046) SoC
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-rzg3l_sdhi-v25-1-57f16691c2ed@bp.renesas.com>
References: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
In-Reply-To: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793191879; l=7268;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=TxWUkuLqsg19AmF0RW4L3Vi0q14uYeLgxqal/SpjHjQ=;
 b=DCbKuOG2oH9Nk/IQjhvnexyFOJebBqIRtv45EUqQLHMe5Qavapns9Jrj/E5xOWd8J23mJUK2x
 OLyMv5VjHn7DCmYwtRPvMbt9/1oR0REdtJJeuMOpecup9dd2PARokTE
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

Document the RZ/G3L (r9a08g046) SDHI controller. The RZ/G3L SDHI
controller is similar to RZ/G2L but has five clocks (core, clkh,
cd, aclkm, aclks) and three resets (rst, axim, axis), so update the
clocks/clock-names maximum to 5 and resets/reset-names maximum to 3.

It also has an internal divider for all modes except HS400, with a
maximum division ratio of 2048 compared to 512 on other SoCs. Because
of this divider, make max-frequency required so that it is always
defined in DT.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v24->v25:
 * Updated commit description.
 * Added max-frequency is a required property for SoCs with internal
   divider.
 * Retained the tags as the change is trivial.
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
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      | 109 ++++++++++++++++-----
 1 file changed, 82 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 4d66966ce290..2bc74288d933 100644
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
@@ -155,60 +161,107 @@ allOf:
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
+          - max-frequency
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
@@ -247,7 +300,9 @@ allOf:
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

