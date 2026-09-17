Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E958959572B
	for <linux-mmc@vger.kernel.org>; Thu, 17 Sep 2026 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656120; cv=none; b=U4JKO8ngWPrlcWqU1KEiZhBdSnaTF7XlwhSPNPkgx0OnccBA2Wib7oyS7zSZXypDZ+XfHiAgNBz6rnibcEmqVbfsTe3YKNqYGdQTrt5f4IOE9DVwZ8IariSJLWL9tnl0REKx/5t2v5TPga0N2O9372NFbRd05T/zqSDgjp5AlhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656120; c=relaxed/simple;
	bh=VR+kwkFmvRt7IIsiF048mZ3MVYW3SZjOswQQ6TsOoRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RK5CUBvCRVwMoTwM9GI4Ut052nZRctNoo+t0ldFKIle1vT2CqDfGaF/TdNScszd+ipRukTYAOnN2GWctMAqpt2fjQagiShdFtP/cgY7zo4/kUrx3Ve075j+bFPVDu7EG1PDhSoBkOGNYP4O8hzpEG5jQUneaCiNFtY+2AH8wv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ownwRosl; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ownwRosl"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49b0dd21eb8so1716995e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 17 Sep 2026 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789656102; x=1790260902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uxdo04KgC3ZopuNd4o1TqXYNrHfISkm+8Ow6DwBarvc=;
        b=ownwRoslxpBe+VrITDjoJh5NP5OC/PbjEVs6NfnVsETHyRqcS5QpjBC5JqKaEsvpr9
         heiLv8qUryFbHpUvPZzDBsl04uz99A0Q9YiHHYB3bdIFkwkDxAByNlm68PSLVMSe4MCg
         cyOTmfd1whQmK6RwMlK9euMXmXdddQiYB+pXL2Ltt6Wl9TlhutIah09rWJc8vzw0lLFz
         ZjE7IYtEZyr26R6v2mCU4k70aQO6L1ebss5it7KUXAGz8gU+IuX/4otWhYdt9rreAuUH
         5mPQd4GUaNg5h/xIYHQmudCeJVLhVLNj1tanEfz+xeGWbF4qi4ArNW/4QUe7j2VF/Iqs
         L19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789656102; x=1790260902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uxdo04KgC3ZopuNd4o1TqXYNrHfISkm+8Ow6DwBarvc=;
        b=EJpXp6K33H1kI8mY8TMtrfzXewXg+8OkJWiQxo3NWqs7/4BmflPSnh606Y5Sz1vOJP
         iqrZ++/WjBnSQBBL93p8TcK2rGAwFELIvyH2WSi7b3aOczGTG/Fkkh2yBv0U8Yk5PTiA
         XwZoZSZCRjBBYzqaQhWHcUudRPSNOVlO56XvVpBYsOKs0Po+IK0/gU+hoQsP+pAUMRgc
         OF5bHSS9pcqMnM8Y/ux9HsES/fslTdm0LFuaPTytcE6bVJWvBDPsRMEzNnwDrroSttst
         /iNSDBcVNYvoWt4Q2USrYNnp0LbpZOVuz8rPe5HjSwAPAcp1XYuSpUzPOlaQjZmjjZL/
         hXvg==
X-Forwarded-Encrypted: i=1; AKwUvByPIyY9YvdAviac7BJNx7M+J1FZB0b1HZ09SAGbMYYj3a480hEEwiEJCjuUtvbHBzD3CTVk2gmeWzk=@vger.kernel.org
X-Gm-Message-State: AFuF++nPO84IZzCRB8dokGm2VlXZmrJeqrT5bEtPythMLdpftHfTzoxG
	c7IsbT08xO2Z//zQhKh9aoRi2HL+TnKaZvO4yNfy0U6mgnOIxmPyK5e4
X-Gm-Gg: AYBFou0s564cCCc2ZYnHJhS2g8axcFETUl7rpGkLjpt8bjxacO97Kv+z4q7Z/53nJki
	L9baxTrHzapWT/gTMAQuNp4tgItVftyt1w0+MyYbBXEA6CkcbxR8zrKMYO7I8S7vQg41gwoJ6cT
	tfLSpD5aKEYE1tmMqPJk9jOJGu7M9Zttpt1tcjGq9feoGBJqPKDwfnbN89K373V1+MZ8nKo0KtV
	CfjMO+t84pwtUMCBuAA2wC+UR5EkFPbr6R2VNjq+0n+n4fQmyETbYzi9CHtwfqexSjbx0JKdLgh
	uPwD7YpwGenFY0iCeJXWfU0+n6xUghqy+8KMLk4VpbNoOUr57cOfQaXB5hY1TVHGBqqPErkl13h
	VlnFR1vnnzxni0xmrE+CWL+EyN7KQmPGCQ7hdVwtmYoHiBfLGShtfVWk/DFHw4YK1RSHouXb1II
	WRT6TqLleIryoWs7rK+DCTkSC951cldHOf/G3Tubwo4kJBERmszJ5qB4yv3X/bheWDd9I3Mflrr
	9ml2Q==
