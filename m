Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F7F213E67;
	Thu, 13 Feb 2025 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444360; cv=none; b=NUe4ehpWPsHn75igwHiBV7Q55e6LXS/xUg+a0ZGVIBcXJ3fnY8aDGp0uauKtseYYwHLP2NsOvuOE5gxIErZVl8QWaXOneXSFllRllNGhlCHzzvZIJD8Zej4lUkVIasXWJKKv7hd8Ls6gfbJyTcco4GqDalI8ZbK9EtnPbUqlY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444360; c=relaxed/simple;
	bh=egbAKOn8wm4RHq9b1iC6xWk9F3swpvX7oZ6TfTqCnRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hHkC4VtqvtFHjdaPnozR+ev3uhvWie5+akghnKr6yRe+KWAJuowwBSp7bDje5jnHWWBDMhJ/vSiz10mXb1uQ//uiH9m2Xv6yXDBr503IaF2asQ1li6gkViufTfJzV0PCKh3XpaSgg0EB60F5+blvin6ebgxNwKnUOhVsMz2u3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [180.172.76.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 62467342FDD;
	Thu, 13 Feb 2025 10:59:15 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 13 Feb 2025 18:58:24 +0800
Subject: [PATCH RFC 1/2] dt-bindings: mmc: spacemit,sdhci: add support for
 K1 SoC
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-20-k1-sdhci-v1-1-1f4362a980cd@gentoo.org>
References: <20250213-20-k1-sdhci-v1-0-1f4362a980cd@gentoo.org>
In-Reply-To: <20250213-20-k1-sdhci-v1-0-1f4362a980cd@gentoo.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1764; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=egbAKOn8wm4RHq9b1iC6xWk9F3swpvX7oZ6TfTqCnRQ=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBnrdB4AZt7G8OD8FJOGOpwPmgt1Y9hFr+BLnupP
 Xe1j1KdkKeJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZ63QeF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277a5eD/9pV8qh7pr3c71VkM
 nviNR3UgrXDSTSTU3BHz794uCz7+kUDVmutQHUQsUrOLd3SZGfq5Y4uCbzLmRCnutwkJfxtd+ss
 fi7bgS/sklEhN5MWLMg6VKuqAObUgWJnK07JVrqpIY3yZOpmf5hjLV4/6yimNCAL8HN2WIEypOs
 slMsolFu+wSGt17/wCwMh84MmcDDplxYMNPsaLYVBPb5vK2HfU5Tesvza5zxgi9x059amXqE86Q
 anLzy2i0eSUl5bK1sbQV//puwzAkSMumOghtWxe7GvHAWXT0V41mKlCf5Ycd6fm9r3QRzUH4Bfn
 BEn/zTOELKqzx6hmx3MpUHvETviLbj2pyvMrGoxPwq2hVUUJ3qGfO+uNYxEYpO8WRWWrc/39NYF
 mE/H2zIdjR7U+9iXr9yV9uSLZ5AofJdUk3tFAIofNr1TbC4rcB22Bgmow6NQ9eg3PRVkKsxKLCu
 ebcUbTFvjfjyOHcchVfVlpA2qzUQtxCH9coGPOsGCLfCP4R1TIOHY10VZ1zqjv+NE+C2CUQe8eh
 MNadzGsuWvcIEPjLwmMPwymOZ7vA62goAPlkLEKtptL58s0t9agzuA/pQo/Tgb0L4TFdoKRuleF
 nAdQLyKBFBAXhXTSjtO6mQ/THk8YORjz6pRPPfI/agt0reAG7TAPhR+bb84nKWP9VZag==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Add support for the SD/eMMC Host Controller found in SpacemiT K1 SoC,
The controller supports data transmission of MMC, SDIO, SD protocol.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 .../devicetree/bindings/mmc/spacemit,sdhci.yaml    | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..13d9382058fbc1c12be1024d1c550f04a825673c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/spacemit,sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT SDHCI Controller
+
+maintainers:
+  - Yixun Lan <dlan@gentoo.org>
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    const: spacemit,k1-sdhci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: core clock, used by internal controller
+      - description: io clock, output for SD, SDIO, eMMC device
+
+  clock-names:
+    items:
+      - const: core
+      - const: io
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@d4281000 {
+      compatible = "spacemit,k1-sdhci";
+      reg = <0xd4281000 0x200>;
+      interrupts = <101>;
+      interrupt-parent = <&plic>;
+      clocks = <&clk_apmu 10>, <&clk_apmu 13>;
+      clock-names = "core", "io";
+    };

-- 
2.48.1

