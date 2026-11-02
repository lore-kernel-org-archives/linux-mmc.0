Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627630;
	b=Boe9xUUse11nkfGBntxph12EOWB4NMqgFjPKlC+r9xCIsOuiWjlODGQUx+AtYlFTc/ls
	 BnNPLYQrjvn+mfYLS9qImsfSCI+E3doKx41fip17oD31yqQm4AJ5z5Qwy58/g84t1dW/l
	 neK42cle2pbXlLDt+KVYe1OTyTqjD+wvyuxvMskuyUELfbk437PNkBxLKH05FmcMrVa7I
	 buvxUCOjN9iixUmyx5498JcukTgwOPudAwYsl9HVwpP5N0qMl2tbol2kag7veSsTT7Av1
	 AGQx/ksu2aBNzHi8aEzm9c0T3SmarnQf/YL8uV6nICkFRNWmYuuXxgN/tT4qzb9RISw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627630;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8PdXPsr0BqbOm4N6slLaJkhJmpRccqZjg1DW7FPgi0w=;
	b=oGbOSpophlUCyUTL6dpktk3wMcDC0S8sxzMUc5ulQzceyILY42QFNt1sTJwOa3UgUUuk
	 6H4LrPxQ0qAiokKWdGvxYElaFgyWZiqcCUBC+WehkYuzwHiXZmsoEniVmXXpgJBDIxdZP
	 z39CoBQBN9KpjtqJRXhakwMcod35xMFCnmIpxuBW8BdMznZtLIu70GFbWU/XAsgtAVR3T
	 21WgxXM7mLOgPoWSA//sfvwTgYHGa2Ii+D5aqQD6C/xc/3FEMsGSBd+HlPuBs8vu7+HdZ
	 Te3EbC3FX7iPr3NbMnMPLleCy+fXsjtmq4Dy0RvHUTSeXr415O/WPkiIZsBpnJg69qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jwEEKbee;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0357D606A32D;
	Mon,  2 Nov 2026 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jwEEKbee
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FAD1F00A16;
	Mon,  2 Nov 2026 13:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793627629;
	bh=8PdXPsr0BqbOm4N6slLaJkhJmpRccqZjg1DW7FPgi0w=;
	h=From:To:Cc:Subject:Date;
	b=jwEEKbeeZuoCHbxJUlWEtLnIQBYGhOQBxwP+tQtMjvmJi6qzxzYcDukdNtIhOkRXJ
	 6n+Jh8CeRi0Y/l5/zWC7hrZVP8JXsVNK9PuCOwrcCdOTS5C7i0aq2uOP5WBFmJG4mP
	 +VSYdrI4Dyorre8UfCZIiuH6uKTkx7HccHlCFrt8dY3IAid0u56LI6rz18RSdj1GvE
	 Y7s+w6UvyezlKJfl2IcZ+A3XK1IREBodAE5iSWak2WphnGkxKjSdn9F8Jz2Du1gOUp
	 DOCFjJCW4UbSQ/Ho05urr8RhaF9BhcvDHN3iwkoV1CL/R3S62YltgkRa6WGZF6ApT9
	 i+0fdXIadN4+A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lee Jones <lee@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Chanh Nguyen <chanh@os.amperecomputing.com>,
	Alistair Francis <alistair@alistair23.me>,
	Julius Werner <jwerner@chromium.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Dmitry Osipenko <digetx@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Ray Jui <ray.jui@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] dt-bindings: Use hex unit address patterns
