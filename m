Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ABB3307B;
	Tue,  3 Sep 2024 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375400; cv=none; b=s9Xya9neW/A88cZhPsD0sPRRs/7I0BojEFnSGkzQfJ4xkyU4zLweNK/ENmeUATVK3pheZ3rPsZY5I/PFk1GX9s8xPYZiONRQgIdSSP/hE2/d/WfgSSB5KRxeiyCgUVIagC8Mq+gACcbbrA3eMSUoGOVAJE6oAzBavr8RdYhLj20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375400; c=relaxed/simple;
	bh=oquAY0gp1E6SrPL/s5McbZb/UfRoWieflfY++3ZILs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnmFwjPPIqlApYXRXfKIgdy0R1kypEhBeWtKEx2pg3sfGa5S4lX9Qqof8uwSYYLw7+NNejnhzhdMb/Jkg71fGajYDM+//Pz/BBgA4Ti+7ii0x26YfzxynhM0nuhxBbdtezc5oev4E9YMpT/wiqHYo2n+08kywdbS3V9a+EGlb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WV++iYFO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WV++iYFO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725375396;
	bh=oquAY0gp1E6SrPL/s5McbZb/UfRoWieflfY++3ZILs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WV++iYFOIFrWUzpFLIBksWuFG0/1JqdtL386suTHvAYH2NmXggj/z/JPJ21JJmd4L
	 zxyT9UPP6smzbWHAEGhHQ2MhIsQLwsk0o9+uZgWK7Ze6eslhFl8jJ2+zPhVHUz+USt
	 1qc9G9OzA8pi08E/daTL0qBin4E55gcT+0l8vOHTwxz58vEuz1X74NUrW3tc08Lq4p
	 5N9ty6oQvIH8XXlOV1MBxdCRGFTSKrcXsyKseCTN5D5KGcp1bnnmIsFOsmM/UsJPbi
	 NG659bD5+GeB0Ciem0d6LLqMJ+/VUMAuvl5WaqZtNY4Os0c/5npZ7iMc4CeFW8LmIv
	 lPUJYBgFhcD4Q==
Received: from bootstrap.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2D78C17E10B7;
	Tue,  3 Sep 2024 16:56:35 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/1] dt-bindings: mmc: Add support for rk3576 eMMC
Date: Tue,  3 Sep 2024 10:51:36 -0400
Message-ID: <20240903145615.9302-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903145615.9302-1-detlev.casanova@collabora.com>
References: <20240903145615.9302-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device is compatible with rk3588, so add an entry for the 2
compatibles together.

The rk3576 device has a power-domain that needs to be on for the eMMC to
be used. Add it as a requirement.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 34 ++++++++++++++-----
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 80d50178d2e3..84a667f0c526 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -12,14 +12,18 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - rockchip,rk3568-dwcmshc
-      - rockchip,rk3588-dwcmshc
-      - snps,dwcmshc-sdhci
-      - sophgo,cv1800b-dwcmshc
-      - sophgo,sg2002-dwcmshc
-      - sophgo,sg2042-dwcmshc
-      - thead,th1520-dwcmshc
+    oneOf:
+      - items:
+          - const: rockchip,rk3576-dwcmshc
+          - const: rockchip,rk3588-dwcmshc
+      - enum:
+          - rockchip,rk3568-dwcmshc
+          - rockchip,rk3588-dwcmshc
+          - snps,dwcmshc-sdhci
+          - sophgo,cv1800b-dwcmshc
+          - sophgo,sg2002-dwcmshc
+          - sophgo,sg2042-dwcmshc
+          - thead,th1520-dwcmshc
 
   reg:
     maxItems: 1
@@ -35,6 +39,9 @@ properties:
     minItems: 1
     maxItems: 5
 
+  power-domains:
+    maxItems: 1
+
   resets:
     maxItems: 5
 
@@ -97,6 +104,17 @@ allOf:
             - const: block
             - const: timer
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3576-dwcmshc
+
+    then:
+      properties:
+        power-domains:
+          minItems: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
2.46.0

