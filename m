Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCCB269AFB;
	Fri,  1 Aug 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057688; cv=none; b=jPDLjN2DajTcywkzFvn1wb5ZrE940V8qV8T8pT4JhuzGndZQXljPkdsGiMLhJmz1Ky89UY9Euy/CvFkBBnq9bUecJHLhdj5o7Jipp5IxWQCYpiatSCU9IEcBpUruj7BzGar98HEageFnPynekLpfc8wXEb80eond6nueWc4HuuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057688; c=relaxed/simple;
	bh=X8bDc3mEF7A+jWR5/Mtli4JbbUPbP/jIzLwqkvh83zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D+UwoXC9j7axk86GxTW1y2DHaAcFAPGCjcD5m+tj1Ye4wVZaxZhKB6/TUIlWcwSQ/IAXYOLV0zBKfHMf1GiZj8gzgeVdJrOhNCnJdcwVNr2ZDjM1tOtXuU0b0i0SHZ7Dan0JHXyjlw/SzAZNOEFtPWb8jr/5jVjtxTuJ61IcEtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=i6N0iP0B; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="i6N0iP0B"
DKIM-Signature: a=rsa-sha256; bh=xg6p9F3CDjFSzSKSOC4/hpt/VNg4sb7Ukef6jTBb/9A=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1754057669; v=1; x=1754489669;
 b=i6N0iP0BaDHQLYoTpRhu7egSc/yKlvNRbElMuGsRpE7zntaKAQ1+33b1r6asHzmD1aWpomZ3
 2o3BPdTPTFI5mQFgjwNyLiYWEZTB74htkkRxFxeBc0qfmc5PE+E9Pi9LCeKiXD/WdoIF9ZybHLf
 PIKoCUfTZGLQMWeUfLN9ZkiXm6p+OATclFc6EkOmXySJqCg0W0G4gxNVF03tz4muok/Pjgi9DMe
 hwlgEXWv8M2ELBwLiOGQI+0TLFavPSoiu2pgrsiq40t4xJKYvS8+E4vXrTb+4Tm6974bWL59zbq
 K8p9xtd4EbKdm3tsCZsPi9UJNwQuMG+Kpd5j0BdyxRLqw==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 2cca7fc8; Fri, 01 Aug 2025 16:14:29 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Fri, 01 Aug 2025 16:14:15 +0200
Subject: [PATCH RFC v2 1/2] dt-bindings: mmc: sdhci-pxa: add state_uhs
 pinctrl
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250801-pxav3-uhs-v2-1-afc1c428c776@dujemihanovic.xyz>
References: <20250801-pxav3-uhs-v2-0-afc1c428c776@dujemihanovic.xyz>
In-Reply-To: <20250801-pxav3-uhs-v2-0-afc1c428c776@dujemihanovic.xyz>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2667;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=X8bDc3mEF7A+jWR5/Mtli4JbbUPbP/jIzLwqkvh83zk=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBk9p4/4vskRf7H2/pumTTsil4g9/yYTUyNWzSo7g+F8g
 H3H1vasjlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZiI+EZGhiXyOXE+F3QWNR8I
 CrrfOSHxZrzxQYv82IlcPc4PS8v49jMy3K2uuP/90A3m4otf5ESEFy+QPm6tyJ23SehoDg/LL5a
 7LAA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

On the pxav3 controller, increasing the drive strength of the data pins
might be required to maintain stability on fast bus clocks (above 100
MHz). Add a state_uhs pinctrl to allow this.

The existing state_cmd_gpio pinctrl is changed to apply only on pxav1 as
it's unneeded on the other controllers.

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

