Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C8289345;
	Wed,  6 Aug 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473470; cv=none; b=dRFdh+YlBEapRp8GW9QtqIe4spB6+G1SU8k3MiBzQkNrLM7c+gD0yNB/Cb9w2MVtrnKymkHAqTjXpPZO4zURujExp+KpRq+1bz6I0u+NzOMzevC1gqUf8U+KYN4fK9WOcpJE0al7PXaNXZPDNj5uimzzKU5ZfGIW7L8omP1qsi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473470; c=relaxed/simple;
	bh=j+r7ZNKSzw9uym9kO0+ZjrP7HOEkHWldRcIktkLhAuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q8XxTSAUI1+z7E0UFB7/UPat+T/xmf5NWaUKRkdrfWgl7MjuzDxp4n2Jm1Fn7Q6YsR3Y/7vS5HaBcdic+01Ggqi7CQiUXb0fBXO4M99WxdNxVYKO5kVpQLbe7ZDzuQALHHsgYnpxRn6ULQwy26OCGt03SQBFQX8Nleq3MpoUxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=XHIPL7oJ; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="XHIPL7oJ"
DKIM-Signature: a=rsa-sha256; bh=IqBCgikWo4wY7MmIWTdFlv0AJR1TxS9Xh2+FP3Wsxd0=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1754473444; v=1; x=1754905444;
 b=XHIPL7oJnqmT+IpcGbWPZsDFivF54k1isvPM+PN5q+0B1pI0Yf/y91NrQrESsODfTFwVNGF2
 wRoH60AkJvxBP9Hyh71p7u0O+WQunfaUpM7Iq+kjpvLJFjTDU3KPYzdXm/dSb2fLULPFBSa9PC6
 ceIfpoSYZd5FbnZjKWkZKg5ivamCV7mYkr5iDZD2mCY3JuFnfKak3S7XogJdiDxEkdOb9z8hn1v
 kpNsxHUI5CeP0iMnw6PPwFrbuujg4EtJsNOkdxoIQPHe9r7CwIKrZ5nqVsBtRjmHXEQs2Z42+S4
 wxvEHNm9+NFkyTZ1sKE2dM14XK/OVj8aL1DeFZweQ3tXg==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id bb930501; Wed, 06 Aug 2025 11:44:04 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Wed, 06 Aug 2025 11:43:53 +0200
Subject: [PATCH v3 1/2] dt-bindings: mmc: sdhci-pxa: add state_uhs pinctrl
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250806-pxav3-uhs-v3-1-2f03fee380b0@dujemihanovic.xyz>
References: <20250806-pxav3-uhs-v3-0-2f03fee380b0@dujemihanovic.xyz>
In-Reply-To: <20250806-pxav3-uhs-v3-0-2f03fee380b0@dujemihanovic.xyz>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2717;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=j+r7ZNKSzw9uym9kO0+ZjrP7HOEkHWldRcIktkLhAuc=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBmTlR/vf2CemnamdkLPcYnQd99VBJa+2BQz93dlSaL13
 kmf3u9p6ihlYRDjYpAVU2TJ/e94jfezyNbt2csMYOawMoEMYeDiFICJfMtn+KeSbvk45f7/q7kP
 zmQLT7yucvZzipz/BdHZMTEPjng8l/vG8D/iUhnb+wXblkd8qLirZjN1SXp0xqcptytmha6eNp1
 p9z1OAA==
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

On the pxav3 controller, increasing the drive strength of the data pins
might be required to maintain stability on fast bus clocks (above 100
MHz). Add a state_uhs pinctrl to allow this.

The existing state_cmd_gpio pinctrl is changed to apply only on pxav1 as
it's unneeded on the other controllers.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Changes in v2:
- Newlines between properties in if:
---
 .../devicetree/bindings/mmc/sdhci-pxa.yaml         | 47 +++++++++++++++++-----
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
index 4869ddef36fd89265a1bfe96bb9663b553ac5084..fba1cc50fdf07cc25d42f45512c385a9b8207b9b 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
@@ -30,6 +30,41 @@ allOf:
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
+
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
+
+        pinctrl-1:
+          description:
+            Should switch the drive strength of the data pins to high.
 
 properties:
   compatible:
@@ -62,21 +97,13 @@ properties:
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