Date: Mon,  2 Nov 2026 07:53:22 -0600
Message-ID: <20261102135330.2493332-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unit-addresses by default (and most commonly) are hexadecimal. There's a
number of cases using decimal patterns. Fix all of them, limiting the
pattern to match the 'reg' limits if there are any.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/display/xylon,logicvc-display.yaml      |  2 +-
 .../devicetree/bindings/dpll/dpll-device.yaml        |  2 +-
 .../bindings/embedded-controller/google,cros-ec.yaml |  4 ++--
 .../intel,ixp4xx-network-processing-engine.yaml      |  2 +-
 Documentation/devicetree/bindings/gpio/gpio-mxs.yaml |  4 ++--
 .../devicetree/bindings/hwmon/maxim,max31790.yaml    |  2 +-
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml    |  2 +-
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml         |  6 +++---
 .../bindings/input/touchscreen/cypress,tt21000.yaml  |  2 +-
 .../memory-controllers/ddr/jedec,sdram-channel.yaml  | 12 ++++++------
 .../bindings/memory-controllers/ingenic,nemc.yaml    |  2 +-
 .../memory-controllers/nvidia,tegra20-emc.yaml       |  4 ++--
 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml    |  2 +-
 .../devicetree/bindings/mfd/st,stm32-timers.yaml     |  2 +-
 .../devicetree/bindings/misc/qcom,fastrpc.yaml       |  2 +-
 .../bindings/mmc/mmc-controller-common.yaml          |  2 +-
 .../bindings/net/cortina,gemini-ethernet.yaml        |  2 +-
 .../bindings/phy/brcm,cygnus-pcie-phy.yaml           |  2 +-
 .../devicetree/bindings/phy/brcm,sata-phy.yaml       |  2 +-
 .../bindings/phy/socionext,uniphier-usb2-phy.yaml    |  2 +-
 .../devicetree/bindings/sound/qcom,q6asm-dais.yaml   |  2 +-
 .../bindings/sound/qcom,q6dsp-lpass-ports.yaml       |  2 +-
 .../devicetree/bindings/thermal/sprd-thermal.yaml    |  2 +-
 23 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml b/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
index 76b804b7c880..3dd54636d23d 100644
--- a/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
+++ b/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
@@ -123,7 +123,7 @@ properties:
         const: 0
 
     patternProperties:
-      "^layer@[0-9]+$":
+      "^layer@[0-9a-f]+$":
         type: object
 
         properties:
diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
index fb8d7a9a3693..4b5184500b9f 100644
--- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
+++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
@@ -65,7 +65,7 @@ properties:
         const: 0
 
     patternProperties:
-      "^pin@[0-9]+$":
+      "^pin@[0-9a-f]+$":
         $ref: /schemas/dpll/dpll-pin.yaml
         unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/embedded-controller/google,cros-ec.yaml b/Documentation/devicetree/bindings/embedded-controller/google,cros-ec.yaml
index 3ab5737c9a8f..75159078f0ef 100644
--- a/Documentation/devicetree/bindings/embedded-controller/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/embedded-controller/google,cros-ec.yaml
@@ -155,7 +155,7 @@ patternProperties:
     type: object
     $ref: /schemas/i2c/google,cros-ec-i2c-tunnel.yaml#
 
-  "^regulator@[0-9]+$":
+  "^regulator@[0-9a-f]+$":
     type: object
     $ref: /schemas/regulator/google,cros-ec-regulator.yaml#
 
@@ -224,7 +224,7 @@ allOf:
 
       patternProperties:
         "^i2c-tunnel[0-9]*$": false
-        "^regulator@[0-9]+$": false
+        "^regulator@[0-9a-f]+$": false
         "^extcon[0-9]*$": false
 
       # Using additionalProperties: false here and
diff --git a/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml b/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml
index 4d66ef483522..a9f874f201aa 100644
--- a/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml
+++ b/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml
@@ -44,7 +44,7 @@ properties:
     const: 0
 
 patternProperties:
-  hss@[0-9]+$:
+  hss@[0-9a-f]+$:
     $ref: /schemas/net/intel,ixp4xx-hss.yaml#
     type: object
     description: Optional node for the High Speed Serial link (HSS), the
diff --git a/Documentation/devicetree/bindings/gpio/gpio-mxs.yaml b/Documentation/devicetree/bindings/gpio/gpio-mxs.yaml
index fed1b06495ad..6cab04ebbdd4 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mxs.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-mxs.yaml
@@ -36,7 +36,7 @@ properties:
     maxItems: 1
 
 patternProperties:
-  '^(?!gpio@)[^@]+@[0-9]+$':
+  '^(?!gpio@)[^@]+@[0-9a-f]+$':
     type: object
     properties:
       fsl,pinmux-ids:
@@ -94,7 +94,7 @@ patternProperties:
 
     additionalProperties: false
 
-  '^gpio@[0-9]+$':
+  '^gpio@[0-9a-f]+$':
     type: object
     properties:
       compatible:
diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
index 558cbd251b0f..bd30886def5f 100644
--- a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
@@ -45,7 +45,7 @@ properties:
     const: 1
 
 patternProperties:
-  "^fan@[0-9]+$":
+  "^fan@[0-9a-f]+$":
     $ref: fan-common.yaml#
     unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
index c4c4575d3fa9..8e11f769d140 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
@@ -231,7 +231,7 @@ required:
   - '#size-cells'
 
 patternProperties:
-  "^adc@[0-9]+$":
+  "^adc@[0-9a-f]+$":
     type: object
     description:
       An ADC block node should contain at least one subnode, representing an
diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
index c24ac98bbb3d..22cbc6e52537 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
@@ -74,7 +74,7 @@ required:
 additionalProperties: false
 
 patternProperties:
-  "^filter@[0-9]+$":
+  "^filter@[0-5]$":
     type: object
     unevaluatedProperties: false
     description: child node
@@ -334,7 +334,7 @@ allOf:
 
     then:
       patternProperties:
-        "^filter@[0-9]+$":
+        "^filter@[0-5]$":
           properties:
             reg:
               items:
@@ -349,7 +349,7 @@ allOf:
 
     then:
       patternProperties:
-        "^filter@[0-9]+$":
+        "^filter@[0-5]$":
           properties:
             reg:
               items:
diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
index 037e5d3c447f..e50adb72f808 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
@@ -46,7 +46,7 @@ properties:
   wakeup-source: true
 
 patternProperties:
-  "^button@[0-9]+$":
+  "^button@[0-9a-f]+$":
     type: object
     $ref: ../input.yaml#
     properties:
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
index 5cdd8ef45100..816c8e8b5713 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
@@ -53,7 +53,7 @@ properties:
     const: 0
 
 patternProperties:
-  "^rank@[0-9]+$":
+  "^rank@[0-3]$":
     type: object
     description:
       Each physical SDRAM chip may have one or more ranks. Ranks are
@@ -72,7 +72,7 @@ allOf:
             const: jedec,ddr4-channel
     then:
       patternProperties:
-        "^rank@[0-9]+$":
+        "^rank@[0-3]$":
           $ref: /schemas/memory-controllers/ddr/jedec,ddr4.yaml#
   - if:
       properties:
@@ -81,7 +81,7 @@ allOf:
             const: jedec,lpddr2-channel
     then:
       patternProperties:
-        "^rank@[0-9]+$":
+        "^rank@[0-3]$":
           $ref: /schemas/memory-controllers/ddr/jedec,lpddr2.yaml#
   - if:
       properties:
@@ -90,7 +90,7 @@ allOf:
             const: jedec,lpddr3-channel
     then:
       patternProperties:
-        "^rank@[0-9]+$":
+        "^rank@[0-3]$":
           $ref: /schemas/memory-controllers/ddr/jedec,lpddr3.yaml#
   - if:
       properties:
@@ -99,7 +99,7 @@ allOf:
             const: jedec,lpddr4-channel
     then:
       patternProperties:
-        "^rank@[0-9]+$":
+        "^rank@[0-3]$":
           $ref: /schemas/memory-controllers/ddr/jedec,lpddr4.yaml#
   - if:
       properties:
@@ -108,7 +108,7 @@ allOf:
             const: jedec,lpddr5-channel
     then:
       patternProperties:
-        "^rank@[0-9]+$":
+        "^rank@[0-3]$":
           $ref: /schemas/memory-controllers/ddr/jedec,lpddr5.yaml#
 
 required:
diff --git a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
index ee74a362f4ca..ca6426c28990 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
@@ -37,7 +37,7 @@ properties:
     maxItems: 1
 
 patternProperties:
-  ".*@[0-9]+$":
+  ".*@[0-9a-f]+$":
     type: object
     $ref: mc-peripheral-props.yaml#
     additionalProperties: true
diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
index 71896cb10692..a0355050a074 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
@@ -142,7 +142,7 @@ $defs:
     additionalProperties: false
 
 patternProperties:
-  "^emc-table@[0-9]+$":
+  "^emc-table@[0-9a-f]+$":
     $ref: "#/$defs/emc-table"
 
   "^emc-tables@[a-f0-9-]+$":
