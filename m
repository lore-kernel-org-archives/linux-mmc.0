Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA53240F75B;
	Wed, 22 Jul 2026 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717194; cv=none; b=THvnUTXzLnSlIuZ+a1BUTqyuGb8g15216R+iUBbPVnvvgf51knrlx26hI75TyyazU3C54XHmhyUS2JmN8sa+6gr+Y4u0mz8fyRa6ZLZ+jgcHhqsKBE9VJi2eVuiT7pLc6PriDGVUqUk6BjlJk6+chS8eFt8rLla1Kt+he5WNvYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717194; c=relaxed/simple;
	bh=UsS+eDtGepxNJpfS9/bGNM8uvx/U3//r9j61bD4Ewm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H6QfPmg4wFSNYcwW8njza7w091D8mg+HU++ikjKnk47EJKihgDhMB+WNS9KSi/UiKT5UtcscEwgKgs6vpDYvRayZJYF4cWtQzMIsy3QloF/vXE7GGKuLg9PjbiymlnZoF+QttY+bMKdShNcC6eRiDyrjbuEvvtu9mrrwIEzJr/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxCbm/xU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxCbm/xU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E665C2BCFA;
	Wed, 22 Jul 2026 10:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784717194;
	bh=UsS+eDtGepxNJpfS9/bGNM8uvx/U3//r9j61bD4Ewm0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pxCbm/xUxWqIJmzZ+QTm9/NDH9c3Mg1MnDuR3c5jKtW9v8YWAjj0/Xr0eJt8SRjOP
	 HP2BwnxcqaJqVYLZGJULicN60UQTkAKkDXZ/iTE/v9Tjhj7DwhMzxdt/CaTVKP0kWq
	 pxn2HkzXmKgbQ7F2sELkuA2rnYp7H2nn1w+n+ghlCs1YPVr+zue1sJ4bkiQFrcVYbO
	 R7mUZk2h/KcKOUnBTdsEWrnMAWC3v1VFGsvSEQTK/mn4mC0B7eSMgClOgcy3xm/k1I
	 8GVBFztABnRiDmej/wpukIkI9iEYLq+koCbRhkHKwPHIj+66g/W+hMTb5tXlSv4xQN
	 uS2BcrB2Sp93w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC44C44539;
	Wed, 22 Jul 2026 10:46:34 +0000 (UTC)
From: Rohan Joshi via B4 Relay <devnull+rohan1sj.cadence.com@kernel.org>
Date: Wed, 22 Jul 2026 16:18:37 +0530
Subject: [PATCH v3 1/2] dt-bindings: mmc: cdns,sdhci: Add CQE support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-cdns_sdhci_cqe-support-v3-1-4412856a4488@cadence.com>
References: <20260722-cdns_sdhci_cqe-support-v3-0-4412856a4488@cadence.com>
In-Reply-To: <20260722-cdns_sdhci_cqe-support-v3-0-4412856a4488@cadence.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mparab@cadence.com, pawell@cadence.com, 
 sjakhade@cadence.com, mpillai@cadence.com, rohan1sj@cadence.com, 
 razb@mobileye.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784717318; l=2038;
 i=rohan1sj@cadence.com; s=20260406; h=from:subject:message-id;
 bh=3c4jIiul3k4zOJgiOZdmt+aBj0CmrIVw3EVAdwc6Stk=;
 b=MYgedew6o5O7v6rUVirmKdMriCt+0bB5jHkLEnZR/9EHtik//mWoif6u1aVN8T5mMV0AwNBSn
 6uM+N2g7UgxCymSTyym4j1KPeSgWhiOvkNdB1a/nFVKp8f8gsLdD3HA
X-Developer-Key: i=rohan1sj@cadence.com; a=ed25519;
 pk=YuwylizMVlVj8I4+VPMZ6xrFR2wyqJAWZyj90OVZgD0=
X-Endpoint-Received: by B4 Relay for rohan1sj@cadence.com/20260406 with
 auth_id=723
X-Original-From: Rohan Joshi <rohan1sj@cadence.com>
Reply-To: rohan1sj@cadence.com

From: Rohan Joshi <rohan1sj@cadence.com>

Cadence host controller can optionally support CQE.
Add optional CQE register space to cdns sdhci bindings.

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


