Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F0C14F104;
	Mon,  5 Aug 2024 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849554; cv=none; b=VW82MJ1IOn/nWDXaH82g4ZOHpkZ1IAgE+kB/HThbYjdPA9QIdek5Qz6ZUUUquvju2tJHz05nuIRNfX+g3C6BSu0SIMuebLoVOcM37sYRTS2cWm0281pNLeS6BFZdtvzD4kk3Aqa2mH3XfU/sEb6v6RP355JvxM2Fi3E9lPfcJs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849554; c=relaxed/simple;
	bh=+FGlhkhwHxHnbAyHFkllHV1+6TCRzAU4acFGmNqwwWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m53a4DplaVVVix9aMIJGGHCJ2iisD3bUNXXb2L9QHPPRD4Azd5r3PBGyBl1OskNORR2jzlt4GuSlalOy/o3a/eziit8090Jh0nheXRIyUS0h8amDPUB4B1Bag0Uk4w5w9PtWPyPJDrGpsRdlcuEQKHRcfDhCnPs78USEs7FexN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODSrkxCa; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODSrkxCa"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5c324267aso5514622eaf.0;
        Mon, 05 Aug 2024 02:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722849552; x=1723454352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKZKLwIrLvB9ZFsYAq1sUq9lxL9HVjwkxz7TvV3FNk8=;
        b=ODSrkxCanF1JFeeD1RZkpkFXu9JkGoeBPEijtc1mjLBzAnslZ2C8I0FCBnwCIiWi3z
         Cm+cENFIpAe6vzwV9XEFPQNdPZ/QYHKOPZKaf1qm18Yo1OJ1Lw4Y8ZyJTBcn9a1sK1Nq
         PoIEJ9wYk9wfXd5twZ8M0bJJl/iuM+wDZIOGogbVTeyFfFups+njUY2PXE5rx97hW5Am
         WzoNBLP9asGqbm6OR7LWap9QRe5cQFnZejs6SeI9lG+59kc0zJhIYl0CBTRoveXEwlLu
         vDITYE1ndX8feYwQKRRcyZV8vpcqcNLt+PNLgovJqN68Q7358JLQKaa9RO8WfKOXV0DL
         cmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849552; x=1723454352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKZKLwIrLvB9ZFsYAq1sUq9lxL9HVjwkxz7TvV3FNk8=;
        b=pYwOBXH0DaQ84Y7+ipLq/eEUPJ8gjdSdeNxGOws/PVv1Hg5FOIKnlIcIVKHzPfd83d
         eVIlfF1n/4eLjOcQ4xVGTSci8s/ms4PSuhtrIeBE/+n0ouucoPNzSvXQjsIo9zdHvVI4
         YWoGzBClZhG28ry1P1IoTVPa8PZgYyIImaedRc0higKg04ckJ+UvxwpMjdVqiBTCexMG
         3StDTu5GjcdXeFgLMzwE2Hr0gUWxErTEE1QmYjI81XZ/BUHiGzcBwmSv1l494Rps2H31
         sHle7KFfaMzguCJQwvPy3lPDEcV1cZ4I2LWBIHemJSsfYRxRteAbtPd+bZWxT9k3vB7b
         Mi9A==
X-Forwarded-Encrypted: i=1; AJvYcCWtKi/Ix842B49Uese2KAgoNbV/gWLI8mxKnH7wDGkrcVeZhiZuz9FJA03zV+scmHHSBH6pFpNwgLjAEtvY+MyliMeMT/V+7uNz8fIcjiduoUzxxANG8g43u3YQwRpgxQz+u1ZkN5C+XNrri9/L5KgvflgR8tVp3F58+LREf1rOicTsCw==
X-Gm-Message-State: AOJu0YwdAvP8A6T0WTugbLQl/bnemHiUPfrY6H5gRrOeVHmaYAzHZU4o
	ADCDGeAXA8Yk7c2W9UE3QtxG1CQy3KMPr5LU0YyDfWNvEQMz2RDE
X-Google-Smtp-Source: AGHT+IFpabPlu04Zp+9kW5LL/5GpnkEoFtCPrhlmJpSoDUSCC7Ht9xubRYfCNquJfjUV8vCE0qZrIA==
X-Received: by 2002:a05:6820:2903:b0:5c9:d9db:6a51 with SMTP id 006d021491bc7-5d8107b74b9mr5369594eaf.0.1722849551987;
        Mon, 05 Aug 2024 02:19:11 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70a3a768e12sm2884751a34.65.2024.08.05.02.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:19:11 -0700 (PDT)
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
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 6/8] dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo SG2042 support
Date: Mon,  5 Aug 2024 17:19:04 +0800
Message-Id: <9ca450097e5389a38bcd7d8ddf863766df4cea10.1722847198.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722847198.git.unicorn_wang@outlook.com>
References: <cover.1722847198.git.unicorn_wang@outlook.com>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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