X-Received: by 2002:a05:600c:1546:b0:49e:67bf:7e97 with SMTP id 5b1f17b1804b1-49ead86eb48mr87880525e9.10.1789656101568;
        Thu, 17 Sep 2026 07:41:41 -0700 (PDT)
Received: from chicken.. ([2a02:2f02:5101:7300:44c:8311:3d26:e514])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd691d8esm33238755e9.0.2026.09.17.07.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:41:41 -0700 (PDT)
From: Daniel Matyas <matyasdaniel006@gmail.com>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Sen Wang <sen@ti.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>,
	Jeff LaBundy <jeff@labundy.com>,
	Simon Glass <sjg@chromium.org>,
	Linus Walleij <linusw@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Atish Patra <atishp@rivosinc.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Okan Sahin <Okan.Sahin@analog.com>,
	devicetree@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Ricard Wanderlof <ricardw@axis.com>,
	patches@opensource.cirrus.com,
	Lukas Wunner <lukas@wunner.de>,
	Eugen Hristev <ehristev@kernel.org>
Cc: mfd@lists.linux.dev,
	linux-samsung-soc@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Daniel Matyas <matyasdaniel006@gmail.com>
Subject: [PATCH] dt-bindings: Expand flow lists to block lists
Date: Thu, 17 Sep 2026 17:41:34 +0300
Message-ID: <20260917144134.459819-1-matyasdaniel006@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running dt_bindings_check returned:
[error] string value is redundantly quoted with any quotes (quoted-strings)

The files used quotation marks in flow lists because the strings had
commas and these commas were interpreted as separators. Convert flow
style lists to block style lists, so that there is no problems with the
commas.

Signed-off-by: Daniel Matyas <matyasdaniel006@gmail.com>
---
 .../bindings/display/atmel,lcdc-display.yaml  |  9 ++++---
 .../devicetree/bindings/eeprom/at24.yaml      |  4 +++-
 .../devicetree/bindings/example-schema.yaml   |  6 +++--
 .../bindings/hwmon/pmbus/adi,max20830.yaml    |  6 +++--
 .../bindings/iio/adc/ti,ads112c14.yaml        |  6 +++--
 .../bindings/iio/frequency/adi,adf41513.yaml  |  3 ++-
 .../bindings/iio/frequency/adi,adrf6780.yaml  |  6 +++--
 .../bindings/iio/temperature/adi,ltc2983.yaml |  6 +++--
 .../bindings/input/azoteq,iqs7222.yaml        | 12 ++++++----
 .../bindings/input/google,cros-ec-keyb.yaml   |  6 +++--
 .../devicetree/bindings/input/input.yaml      |  3 ++-
 .../devicetree/bindings/input/iqs269a.yaml    | 12 ++++++----
 .../devicetree/bindings/input/iqs626a.yaml    | 15 ++++++++----
 .../input/touchscreen/azoteq,iqs7211.yaml     | 24 ++++++++++++-------
 .../interrupt-controller/riscv,aplic.yaml     |  3 ++-
 .../bindings/mfd/maxim,max8998.yaml           |  6 +++--
 .../bindings/mfd/samsung,s5m8767.yaml         | 21 +++++++++++-----
 .../devicetree/bindings/mmc/arm,pl18x.yaml    |  9 ++++---
 .../bindings/mtd/amlogic,meson-nand.yaml      |  8 +++++--
 .../devicetree/bindings/net/snps,dwmac.yaml   |  6 +++--
 .../bindings/pci/brcm,iproc-pcie.yaml         |  3 ++-
 .../devicetree/bindings/perf/riscv,pmu.yaml   |  3 ++-
 .../phy/hisilicon,hi3798cv200-combphy.yaml    |  6 +++--
 .../bindings/phy/nvidia,tegra20-usb-phy.yaml  |  6 +++--
 .../bindings/regulator/adi,max77857.yaml      |  6 +++--
 .../bindings/regulator/maxim,max8997.yaml     |  9 ++++---
 .../regulator/samsung,s2mpg10-regulator.yaml  |  3 ++-
 .../regulator/samsung,s2mpg11-regulator.yaml  |  3 ++-
 .../bindings/regulator/ti,tps65132.yaml       |  3 ++-
 .../devicetree/bindings/riscv/cpus.yaml       |  6 +++--
 .../bindings/rtc/abracon,abx80x.yaml          |  6 +++--
 .../soc/tegra/nvidia,tegra20-pmc.yaml         | 10 +++++---
 .../bindings/sound/ti,tlv320adc3xxx.yaml      |  6 +++--
 .../devicetree/bindings/sound/wlf,wm8904.yaml | 18 ++++++++++----
 .../devicetree/bindings/tpm/tpm-common.yaml   |  6 +++--
 .../bindings/usb/mediatek,mtk-xhci.yaml       |  3 ++-
 .../bindings/usb/mediatek,mtu3.yaml           | 12 ++++++----
 .../bindings/watchdog/atmel,at91sam9-wdt.yaml |  3 ++-
 38 files changed, 192 insertions(+), 91 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/atmel,lcdc-display.yaml b/Documentation/devicetree/bindings/display/atmel,lcdc-display.yaml
