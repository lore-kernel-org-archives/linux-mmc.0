Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E43FA5FC;
	Tue, 25 Aug 2026 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787656134; cv=none; b=X/dGpB+q5+X2H4mQs5ZKK4JXtTKAf5xiPTJek2zPWZdUZ/zPiViRKi/p5jP9dLKkZ7IfRjK8ymkIoDep7F9k+a7bJk5B21d5XWD0O3ZUtfbmqJQlDaUKg/UxImRpVnV9YoxW9+MA3sVB3Vx7GDYpRyJsD0ANLZMh2FLCmyJ3IIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787656134; c=relaxed/simple;
	bh=TUIgN/sa9/6uBBWA4LxoxB40C8FVlYaGtN9aNjYFVCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=neJ06Hkiz/nNW5lY2Zyu7o6yTO4cU+70wqppxCT5hGICXE3HU9UUquwL815boziqtjJrNlT0i2w6fr2y6oMOgA0IWomQ0ys6QChnupALSIz5ZkOUWeCx5m5JHsk/ITTOhZoOGEJnsh3JrklUGfekypfBegviVhEOieiIV/P5LyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+MtPpva; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+MtPpva"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56F02C2BCC7;
	Tue, 25 Aug 2026 11:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787656134;
	bh=TUIgN/sa9/6uBBWA4LxoxB40C8FVlYaGtN9aNjYFVCw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=D+MtPpvaXUuzdrihiMmS9LOSPa1ry+oI/z5de1G2pJif0qg6kGwzOLmOydUMVN8qL
	 4V6PwaXkHBgY2os3OwEtsC7R4PLlxGz5ItIFrSHnFGjfkdG9XmhxFwgJBdqMe9nTnZ
	 qcpczR1l0lBBMlRBmSS1XWXaxiCyJnbNI/+yabgA/2MsE2TZtPe5PuwZyV03KTF7fq
	 afUW1mm7KA5PJazDCtLri8BXL0vahmMpBawzUSekXKHYycvYjiHsR4wsnNsP4M1Bk8
	 igaC9S9S6nvBjDiSRdO715jBu9LAw71CXu8WGcAVzvAy5ZFL34LZnjhdf6PYuU86Uz
	 I+1cizRJhLkpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AF6C61DBD;
	Tue, 25 Aug 2026 11:08:54 +0000 (UTC)
From: Rohan Joshi via B4 Relay <devnull+rohan1sj.cadence.com@kernel.org>
Date: Tue, 25 Aug 2026 16:40:57 +0530
Subject: [PATCH v4 1/2] dt-bindings: mmc: cdns,sdhci: Add CQE support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-cdns_sdhci_cqe-support-v4-1-e9f72e338373@cadence.com>
References: <20260825-cdns_sdhci_cqe-support-v4-0-e9f72e338373@cadence.com>
In-Reply-To: <20260825-cdns_sdhci_cqe-support-v4-0-e9f72e338373@cadence.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: Rohan Joshi <rohan1sj@cadence.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mparab@cadence.com, pawell@cadence.com, sjakhade@cadence.com, 
 mpillai@cadence.com, razb@mobileye.com, blarson@amd.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787656261; l=2483;
 i=rohan1sj@cadence.com; s=20260406; h=from:subject:message-id;
 bh=tnxL6P/kgvSIMtCk+Ymrqyu224na2jvLAY8/B+g5f2g=;
 b=hxGduSniPK0Ou//Q34vXOH5FohiuZGGh6AbxKHkphdv3d7T4+J9rperQnanY5J8R2XvQRTftb
 h9nPjVbKuJ7Ac3Z9wUST+0qOdx/JVCvyTa6w1OUwEmIgjQp6wFciuzp
X-Developer-Key: i=rohan1sj@cadence.com; a=ed25519;
 pk=YuwylizMVlVj8I4+VPMZ6xrFR2wyqJAWZyj90OVZgD0=
X-Endpoint-Received: by B4 Relay for rohan1sj@cadence.com/20260406 with
 auth_id=723
X-Original-From: Rohan Joshi <rohan1sj@cadence.com>
Reply-To: rohan1sj@cadence.com

From: Rohan Joshi <rohan1sj@cadence.com>

Add optional named resource "cqhci" to map the CQE
register space. When present, it is used for CQHCI
initialization and enable Command Queue Engine for eMMC.

The "cqhci" space is optional to maintain compatibility
for platforms that don't have CQE block. When absent, the
controller can operate without the CQE block as routined.

Update amd,pensando-elba platform to include this resource
since Elba does have hardware block required for CQE! The
original author for Elba, Brad Larson (blarson@amd.com)
was able to confirm the CQE support.

Signed-off-by: Rohan Joshi <rohan1sj@cadence.com>
---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml        | 28 +++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 6c7317d13aa6..10bc9ac2073a 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -22,7 +22,14 @@ properties:
 
   reg:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: hc
+      - enum: [bctl, cqhci]
+      - const: cqhci
 
   interrupts:
     maxItems: 1
@@ -131,13 +138,27 @@ allOf:
     then:
       properties:
         reg:
+          minItems: 2
           items:
             - description: Host controller registers
             - description: Elba byte-lane enable register for writes
+            - description: CQE (Command Queuing Engine) registers (optional)
+        reg-names:
+          minItems: 2
+          items:
+            - const: hc
+            - const: bctl
+            - const: cqhci
     else:
       properties:
         reg:
-          maxItems: 1
+          items:
+            - description: Host Controller registers
+            - description: CQE (Command Queuing Engine) registers (optional)
+        reg-names:
+          items:
+            - const: hc
+            - const: cqhci
 
 unevaluatedProperties: false
 
@@ -145,7 +166,8 @@ examples:
   - |
     emmc: mmc@5a000000 {
         compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
-        reg = <0x5a000000 0x400>;
+        reg = <0x5a000000 0x400>, <0x5a000400 0x060>;
+        reg-names = "hc", "cqhci";
         interrupts = <0 78 4>;
         clocks = <&clk 4>;
         bus-width = <8>;

-- 
2.43.0


