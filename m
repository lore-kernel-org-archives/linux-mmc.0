Received: from mx.olsak.net (unknown [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764502DFF04;
	Tue,  8 Jul 2025 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994710; cv=none; b=Rw+y4EJUBwGkS5Qlmu/nP1s93N0im/g0CbehI1K99HoPaWj66Pc2KEb4CNGuzm/JaqYsxUA2JRdPfGMraMQwDOJxnm85jO7P+OmLgpz6l4kl35pkZ8naOdrp+Zs0JCFrSnsccRwckaHk5DlhY4fVhWi1qMIl0uJHBcMhKP3EL0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994710; c=relaxed/simple;
	bh=65aNYsQ8JjFSYbzJx1V2anTWL2zOApEH8927sYndFAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhW6sFlMbmOI6uwgYst2H7Ta48LI88EDvGU+D1MgjopbMZRR/JV5gtZM5jPI8xrl0OcF3gbQmCe7h2BRrLMNderRarzTW8EXVE6GoN20BIrbFwpmzUCqhEg6qyMgTr4Xv+R9D2I5iZCxUduzObCUz+hROZexSW0UJA9/6INCtkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=hKNNTxNs; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="hKNNTxNs"
DKIM-Signature: a=rsa-sha256; bh=LtpL9xeWswzKfuckZn9sP+YgvbyRD6xwyqCKGbCnyIQ=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1751994598; v=1; x=1752426598;
 b=hKNNTxNsvtDaf14HLCbJwhNkEndvJQZ0eZnLLYPYxC5pc4WvEulGpw/uTtwpES+KrtvI3B8I
 6YgysTMp1rMtCAhzBU1hwLZVfqNs4RL/CwDY0J7Ul47Uo3wlhcvjR97iFwqbDrp4MJk4ekfFdZZ
 W3iZy414rnfVoVCnrRt65Bi5lFEjkPycxWADBfR0/09aorq4xUnEMgF1I4BxBZTOy0z50S2pNDB
 tBgWCvUMgY4F9ciVp457vxHBeJS6lJWXqPGKqQXNtgQaDEpMKGcYOzWnSFHeZTc1faze1euqNBi
 FKaLYMDxc8Q/cXP5Jf5qXHa+bMcLGkkiB7k5LHao2cm2A==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 2d725840; Tue, 08 Jul 2025 19:09:58 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Tue, 08 Jul 2025 19:09:46 +0200
Subject: [PATCH v16 1/5] dt-bindings: mmc: sdhci-pxa: restrict pinctrl to
 pxav1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250708-pxa1908-lkml-v16-1-b4392c484180@dujemihanovic.xyz>
References: <20250708-pxa1908-lkml-v16-0-b4392c484180@dujemihanovic.xyz>
In-Reply-To: <20250708-pxa1908-lkml-v16-0-b4392c484180@dujemihanovic.xyz>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 soc@lists.linux.dev, linux-mmc@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2237;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=65aNYsQ8JjFSYbzJx1V2anTWL2zOApEH8927sYndFAo=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBm5AY9nmbNYmQkwrMpQtrlS3eM9k7N5igXru/6XX3+0z
 L+VzlfbUcrCIMbFICumyJL73/Ea72eRrduzlxnAzGFlAhnCwMUpABNhVmFkWOMRLuT5c++SQiN5
 2cxjHou/XuTKK50sqdZdXplqFCSfysgw+3lvr4tJytUFZ74/fK2vcIf1gfSMk1mzXtmVVLRXFqn
 xAwA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

The current pinctrl properties apply only to the pxav1 controller.
Adding one default pinctrl node to a pxav3 controller therefore causes
a schema warning.

Check the existing properties only on pxav1. pxav2 and pxav3 may add
their own set of pinctrl properties if and when needed.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Changes in v16:
- New patch
---
 .../devicetree/bindings/mmc/sdhci-pxa.yaml         | 36 ++++++++++++----------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
index 4869ddef36fd89265a1bfe96bb9663b553ac5084..e7c06032048a3a73eb3eb67a887e75db273ffa92 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
@@ -30,6 +30,26 @@ allOf:
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
+        pinctrl-0:
+          description:
+            Should contain default pinctrl.
+        pinctrl-1:
+          description:
+            Should switch CMD pin to GPIO mode as a high output.
 
 properties:
   compatible:
@@ -62,22 +82,6 @@ properties:
       - const: io
       - const: core
 
-  pinctrl-names:
-    description:
-      Optional for supporting PXA168 SDIO IRQ errata to switch CMD pin between
-      SDIO CMD and GPIO mode.
-    items:
-      - const: default
-      - const: state_cmd_gpio
-
-  pinctrl-0:
-    description:
-      Should contain default pinctrl.
-
-  pinctrl-1:
-    description:
-      Should switch CMD pin to GPIO mode as a high output.
-
   mrvl,clk-delay-cycles:
     description: Specify a number of cycles to delay for tuning.
     $ref: /schemas/types.yaml#/definitions/uint32

-- 
2.50.0