index a5cf040ab4ea..51aa13f6a348 100644
--- a/Documentation/devicetree/bindings/display/atmel,lcdc-display.yaml
+++ b/Documentation/devicetree/bindings/display/atmel,lcdc-display.yaml
@@ -23,9 +23,12 @@ description:
 
 select:
   anyOf:
-    - required: [ 'atmel,dmacon' ]
-    - required: [ 'atmel,lcdcon2' ]
-    - required: [ 'atmel,guard-time' ]
+    - required:
+        - atmel,dmacon
+    - required:
+        - atmel,lcdcon2
+    - required:
+        - atmel,guard-time
 
 properties:
   atmel,dmacon:
diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
index ef88f46928a4..6d9167cfd12d 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
@@ -20,7 +20,9 @@ select:
       contains:
         anyOf:
           - pattern: "^atmel,(24(c|cs|mac)[0-9]+|spd)$"
-          - enum: ["microchip,24aa025e48", "microchip,24aa025e64"]
+          - enum:
+              - microchip,24aa025e48
+              - microchip,24aa025e64
   required:
     - compatible
 
diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
index b04f3cc4312c..4ff46f1384b9 100644
--- a/Documentation/devicetree/bindings/example-schema.yaml
+++ b/Documentation/devicetree/bindings/example-schema.yaml
@@ -206,10 +206,12 @@ properties:
 dependencies:
   # 'vendor,bool-property' is only allowed when 'vendor,string-array-property'
   # is present
-  vendor,bool-property: [ 'vendor,string-array-property' ]
+  vendor,bool-property:
+    - vendor,string-array-property
   # Expressing 2 properties in both orders means all of the set of properties
   # must be present or none of them.
-  vendor,string-array-property: [ 'vendor,bool-property' ]
+  vendor,string-array-property:
+    - vendor,bool-property
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/adi,max20830.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/adi,max20830.yaml
index cc50a4ee44a2..7904dacff789 100644
--- a/Documentation/devicetree/bindings/hwmon/pmbus/adi,max20830.yaml
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/adi,max20830.yaml
@@ -67,8 +67,10 @@ required:
   - vddh-supply
 
 dependencies:
-  adi,vout-rfb1-ohms: ['adi,vout-rfb2-ohms']
-  adi,vout-rfb2-ohms: ['adi,vout-rfb1-ohms']
+  adi,vout-rfb1-ohms:
+    - adi,vout-rfb2-ohms
+  adi,vout-rfb2-ohms:
+    - adi,vout-rfb1-ohms
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
index facfeee61330..6dd59552a41f 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
@@ -132,8 +132,10 @@ dependencies:
   refn-supply: [ refp-supply ]
 
 oneOf:
-  - required: [ refp-supply ]
-  - required: [ "ti,refp-refn-resistor-ohms" ]
+  - required:
+      - refp-supply
+  - required:
+      - ti,refp-refn-resistor-ohms
   - properties:
       refp-supply: false
       refn-supply: false
diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
index f4fae9210382..c71ebc039af2 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
@@ -166,7 +166,8 @@ properties:
     type: boolean
 
 dependencies:
-  adi,charge-pump-resistor-ohms: [ 'adi,charge-pump-current-microamp' ]
+  adi,charge-pump-resistor-ohms:
+    - adi,charge-pump-current-microamp
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
index f11391ab4b62..2bb3ddd252c9 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
@@ -104,8 +104,10 @@ properties:
     const: 0
 
 dependencies:
