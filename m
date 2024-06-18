Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326EB1AED3A;
	Tue, 18 Jun 2024 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699921; cv=none; b=ekjeRBQYXt/rta9S4SxUXoZtuza9pk9Y1JMqch1+CZPsagdTcDCnrf8R+IrpA3pDgyGmiE7nGotG+mnnALdpufRhWMynDot1PSnANkOLvBLZq768Ts2X+CDXwElM1oK/rFu97VhjmojlNjyL479ZJvPHJqWTK7Emp9NuLTxHhsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699921; c=relaxed/simple;
	bh=B+llYKiMHvIXBuJSTjGy7QGQWVdZRavexk8e4cQMxWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UUc8wuNeeQE2oqVm39ykwPkx5JkOIPNz0InoQoxTUwUZV9vdTtLiMugfmaQV3eCxzPSPRCJ/wXimHLtRHO/LaAbGAgXjACaf1sSXX1Z8Vao0EPvGc+RTl1OemqpVQprGJEqAgcpCgVOyOe/0MsWpb5QbPfcaeAqhoFGwQ0rxmQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKTjJ2LL; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKTjJ2LL"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6fa11ac8695so2917787a34.3;
        Tue, 18 Jun 2024 01:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718699919; x=1719304719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1GjDUQ3o3b4+jeUyqmth+0z9OUp8eftPqc5a3xc1TU=;
        b=FKTjJ2LLTLr/pXCYTlBZ+8SYs4VHTtPRdN9Pbn9N0J1UjnfJv/m+QQqSEGyQLddMgD
         AC4/PvX82YcFqBzYgmjwWKmnG8GNq+UdaG4rNyQjF8zfbh1nKiXgZEVC4qYlMHRktNT8
         5DS8qCpR94s4ksB0RBtcCqVcsQ4w3px0NwVgHB31c/QLMoEj2jJUlU4WTqm8D8QAXUNt
         QGY5caah0AecYcHi6npH0o0ZDjBHrjYNXwuPOVM65SQYbag2Dsfq/Q90nLFCjP5p0Mu0
         rUjrKzJ27Hy2Shg+OOzcJ299xvbBvHzDaAOcZni6LsQhz9jbWRLzn5uxnXaQ56JDB/Sm
         xuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718699919; x=1719304719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1GjDUQ3o3b4+jeUyqmth+0z9OUp8eftPqc5a3xc1TU=;
        b=hf29OjZxNBNEHVw2toYtlUR6a5nJDxZAMEqrSfyA4x1uPTTsTailTcC4IVwdul6xXS
         gL+fEm7AFK74NRXCtZJWQ1aslRsOkc7HyDwevOTrGtKl2sItLwMS6r54H5XcaraGmFrf
         dUhBkNoz3BjvpicVe+Jvm9Fv0s8JMSrgTfAlg7rLK2WonCp5xdVGdm3ajnqa1AVzMNMa
         FqxmQyYdxIOt4CzGJtHq7IsinZGoZ+lfqhAuVYbc65CETaohI6/29/c18CyWkgYtxRRF
         KD9cfi39KbSjFOUE5k5fWrh32qakV/tKkMim1b0LUJhzzxJ0RyS8/axTc77uo4+1vjxK
         JrVw==
X-Forwarded-Encrypted: i=1; AJvYcCUPLDwShqQnGFSg6Ii5F4X+8kwODdEMG3Vh8i5YtbvuvtDBvjfPTdcrnPvDtOEg05ehOaKMiApyOLwlqzhyTHGgP1nhuwa4mF7ampQ+sGU9JQ1+0IzLd4za4SOMPhMfH0gjh2H4iv0jijCuB8kpLMRw/CktGVtvXSdIzD1sB92/hiKV4Q==
X-Gm-Message-State: AOJu0YzRZeOT/Vtz9TPMeVo37zwyCtGh1JJjHv1t/PVYit/xJUevjqZW
	Weq3GknX0M0QWjWVIDU6xzILVVQ5+Kev9s1jy5rR/IjTycV+3rx49Rn3uIFw
X-Google-Smtp-Source: AGHT+IFALoxJytTixSUwVOhyfDsBA+wYcZg2xiod4lujmIbAlaE/efLxS/7TXcwcLL+d05UFBkl5gw==
X-Received: by 2002:a05:6830:1e70:b0:6f9:f231:3909 with SMTP id 46e09a7af769-6fb939f0984mr12894884a34.29.1718699919166;
        Tue, 18 Jun 2024 01:38:39 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b1b0bd9sm1779441a34.27.2024.06.18.01.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:38:37 -0700 (PDT)
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
Subject: [PATCH v4 2/4] dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo SG2042 support
Date: Tue, 18 Jun 2024 16:38:30 +0800
Message-Id: <dcc060c3ada7a56eda02b586c16c47f0a0905c61.1718697954.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718697954.git.unicorn_wang@outlook.com>
References: <cover.1718697954.git.unicorn_wang@outlook.com>
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
- AXI_EMMC/AXI_SD for aclk/hclk(Bus interface clocks in DWC_mshc)
  and blck(Core Base Clock in DWC_mshc), these 3 clocks share one
  source, so reuse existing "core".
- 100K_EMMC/100K_SD for cqetmclk(Timer clocks in DWC_mshc), so reuse
  existing "timer" which was added for rockchip specified.
- EMMC_100M/SD_100M for cclk(Card clocks in DWC_mshc), add new "card".

Adding example for sg2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 69 +++++++++++++------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 4d3031d9965f..b53f20733f79 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -21,6 +21,7 @@ properties:
       - snps,dwcmshc-sdhci
       - sophgo,cv1800b-dwcmshc
       - sophgo,sg2002-dwcmshc
+      - sophgo,sg2042-dwcmshc
       - thead,th1520-dwcmshc
 
   reg:
@@ -29,25 +30,6 @@ properties:
   interrupts:
     maxItems: 1
 
-  clocks:
-    minItems: 1
-    items:
-      - description: core clock
-      - description: bus clock for optional
-      - description: axi clock for rockchip specified
-      - description: block clock for rockchip specified
-      - description: timer clock for rockchip specified
-
-
-  clock-names:
-    minItems: 1
-    items:
-      - const: core
-      - const: bus
-      - const: axi
-      - const: block
-      - const: timer
-
   resets:
     maxItems: 5
 
@@ -63,6 +45,43 @@ properties:
     description: Specify the number of delay for tx sampling.
     $ref: /schemas/types.yaml#/definitions/uint8
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: sophgo,sg2042-dwcmshc
+then:
+  properties:
+    clocks:
+      items:
+        - description: core clock
+        - description: timer clock
+        - description: card clock
+
+    clock-names:
+      items:
+        - const: core
+        - const: timer
+        - const: card
+else:
+  properties:
+    clocks:
+      minItems: 1
+      items:
+        - description: core clock
+        - description: bus clock for optional
+        - description: axi clock for rockchip specified
+        - description: block clock for rockchip specified
+        - description: timer clock for rockchip specified
+
+    clock-names:
+      minItems: 1
+      items:
+        - const: core
+        - const: bus
+        - const: axi
+        - const: block
+        - const: timer
 
 required:
   - compatible
@@ -96,5 +115,15 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
     };
-
+  - |
+    mmc@bb0000 {
+      compatible = "sophgo,sg2042-dwcmshc";
+      reg = <0xcc000 0x1000>;
+      interrupts = <0 25 0x4>;
+      clocks = <&cru 17>, <&cru 18>, <&cru 19>;
+      clock-names = "core", "timer", "card";
+      bus-width = <8>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
 ...
-- 
2.25.1

