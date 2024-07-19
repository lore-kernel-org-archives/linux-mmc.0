Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C3C79B96;
	Fri, 19 Jul 2024 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378820; cv=none; b=B8GzcFo1UPe2uXH+5/MZGWjRj7/9PiEebLWb1l6139rJOg6I3oPALc5TLnFQEmAnU0eF1ss9HyyGOu0Gz3yPsAzoXKjhmDfPx2ohdAWoNx2L5nruHoh7gBmXjoRfas+6Xlv9zyRIk+WLpXMuZc/K78gWw2l5ReqfZMlc0fSkKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378820; c=relaxed/simple;
	bh=Z1EIUW9ZSmPeZCZvFwag4fz1+w9h2lWqIyNdEIxWUy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VwXXW1Mk7fnnPSPm6dzPHYBkBo/pzBEWMNLXKWFF4TDdZzKxuR6FhZebwm+t2dFMGba70WzQ2hLwmKoFc8T7dPdgcUDkdbbY0rB1PSfwPM02XbMZrE6ox5mBjDYziUTRSvqGun50lm+BsZVkO9qCM1KcjtXVgppHeNAmwfqxVLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK1zjL1e; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK1zjL1e"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3cabac56b38so1055257b6e.3;
        Fri, 19 Jul 2024 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721378818; x=1721983618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKKw/4Id92VNitQ7o/JQZihQX7XuedjZLl/fZYSG9co=;
        b=AK1zjL1eindl0H0LLq8TiVFYLyQD4ADeVLd9vkhIGBfJlHMGroZCxRyJYB9nxIRhy+
         ZsuERUTaaV7UX1Nuc7JhzoJibmPpfSx5VGaTCLCx1t0J7HpMBCtlBiSulg5nkMyWglKK
         u1dgeA6LMBqiH13V7StIyAtxSqgTmdjk3Ll4QzLDUMDb72KAu5Py/5e3P/Y0q1IgKpmV
         jOMAOn9zqk7q/qH9cPHFjY8JwNtaCrbYOdqP7U6pF0cfsUl958XhsxgJKFbgUaK+buq3
         JEi3bVApIRz4a7nZCDZz1JruJLhytdfeGEczwPA2Bqea1lPOknMqX7xbmjd2UlcTO7ik
         kUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721378818; x=1721983618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKKw/4Id92VNitQ7o/JQZihQX7XuedjZLl/fZYSG9co=;
        b=twLUp9Ghv6wzxCa8p4gmFm+sUFPEjazC4fKTlJtcGj7c+oRMxHujBINoKu8WxbD/yn
         FYCRy8Er8K7avfuvwbZ3fvpD2Zpwoc/M4lD+pwuqFayCWVkBD0nLNzboGyZCobcXn9XQ
         i8s2s2i8fwKFyisd7J1xaKlpeySPG/rHYcZCprSLsd1Pik1DOxVnXilVR8kaX20z3+Lf
         yP7CPcBIaSYK8d4Yw6GZIYeLmp4DAY9KXJuV48GKdejbAd2BqwEUSX32GVjFx2MysNOE
         dzb3WnPHyRyNu9vbMOsdPNH3yQt3K4xkxEJIuPFUgutLFLlIk3YTGwk9mFXGNcPF9uwG
         imAg==
X-Forwarded-Encrypted: i=1; AJvYcCXwMz909/eJxvGS4l77drpyd7iziBurWXVLZP3FDNsCGBo//qosb7KZ3UhXv69Tamz+Ioc6PN/aD58g5jDQlKudGhgqPidVW8biFp9Qz7YRdy9MNUKua+i2sv4xUcWr5NqtX/SkM8JWVeRNKSeiuBB1mAK1R7NkltdEcqdtL6m7s4c7FA==
X-Gm-Message-State: AOJu0Yw65GbvtPWn8HsMO0z/1NGqdve/cIEILHbjFCfPEj8IuNTmh6s/
	Qpd4EtUo5UVZjhbTAUxtZRFSyYZNPvVv24igj3IYCR6vh5Z8U52/
X-Google-Smtp-Source: AGHT+IGAbSX7r8e0DjtizVbyHAI2tIPQog4VJJFwrAa+LxMXgf/cjjUFmzfDEpCmO19giRs2ru3bxg==
X-Received: by 2002:a05:6870:6126:b0:261:906:a03c with SMTP id 586e51a60fabf-2610906d02amr1641798fac.53.1721378817708;
        Fri, 19 Jul 2024 01:46:57 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2610ca48c79sm230586fac.45.2024.07.19.01.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:46:57 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: adrian.hunter@intel.com,
	aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	ulf.hansson@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v5 6/8] dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo SG2042 support
Date: Fri, 19 Jul 2024 16:46:50 +0800
Message-Id: <55bc60606bc9b2558eeddb00fd8b659d3fcd69ff.1721377374.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721377374.git.unicorn_wang@outlook.com>
References: <cover.1721377374.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

SG2042 use Synopsys dwcnshc IP for SD/eMMC controllers.

SG2042 defines 3 clocks for SD/eMMC controllers.
- EMMC_100M/SD_100M for cclk(Card clocks in DWC_mshc), so reuse
  existing "core".
- AXI_EMMC/AXI_SD for aclk/hclk(Bus interface clocks in DWC_mshc)
  and blck(Core Base Clock in DWC_mshc), these 3 clocks share one
  source, so reuse existing "bus".
- 100K_EMMC/100K_SD for cqetmclk(Timer clocks in DWC_mshc), so reuse
  existing "timer" which was added for rockchip specified.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 60 +++++++++++++------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 4d3031d9965f..80d50178d2e3 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -10,9 +10,6 @@ maintainers:
   - Ulf Hansson <ulf.hansson@linaro.org>
   - Jisheng Zhang <Jisheng.Zhang@synaptics.com>
 
-allOf:
-  - $ref: mmc-controller.yaml#
-
 properties:
   compatible:
     enum:
@@ -21,6 +18,7 @@ properties:
       - snps,dwcmshc-sdhci
       - sophgo,cv1800b-dwcmshc
       - sophgo,sg2002-dwcmshc
+      - sophgo,sg2042-dwcmshc
       - thead,th1520-dwcmshc
 
   reg:
@@ -31,22 +29,11 @@ properties:
 
   clocks:
     minItems: 1
-    items:
-      - description: core clock
-      - description: bus clock for optional
-      - description: axi clock for rockchip specified
-      - description: block clock for rockchip specified
-      - description: timer clock for rockchip specified
-
+    maxItems: 5
 
   clock-names:
     minItems: 1
-    items:
-      - const: core
-      - const: bus
-      - const: axi
-      - const: block
-      - const: timer
+    maxItems: 5
 
   resets:
     maxItems: 5
@@ -63,7 +50,6 @@ properties:
     description: Specify the number of delay for tx sampling.
     $ref: /schemas/types.yaml#/definitions/uint8
 
-
 required:
   - compatible
   - reg
@@ -71,6 +57,46 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: mmc-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: sophgo,sg2042-dwcmshc
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: core clock
+            - description: bus clock
+            - description: timer clock
+        clock-names:
+          items:
+            - const: core
+            - const: bus
+            - const: timer
+    else:
+      properties:
+        clocks:
+          minItems: 1
+          items:
+            - description: core clock
+            - description: bus clock for optional
+            - description: axi clock for rockchip specified
+            - description: block clock for rockchip specified
+            - description: timer clock for rockchip specified
+        clock-names:
+          minItems: 1
+          items:
+            - const: core
+            - const: bus
+            - const: axi
+            - const: block
+            - const: timer
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

