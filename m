Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966DC1BD9C2
	for <linux-mmc@vger.kernel.org>; Thu, 28 Nov 2024 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807015; cv=none; b=umjYEJ+XvbMW0bmuUvxZ3RBTCmFc3b/syIvyCXa2gCEU3ZdCTEYpgEl7EOckDxDoG406m5PP5XnMpDwwz8gHBxkU3MiNJD7+RfUkyCoMu81L+sAKDbmkWwmV4++EH27HRg3MY36AEGygC49UszO4XaXnC4wLYDnXMSwMkCrCR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807015; c=relaxed/simple;
	bh=EyHdKYQSzhp6Q5IckerUZg/bcUhVWP1QC3wdvMtdE4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkP3XMzVpnBn4xo+pebmkTEaZG51O7Lx6/Puif8CR1LDN0Ks/xaxBWKWoSCChVubo+ISzMxzERZBHlGp1y6uh7Gs1crfmIplOjPKcPm6hjMuWNv4I4N6l9xP2lxnba6w88iTujs0TNdSkWGazXl3VGAcv1V5BW4y2oj8shmaYDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nktGNZIY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nktGNZIY"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-382325b0508so478034f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 28 Nov 2024 07:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732807012; x=1733411812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzpFYlwmRDjUdywRFCwk3EMOwG1W4Bvy7VRMs6AVjzU=;
        b=nktGNZIYAxR7N0RpoNTV/b7UVj0G+NbbNf4HWCA/S84MSEW6LSdG08quZL0zVVEIIP
         KDhB+Lne0aRt4yNkbnXLyMLqZw9AJAVpt0xz8s/2qP57BcSh9U2WQw6nZZDV1av6V4XE
         0yJd1BGzpriC5oxXI/VAtJcH3j5sQJtgQWq/HKrK3i32dDOUGe7UX/G/nV7HgnQdNQx/
         utIsf63kYCqc5E9rDkZLyl/RC9dBAn/tqTRLJI+N3heRrpOrGkeOvtrRx26vEu8rnH2m
         J5YpVvZ1o4DS2c3HGwgsNH+muNtDsu5s145SUlx6UAwIzT1YPF4blNagiyo+NPyrxhM2
         CRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732807012; x=1733411812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzpFYlwmRDjUdywRFCwk3EMOwG1W4Bvy7VRMs6AVjzU=;
        b=VxYTf4+YHf2kBnjVn1Jshi2K5kbNfuaCtNMsL0ofkY4l4fWXxavqQbCQ6K/1PCrEfg
         AaxZjMUyTab4o2MBaJ3judUy3MaFS39HyGEWOhtZ804e0xDXyRQu0odwStYxVwZ1ScEK
         D12MecdPW1ePjcq0im5EQ4dh2CEdVZ/9VRlaIyHUsb/pxkplgLoP3xY7cimjamw+GulS
         rgIlvCJ6ZsBFATg1fhpyTZ45coFSCkK8q8Lq+JPJ2HWBia09TW5TigRb32amgbmRCGmG
         WuBgdii8WYJpknGlGet9jSz3k4Um6lALJAfe0aji7OcXO9F3igDjjG9AfavDC1/hhxWy
         /8/Q==
X-Gm-Message-State: AOJu0Yz6vXrUykLIKmOv/dXt2/TrDBt0V5rB5Ym+tg2nAAzkflfOtbjC
	+WmkUbP2m983pV0ldWISQFs0UAQ9i188xd262bJvwWNKuR3PzQUMAcmq2hfqgYY=
X-Gm-Gg: ASbGncsTsQ7tlCfmfRjUCmsa780ngrH+qil1smJahGoDLEgbfac0t3Be7oiBnqymBAp
	nC31NrX3iCYoRXQeTQLfFynhy3Pu+bi4bOwcJ9jQQEuYRhGV4Mji3KqpmnFFQC9ZQZKwEjFha8j
	xLHKd+WKSZuO/XJ6e7l9HORCL6jFTCMy+w1Qv36d3JDRGlzhFS60eGJBlLI1qKcfV4viT+UQk6L
	pehJ3Owxt89Hny/JPjf+FExoCNR8n7TdSz/K4S2HkI5c3q/74pfkZkYIGrdjOdluP/yziw=
X-Google-Smtp-Source: AGHT+IH4AIKDNQTGuzrRL5OCcaR5+oCwqwuiQGkqb+Yio/Cxxa2N2THu7Mb64eFoUBklqJHWFxGrjw==
X-Received: by 2002:a05:6000:1846:b0:382:4d6e:9f3f with SMTP id ffacd0b85a97d-385c6ec0b9dmr6474374f8f.34.1732807011807;
        Thu, 28 Nov 2024 07:16:51 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4fe1sm55867025e9.38.2024.11.28.07.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 07:16:51 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 28 Nov 2024 16:16:45 +0100
Subject: [PATCH v4 5/5] dt-bindings: mmc: convert amlogic,meson-mx-sdio.txt
 to dtschema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-5-11d9f9200a59@linaro.org>