-  adi,lo-x2-en: [ "adi,lo-en" ]
-  adi,lo-ppf-en: [ "adi,lo-en" ]
+  adi,lo-x2-en:
+    - adi,lo-en
+  adi,lo-ppf-en:
+    - adi,lo-en
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 13e5f29f0588..19fc978deb76 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -284,7 +284,8 @@ patternProperties:
               type: boolean
 
           dependencies:
-            adi,current-rotate: [ 'adi,rsense-share' ]
+            adi,current-rotate:
+              - adi,rsense-share
 
       - if:
           properties:
@@ -368,7 +369,8 @@ patternProperties:
       - adi,rsense-handle
 
     dependencies:
-      adi,current-rotate: [ 'adi,rsense-share' ]
+      adi,current-rotate:
+        - adi,rsense-share
 
     allOf:
       - if:
diff --git a/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml b/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
index 418c168b223b..5043ed4cbd5c 100644
--- a/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
+++ b/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
@@ -396,8 +396,10 @@ patternProperties:
         description: Specifies the cycle's current reference trim.
 
     dependencies:
-      azoteq,iref-level: ["azoteq,iref-enable"]
-      azoteq,iref-trim: ["azoteq,iref-enable"]
+      azoteq,iref-level:
+        - azoteq,iref-enable
+      azoteq,iref-trim:
+        - azoteq,iref-enable
 
     additionalProperties: false
 
@@ -627,8 +629,10 @@ patternProperties:
         additionalProperties: false
 
     dependencies:
-      azoteq,ref-weight: ["azoteq,ref-select"]
-      azoteq,use-prox: ["azoteq,ref-select"]
+      azoteq,ref-weight:
+        - azoteq,ref-select
+      azoteq,use-prox:
+        - azoteq,ref-select
 
     additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
index fefaaf46a240..a8e61ad5b52a 100644
--- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
+++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
@@ -45,8 +45,10 @@ properties:
       when the keyboard has a custom design for the top row keys.
 
 dependencies:
-  function-row-physmap: [ 'linux,keymap' ]
-  google,needs-ghost-filter: [ 'linux,keymap' ]
+  function-row-physmap:
+    - linux,keymap
+  google,needs-ghost-filter:
+    - linux,keymap
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
index 64d1c46cb2f2..7181af1ac8c2 100644
--- a/Documentation/devicetree/bindings/input/input.yaml
+++ b/Documentation/devicetree/bindings/input/input.yaml
@@ -75,6 +75,7 @@ properties:
     default: 0
 
 dependencies:
-  linux,input-type: [ "linux,code" ]
+  linux,input-type:
+    - linux,code
 
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/input/iqs269a.yaml b/Documentation/devicetree/bindings/input/iqs269a.yaml
index 2c3f693b8982..e77702feaeca 100644
--- a/Documentation/devicetree/bindings/input/iqs269a.yaml
+++ b/Documentation/devicetree/bindings/input/iqs269a.yaml
@@ -272,10 +272,14 @@ properties:
       in order to be interpreted as a flick or swipe.
 
 dependencies:
-  azoteq,gesture-swipe: ["linux,keycodes"]
-  azoteq,timeout-tap-ms: ["linux,keycodes"]
-  azoteq,timeout-swipe-ms: ["linux,keycodes"]
-  azoteq,thresh-swipe: ["linux,keycodes"]
+  azoteq,gesture-swipe:
+    - linux,keycodes
+  azoteq,timeout-tap-ms:
+    - linux,keycodes
+  azoteq,timeout-swipe-ms:
+    - linux,keycodes
+  azoteq,thresh-swipe:
+    - linux,keycodes
 
 patternProperties:
   "^channel@[0-7]$":
diff --git a/Documentation/devicetree/bindings/input/iqs626a.yaml b/Documentation/devicetree/bindings/input/iqs626a.yaml
index e424d67b0542..534ee0742fdb 100644
--- a/Documentation/devicetree/bindings/input/iqs626a.yaml
+++ b/Documentation/devicetree/bindings/input/iqs626a.yaml
@@ -500,7 +500,8 @@ patternProperties:
         additionalProperties: false
 
     dependencies:
-      azoteq,assoc-weight: ["azoteq,assoc-select"]
+      azoteq,assoc-weight:
+        - azoteq,assoc-select
 
     additionalProperties: false
 
@@ -722,10 +723,14 @@ patternProperties:
         additionalProperties: false
 
     dependencies:
-      azoteq,gesture-swipe: ["linux,keycodes"]
-      azoteq,timeout-tap-ms: ["linux,keycodes"]
-      azoteq,timeout-swipe-ms: ["linux,keycodes"]
-      azoteq,thresh-swipe: ["linux,keycodes"]
+      azoteq,gesture-swipe:
+        - linux,keycodes
+      azoteq,timeout-tap-ms:
+        - linux,keycodes
+      azoteq,timeout-swipe-ms:
+        - linux,keycodes
+      azoteq,thresh-swipe:
+        - linux,keycodes
 
     additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/input/touchscreen/azoteq,iqs7211.yaml b/Documentation/devicetree/bindings/input/touchscreen/azoteq,iqs7211.yaml
