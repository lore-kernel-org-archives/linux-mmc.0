Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8733F1EE014
	for <linux-mmc@vger.kernel.org>; Tue,  1 Apr 2025 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743502148; cv=none; b=tKBij+JMA988EsgZM8bEvRfNdEvy3Tw9aGiTv3nslMvJclnpI/ju0fAE6qYoNPo2xS4k8k1fcBYj+WtqtD4lLZp4cUQBKVK1IZIosEzMZ0h1LQUWwanBfqI6wWffksYiUKfkpcC8kA7STnFVQckaMYp/61M7sgJoKVNXIOY1JNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743502148; c=relaxed/simple;
	bh=36NpNNjl13Ta26IFroNQ5oZqlcqeSHwUikkx136LO0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sliXvu386YUujFRRixDA1aIh9dzfE04Uvw/dB7Phegf8sL2E6WaP0tVpBSaQmQUFXInjEXEXlIrbU0PeOsf57vDqV24nPA/PTLXs+FQJmg1RTHQ9+r9F9xmdySrCR5E4c6SLmH4nd8joZXmNwSt2oGPLPD7eE2OoDWj1tQr9JlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=LMxgxRvZ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="LMxgxRvZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=O5+o6l2k86+lZW
	Qt3e6g6NmW2sXi4Hdxu8WkqElZOe4=; b=LMxgxRvZyoiOV4kxj9OiGpfLKit4B1
	pQE5QvbgPUmy1GcL7RgCDskw6F7+lP+ADbmPMUOp6Vpp8y6WrIQekQCcL6Si5Cb2
	JZfsOGGuYC9YZq8k/JzXPVuudxRgOYvWhZLOalnfjom9lQYgGHpw3g2Eznlv6J/P
	B/YtrMJKn0W7S7Lj1Mu3hD26kPkckBXELeWQVUvs6Mf4oEqwAuM8U3g+LojtUx6P
	+5Q2oZiDbMHy2YEWIJH1llg8GpatHMaPMrvkYBBPm8QkK6Vc8jOBaEXVJfss2810
	wSG6MY/ZC06yQCnrOLH4hcGeq3OvTlyziNf/y/LeAcgrt0Ym/M+8W/gA==
Received: (qmail 1562725 invoked from network); 1 Apr 2025 12:09:04 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Apr 2025 12:09:04 +0200
X-UD-Smtp-Session: l3s3148p1@qS73ubQxnOsgAwDPXwSgADIEZgbhJYA3
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: arasan,sdhci: Add Renesas RZ/N1D
Date: Tue,  1 Apr 2025 12:08:37 +0200
Message-ID: <20250401100837.29792-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This instance has a wakeup irq defined. It is currently not used by the
driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../devicetree/bindings/mmc/arasan,sdhci.yaml | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 9075add020bf..7c59def3326e 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -38,6 +38,15 @@ allOf:
             - items:
                 - const: clk_out_sd1
                 - const: clk_in_sd1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rzn1-sdhci
+    then:
+      properties:
+        interrupts:
+          minItems: 2
 
 properties:
   compatible:
@@ -45,6 +54,10 @@ properties:
       - const: arasan,sdhci-8.9a                # generic Arasan SDHCI 8.9a PHY
       - const: arasan,sdhci-4.9a                # generic Arasan SDHCI 4.9a PHY
       - const: arasan,sdhci-5.1                 # generic Arasan SDHCI 5.1 PHY
+      - items:
+          - const: renesas,r9a06g032-sdhci      # Renesas RZ/N1D SoC
+          - const: renesas,rzn1-sdhci           # Renesas RZ/N1 family
+          - const: arasan,sdhci-8.9a
       - items:
           - const: rockchip,rk3399-sdhci-5.1    # rk3399 eMMC PHY
           - const: arasan,sdhci-5.1
@@ -109,7 +122,15 @@ properties:
       - const: gate
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: int
+      - const: wkup
 
   phys:
     maxItems: 1
-- 
2.47.2

