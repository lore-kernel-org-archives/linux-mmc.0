Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015331DFDA1;
	Fri, 18 Jul 2025 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873211; cv=none; b=ZCwHWh3mcFTJVrAHPUMirODYd+d34NTBxKSvGH5MlzKWSim49OAb0sT8MCfxcuMDprUv5ABW4AF1zDrDLPJvNKFeNuNCa13NNcKDfvfvQDEqmR9h7JpryCP/lKRrmeyXRHsNN/MMt0BKNEvj6o8m3AcdRFc4ZMjRNcrq76cSVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873211; c=relaxed/simple;
	bh=X0ruUBCWmqPUnMw0Occmhf5PEzBxkpVnH5AXoDKfe9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JSzUD76QzWf0w6TS7GgtY5RdFCzQHtwtASIxtYXbwbW212UxW5gMScH2SUI/3h3lGnYcflhAMRPyHI7H/fBZDCJWKWzRIKLRCXkXdVD2V4DQQk6mxlFBZedBIZWInLmdo82HvhNFfAbTdmrMz7SG+6o5mO+1hComiFJgOK9Jx7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=Zv7iDqvA; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="Zv7iDqvA"
DKIM-Signature: a=rsa-sha256; bh=QyqeF9sRoGvvojqnJHNwL0AQl2Z7d0Gpu9tbw2QxQfI=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1752873185; v=1; x=1753305185;
 b=Zv7iDqvA8i69mT3Mv3IqUTB/189Jmv6qe0VH+nuWDKjmt9SaEaNZKMkVv7ifl7Zu2GiLlTAh
 BRMpEm1RCKrj+yHKkRN2NY74AU1SUJDgBQ5Hg4mLbveSxEZYfJbLVHNJCcWIMzLVCpds9I0gHJv
 v4NEW7bxq34bMA91kLY3XKtWxe/iRO8ipTcfDB3EoB/9WsEnzKaTaGvhw4SisPcHxiWA91Fjp7j
 K45oRyHLZHOn7svwnuBHdbZ9lC9lj9N/QoGXjHwatv7scTyrEbPtf1jnazWCVpYmXf4R3wu0s6O
 GVLcGske/27oikZDYxeysZLbIFJ51VDaJnMWvpGuCFC+g==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id e9e4dbdb; Fri, 18 Jul 2025 23:13:05 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Fri, 18 Jul 2025 23:12:38 +0200
Subject: [PATCH RFC 1/2] dt-bindings: mmc: sdhci-pxa: add state_uhs pinctrl
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250718-pxav3-uhs-v1-1-2e451256f1f6@dujemihanovic.xyz>
References: <20250718-pxav3-uhs-v1-0-2e451256f1f6@dujemihanovic.xyz>
In-Reply-To: <20250718-pxav3-uhs-v1-0-2e451256f1f6@dujemihanovic.xyz>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2602;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=X0ruUBCWmqPUnMw0Occmhf5PEzBxkpVnH5AXoDKfe9M=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlVO+6r+ene42++o23IY3LxT2j6FJ7LJ8y/eB69zdVgV
 VV0/ub6jlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZiIjzojww7Vn/Lc5celHVo3
 zl616bUOh18375uC35t/1H49vNl/EgPD/2ShPRO0TKNVJpXcrj19+5rFbOPazuaOed9eH/4SkHH
 7FzcA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

On the pxav3 controller, increasing the drive strength of the data pins
might be required to maintain stability on fast bus clocks (above 100
MHz). Add a state_uhs pinctrl to allow this.

The existing state_cmd_gpio pinctrl is changed to apply only on pxav1 as
it's unneeded on the other controllers.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 .../devicetree/bindings/mmc/sdhci-pxa.yaml         | 45 +++++++++++++++++-----
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
index 4869ddef36fd89265a1bfe96bb9663b553ac5084..7a9e2a63ac4351aea10b2763ca250ce4889df1eb 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
@@ -30,6 +30,39 @@ allOf:
           maxItems: 1
         reg-names:
           maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mrvl,pxav1-mmc
+    then:
+      properties:
+        pinctrl-names:
+          description:
+            Optional for supporting PXA168 SDIO IRQ errata to switch CMD pin between
+            SDIO CMD and GPIO mode.
+          items:
+            - const: default
+            - const: state_cmd_gpio
+        pinctrl-1:
+          description:
+            Should switch CMD pin to GPIO mode as a high output.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mrvl,pxav3-mmc
+    then:
+      properties:
+        pinctrl-names:
+          description:
+            Optional for increasing stability of the controller at fast bus clocks.
+          items:
+            - const: default
+            - const: state_uhs
+        pinctrl-1:
+          description:
+            Should switch the drive strength of the data pins to high.
 
 properties:
   compatible:
@@ -62,21 +95,13 @@ properties:
       - const: io
       - const: core
 
-  pinctrl-names:
-    description:
-      Optional for supporting PXA168 SDIO IRQ errata to switch CMD pin between
-      SDIO CMD and GPIO mode.
-    items:
-      - const: default
-      - const: state_cmd_gpio
+  pinctrl-names: true
 
   pinctrl-0:
     description:
       Should contain default pinctrl.
 
-  pinctrl-1:
-    description:
-      Should switch CMD pin to GPIO mode as a high output.
+  pinctrl-1: true
 
   mrvl,clk-delay-cycles:
     description: Specify a number of cycles to delay for tuning.

-- 
2.50.1

