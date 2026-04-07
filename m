Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D81E31283A;
	Tue,  7 Apr 2026 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775560606; cv=none; b=LaJwt/wfCYf4LY+L6anj/k9FN4QANpfHVMhiAMr1ulhATpBdoHO7w/++v81yrfk0xc9lZdg3pqN+yWApscz52G6RlTMM+yoYNJxb0msxxVqsctY/yc4c3IBOP+sjNeA3IqGkXaqqo6cmqLEDRDMRpJfzOLt0Ei41om4DPXki6hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775560606; c=relaxed/simple;
	bh=q/+Q/SA2lhrHFFOUxEmsDAphRukWcZrvcmEW82UieOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j2SIfYCD9USGpAY2W864yO3g6EElGGFallueG8DdXtrSwW7XxTmM4DY5e8i+ve8sSDjvwz4QzRFHTPkRU5V/wSSZV7Uzq84H4PMWT6Llu5/pL/GJ1YPihdQpriqI/Lyp8kudtwqA1wcWrYFJO6L2wWAZTo7aFKBveQj9xHRKAB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlXF1Lqi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlXF1Lqi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E974BC19421;
	Tue,  7 Apr 2026 11:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775560606;
	bh=q/+Q/SA2lhrHFFOUxEmsDAphRukWcZrvcmEW82UieOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VlXF1LqirstxPAbtuCRgs27skJhRo9tqQxNOlKaGm2gUbfx8Md8y8ch74DNKjr1V2
	 JMJdkGj9WYS2ukTK7PUmJCu+nEfmWMzNBfQ6VKxxvPF3Xx2pD3SVKP6XbRWKPOzDxX
	 VKqAXIC/NItF9NysAnrQslihqtacaSsbtFZVOxBOTm0U9nmPBVn4jWqxSt1IpfkfUj
	 fnx/1J6l4uWU8H6Nf8tf4V2iPESaKqENDTNI6zVNeQrMqjmuEkoLj5t9IQGJeHG51r
	 0gcjIe+ljuc/YfzClDuaGbH4c+k5qsd/eUo2JPoWvK1QUYRir3V6fW7yoYAirxaDiT
	 w29GsHXg3LgXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E0CEDB7FE;
	Tue,  7 Apr 2026 11:16:45 +0000 (UTC)
From: rohan1sj via B4 Relay <devnull+rohan1sj.cadence.com@kernel.org>
Date: Tue, 07 Apr 2026 16:48:20 +0530
Subject: [PATCH 1/2] mmc: cqe: Add CQE DT support for cadence controller
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-cdns_sdhci_cqe-support-v1-1-13efc0810631@cadence.com>
References: <20260407-cdns_sdhci_cqe-support-v1-0-13efc0810631@cadence.com>
In-Reply-To: <20260407-cdns_sdhci_cqe-support-v1-0-13efc0810631@cadence.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Milind Parab <mparab@cadence.com>, 
 Swapnil Jakhade <sjakhade@cadence.com>, 
 Manikandan Pillai <mpillai@cadence.com>, rohan1sj <rohan1sj@cadence.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775560710; l=1838;
 i=rohan1sj@cadence.com; s=20260406; h=from:subject:message-id;
 bh=2Nj43iUADBM6GdTZZUu58CP25EFDyw5xiqmEYK92Vd0=;
 b=nkSD9fkbW9vT4GqqWqXoFMbK5JQFU/fqX4Xm9VfD4l2exop9Us/vV5je4LEJrlWRnzxc/GpjC
 HDyWZUi/5W0BjyCFmIddTaO8zl07qhjNZW0WIC7jeGoetIA0SevFhFy
X-Developer-Key: i=rohan1sj@cadence.com; a=ed25519;
 pk=YuwylizMVlVj8I4+VPMZ6xrFR2wyqJAWZyj90OVZgD0=
X-Endpoint-Received: by B4 Relay for rohan1sj@cadence.com/20260406 with
 auth_id=723
X-Original-From: rohan1sj <rohan1sj@cadence.com>
Reply-To: rohan1sj@cadence.com

From: rohan1sj <rohan1sj@cadence.com>

Add DT config required to support CQE as present in
cadence eMMC host controller

Signed-off-by: rohan1sj <rohan1sj@cadence.com>
---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml        | 32 +++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index ac75d694611a..c0d8aefe20c2 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -24,6 +24,10 @@ properties:
     minItems: 1
     maxItems: 2
 
+  reg-names:
+    minItems: 1
+    maxItems: 2
+
   interrupts:
     maxItems: 1
 
@@ -139,7 +143,19 @@ allOf:
     else:
       properties:
         reg:
-          maxItems: 1
+          oneOf:
+            - items:
+                - description: Host controller registers
+            - items:
+                - description: Host controller registers
+                - description: CQE (Command Queue Engine) registers
+        reg-names:
+          oneOf:
+            - items:
+                - const: sdhci
+            - items:
+                - const: sdhci
+                - const: cqhci
 
 unevaluatedProperties: false
 
@@ -156,3 +172,17 @@ examples:
         mmc-hs400-1_8v;
         cdns,phy-dll-delay-sdclk = <0>;
     };
+
+  - |
+    emmc_cqe: mmc@5b000000 {
+        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
+        reg = <0x5b000000 0x400>, <0x5b000400 0x060>;
+        reg-names = "sdhci", "cqhci";
+        interrupts = <0 79 4>;
+        clocks = <&clk 4>;
+        bus-width = <8>;
+        mmc-ddr-1_8v;
+        mmc-hs200-1_8v;
+        mmc-hs400-1_8v;
+        cdns,phy-dll-delay-sdclk = <0>;
+    };

-- 
2.34.1