@@ -169,7 +169,7 @@ patternProperties:
         type: object
 
     patternProperties:
-      "^emc-table@[0-9]+$":
+      "^emc-table@[0-9a-f]+$":
         $ref: "#/$defs/emc-table"
 
     oneOf:
diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
index 4eabafb8079d..8de82540d231 100644
--- a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
@@ -109,7 +109,7 @@ properties:
       - compatible
 
 patternProperties:
-  "^trigger@[0-9]+$":
+  "^trigger@[0-4]$":
     type: object
     additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
index 66aa1550a4e5..5853c6019e98 100644
--- a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
@@ -128,7 +128,7 @@ properties:
       - compatible
 
 patternProperties:
-  "^timer@[0-9]+$":
+  "^timer@([0-9a-f]|1[0-3])$":
     type: object
     additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 49d2a5e8ba39..d9444f452585 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -79,7 +79,7 @@ properties:
     const: 0
 
 patternProperties:
-  "(compute-)?cb@[0-9]*$":
+  "(compute-)?cb@[0-9a-f]+$":
     type: object
 
     description: >
diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 3d7195e9461c..f235f3ed1692 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -317,7 +317,7 @@ properties:
       power sequence must be maintained while initializing the card.
 
 patternProperties:
-  "^.*@[0-9]+$":
+  "^.*@[0-7]$":
     type: object
     description: |
       On embedded systems the cards connected to a host may need
diff --git a/Documentation/devicetree/bindings/net/cortina,gemini-ethernet.yaml b/Documentation/devicetree/bindings/net/cortina,gemini-ethernet.yaml
index f0b5bea2458d..900e4e5ac360 100644
--- a/Documentation/devicetree/bindings/net/cortina,gemini-ethernet.yaml
+++ b/Documentation/devicetree/bindings/net/cortina,gemini-ethernet.yaml
@@ -35,7 +35,7 @@ properties:
 # They are not independent of each other since they share resources
 # in the parent node, and are thus children.
 patternProperties:
-  "^ethernet-port@[0-9]+$":
+  "^ethernet-port@[0-9a-f]+$":
     type: object
     unevaluatedProperties: false
     description: contains the resources for ethernet port
diff --git a/Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml
index 808e90b2465d..25356f03f4a6 100644
--- a/Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml
@@ -30,7 +30,7 @@ properties:
     const: 0
 
 patternProperties:
-  "^pcie-phy@[0-9]+$":
+  "^pcie-phy@[0-9a-f]+$":
     type: object
     additionalProperties: false
     description: >
diff --git a/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
index 439bda142764..31d534065d42 100644
--- a/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
@@ -46,7 +46,7 @@ properties:
     const: 0
 
 patternProperties:
-  "^sata-phy@[0-9]+$":
+  "^sata-phy@[0-9a-f]+$":
     type: object
     description: |
       Each port's PHY should be represented as a sub-node.
diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml
index 19522c54f448..b1a69ed96bb4 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml
@@ -29,7 +29,7 @@ properties:
     const: 0
 
 patternProperties:
-  "^phy@[0-9]+$":
+  "^phy@[0-3]$":
     type: object
     additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml b/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
index bc8c8ba24f9c..988a84099790 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
@@ -32,7 +32,7 @@ properties:
     const: 0
 
 patternProperties:
-  "^dai@[0-9]+$":
+  "^dai@[0-9a-f]+$":
     type: object
     description:
       Q6ASM Digital Audio Interface
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
index 3b03e2acd67e..060487b2b72c 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
@@ -28,7 +28,7 @@ properties:
 
 # Digital Audio Interfaces
 patternProperties:
-  '^dai@[0-9]+$':
+  '^dai@[0-9a-f]+$':
     type: object
     description:
       Q6DSP Digital Audio Interfaces.
diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
index afa551f6185f..222d70baef1e 100644
--- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
@@ -47,7 +47,7 @@ properties:
     const: 0
 
 patternProperties:
-  "^([a-z]*-)?sensor(-section)?@[0-9]+$":
+  "^([a-z]*-)?sensor(-section)?@[0-9a-f]+$":
     type: object
     description:
       Represent one thermal sensor.
-- 
2.53.0

