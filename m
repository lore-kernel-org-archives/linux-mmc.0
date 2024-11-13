Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904D12AE84;
	Wed, 13 Nov 2024 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731538570; cv=none; b=HOBJW3+j/wKaYFoS+rgG2LXW9LP/lb5lfSpKwIkVgXDuxmvIV2pP1M7IZpklGJzNFLFAeqwB5z2q9HlxSD3KtA47Mw68Lqd0DDF+vvMoi0FC1dCPHbsuuuRo9F4bJ/s32o+7IdBn34h0qOa2F6L1dqFu2o8mXQvInd3wu0ZsO4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731538570; c=relaxed/simple;
	bh=zSA3eE89l1UDfOvFbyzQrw4Ez4fRb4Xk/Y3akNPoOdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FSSnFILsV5s/vaYJVaiPLjUYZVrN3PvKcHmXjh5XftkmXcLG55uRcMSSyJlSshq/CMDI91Laroki8b4kbNW0qpP5ncGuUbBHf3y9xkx6re6a/1CM3dJfJvDSQhcvoPI/sTRbO6mvJ5HhFBRjog1bqIiuf0e7lDh1XOyw4yVVWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIC8EOFz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIC8EOFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D03FC4CEC3;
	Wed, 13 Nov 2024 22:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731538570;
	bh=zSA3eE89l1UDfOvFbyzQrw4Ez4fRb4Xk/Y3akNPoOdU=;
	h=From:To:Cc:Subject:Date:From;
	b=hIC8EOFzRvdiuwcpt02lbeyGLdcU+M/3ckOVKJ7PkHww00QpyCXV2bi0iOPEj8SF1
	 gu3dwwPjN3Ma1x9eIT9j0C33/hIUIMGkZFIU4YfZcEfVC7jfGDk8prDqkg2MxojTSl
	 btVGiPi1xw+NYdJ6GchvfqS59a6ZIAb1E23WKd1F6bTfaTiXbPxJDqLrKvAVRL8W82
	 0K2A76YXgV/oLbv3Ym6Zo5s5q6wez6FslsBqVOCssWRYLs97dvDhF+xtckZoWG+4Nh
	 23oV6zX4Aqyr6SSULs495VniS8SYux1xB4qHoIeuW1Qmw6BHYvzlDeMtMsLxA4jVqQ
	 Ybxfgj1f9/brA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Hu Ziji <huziji@marvell.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: marvell,xenon-sdhci: Simplify Armada 3700 if/then schema
Date: Wed, 13 Nov 2024 16:56:01 -0600
Message-ID: <20241113225602.1782573-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properties are supposed to be defined in the top-level schema and then
disallowed in an if/then schema if necessary. Move the "marvell,pad-type"
property to follow this.

"reg" can also be similarly described at the top-level with only the
number of entries restricted in the if/then schema.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/mmc/marvell,xenon-sdhci.yaml     | 48 +++++++++----------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
index cfe6237716f4..3f48d8292d5b 100644
--- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
@@ -38,15 +38,9 @@ properties:
 
   reg:
     minItems: 1
-    maxItems: 2
-    description: |
-      For "marvell,armada-3700-sdhci", two register areas.  The first one
-      for Xenon IP register. The second one for the Armada 3700 SoC PHY PAD
-      Voltage Control register.  Please follow the examples with compatible
-      "marvell,armada-3700-sdhci" in below.
-      Please also check property marvell,pad-type in below.
-
-      For other compatible strings, one register area for Xenon IP.
+    items:
+      - description: Xenon IP registers
+      - description: Armada 3700 SoC PHY PAD Voltage Control register
 
   clocks:
     minItems: 1
@@ -61,6 +55,17 @@ properties:
   interrupts:
     maxItems: 1
 
+  marvell,pad-type:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - sd
+      - fixed-1-8v
+    description:
+      Type of Armada 3700 SoC PHY PAD Voltage Controller register. If "sd" is
+      selected, SoC PHY PAD is set as 3.3V at the beginning and is switched to
+      1.8V when later in higher speed mode. If "fixed-1-8v" is selected, SoC PHY
+      PAD is fixed 1.8V, such as for eMMC.
+
   marvell,xenon-sdhc-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
@@ -147,27 +152,18 @@ allOf:
     then:
       properties:
         reg:
-          items:
-            - description: Xenon IP registers
-            - description: Armada 3700 SoC PHY PAD Voltage Control register
-
-        marvell,pad-type:
-          $ref: /schemas/types.yaml#/definitions/string
-          enum:
-            - sd
-            - fixed-1-8v
-          description: |
-            Type of Armada 3700 SoC PHY PAD Voltage Controller register.
-            If "sd" is selected, SoC PHY PAD is set as 3.3V at the beginning
-            and is switched to 1.8V when later in higher speed mode.
-            If "fixed-1-8v" is selected, SoC PHY PAD is fixed 1.8V, such as for
-            eMMC.
-            Please follow the examples with compatible
-            "marvell,armada-3700-sdhci" in below.
+          minItems: 2
 
       required:
         - marvell,pad-type
 
+    else:
+      properties:
+        reg:
+          maxItems: 1
+
+        marvell,pad-type: false
+
   - if:
       properties:
         compatible:
-- 
2.45.2