References: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-0-11d9f9200a59@linaro.org>
In-Reply-To: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-0-11d9f9200a59@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5272;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=EyHdKYQSzhp6Q5IckerUZg/bcUhVWP1QC3wdvMtdE4Y=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnSIldLzAfDGWjxNDmzJ2/2WMIp1sGGnOvNvp6JCAp
 myNjCKKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0iJXQAKCRB33NvayMhJ0azxEA
 C0McuYqWQAYwfk2xajPs3bcX+BmlzuLuas2bMzBD/me9jZu2mkdUG1VEwoolEX0gCO6JlqxaxQJ4WM
 wL5TOWyl98rq7QvpGteUK8etgNs2ID4qhKX5hsWLrDH4oFKHIg776KlZ16WwFxrM9zotbWNMva+AMr
 PN2wCcOX42276Z2sU+fwg0/lzdd9L6FPWHRy5eEpK0aQHmiDQj+xWmpVF02Rpy5PZfZLrrFk0JKfYn
 kMwv8pGldajb1UUUNMVjgVjW3nCPo6TR2mKVgq07cyTxpi/BpzMzsx7mKZyQRV1wIhs/0vaSqGGoR8
 PtPicnej6Zrj/gBQ0Rx41nTgYe1ymgeHaeu7hTpaGuswR1U4Yst4g4st1a9VRP+Z3+aHaE9G68NBGW
 EFEGhsTm7hiRiOpOm/e4mIwZNv8BHi2KP+D8nWhyGQaMZQNCOoFsYII+g1gTq+O57co/vJIJGoPCS7
 HiFh3roegB3Z1kHpgZfMy+n26Nq6UgphQZK9vM8DIcEtNg+hpAvS+D2SArm9nd7UVMq3GLHcRwABCo
 znU/pLdQSIlPfCbgFBobDgij0o20asawXWTryI8DjRMq5MWYv1IFkyqg1upLB3lmE/KKIGgVc+oyRs
 rKG7qfGo4UICqZfJVFM5ejB7HSDuzO9FBcPhkyYtfPmmG3r90+p5BpLOl+yw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Convert the Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
bindings to dt-schema.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/mmc/amlogic,meson-mx-sdio.txt         | 54 -------------
 .../bindings/mmc/amlogic,meson-mx-sdio.yaml        | 94 ++++++++++++++++++++++
 2 files changed, 94 insertions(+), 54 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
deleted file mode 100644
index 8765c605e6bc761db2923ad748b5bb70d40ea830..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
+++ /dev/null
@@ -1,54 +0,0 @@
-* Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
-
-The highspeed MMC host controller on Amlogic SoCs provides an interface
-for MMC, SD, SDIO and SDHC types of memory cards.
-
-Supported maximum speeds are the ones of the eMMC standard 4.41 as well
-as the speed of SD standard 2.0.
-
-The hardware provides an internal "mux" which allows up to three slots
-to be controlled. Only one slot can be accessed at a time.
-
-Required properties:
- - compatible : must be one of
-	- "amlogic,meson8-sdio"
-	- "amlogic,meson8b-sdio"
-	along with the generic "amlogic,meson-mx-sdio"
- - reg : mmc controller base registers
- - interrupts : mmc controller interrupt
- - #address-cells : must be 1
- - size-cells : must be 0
- - clocks : phandle to clock providers
- - clock-names : must contain "core" and "clkin"
-
-Required child nodes:
-A node for each slot provided by the MMC controller is required.
-NOTE: due to a driver limitation currently only one slot (= child node)
-      is supported!
-
-Required properties on each child node (= slot):
- - compatible : must be "mmc-slot" (see mmc.txt within this directory)
- - reg : the slot (or "port") ID
-
-Optional properties on each child node (= slot):
- - bus-width : must be 1 or 4 (8-bit bus is not supported)
- - for cd and all other additional generic mmc parameters
-   please refer to mmc.txt within this directory
-
-Examples:
-	mmc@c1108c20 {
-		compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
-		reg = <0xc1108c20 0x20>;
-		interrupts = <0 28 1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&clkc CLKID_SDIO>, <&clkc CLKID_CLK81>;
-		clock-names = "core", "clkin";
-
-		slot@1 {
-			compatible = "mmc-slot";
-			reg = <1>;
-
-			bus-width = <4>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..022682a977c6d347c36279f958dcd6f53d385b71
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/amlogic,meson-mx-sdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
+
+description: |
+  The highspeed MMC host controller on Amlogic SoCs provides an interface
+  for MMC, SD, SDIO and SDHC types of memory cards.
+
+  Supported maximum speeds are the ones of the eMMC standard 4.41 as well
+  as the speed of SD standard 2.0.
+
+  The hardware provides an internal "mux" which allows up to three slots
+  to be controlled. Only one slot can be accessed at a time.
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - amlogic,meson8-sdio
+          - amlogic,meson8b-sdio
+      - const: amlogic,meson-mx-sdio
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: core
+      - const: clkin
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "slot@[0-2]$":
+    $ref: mmc-slot.yaml#
+    description:
+      A node for each slot provided by the MMC controller
+
+    properties:
+      reg:
+        enum: [0, 1, 2]
+
+      bus-width:
+        enum: [1, 4]
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mmc@c1108c20 {
+        compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
+        reg = <0xc1108c20 0x20>;
+        interrupts = <GIC_SPI 28 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clk_core>, <&clk_in>;
+        clock-names = "core", "clkin";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        slot@1 {
+            compatible = "mmc-slot";
+            reg = <1>;
+            bus-width = <4>;
+        };
+    };

-- 
2.34.1

