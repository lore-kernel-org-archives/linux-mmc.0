Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325A1264617
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469859; cv=none; b=PIevXOh4nSMFWbU0d3jjhZ+JYMNmJTDyT8/3OBNXEdOpJC9ZZO+A77vQAULKD1UUXSyi3SrXGqzqPUTdm/4H6rJHa6Wn72TlLKSEvYuc33pVUAu7EmmnFQrMxOnzqVj/Sc61MPNg80jhvbzKEM7jEqdDj89afNzFeFU6go7hYpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469859; c=relaxed/simple;
	bh=ktPWTrIQ6kUyMYFIfy7AUvYRJMB22/jk4rE8DMBdAcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAiYyGItpFcVAG99YHti8COyOddSV1Sitj41Uf+FkXDkoeWgXQqI6ifblXLXYda+vzQfVwusNzN+0sVhL84I7NBUCIyJiXemmxJVbacwTpuVNeHON2RKrVrLCK7HS5zZjFhD6cCYWZ42heJ/ebf3x1SVQgFi6cwl5tUz17FVVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2eek9Tq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2eek9Tq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so92527945e9.0
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 23:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780469857; x=1781074657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxODoCaYbGYHXWV46RIuqQL4fxR5L5CkKK8wbKgagJA=;
        b=C2eek9Tqala0KNlteyH+wFaDlUfs8LX6rXXOrQkv5HAbJBYSYNlMuNewhqt0lsb30v
         zhD5RNeKNjEAP3RE3vbOkMuTVZ0qKhesXwNJXhyl3FOR9PT9syvcJdir4bZqH7wvx8+y
         F7Bo1MQWfIY9hW89lymPg9+vXFXBepXjNTE2PTxKG0pxlXnJHsa/mZ5/+Uaw83wYOo8v
         gOXZxBD+nnVDJzzLEHN9j+haE8cvVJ/IZ/Jkr59eoa3FbuRVog13Iyy3DeHBRa7JlFvX
         +CpCW4kvFjvpffOPEdJU4qbk3Aego1xitJsZq1y3eonLvkhkNCr6Iz9+wu0xLvlg5gWD
         DneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780469857; x=1781074657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sxODoCaYbGYHXWV46RIuqQL4fxR5L5CkKK8wbKgagJA=;
        b=jWqdtlTNJ8+JuoGRSGU/PFZOOKauQdPB07mIwI1zGKIg/lfHAvccGWnKr8qtP+Gzes
         uU84cDAaSrya5pNtYtAAGGdMqjbzIS3AjFD0ffxfULl7isDVgezi/il61P3Cm14lEgSR
         ilsEwze9YTxruviFh40C4ryp9EHr7uQ0w0zu2YTsMY1pES6YPTc/FOf23ohMe2g/1YCo
         riS3aTQN5nkdWJJWnsZlwNgQyHQ1SMJ6fk7eYRT5f96t/lXNbYK+qPos9JIwU/GvUOM+
         2cijUGgmei7bTFTvAsBwa5c3HhzBB5PVKlnpJQfenGEAC2Pf2KWqX6iERNi6IKwPHzm6
         +CPA==
X-Forwarded-Encrypted: i=1; AFNElJ/TiysBb4QMsZM4IZuAcUh9n3nDImw+DYUYAflL1HTA7/uOi4YDLVmPVacC++ZgGJV0D1L8dU3u3Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5MkeNUaqErbJOq/75z5l8kWyTXwbvOhccumtwkKw7aXVRrlGs
	wgMVgqG/Yq23gx35WQHH1Rso/edLCKSB9rAZhqQem4Wk5uoc7OCrp/Hf
X-Gm-Gg: Acq92OEd5V37ioAojvSRgxDLRoTDKJm3QVAb9CCQjJV9V4mKeLo7qsVgWB2wU+TxBcH
	59ZYrAHxWCp4yd3jBDwpYNkKbuA9DKHi2Ps9OLUHeZODE6Q1P6ykYC11bAghAR3tP7u7DJDERmk
	hfWNbv11T0V2m18XmwPKoyynGAVNg1y0YIq8xDMiK2SqkX0CIy5yKGT5TBTvoU5OkVvsN8EaSMg
	Zprw49YboOM3Cznk5LrKAl09G7Q1RVt/8+poP94ebJRiJFzEiy8zW/1wfLg/NQtEGh5tK4h2BxH
	B86ZpTtLM9O7qZ/TGyBlFiW59BFE3QIntDGVjwE1LjNIbcOE+YlqKVq/0qDjAiDA2SpViWSIFSJ
	pKdORCH1nSxTwPSYOVA9onK9h6CSBKGDTnAbg0DcCkXnRlsIXcUOu9nO9bw3HeemzyFKtBaUjDh
	YfwgrPDaHjp7iNCgqTLhNMUNtcvtlbJRCx58OSPCwpjcRoNXZbbfdTO4TnqEHR39pS+UrrzA==
X-Received: by 2002:a05:600c:810c:b0:48a:525b:e148 with SMTP id 5b1f17b1804b1-490b5e7959emr31834725e9.4.1780469856635;
        Tue, 02 Jun 2026 23:57:36 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:179c:89ab:19f6:9ba4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b79d90bdsm9001855e9.0.2026.06.02.23.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:57:36 -0700 (PDT)
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
Subject: [PATCH v17 01/17] dt-bindings: mmc: renesas,sdhi: Document RZ/G3L (r9a08g046) SoC
Date: Wed,  3 Jun 2026 07:57:01 +0100
Message-ID: <20260603065731.93243-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tag.
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

