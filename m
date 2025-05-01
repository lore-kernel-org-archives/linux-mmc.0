Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606F1E5B6F;
	Thu,  1 May 2025 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746089458; cv=none; b=N2t2qluCN7QHrzyIQAydzj6Yp1/MawAlHrFkAZtr5QM6pZMQ4VUhGNi3FN39XbGvhB+TwShzmsh4fwzjZ5TItxZeJPdBb1n/Yziq84viTZ3/V2kGByDi4QQW08XFf3REutkIbFvAcufbhs2oQfjd0YueHKQx4tHqbeMK0gt6ckw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746089458; c=relaxed/simple;
	bh=2iC0S3nNd+mUxS2wD1OXShi88nihnVwChgARpJPrfL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m01G/+y4mjTmuWNWMOYION2OxrvA5kKedRg9dpLqGH59glOXCGLrjZ1lfJhBXMOXhwzKIIQwfxRxD9v2ZEAO/CHbJ/LJxj+skUlXjEU0dsBZdkDNF+aL1pnblXJC0hcTphmIfB1iClgPRBl1N3mNDM93WHPeb7rkL10kYcKpyPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.147.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 9A481340C3C;
	Thu, 01 May 2025 08:50:53 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 01 May 2025 16:50:21 +0800
Subject: [PATCH v2 1/2] dt-bindings: mmc: spacemit,sdhci: add support for
 K1 SoC
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-20-k1-sdhci-v2-1-3e7005fae29b@gentoo.org>
References: <20250501-20-k1-sdhci-v2-0-3e7005fae29b@gentoo.org>
In-Reply-To: <20250501-20-k1-sdhci-v2-0-3e7005fae29b@gentoo.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Alex Elder <elder@riscstar.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=2iC0S3nNd+mUxS2wD1OXShi88nihnVwChgARpJPrfL4=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoEzXiuB0ELTpd5KRo4ZYc3gHUYBPUWI1gWZiSh
 E0pyU+rQWyJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaBM14l8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277a7dEACTjn9pJJadovd5+Q
 rwW+FN/GXE5c+FD9XZdTooCbh2UWFqYTnLn5JLV8AMNC7Vyu8WfxAwZrUYljh5R3BfX9mbPi1PH
 2xF547ZuZ866Xyl7vvz52MrbomqqitTWYAQRpeXAu3feV1MLfR+n9cmKpyI+ZXz/Jiiu8M87BbZ
 GZo9MOyBWvZ17wIYWZKb8htp9pDbZDlbHasWfVUSbTdWNrRpKp4HG1AtD/nVVOQZt1880RHtLaQ
 s0pXq2O6bIGiKO377a30Kza2VsoL5HDzKSJbWPdpLAtoy+Ec19owaFM0CYD7Lb2OKdY0gW0XRA8
 TU/tZuU18overqzQfvqe0BFT3SKZlwbfSMVQaHODgNC7oRpPIKfjJoHvVmY8LDFBrzX9Jf5GhPe
 IHl00YLoIm8hbSUdyGa0LIjVfF3gqtf3ZSfhUP/l7xjBDVH6OPWnX6KKo5tmEADeOtBWVdcE9gK
 RexZ9kIIecwrgvZEmHHRmelgsDLfe2Um2KWWcG7FliBr2R4nO582keIMn5kHZDSk0Wpz5v/7p55
 gyb2OFh1sQOIwjik9/zAi+i30cMAQUCg/7PAWYnEwz7RqZrcATNnoZlX8315mZ5pncYoZ2RkHuZ
 SY+p7jq2xA128dIRoMPeLfn+PDSTvQ0NbpY7qRNOFdsn2P78glJ0gXdBN/0NHgajDynQ==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Add support for the SD/eMMC Host Controller found in SpacemiT K1 SoC,
The controller supports data transmission of MMC, SDIO, SD protocol.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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
2.49.0