index e4dbbafb3779..bb5407649717 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/azoteq,iqs7211.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/azoteq,iqs7211.yaml
@@ -347,9 +347,12 @@ properties:
         additionalProperties: false
 
     dependencies:
-      azoteq,rx-enable: ["azoteq,tx-enable"]
-      azoteq,tx-enable: ["azoteq,rx-enable"]
-      azoteq,channel-select: ["azoteq,rx-enable"]
+      azoteq,rx-enable:
+        - azoteq,tx-enable
+      azoteq,tx-enable:
+        - azoteq,rx-enable
+      azoteq,channel-select:
+        - azoteq,rx-enable
 
     additionalProperties: false
 
@@ -592,11 +595,16 @@ properties:
   touchscreen-swapped-x-y: true
 
 dependencies:
-  touchscreen-size-x: ["azoteq,num-contacts"]
-  touchscreen-size-y: ["azoteq,num-contacts"]
-  touchscreen-inverted-x: ["azoteq,num-contacts"]
-  touchscreen-inverted-y: ["azoteq,num-contacts"]
-  touchscreen-swapped-x-y: ["azoteq,num-contacts"]
+  touchscreen-size-x:
+    - azoteq,num-contacts
+  touchscreen-size-y:
+    - azoteq,num-contacts
+  touchscreen-inverted-x:
+    - azoteq,num-contacts
+  touchscreen-inverted-y:
+    - azoteq,num-contacts
+  touchscreen-swapped-x-y:
+    - azoteq,num-contacts
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
index 0718071444d2..20a52bd25bd8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
@@ -101,7 +101,8 @@ properties:
       that is mentioned in the "interrupts-extended"
 
 dependencies:
-  riscv,delegation: [ "riscv,children" ]
+  riscv,delegation:
+    - riscv,children
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/mfd/maxim,max8998.yaml b/Documentation/devicetree/bindings/mfd/maxim,max8998.yaml
index f3c3f64fd012..a4fd1805b13f 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max8998.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max8998.yaml
@@ -130,8 +130,10 @@ properties:
           - regulator-name
 
 dependencies:
-  max8998,pmic-buck1-dvs-gpios: [ "max8998,pmic-buck1-dvs-voltage" ]
-  max8998,pmic-buck2-dvs-gpio: [ "max8998,pmic-buck2-dvs-voltage" ]
+  max8998,pmic-buck1-dvs-gpios:
+    - max8998,pmic-buck1-dvs-voltage
+  max8998,pmic-buck2-dvs-gpio:
+    - max8998,pmic-buck2-dvs-voltage
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml b/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
index 249248078c59..df0640423757 100644
--- a/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
+++ b/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
@@ -143,12 +143,21 @@ required:
   - s5m8767,pmic-buck-ds-gpios
 
 dependencies:
-  s5m8767,pmic-buck2-dvs-voltage: [ 's5m8767,pmic-buck-dvs-gpios' ]
-  s5m8767,pmic-buck3-dvs-voltage: [ 's5m8767,pmic-buck-dvs-gpios' ]
-  s5m8767,pmic-buck4-dvs-voltage: [ 's5m8767,pmic-buck-dvs-gpios' ]
-  s5m8767,pmic-buck2-uses-gpio-dvs: [ 's5m8767,pmic-buck-dvs-gpios', 's5m8767,pmic-buck2-dvs-voltage' ]
-  s5m8767,pmic-buck3-uses-gpio-dvs: [ 's5m8767,pmic-buck-dvs-gpios', 's5m8767,pmic-buck3-dvs-voltage' ]
-  s5m8767,pmic-buck4-uses-gpio-dvs: [ 's5m8767,pmic-buck-dvs-gpios', 's5m8767,pmic-buck4-dvs-voltage' ]
+  s5m8767,pmic-buck2-dvs-voltage:
+    - s5m8767,pmic-buck-dvs-gpios
+  s5m8767,pmic-buck3-dvs-voltage:
+    - s5m8767,pmic-buck-dvs-gpios
+  s5m8767,pmic-buck4-dvs-voltage:
+    - s5m8767,pmic-buck-dvs-gpios
+  s5m8767,pmic-buck2-uses-gpio-dvs:
+    - s5m8767,pmic-buck-dvs-gpios
+    - s5m8767,pmic-buck2-dvs-voltage
+  s5m8767,pmic-buck3-uses-gpio-dvs:
+    - s5m8767,pmic-buck-dvs-gpios
+    - s5m8767,pmic-buck3-dvs-voltage
+  s5m8767,pmic-buck4-uses-gpio-dvs:
+    - s5m8767,pmic-buck-dvs-gpios
+    - s5m8767,pmic-buck4-dvs-voltage
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
index 8d62be4355a0..fec8ecbb56d5 100644
--- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
+++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
@@ -168,9 +168,12 @@ properties:
       The GPIO matching the CKIN pin.
 
 dependencies:
-  st,cmd-gpios: [ "st,use-ckin" ]
-  st,ck-gpios: [ "st,use-ckin" ]
-  st,ckin-gpios: [ "st,use-ckin" ]
+  st,cmd-gpios:
+    - st,use-ckin
+  st,ck-gpios:
+    - st,use-ckin
+  st,ckin-gpios:
+    - st,use-ckin
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
index fa2aa29be794..00079edc7dd3 100644
--- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
@@ -85,8 +85,12 @@ patternProperties:
     dependencies:
       nand-ecc-strength: [nand-ecc-step-size]
       nand-ecc-step-size: [nand-ecc-strength]
-      amlogic,boot-pages: [nand-is-boot-medium, "amlogic,boot-page-step"]
-      amlogic,boot-page-step: [nand-is-boot-medium, "amlogic,boot-pages"]
+      amlogic,boot-pages:
+        - nand-is-boot-medium
+        - amlogic,boot-page-step
+      amlogic,boot-page-step:
+        - nand-is-boot-medium
+        - amlogic,boot-pages
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 2449311c6d28..8eb84942ce3f 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -605,8 +605,10 @@ required:
   - phy-mode
 
 dependencies:
-  snps,reset-active-low: ["snps,reset-gpio"]
-  snps,reset-delays-us: ["snps,reset-gpio"]
+  snps,reset-active-low:
+    - snps,reset-gpio
+  snps,reset-delays-us:
+    - snps,reset-gpio
 
 allOf:
   - $ref: ethernet-controller.yaml#
diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
index 18e7981241b5..2f1be6420e23 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
@@ -82,7 +82,8 @@ properties:
   msi-parent: true
 
 dependencies:
-  brcm,pcie-ob-axi-offset: ["brcm,pcie-ob"]
+  brcm,pcie-ob-axi-offset:
+    - brcm,pcie-ob
   brcm,pcie-msi-inten: [msi-controller]
 
 required:
diff --git a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
index d01c677ad3c7..aa2ccf00d136 100644
--- a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
+++ b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
@@ -90,7 +90,8 @@ properties:
             bitmap of all MHPMCOUNTERx that can monitor the range of events
 
 dependencies:
-  riscv,event-to-mhpmevent: [ "riscv,event-to-mhpmcounters" ]
+  riscv,event-to-mhpmevent:
+    - riscv,event-to-mhpmcounters
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/phy/hisilicon,hi3798cv200-combphy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,hi3798cv200-combphy.yaml
index 81001966f657..2040723f5297 100644
--- a/Documentation/devicetree/bindings/phy/hisilicon,hi3798cv200-combphy.yaml
+++ b/Documentation/devicetree/bindings/phy/hisilicon,hi3798cv200-combphy.yaml
@@ -48,8 +48,10 @@ required:
   - resets
 
 oneOf:
-  - required: ['hisilicon,fixed-mode']
-  - required: ['hisilicon,mode-select-bits']
+  - required:
+      - hisilicon,fixed-mode
+  - required:
+      - hisilicon,mode-select-bits
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml b/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml
index a37e8322dc50..90eba0e6ecdb 100644
--- a/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml
@@ -251,8 +251,10 @@ allOf:
         - nvidia,xcvr-lsrslew
 
       anyOf:
-        - required: ["nvidia,xcvr-setup"]
-        - required: ["nvidia,xcvr-setup-use-fuses"]
+        - required:
+            - nvidia,xcvr-setup
+        - required:
+            - nvidia,xcvr-setup-use-fuses
 
       if:
         properties:
diff --git a/Documentation/devicetree/bindings/regulator/adi,max77857.yaml b/Documentation/devicetree/bindings/regulator/adi,max77857.yaml
index d1fa74aca721..4191c5f3dcd0 100644
--- a/Documentation/devicetree/bindings/regulator/adi,max77857.yaml
+++ b/Documentation/devicetree/bindings/regulator/adi,max77857.yaml
@@ -43,8 +43,10 @@ properties:
     description: Bottom feedback resistor value in ohms for external feedback.
 
 dependencies:
