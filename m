Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D3722CBC9;
	Fri, 16 May 2025 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387041; cv=none; b=U7tnjCNgtOrp60Qu+hPJC4U2j59q5qBJ2G2c6pSadz14vc/UtIXzd1KmlgZGIqFG2nsC3mJ/H7J1ruPPmcyZBONUW/tDO/8+mL6X8/ZXEli2mcEGlinsDClig+NfHa3Ij8X07r2hGbDCmE8XVdJ5xVHfEgJAZ8sz+h3vNi8xa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387041; c=relaxed/simple;
	bh=xJfQfSHH/0PyHDRDTuD+QGC9oCH7IyYYHmP0zFExXzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PGqgEbVlZyYcBlQQt2zfH1UvDWOPge6djZ7OUt1g/YpML8OBI+Qhu7hcCuMAnpgxrsTVhz33sL7U2Wr+6wonQFgQtjmVb1tI2+yzI7fRNAJmXUWOHXAQRrlK6qoWShNBGzqZJkEv//H2xb4aE9E77oKuKAPH7O7VEqXVqetUwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app2 (Coremail) with SMTP id TQJkCgAXqZKEAidohNF8AA--.49748S2;
	Fri, 16 May 2025 17:16:54 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: ulf.hansson@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	adrian.hunter@intel.com,
	p.zabel@pengutronix.de,
	shanchun1218@gmail.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	xuxiang@eswincomputing.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: [PATCH v1 1/2] dt-bindings: sdhci: eswin: Documentation for eic7700 SoC
Date: Fri, 16 May 2025 17:16:50 +0800
Message-Id: <20250516091650.832-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20250516091259.774-1-dongxuyang@eswincomputing.com>
References: <20250516091259.774-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAXqZKEAidohNF8AA--.49748S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1UKFWfJF48Kr17Gw17Wrg_yoWrWFyDpF
	4xGw1UAr1fXF1fua1rKw10kF1agan8GF1IyrnrXw1Yy3WYgFy0qw1ayFy5Ga4UAr1xZay3
	XFyY934xAa17AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUXJ5wUUUUU=
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

Add device tree binding documentation for the ESWIN
eic7700 sdhci controller module.

Signed-off-by: Xiang Xu <xuxiang@eswincomputing.com>
Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
---
 .../bindings/mmc/eswin,sdhci-eic7700.yaml     | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/eswin,sdhci-eic7700.yaml

diff --git a/Documentation/devicetree/bindings/mmc/eswin,sdhci-eic7700.yaml b/Documentation/devicetree/bindings/mmc/eswin,sdhci-eic7700.yaml
new file mode 100644
index 000000000000..d4826f2aa619
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/eswin,sdhci-eic7700.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/eswin,sdhci-eic7700.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ESWIN EIC7700 SoC SDHCI controller
+
+maintainers:
+  - Shuang Liang <liangshuang@eswincomputing.com>
+  - Xuyang Dong <dongxuyang@eswincomputing.com>
+
+allOf:
+  - $ref: /schemas/mmc/mmc-controller.yaml#
+
+properties:
+  compatible:
+    const: eswin,eic7700-emmc-sdhci
+
+  reg:
+    maxItems: 1
+    description: Common configuration registers
+  "#address-cells":
+    const: 1
+  "#size-cells":
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+  assigned-clocks:
+    maxItems: 1
+    description: should contain "core_clk" phandle + clock-specifier pairs.
+
+  assigned-clock-rates:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    description: handles to clock for the sdhci controller.
+
+  clock-names:
+    minItems: 2
+    description: the name of each clock.
+
+  clock-output-names:
+    maxItems: 1
+
+  '#clock-cells':
+    enum: [0]
+    description:
+      With this property in place we will export one clock
+      representing the Card Clock. These clocks are expected to be
+      consumed by our PHY.
+
+  resets:
+    description: resets to be used by the controller.
+
+  reset-names:
+    description: names of the resets listed in resets property in the same order.
+
+  bus-width:
+    enum: [4, 8]
+    description: for emmc bus-width is 8, for sdio bus-width is 4.
+
+  eswin,hsp_sp_csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: hsp_sp_csr regs to be used by the controller.
+    items:
+      - description: phandle to HSP_SP_CSR register block
+      - description: status register offset
+      - description: control register offset
+      - description: configuration register offset
+
+  eswin,syscrg_csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: syscrg_csr regs to be used by the controller.
+    items:
+      - description: phandle to SYS_CRG_CSR register block
+      - description: status register offset
+      - description: control register offset
+      - description: configuration register offset
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - assigned-clocks
+  - assigned-clock-rates
+  - clocks
+  - clock-names
+  - clock-output-names
+  - resets
+  - reset-names
+  - bus-width
+  - eswin,hsp_sp_csr
+  - eswin,syscrg_csr
+
+unevaluatedProperties: false
+
+examples:
+  - |
+
+    sdhci_emmc: mmc@50450000 {
+      compatible = "eswin,eic7700-emmc-sdhci";
+      reg = <0x50450000 0x10000>;
+      interrupt-parent = <&plic>;
+      interrupts = <79>;
+      clocks = <&clock 554>, <&clock 546>;
+      clock-names = "clk_xin", "clk_ahb";
+      assigned-clocks = <&clock 554>;
+      assigned-clock-rates = <200000000>;
+      clock-output-names = "emmc_cardclock";
+      #clock-cells = <0>;
+
+      resets = <&reset 7 (1 << 6)>,
+        <&reset 7 (1 << 3)>,
+        <&reset 7 (1 << 19)>,
+        <&reset 7 (1 << 23)>;
+      reset-names = "txrx_rst", "phy_rst", "prstn", "arstn";
+
+      core-clk-reg = <0x51828160>;
+      disable-cqe-dcmd;
+      bus-width = <8>;
+      non-removable;
+      mmc-hs400-1_8v;
+      max-frequency = <200000000>;
+      eswin,hsp_sp_csr = <&hsp_sp_csr 0x1038 0x508 0x50c>;
+      eswin,syscrg_csr = <&sys_crg 0x160 0x148 0x14c>;
+      status = "disabled";
+    };
-- 
2.17.1

