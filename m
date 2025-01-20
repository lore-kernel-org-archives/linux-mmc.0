Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D373156678;
	Mon, 20 Jan 2025 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737398899; cv=none; b=FoB+Dx2NJ284qNFyVGpN2bmKU7lxo9/H3AaXjEFVTnDvGHLOd63ofN4p9a7UMOgrpS8hfqGwxM2N1nuNXJH0QkVlf8NVnsHVWxYWQCnPG+gjISA4W+ikWmJBEXxZ8VSy216JvMf+1ZBXJbfP57jtNBKJysr4zKhOE/+ea0tR9FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737398899; c=relaxed/simple;
	bh=t5j6/xb9wRBJfV3KlTzoDsRE6qny8nT6MBzGBHuo0rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jzT/H6rzuCWaAvHbPWJQQWxkR5yXqpRdfZGvsYDaJWgzuKgMXTHxQyzpGkJr+obUzG5P8vcM/lx303vr646ELDg87nVUGzZqCP+JWnWvo5rahfuM1yG1mpAcoKmEptK7Dh/C77vOxwjY+82XbJHoZ0lCX7A4TXHC7DzqfRzobBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYlAEDmo; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYlAEDmo"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385de9f789cso3707894f8f.2;
        Mon, 20 Jan 2025 10:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737398895; x=1738003695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S8Seydpbd7RN4//dau0WHbnEJIo9MdsVN3XRt1Twru0=;
        b=EYlAEDmohaGuMT+TX8jdC/mEfXfXeN5hAlT49IF4GppNOPm3lbDBAztaA34ovTQJPC
         NrvMX64Gpf/7Dr6l3UXTsH+qKRtYJUdS2fDcL/FYEi+Ot0Hj3nPoLaShZFk/7p4Oa5HK
         jlnnZR3wTR5uJ7G4RlK9r2Js15BHmSqt7vlTvuUj9LpD1+scaa6SuOdWlnHEWU8ikHS1
         dqBznMShPXt51L9aCil/Av12DsQbrq+Iv0XNW0x3dHFKzMjovHDHMdP1pI8MwKbZnX9v
         OVUyNLpWt+OCgAvflin3n6lDL8r77R9/aTUW+quiOWaQIyev5mv2TqkDMdQEsT5iMkcm
         ObTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737398895; x=1738003695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S8Seydpbd7RN4//dau0WHbnEJIo9MdsVN3XRt1Twru0=;
        b=eWV2GrTWI/JNxcchr8Az2fDZzikBlo5j8DQgV6LQlI/Ark+oqC6cC8CoxRHcfEEcHe
         R2wFJTtCbyKL5WL6Pf61rEv8Uf3bqJTJ8yQSDW6VfTymORj8rsNbLnu3xeKHpH3gR7XR
         A8ftMIAmB5p6NPXbOMvz54zSxWdWZDzsjoWCNCOFhFRdzYdFmVDTvc0OzosKiTziMHE/
         BUme5c1rRwhr5AN3go7ZZGWz8OwigpjXFs+iM4RuD9L578lQR64njF8Eb5enmV/85q6H
         12bmiTLwY/Z8D38x07B8TTI6B6wgZFrSzA6CaPU4E+t+PMaWPNJTDib6CNSfdjogokvh
         QwxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpL662Ukxr2OBpUPkkvnkidZH7bbvN7scvNfG+uMo/8sxMLCX05mFEUhq58QjuoEvDbpofBLZIWsztjGkG@vger.kernel.org, AJvYcCWWRUaneiJ18JSKJtHSCkV/qPeMUil0WaFDScAqOYQaC7g5h0pPyfGjMWyjfeHlogvg7rffwj+A28VR@vger.kernel.org, AJvYcCXzJlGHNAnoAEMp3r07+4kW7QBTyR41DHtwiZnxKgxG8Un1nwrPO9XoWfCzQLj/I2JP5kU/7zM1GGme@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9vs+ZH3GT/f/xyK06kttKxOX+2ucbE7cj+QLBQo4plNYInJUM
	hDyeFYwWayZ0JJCg6AiIgmAMX3NXrn3zD1DtLE4g7yh8WxI1r4UcLqNOyA==
X-Gm-Gg: ASbGnctKbsenRuJI03bdB3p8OaEkkN7buCT4K8kFuJJw+JI+ndmCHkeS16hhj0e+pkJ
	Pmf6S48ZCDqoxIHrrnwi6vP3RFS9y+XRd2DbNshk3B3Inkt+s8vdPOGxeapeV4dngKiRiAAw1J9
	Le/t9ZrVgLeVv2uvGAUAn5FQTmqTYDTso00U/e1Fo0Q6WnmWguHRs+kHFAnK505jSZUOxlZx+Zc
	m2zHbBHPiM0OhqDAb6lwl40rMva+LJun3GDMKLsJDoSbcbKU0VxPWLy826Ts/1hMKELUaNm3BND
	EGCYZmZQ3j/nX55wDNPzZo7t8jyHWT+8dywNSbg=
X-Google-Smtp-Source: AGHT+IHdc8xiYtH4eGE52ikJIMkZ5teueIyjohP596cdY4yzLLgnrH7k/sLT0W0Fb/5CsCENj4sPrw==
X-Received: by 2002:a05:6000:1788:b0:382:3c7b:9ae with SMTP id ffacd0b85a97d-38bf56633damr14023832f8f.16.1737398895134;
        Mon, 20 Jan 2025 10:48:15 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38bf3215023sm11095390f8f.9.2025.01.20.10.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 10:48:14 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wenbin Mei <wenbin.mei@mediatek.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	upstream@airoha.com
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Add eMMC for AN7581
Date: Mon, 20 Jan 2025 19:47:01 +0100
Message-ID: <20250120184728.18325-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document eMMC compatible for AN7581. This eMMC controller doesn't have
regulator exposed to the system and have a single clock only for source
clock and only default pintctrl.

