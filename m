Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A641F2E4274;
	Sun, 19 Oct 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760874794; cv=none; b=W5T2XtetGnASAdFsME+WjhBAtA2BN+VxsqJwISlTlmV7i6gtauE7ZzGlFv4u0nZJmGOMCT3pPGYyv7iRo8AfS/R4ImBuf7fxlnZBovKDFgn1BfbxbSjUfLS65cgiVXIcbAQaCGLMYuIMEXrtaKU2dmL1FfFDYWee1TCjMZapsT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760874794; c=relaxed/simple;
	bh=sDW89jNy0IdOGVAN2W7BI2wZuL27rXm7OI9loBvaoBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rM0mLgtCd67bcbSkjsSDN4kwOrpEC/xnvbv2dnzl4X0d6UWqfq4y06XVUP7cMchc0z1WIWZN5x3guIrmJvj0ok/9vsumFqMztnQsJyV556ibb6HjgG9xsQqpWAy7Hhvhcbx44N7+LwYtDyuU1emdMnuW8K9krsDYNTb5RanXjOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005154LT.eswin.cn (unknown [10.100.73.96])
	by app2 (Coremail) with SMTP id TQJkCgBnBpUJ0fRoNUQYAQ--.7701S2;
	Sun, 19 Oct 2025 19:52:47 +0800 (CST)
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
	hehuan1@eswincomputing.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/2] dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin EIC7700
Date: Sun, 19 Oct 2025 19:52:38 +0800
Message-ID: <20251019115238.320-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20251019115133.300-1-hehuan1@eswincomputing.com>
References: <20251019115133.300-1-hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgBnBpUJ0fRoNUQYAQ--.7701S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr45ZF17Jr48tryruFW7urg_yoW5Jr1fpa
	95GFZrGr1fJr1fZw48J3Wvk3W3t3Z7Jr1Yyr17Jr43JanYqFyUtrZIkwn8Ka45CFyxXFya
	9ay2vry5Aa42vr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBq14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiBT5PUUUUU==
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/

From: Huan He <hehuan1@eswincomputing.com>

EIC7700 use Synopsys dwcmshc IP for SD/eMMC controllers.
Add Eswin EIC7700 support in sdhci-of-dwcmshc.yaml.

Signed-off-by: Huan He <hehuan1@eswincomputing.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 57 +++++++++++++++++--
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index f882219a0a26..7e7c55dc2440 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -30,6 +30,7 @@ properties:
           - sophgo,sg2002-dwcmshc
           - sophgo,sg2042-dwcmshc
           - thead,th1520-dwcmshc
+          - eswin,eic7700-dwcmshc
 
   reg:
     maxItems: 1
@@ -52,17 +53,30 @@ properties:
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
 
+  eswin,hsp-sp-csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to HSP(High-Speed Peripheral) device
+          - description: Offset of the stability status register for internal
+                         clock.
+          - description: Offset of the stability register for host regulator
+                         voltage.
+    description:
+      HSP CSR is to control and get status of different high-speed peripherals
+      (such as Ethernet, USB, SATA, etc.) via register, which can tune
+      board-level's parameters of PHY, etc.
+
+  eswin,drive-impedance-ohms:
+    description: Specifies the drive impedance in Ohm.
+    enum: [33, 40, 50, 66, 100]
+
 required:
   - compatible
   - reg
@@ -110,6 +124,37 @@ allOf:
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
+            - const: axi
+            - const: phy
+            - const: prstn
+            - const: txrx
+      required:
+        - eswin,hsp-sp-csr
+        - eswin,drive-impedance-ohms
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