-  adi,rtop-ohms: [ 'adi,rbot-ohms' ]
-  adi,rbot-ohms: [ 'adi,rtop-ohms' ]
+  adi,rtop-ohms:
+    - adi,rbot-ohms
+  adi,rbot-ohms:
+    - adi,rtop-ohms
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml b/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
index 2b266ea43716..acc493840588 100644
--- a/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
+++ b/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
@@ -251,9 +251,12 @@ required:
   - regulators
 
 dependencies:
-  max8997,pmic-buck1-uses-gpio-dvs: [ 'max8997,pmic-buck125-dvs-gpios' ]
-  max8997,pmic-buck2-uses-gpio-dvs: [ 'max8997,pmic-buck125-dvs-gpios' ]
-  max8997,pmic-buck5-uses-gpio-dvs: [ 'max8997,pmic-buck125-dvs-gpios' ]
+  max8997,pmic-buck1-uses-gpio-dvs:
+    - max8997,pmic-buck125-dvs-gpios
+  max8997,pmic-buck2-uses-gpio-dvs:
+    - max8997,pmic-buck125-dvs-gpios
+  max8997,pmic-buck5-uses-gpio-dvs:
+    - max8997,pmic-buck125-dvs-gpios
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/regulator/samsung,s2mpg10-regulator.yaml b/Documentation/devicetree/bindings/regulator/samsung,s2mpg10-regulator.yaml
index 7252f94b3a8f..506b61175ae9 100644
--- a/Documentation/devicetree/bindings/regulator/samsung,s2mpg10-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/samsung,s2mpg10-regulator.yaml
@@ -139,7 +139,8 @@ $defs:
           property describes the GPIO line used.
 
     dependentRequired:
-      enable-gpios: [ "samsung,ext-control" ]
+      enable-gpios:
+        - samsung,ext-control
 
 allOf:
   # Bucks 8, 9, and LDO 1 can not be controlled externally - above definition
diff --git a/Documentation/devicetree/bindings/regulator/samsung,s2mpg11-regulator.yaml b/Documentation/devicetree/bindings/regulator/samsung,s2mpg11-regulator.yaml
index 119386325d1b..3a8a2945efd7 100644
--- a/Documentation/devicetree/bindings/regulator/samsung,s2mpg11-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/samsung,s2mpg11-regulator.yaml
@@ -116,7 +116,8 @@ $defs:
           property describes the GPIO line used.
 
     dependentRequired:
-      enable-gpios: [ "samsung,ext-control" ]
+      enable-gpios:
+        - samsung,ext-control
 
 allOf:
   # Bucks 4, 6, 7 and 10 can not be controlled externally - above definition
diff --git a/Documentation/devicetree/bindings/regulator/ti,tps65132.yaml b/Documentation/devicetree/bindings/regulator/ti,tps65132.yaml
index 873d92738eb0..f120f82398dc 100644
--- a/Documentation/devicetree/bindings/regulator/ti,tps65132.yaml
+++ b/Documentation/devicetree/bindings/regulator/ti,tps65132.yaml
@@ -48,7 +48,8 @@ patternProperties:
         description: Regulator active discharge time in microseconds.
 
     dependencies:
-      active-discharge-gpios: [ 'ti,active-discharge-time-us' ]
+      active-discharge-gpios:
+        - ti,active-discharge-time-us
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 5feeb2203050..26914597d049 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -151,8 +151,10 @@ anyOf:
       - riscv,isa-base
 
 dependencies:
-  riscv,isa-base: [ "riscv,isa-extensions" ]
-  riscv,isa-extensions: [ "riscv,isa-base" ]
+  riscv,isa-base:
+    - riscv,isa-extensions
+  riscv,isa-extensions:
+    - riscv,isa-base
 
 required:
   - interrupt-controller
diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
index 355b0598411a..9990de48bdd3 100644
--- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
+++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
@@ -53,8 +53,10 @@ properties:
     enum: [0, 3, 6, 11]
 
 dependentRequired:
-  abracon,tc-diode: ["abracon,tc-resistor"]
-  abracon,tc-resistor: ["abracon,tc-diode"]
+  abracon,tc-diode:
+    - abracon,tc-resistor
+  abracon,tc-resistor:
+    - abracon,tc-diode
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml b/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml
index f516960dbbef..819adf7e005e 100644
--- a/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml
+++ b/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml
@@ -365,9 +365,13 @@ allOf:
 additionalProperties: false
 
 dependencies:
