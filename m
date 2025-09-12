Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF92211A09;
	Fri, 12 Sep 2025 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669860; cv=none; b=WPBchnoaEEE/bOoXPyKiKHXkBnZidVvNLgsya7ZbXAAvoNlleKqyAuKmHLEN2Lr5wggJnc4Pl2HNaZXOD/X3Rf8nNRg49q22mIrLgByXJhpdqyHp/DroQAdaCvAynIF5FCsX/XioI1Bla0IQJZX+czoHB364Gy9mvv7dPKuZHck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669860; c=relaxed/simple;
	bh=d3Xz5EpHIWdV7OLbNRXvXBeYGZWMR4ewhEs6jhMcR7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSZ0hSQM8JVXXIaNaokGfvFkUNqKVfgbS9bsKepJ1YmZpcBspgzleDcWqeOBFZAhbOOUv4dxbQ/TFSvFdS3P2XWhrc6trfsYAvn5fEBbdITolMV0tWu7pu5QU0BhME2e4h/ePCoGSstmqxeqfba8xByb4QZCp97XkjzZWhxgsS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005154LT.eswin.cn (unknown [10.12.96.103])
	by app1 (Coremail) with SMTP id TAJkCgDnCxLM6cNoRM7OAA--.64219S2;
	Fri, 12 Sep 2025 17:37:18 +0800 (CST)
From: hehuan1@eswincomputing.com
To: ulf.hansson@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jszhang@kernel.org,
	adrian.hunter@intel.com,
	p.zabel@pengutronix.de,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	xuxiang@eswincomputing.com,
	luyulin@eswincomputing.com,
	dongxuyang@eswincomputing.com,
	zhangsenchuan@eswincomputing.com,
	weishangjuan@eswincomputing.com,
	lizhi2@eswincomputing.com,
	caohang@eswincomputing.com,
	hehuan1@eswincomputing.com
Subject: [PATCH v2 1/2] dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin EIC7700
Date: Fri, 12 Sep 2025 17:37:13 +0800
Message-ID: <20250912093713.142-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250912093451.125-1-hehuan1@eswincomputing.com>
References: <20250912093451.125-1-hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgDnCxLM6cNoRM7OAA--.64219S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw15CF17XF1kXr15Zr1UKFg_yoW5Cr17pa
	ykJ3y7Gr1fJF1fZw4Ut3WkC3W3Kan7Jr1Yyr17Jr13Jan0qFy8tFWak3Z8Ka45CF1xZaya
	gayUuryfAw12vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRuHqcUUUUU=
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/

From: Huan He <hehuan1@eswincomputing.com>

EIC7700 use Synopsys dwcmshc IP for SD/eMMC controllers.
Add Eswin EIC7700 support in sdhci-of-dwcmshc.yaml.

Signed-off-by: Huan He <hehuan1@eswincomputing.com>
---
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 81 +++++++++++++++++--
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index f882219a0a26..e0f34bc28e0c 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -30,6 +30,7 @@ properties:
           - sophgo,sg2002-dwcmshc
           - sophgo,sg2042-dwcmshc
           - thead,th1520-dwcmshc
+          - eswin,eic7700-dwcmshc
 
   reg:
     maxItems: 1
@@ -52,17 +53,51 @@ properties:
     maxItems: 5
 
   reset-names:
-    items:
-      - const: core
-      - const: bus
-      - const: axi
-      - const: block
-      - const: timer
+    maxItems: 5
 
   rockchip,txclk-tapnum:
     description: Specify the number of delay for tx sampling.
     $ref: /schemas/types.yaml#/definitions/uint8
 
+  clock-output-names:
+    maxItems: 1
+    description:
+      The name of the clock output representing the card clock,
+      consumed by the PHY.
+
+  '#clock-cells':
+    enum: [0]
+    description:
+      Specifies how many cells are used when referencing the
+      exported clock from another node. This property indicates
+      that the clock output has no extra parameters and represents
+      the card clock.
+
+  eswin,hsp-sp-csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - description: Phandle to HSP(High-Speed Peripheral) device
+      - description: Offset of the stability status register for
+                     internal clock
+      - description: Offset of the stability register for host
+                     regulator voltage.
+    description: |
+      High-Speed Peripheral device needed to configure internal
+      clocks, and the power.
+
+  eswin,syscrg-csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - description: Phandle to system CRG(System Clock and Reset
+                     Generator) device
+      - description: Offset of core clock control register
+    description: |
+      System Clock and Reset Generator device needed to configure
+      core clock.
+
+  drive-impedance-ohm:
+    description: Specifies the drive impedance in Ohm.
+    enum: [33, 40, 50, 66, 100]
+
 required:
   - compatible
   - reg
@@ -110,6 +145,40 @@ allOf:
             - const: block
             - const: timer
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: eswin,eic7700-dwcmshc
+    then:
+      properties:
+        resets:
+          minItems: 4
+          maxItems: 4
+        reset-names:
+          items:
+            - const: arstn
+            - const: phy_rst
+            - const: prstn
+            - const: txrx_rst
+      required:
+        - clock-output-names
+        - '#clock-cells'
+        - eswin,hsp-sp-csr
+        - eswin,syscrg-csr
+        - drive-impedance-ohm
+    else:
+      properties:
+        resets:
+          maxItems: 5
+        reset-names:
+          items:
+            - const: core
+            - const: bus
+            - const: axi
+            - const: block
+            - const: timer
+
   - if:
       properties:
         compatible:
-- 
2.25.1

