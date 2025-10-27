Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD10313E1C
	for <linux-mmc@vger.kernel.org>; Mon, 27 Oct 2025 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583772; cv=none; b=fwVPaTdPlkwme23+SJFrgzthLrT4LLqKKjXG6RUQOxUDnM+zWybxgptmnhX0fpztzprY2hklwKxjcnATLHXnIZK/SQV9IvAgtT6/M1XYrIiCInPdfodwq7+ouzIlumLWPx8QNeN9oqbII+Q8An4wX0XSfM1wdd17LgckoxLTdvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583772; c=relaxed/simple;
	bh=TWUcnMhGYjqpSEACT1hY8gU5ZXrwBEJkbZ/hFSk485A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sJjb3t/MebmehN8G0Iuw3VF5XVBNFxhGHlcEEuycifO/SLa8ZAYpmOrVr73Nz6fTbeD09bnVmfAta6zUX5BF0JiRRos6wmd3nZ0n+Vlgkac3E8BRJj6oiwD3fBiV7DkFxNKuWYmnTOwDHnjZbSpeTrv6CPdXS8QYd1z65YZVgjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hx22Y6CI; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx22Y6CI"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso3323245a12.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 Oct 2025 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761583769; x=1762188569; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=geguZxaeJiqKqJQ0kK8UQgUfhxCEenMLMdjKppCx4hc=;
        b=hx22Y6CI/zP/jF+Xi3eElk/Yz7VC5/ug/78dKwna2BwOd2ohPH+vrL+8J8kaf5H61z
         GWSVoszeXs7Ig8SzkKDUo4de9dorZ1qxt88FcOchiwQBmroQgG+vr8R8F//SEHXZNNpm
         UJIi3SOBKMsoiNqLw+J3seyPQVO3A27cZItPW4lHmYvc1L58SAk8yT3BD439mkQMoILJ
         cPSUL1w7aLYQlg8R64r1Rvg5QqbUb9M+Y8bCKWwEolP1qJg5+GKCVWKU065jFbhwCJ0j
         lFLpuTHoF/ZJEN3gBiuG6qmdtXQIhybs3paDZZ+lNF9ILR4lpq0EAuJZGDwpXrqYY8I9
         jP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583769; x=1762188569;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=geguZxaeJiqKqJQ0kK8UQgUfhxCEenMLMdjKppCx4hc=;
        b=TeovZ+jQRMz4qe6KkuMPnXks3uvMAebnmNmuw2peguPUEyIK2B6LXDqIuXhdFdj1Wd
         h1aP2VSZN6bD6EpmP+k98SOEGcG16DlehpMZzHYuVk3zGuf4pX0qbwq1vZAbuhyrrAJu
         aoFvB2Tt1F+5ujx1vcGIvVllHRaOAzbhcFluYaz+8rP33pyU4r58D4Vj6oDedVzdOpLf
         XMy2VOaJbtgs3QB0A4olm8QDwvmmpsDBV0ozZpWJDyj8H7up69YRneJu0OCa9d2euHcj
         JF7NeDdOhvGNgPIa0SKuGNU42CVtyKtb/w3y3or8Fu8yisU+rVciGBbNo9vITCv7o3Hj
         xooQ==
X-Gm-Message-State: AOJu0YzTgwWIcbEwWNQqSTF2iI/BAKOCkCyk+lakYdj7+UuJvPMnTzWU
	CAKpMFy6PbiF2c2he+euq4PqVb9RCVVwd8rL1Y/V+9UoHex/WEwAWyjZ
X-Gm-Gg: ASbGnctvqlqgCinBJ6UrC3j4Jj6A/YRsm05jwk12KwlQqA/izbaXZyKNwo5mQV/PEsh
	yh1zcAhtRrQP/8qC4YgHeewYfK2WazmgMWY/WKzMvebJTHTZuWO1fhivc0i4ZApFOOTWrmMqPaB
	pdNAQUTXxaCptzY3IGgcOevhG5n5WbK7GoAWFmckFiapVuobTMcZqEaRkDVi2+IwniADyGy+LbP
	pKW5S2vZrf4/s+6DqqFk1ZELV3qg6IYP/utXBGjk18OtVy/DHotCQ8sF/zY/B8zSIVctLpEjZiS
	ebz6wHy5MPtXNUYDgS/vWobNko9VrFTx1ksyZC0PEj7UyHZnb7LA9GNyIzN8mjkZqcRxM+LqXH6
	li0uRJSXwnbU+SD9hx6W4t2zu8XbMpRKvlTeF6eOgcjuO5fMIVUkXLRjzGaebuci71Ly1/oJ0An
	JX6PdEf61hahggNn0i0tUv
