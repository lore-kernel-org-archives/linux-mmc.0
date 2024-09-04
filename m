Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F39C148304;
	Wed,  4 Sep 2024 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481927; cv=none; b=JKG4dT93amceIEPl7NLOl4ktdJh1Pfmin761D8VWm5Tb63yddwjxOr0RB6/mWEKFtvLsY3vOtuQdVK6N0Db8sVMhxCDoAk8LelgLXKTw1X8X5ZCdp/GnoihAYB7bsQiZ7YtQ4DxftpwtuvuIr54qMJaVvAx+imhJWjxXFTTOSzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481927; c=relaxed/simple;
	bh=BOpPOteOgOAfROk0/u+2xBJl3CQ/Rfkyo13BDvqI1CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvaSqvWb6jDBfI/EUxehJeppQNqA2EyFLBCeoMNe9HzoA9RttoimJGgAtxfkU4xBEAYrdymuMaNjnNjjjrV7+lpObE86Sdty5JIPbgSXQuvjqiU5gTYczl1TLTAVbrB01N7bzL15NkBSgDW2/gOMb6uHlXoamKx9ZdK7uC/dxaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TPVYrQ3k; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TPVYrQ3k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725481923;
	bh=BOpPOteOgOAfROk0/u+2xBJl3CQ/Rfkyo13BDvqI1CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPVYrQ3kORi5yxgH2XtCdkiuEIH5Y5ct3xeWBiy3qLVdynDBIc6yxIXxnuQJ9Pih7
	 Duq3LiFy1BSVunjPem9jDvPVCfF4cPzizi2FOQvxtfjK3MpjhXk3odmRikEeezHco6
	 e5bvlGX1zb5qb5ve2VUvMQX9W8bgpmyhp0Yt11jjK0iw/qGIiyxidS/xrBS4TWRSgS
	 4k63VWtHTVhqkyDl5IM6YIA6HlpDU3QDcnAuWEggv8tedyhSUqtmXuWsdSfd3c8+Ey
	 M+6p4by8KriklxuxvxyER2M0RVUs+J9FGzZhLh+pDhE3Jcs2HCw+dfIHzgLU5FTF1U
	 fxvRsue5tijcQ==
Received: from bootstrap.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EFE1217E0B18;
	Wed,  4 Sep 2024 22:32:01 +0200 (CEST)
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
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v4 1/1] dt-bindings: mmc: Add support for rk3576 eMMC
Date: Wed,  4 Sep 2024 16:30:58 -0400
Message-ID: <20240904203154.253655-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904203154.253655-1-detlev.casanova@collabora.com>
References: <20240904203154.253655-1-detlev.casanova@collabora.com>
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
---
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 37 +++++++++++++++----
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 80d50178d2e3..c3d5e0230af1 100644
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
 
@@ -97,6 +104,20 @@ allOf:
             - const: block
             - const: timer
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3576-dwcmshc
+
+    then:
+      required:
+        - power-domains
+
+    else:
+      properties:
+        power-domains: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.46.0

