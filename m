Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215F2951B3;
	Fri,  9 May 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796980; cv=none; b=gm/Ou7pqpvgZOSHdVPEkDDBuHK376acbg6dZKMM3hO8NhVcGDZ2f+FbWi6csrywjeYF2MiRYp8ZuPcIOCy8U2nu7zj6wsZrbyeH3CVvGKd9rCOgYADnV8vhOrfENeRvLOuSnj8rJWwIH0pA6+QtajfaKYOIXExr3J5yflT74qyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796980; c=relaxed/simple;
	bh=2iC0S3nNd+mUxS2wD1OXShi88nihnVwChgARpJPrfL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qD165zV3bLamQB+1a9ZWG5QRhgc+tWKQkfbdpqUVbSSNyE+G9gjXtGBYuoqBrji34bC33P2EnbasyLVWSnRTjKR5/koqS/pihBmxr2h0JR03z68Nyb9FEECJrHGfFX7ilJNR9o2qyR6Pc9/dgwWMQWhFlg+In8+IiOgOH5qYGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.147.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C2FAA33BEED;
	Fri, 09 May 2025 13:22:44 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Fri, 09 May 2025 21:22:11 +0800
Subject: [PATCH v3 1/2] dt-bindings: mmc: spacemit,sdhci: add support for
 K1 SoC
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-20-k1-sdhci-v3-1-526c35feaa20@gentoo.org>
References: <20250509-20-k1-sdhci-v3-0-526c35feaa20@gentoo.org>
In-Reply-To: <20250509-20-k1-sdhci-v3-0-526c35feaa20@gentoo.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Alex Elder <elder@riscstar.com>, Inochi Amaoto <inochiama@gmail.com>, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=2iC0S3nNd+mUxS2wD1OXShi88nihnVwChgARpJPrfL4=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoHgGVemjycRD798EDLIseMN4UlE0vM+2DSlz82
 I0cybB3QmCJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaB4BlV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277ddgD/9pAMo/d2xYyKXMYN
 kDwzbfsVs0znb4ntQyiMt+w6koLArY7ejzMbkzL5C6v7AxHKlowrAVV9fBTLqmQwhT8B1I4Ko10
 FGnA0lLhHHBVEyJS/iGtpMuXulUzkw8qEX/GfKfU66Y2JYZ1Z48tRzvoMe+ZaJbeI5JTbBzyPrz
 v/E3rlM9Hdx7LQIYy9MNS6ExWNkSbJWRhRu9WC///Elx5xe2sKe1wGTNbuHXkhdxPSaLaXGslW0
 qdE6oVJk3Ty06B/qPZC+W3+JRfUeD9Pu+BqK44eGE2hcz1h5dTE8KaspwaoU8FlFFrwnT8QT8LK
 q01Wpjj8Bxejz2EKovQJhYAGk8Jv9LRfNaV1YsW+SqwB9jv4KkWVC+rgms0EtcwnDiistPZ06Au
 CChcGKqrohiu1PL7ow0YSGl+ExeLx9aMLYKNohpyicGyCyoJhC9EAYVh6pIZUSIQc95ECWv162r
 TRLp2MM06U9CbzN8mYfVCEBW60eKgRkNUEK9J0S46Zk3UG43MKYXAJPqaed8voRdVKuO+zRF028
 8/StnbKvMpO83AWUqHHBPIFDGm41yUrjlgxeAp2pwXOlczlQNBHFpsyvDyzmZPpVk10U0BIkh/q
 YIL2MpffJx2YwhuHOb4j6TeWQz0B/AynfwXP1sph1CtYNQzrWO3o7X+2SPRxOal7QpQA==
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