X-Google-Smtp-Source: AGHT+IFsZhMXjDA3rdE7firYijUNXcnLWPPnTnb2rv5dx73e9it+zwX4W3UIHnIxK9VNAzx0q7dU+A==
X-Received: by 2002:a17:902:cecb:b0:26d:72f8:8d0a with SMTP id d9443c01a7336-294cb368bd0mr6638925ad.12.1761583768299;
        Mon, 27 Oct 2025 09:49:28 -0700 (PDT)
Received: from Black-Pearl.localdomain ([27.7.191.116])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498cf358fsm86581925ad.20.2025.10.27.09.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:49:27 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Mon, 27 Oct 2025 16:46:16 +0000
Subject: [PATCH v2] dt-bindings: mmc: socionext,milbeaut-m10v-sdhci-3.0:
 convert to DT schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-milbeaut-v2-1-9e1954ff7708@gmail.com>
X-B4-Tracking: v=1; b=H4sIANeh/2gC/0XMywqDMBCF4VeRWTclMxqFrvoe4iKNEx3wUhIbW
 sR3b+qmy/9w+HaIHIQj3IodAieJsi456FKAG+0ysJI+N5Amow1Vapbpwfa1KeM01U3emRzk+zO
 wl/dJtV3uUeK2hs8pJ/ytJ4Kayj+SUKEqufK+bhC17e/DbGW6unWG7jiOLz8RU8qgAAAA
X-Change-ID: 20250524-milbeaut-5c0267202e2c
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taichi Sugaya <sugaya.taichi@socionext.com>, 
 Takao Orito <orito.takao@socionext.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.3

Convert SOCIONEXT Milbeaut SDHCI controller binding to YAML format.
Add a new property "voltage-ranges" to resolve dt_check errors.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
Changes in v2:
- Change the description for the property "voltage-ranges".
- Link to v1: https://lore.kernel.org/r/20251023-milbeaut-v1-1-3e4ff67110ad@gmail.com
---
 .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 30 --------
 .../mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml     | 79 ++++++++++++++++++++++
 2 files changed, 79 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
deleted file mode 100644
index 627ee89c125b..000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* SOCIONEXT Milbeaut SDHCI controller
-
-This file documents differences between the core properties in mmc.txt
-and the properties used by the sdhci_milbeaut driver.
-
-Required properties:
-- compatible: "socionext,milbeaut-m10v-sdhci-3.0"
-- clocks: Must contain an entry for each entry in clock-names. It is a
-  list of phandles and clock-specifier pairs.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names: Should contain the following two entries:
-	"iface" - clock used for sdhci interface
-	"core"  - core clock for sdhci controller
-
-Optional properties:
-- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
-  requires the CMD_DAT_DELAY control to be enabled.
-
-Example:
-	sdhci3: mmc@1b010000 {
-		compatible = "socionext,milbeaut-m10v-sdhci-3.0";
-		reg = <0x1b010000 0x10000>;
-		interrupts = <0 265 0x4>;
-		voltage-ranges = <3300 3300>;
-		bus-width = <4>;
-		clocks = <&clk 7>, <&ahb_clk>;
-		clock-names = "core", "iface";
-		cap-sdio-irq;
-		fujitsu,cmd-dat-delay-select;
-	};
diff --git a/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml b/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml
new file mode 100644
index 000000000000..2ba53626a959
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SOCIONEXT Milbeaut SDHCI controller
+
+maintainers:
+  - Taichi Sugaya <sugaya.taichi@socionext.com>
+  - Takao Orito <orito.takao@socionext.com>
+
+description:
+  The SOCIONEXT Milbeaut SDHCI controller is a specialized SD Host
+  Controller found in some of Socionext's Milbeaut image processing SoCs.
+  It features a dedicated "bridge controller." This bridge controller
+  implements special functions like reset control, clock management for
+  various SDR modes (SDR12, SDR25, SDR50) and physical pin property settings.
+
+allOf:
+  - $ref: sdhci-common.yaml#
+
+properties:
+  compatible:
+    const: socionext,milbeaut-m10v-sdhci-3.0
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
+      - const: iface
+
+  fujitsu,cmd-dat-delay-select:
+    description:
+      Its presence indicates that the controller requires a specific command
+      and data line delay selection mechanism for proper operation, particularly
+      when dealing with high-speed SD/eMMC modes.
+    type: boolean
+
+  voltage-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: minimum slot voltage (mV).
+        - description: maximum slot voltage (mV).
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mmc@1b010000 {
+        compatible = "socionext,milbeaut-m10v-sdhci-3.0";
+        reg = <0x1b010000 0x10000>;
+        interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+        voltage-ranges = <3300 3300>;
+        bus-width = <4>;
+        clocks = <&clk 7>, <&ahb_clk>;
+        clock-names = "core", "iface";
+        cap-sdio-irq;
+        fujitsu,cmd-dat-delay-select;
+    };
+...

---
base-commit: 7bac2c97af4078d7a627500c9bcdd5b033f97718
change-id: 20250524-milbeaut-5c0267202e2c

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@gmail.com>