-  nvidia,suspend-mode: ['nvidia,core-pwr-off-time', 'nvidia,cpu-pwr-off-time']
-  nvidia,core-pwr-off-time: ['nvidia,core-pwr-good-time']
-  nvidia,cpu-pwr-off-time: ['nvidia,cpu-pwr-good-time']
+  nvidia,suspend-mode:
+    - nvidia,core-pwr-off-time
+    - nvidia,cpu-pwr-off-time
+  nvidia,core-pwr-off-time:
+    - nvidia,core-pwr-good-time
+  nvidia,cpu-pwr-off-time:
+    - nvidia,cpu-pwr-good-time
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml b/Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml
index 66b76656229f..4e02f2dc5aa8 100644
--- a/Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml
@@ -125,8 +125,10 @@ properties:
       Mic bias voltage output on MICBIAS2 pin
 
 dependencies:
-  ti,micbias1-gpo: ['ti,micbias1-vg']
-  ti,micbias2-gpo: ['ti,micbias2-vg']
+  ti,micbias1-gpo:
+    - ti,micbias1-vg
+  ti,micbias2-gpo:
+    - ti,micbias2-vg
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
index 3029a868e5e1..eb0cf2002865 100644
--- a/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
@@ -107,12 +107,20 @@ properties:
       maxItems: 24
 
 dependencies:
-  wlf,drc-cfg-names: [ 'wlf,drc-cfg-regs' ]
-  wlf,drc-cfg-regs: [ 'wlf,drc-cfg-names' ]
+  wlf,drc-cfg-names:
+    - wlf,drc-cfg-regs
+  wlf,drc-cfg-regs:
+    - wlf,drc-cfg-names
 
-  wlf,retune-mobile-cfg-names: [ 'wlf,retune-mobile-cfg-hz', 'wlf,retune-mobile-cfg-regs' ]
-  wlf,retune-mobile-cfg-regs: [ 'wlf,retune-mobile-cfg-names', 'wlf,retune-mobile-cfg-hz' ]
-  wlf,retune-mobile-cfg-hz: [ 'wlf,retune-mobile-cfg-names', 'wlf,retune-mobile-cfg-regs' ]
+  wlf,retune-mobile-cfg-names:
+    - wlf,retune-mobile-cfg-hz
+    - wlf,retune-mobile-cfg-regs
+  wlf,retune-mobile-cfg-regs:
+    - wlf,retune-mobile-cfg-names
+    - wlf,retune-mobile-cfg-hz
+  wlf,retune-mobile-cfg-hz:
+    - wlf,retune-mobile-cfg-names
+    - wlf,retune-mobile-cfg-regs
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/tpm/tpm-common.yaml b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
index 3c1241b2a43f..b8853c39ebbf 100644
--- a/Documentation/devicetree/bindings/tpm/tpm-common.yaml
+++ b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
@@ -50,8 +50,10 @@ properties:
 
 # must always have both linux,sml-base and linux,sml-size
 dependentRequired:
-  linux,sml-base: ['linux,sml-size']
-  linux,sml-size: ['linux,sml-base']
+  linux,sml-base:
+    - linux,sml-size
+  linux,sml-size:
+    - linux,sml-base
 
 # must only have either memory-region or linux,sml-base
 # as well as either resets or reset-gpios
diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 231e6f35a986..af13035f94dc 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -194,7 +194,8 @@ patternProperties:
     description: The hard wired USB devices.
 
 dependencies:
-  wakeup-source: [ 'mediatek,syscon-wakeup' ]
+  wakeup-source:
+    - mediatek,syscon-wakeup
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
index d148e938d647..27d512ada717 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
@@ -227,10 +227,14 @@ patternProperties:
       example if the host mode is enabled.
 
 dependencies:
-  connector: [ usb-role-switch ]
-  port: [ usb-role-switch ]
-  role-switch-default-mode: [ usb-role-switch ]
-  wakeup-source: [ 'mediatek,syscon-wakeup' ]
+  connector:
+    - usb-role-switch
+  port:
+    - usb-role-switch
+  role-switch-default-mode:
+    - usb-role-switch
+  wakeup-source:
+    - mediatek,syscon-wakeup
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/watchdog/atmel,at91sam9-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,at91sam9-wdt.yaml
index ad27bc518670..fea4f510aa6c 100644
--- a/Documentation/devicetree/bindings/watchdog/atmel,at91sam9-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/atmel,at91sam9-wdt.yaml
@@ -104,7 +104,8 @@ allOf:
           const: hardware
 
 dependencies:
-  atmel,reset-type: ['atmel,watchdog-type']
+  atmel,reset-type:
+    - atmel,watchdog-type
 
 unevaluatedProperties: false
 
-- 
2.43.0

