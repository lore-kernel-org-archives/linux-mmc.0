Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E183331A43
	for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157312; cv=none; b=LqZ7rjkGjBrLpQBEyljSvGsXylxiP7696ABL1mgGT25qw0AIFB6AEjsJklUl8ExmATc+Uz1pqVng1h1fZewXRSHrMcAAuRqDO3/5AHpvBJKyQKimMr1jsarvVHVAxZEKSeP6ggFuIGy3A/03ckjHbvzNSmeDWB0kNpzaehXStRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157312; c=relaxed/simple;
	bh=LGU3EhNzItmD7/F0QP+/J37ZX1QLxCXHqhE26IfIzsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQsgxRu3YRdZiafyL12eE+ae1vA4ga+40rAG3Vq56LxKXQgpUmhyiLML8onRZnMwCGNn6uLrktRv/HOx1KXayLivabLsa24/taZcbDMQBekLtwX11u2JdGfpl39uuGwV+CHtz7kb8U3qqEvZG8IY0NTwmj4jhtlkFcCQGp6DeZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYcOosoH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYcOosoH"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso1429207f8f.0
        for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780157310; x=1780762110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umKfVYTIv6The/YCck3O88OfkMKCNNX7zzNxe0iNolQ=;
        b=IYcOosoHAEoUg/MDxAbVJCb4CygvRqddfkyAIsOnZaoirCGK6C5qXIxeaVkJOKjAqV
         s6ZwLyE8Suf1p9Mq3iYgnmW6oslZCh4juU20JMR4NM2TexFwGEBx8G1CvSMO1sPtp9Y4
         ovUo7IG3iw19Ae8BzfOdJ3BTvGJjH7ESy+XVOc6vAI/iRaGX+72ketXHSL6u+6vVb6aK
         dP7QUVheA6MuNszsgT+uVbDzhqVUxljTelhafsXWyx+L0iZJBRuGaO1FF1izIZe/I9d7
         7DS289yIubELkuNZ9jnE4QTFgjNcqWQgLlSdYzNPktzMmnxr/LaLNNcWcjkiryUnwZYm
         ZGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780157310; x=1780762110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=umKfVYTIv6The/YCck3O88OfkMKCNNX7zzNxe0iNolQ=;
        b=mTMBNkNzYr4VS3ASFUtSk3sGdufo2Y8y0dHSTXKL+Y/y/YPCpQO7OkGuRcPevmstiW
         6h8RUabv1wP5CbXgfmQNAAJtBHpeovaYHOb9VF04JNYjAbrJgwWRASMaV/sbFtnWQJD2
         rPReqwVM4q2n6Z9yZStczVob6W/wdA6u/UHck5XcRn/DBLSl0HbWrcKWoyU1nf2lGK1z
         cG5qSCD4Y3jb/3E0qGNJ8Y9VQwLdwSbclGwoZzdE7b+5bB3wPfepumYRxcHDAVUTSkEq
         VZkDKRq5eAMLJL08l4jQWjqkzfxsZzxkYoOIjtvoHJuu3crErbsVEYBiF3B45IwRnucS
         GhYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FIl/ysSyUXO6k1zRYNltU4mrbcWP1wl6EymTV0jbB3QI8tdffj1N4rbbrfIyWcRgaux38H6v2DdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyidulc3SNwnSvu9Cjd7yMHZSCchSmkFgzKY3ccoMpTUuUCWfbb
	LNlGvOeHWVkJ55yBo26WUumIS7hfCd+htyzXR9jvfFd3M84SMnLvCiXS
X-Gm-Gg: Acq92OGrCDAt2uN1snAN8NMx0TQOtEMuNLYjnX+VLJOFnu9dRVLJoeb+fAXxQzSMCE/
	cn8SzgKY5KapIZdceyWgWGnFv8MIMBizYyjXdZjwX470goTLjzqLDr+jMMF1fL9cuKb1tWtdYXH
	hhzPIy6K2sCfaX+N7mZeqzaexHrx2mO6OaXlq5hJAUbZh4N8RwCa32hXCOpmYKZgq0xtAENLl2K
	sHTiT4a69p7naboDwMDcC8TiTAi1NYUsi8GMn8FbblMdTDD1xPu8c1k5whfoE2leNhm0wKASKuj
	uNAZ2ZoxCFmkXQuVpNe6+KIy3JGOItLSUWO/M/nFgArw3UYp5jvOBck+BNevI+kbrWYZJttVuIp
	oX1SZC/ju+LEOyye7sXHoa50VyGmanin7LsCQ8ald7R2v1oJCGnidXH3aXdSruqiXO8VKaN3lo3
	L0MZrrp47EIyXDINCmtdj2DcM0iSPlAT+/+4ElVzFpwwmi/CliUJY0S6nsh/wVesoK1BXefA==
X-Received: by 2002:adf:e84c:0:b0:45e:ec17:430a with SMTP id ffacd0b85a97d-45ef6afbf37mr6578158f8f.11.1780157309895;
        Sat, 30 May 2026 09:08:29 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:5db6:a512:6ab4:aa07])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35874b7sm12170799f8f.35.2026.05.30.09.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 09:08:29 -0700 (PDT)
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
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 01/17] dt-bindings: mmc: renesas,sdhi: Document RZ/G3L (r9a08g046) SoC
Date: Sat, 30 May 2026 17:07:55 +0100
Message-ID: <20260530160823.130907-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
References: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
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
cd, aclk, aclkm) and three resets (rst, axim, axis), so update the
clocks/clock-names maximum to 5 and resets/reset-names maximum to 3.
It has an internal divider for all modes except HS400, and a 2048-bit
divider compared to 512 on others.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 101 +++++++++++++-----
 1 file changed, 75 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 4d66966ce290..16cb395403f6 100644
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
@@ -155,60 +161,101 @@ allOf:
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
+              - description: ACLK/IACLKS, SDHI channel bus clock.
+              - description: IACLKM, SDHI channel bus clock m.
           clock-names:
             items:
               - const: core
               - const: clkh
               - const: cd
               - const: aclk
+              - const: aclkm
+          resets:
+            items:
+              - description: rst, Core reset.
+              - description: axim, SDHI axi bus reset m.
+              - description: axis, SDHI axi bus reset s.
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
@@ -247,7 +294,9 @@ allOf:
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

