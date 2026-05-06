Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9E3DC4A3;
	Wed,  6 May 2026 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058217; cv=none; b=Xf2fM8NmL4rio5eV7RLCTyKNKp84RDra1850lNCrotb8OEUSUxSiLbL263mgKoXX7re7uLnC91jN9tQ5wsDUav+BtB+NTjKg+jdhqqACBPE+TeurDVJMFsMbBi8QrLXg/typEq360zmCccxQQSG77rxOBv6e1OD0ErGKqle8y0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058217; c=relaxed/simple;
	bh=6W3Fb4ZLv48stVHwf77aYCkiYKDnhUxTeKvXgrBaONs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ksI/9pERvjR8noVBXn6hKmSZB3Qf9WLtcUA2lVM5i2d8/sYikWcns8fStKG9/fItQyhq63FXxDdcpCt9kgLXpBfDJfmq/QYb0PZMvxtx9SRaxKrJ7g19aDfHeFqq3/z3VIQReSIC2Fnkj2B3bLqYlPoYBctnI/osFvVzX+hDa6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi8dRwgZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qi8dRwgZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 708B1C2BCF4;
	Wed,  6 May 2026 09:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778058217;
	bh=6W3Fb4ZLv48stVHwf77aYCkiYKDnhUxTeKvXgrBaONs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Qi8dRwgZIqrlhwv9GmNIH37XY11WTed+oDdM+CEDOjuS8edXYOYun7w6Yx8ZQ3kvE
	 FKNSPgwCjs7uOrcQleJtTfE1lHkUJ0q4WML8uELpIFryzVeVWzGVHhOhPTl3usOxGp
	 +EJ29ELC/xSuPogBKq83bvAuBqVgE8jEhh10v/BLZLCBe9QHX0CBgYJGiCD/T9PU1d
	 AtMt3iWo9LGpbkNUeeYnsNNQ3UFDjESn0qF3lfkV5y1lUot5oxSxz03JRI7dxOWjgI
	 DDIgrl90hysXXOugf047+04gG+St/V1OKkvhe3XVn7dGoTshhWJkFslB5Zd9W6pwtX
	 JXdGLSHHWfJYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C4ECD3439;
	Wed,  6 May 2026 09:03:37 +0000 (UTC)
From: Rohan Joshi via B4 Relay <devnull+rohan1sj.cadence.com@kernel.org>
Date: Wed, 06 May 2026 14:34:46 +0530
Subject: [PATCH v2 1/2] dt-bindings: mmc: cdns,sdhci: Add CQE support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-cdns_sdhci_cqe-support-v2-1-754fe4de8b65@cadence.com>
References: <20260506-cdns_sdhci_cqe-support-v2-0-754fe4de8b65@cadence.com>
In-Reply-To: <20260506-cdns_sdhci_cqe-support-v2-0-754fe4de8b65@cadence.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mparab@cadence.com, pawell@cadence.com, 
 sjakhade@cadence.com, mpillai@cadence.com, rohan1sj@cadence.com
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778058298; l=2597;
 i=rohan1sj@cadence.com; s=20260406; h=from:subject:message-id;
 bh=n42mGGYkYpXMehcfhaVeXxEx7pSGijf2DNwxK2oxS9s=;
 b=GKz4pe8SMh6qxwCXXVRDN5JrBWPaHMDpss+m+X9LNk/1mDplxtcIKPzZcJwL0fv9FZb+Lz0Jl
 ZS9U0jZTv1cBgytWtKJwC+qriyvq4JuMKxHNuH1apF1s4fRaSYQsd2J
X-Developer-Key: i=rohan1sj@cadence.com; a=ed25519;
 pk=YuwylizMVlVj8I4+VPMZ6xrFR2wyqJAWZyj90OVZgD0=
X-Endpoint-Received: by B4 Relay for rohan1sj@cadence.com/20260406 with
 auth_id=723
X-Original-From: Rohan Joshi <rohan1sj@cadence.com>
Reply-To: rohan1sj@cadence.com

From: Rohan Joshi <rohan1sj@cadence.com>

Cadence host controller can support CQE. Add optional CQE
register space and reg-names property to cdns sdhci binding

Signed-off-by: Rohan Joshi <rohan1sj@cadence.com>
---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml        | 41 +++++++---------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 8902e7925eab..79064282fabc 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -26,7 +26,9 @@ properties:
 
   reg-names:
     minItems: 1
-    maxItems: 2
+    items:
+      - const: hc
+      - const: cqhci
 
   interrupts:
     maxItems: 1
@@ -138,22 +140,16 @@ allOf:
           items:
             - description: Host controller registers
             - description: Elba byte-lane enable register for writes
+        reg-names: false
+      required:
+        - resets
     else:
       properties:
         reg:
-          oneOf:
-            - items:
-                - description: Host controller registers
-            - items:
-                - description: Host controller registers
-                - description: CQE (Command Queue Engine) registers
-        reg-names:
-          oneOf:
-            - items:
-                - const: sdhci
-            - items:
-                - const: sdhci
-                - const: cqhci
+          minItems: 1
+          items:
+            - description: Host Controller registers
+            - description: CQE (Command Queuing Engine) registers
 
 unevaluatedProperties: false
 
@@ -161,7 +157,8 @@ examples:
   - |
     emmc: mmc@5a000000 {
         compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
-        reg = <0x5a000000 0x400>;
+        reg = <0x5a000000 0x400>, <0x5a000400 0x060>;
+        reg-names = "hc", "cqhci";
         interrupts = <0 78 4>;
         clocks = <&clk 4>;
         bus-width = <8>;
@@ -170,17 +167,3 @@ examples:
         mmc-hs400-1_8v;
         cdns,phy-dll-delay-sdclk = <0>;
     };
-
-  - |
-    emmc_cqe: mmc@5b000000 {
-        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
-        reg = <0x5b000000 0x400>, <0x5b000400 0x060>;
-        reg-names = "sdhci", "cqhci";
-        interrupts = <0 79 4>;
-        clocks = <&clk 4>;
-        bus-width = <8>;
-        mmc-ddr-1_8v;
-        mmc-hs200-1_8v;
-        mmc-hs400-1_8v;
-        cdns,phy-dll-delay-sdclk = <0>;
-    };

-- 
2.34.1