Rework the schema to permit these new requirements and make supply
optional only for airoha,an7581-mmc compatible.

Also provide an example for airoha,an7581-mmc.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Drop else condition
- Move Required and pinctrl property to dedicated if condition

 .../devicetree/bindings/mmc/mtk-sd.yaml       | 116 +++++++++++++++++-
 1 file changed, 110 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index f86ebd81f5a5..4c1da48aaa1b 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - airoha,an7581-mmc
           - mediatek,mt2701-mmc
           - mediatek,mt2712-mmc
           - mediatek,mt6779-mmc
@@ -48,11 +49,11 @@ properties:
   clocks:
     description:
       Should contain phandle for the clock feeding the MMC controller.
-    minItems: 2
+    minItems: 1
     maxItems: 7
 
   clock-names:
-    minItems: 2
+    minItems: 1
     maxItems: 7
 
   interrupts:
@@ -72,7 +73,7 @@ properties:
       Should at least contain default and state_uhs. To support SDIO in-band wakeup, dat1 pin
       will be switched between GPIO mode and SDIO DAT1 mode, state_eint is mandatory in this
       scenario.
-    minItems: 2
+    minItems: 1
     items:
       - const: default
       - const: state_uhs
@@ -170,9 +171,6 @@ required:
   - clock-names
   - pinctrl-names
   - pinctrl-0
-  - pinctrl-1
-  - vmmc-supply
-  - vqmmc-supply
 
 allOf:
   - $ref: mmc-controller.yaml#
@@ -275,12 +273,14 @@ allOf:
     then:
       properties:
         clocks:
+          minItems: 2
           items:
             - description: source clock
             - description: HCLK which used for host
             - description: Advanced eXtensible Interface
             - description: Advanced High-performance Bus clock
         clock-names:
+          minItems: 2
           items:
             - const: source
             - const: hclk
@@ -317,6 +317,7 @@ allOf:
     then:
       properties:
         clocks:
+          minItems: 2
           items:
             - description: source clock
             - description: HCLK which used for host
@@ -326,6 +327,7 @@ allOf:
             - description: AXI bus clock gate
             - description: AHB bus clock gate
         clock-names:
+          minItems: 2
           items:
             - const: source
             - const: hclk
@@ -335,6 +337,89 @@ allOf:
             - const: axi_cg
             - const: ahb_cg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: airoha,an7581-mmc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: source clock
+
+        clock-names:
+          items:
+            - const: source
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - mediatek,mt2701-mmc
+            - mediatek,mt2712-mmc
+            - mediatek,mt6779-mmc
+            - mediatek,mt6795-mmc
+            - mediatek,mt7620-mmc
+            - mediatek,mt7622-mmc
+            - mediatek,mt7623-mmc
+            - mediatek,mt7986-mmc
+            - mediatek,mt7988-mmc
+            - mediatek,mt8135-mmc
+            - mediatek,mt8173-mmc
+            - mediatek,mt8183-mmc
+            - mediatek,mt8186-mmc
+            - mediatek,mt8188-mmc
+            - mediatek,mt8192-mmc
+            - mediatek,mt8195-mmc
+            - mediatek,mt8196-mmc
+            - mediatek,mt8365-mmc
+            - mediatek,mt8516-mmc
+    then:
+      properties:
+        pinctrl-names:
+          minItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: airoha,an7581-mmc
+    then:
+      properties:
+        pinctrl-names:
+          items:
+            - const: default
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - mediatek,mt2701-mmc
+            - mediatek,mt2712-mmc
+            - mediatek,mt6779-mmc
+            - mediatek,mt6795-mmc
+            - mediatek,mt7620-mmc
+            - mediatek,mt7622-mmc
+            - mediatek,mt7623-mmc
+            - mediatek,mt7986-mmc
+            - mediatek,mt7988-mmc
+            - mediatek,mt8135-mmc
+            - mediatek,mt8173-mmc
+            - mediatek,mt8183-mmc
+            - mediatek,mt8186-mmc
+            - mediatek,mt8188-mmc
+            - mediatek,mt8192-mmc
+            - mediatek,mt8195-mmc
+            - mediatek,mt8196-mmc
+            - mediatek,mt8365-mmc
+            - mediatek,mt8516-mmc
+    then:
+      required:
+        - pinctrl-1
+        - vmmc-supply
+        - vqmmc-supply
+
 unevaluatedProperties: false
 
 examples:
@@ -389,5 +474,24 @@ examples:
         vqmmc-supply = <&mt6397_vgp3_reg>;
         mmc-pwrseq = <&wifi_pwrseq>;
     };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/en7523-clk.h>
+    mmc@1fa0e000 {
+        compatible = "airoha,an7581-mmc";
+        reg = <0x1fa0e000 0x1000>,
+              <0x1fa0c000 0x60>;
+        clocks = <&scuclk EN7581_CLK_EMMC>;
+        clock-names = "source";
+        interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&mmc_pins>;
+        bus-width = <4>;
+        max-frequency = <52000000>;
+        disable-wp;
+        cap-mmc-highspeed;
+        non-removable;
+    };
 
 ...
-- 
2.47.1

