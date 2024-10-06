Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D3A184554;
	Sun,  6 Oct 2024 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728228899; cv=none; b=Ast0dtMT7r4AH8Ase+yXxWHf8jT83CDoTK0aE6EczYu54sArgIIWp+gU31oglHw51M6hh5Xe1XR2vzkYetSewGr045YBf5vqswoUGX0DDIYvt70clIR4XYbxbV2ii7HX2Nx800SH+ZZ+SKXQbgJ6outzsJw5eXYsHyLkpux9LW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728228899; c=relaxed/simple;
	bh=k+cFr7TI2yE1hu8/1qye7rUvFig0LJNomXF3W9J6aIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t32f59bxxiGsRMkFi2Gn3Fg30VuxNrih2Q8Nr1hMXAvbHbxYxZFkhBcKtVp/uSaxLdZCY5SfyTZewIbll/sXH2ybqIXVDkDQq/Vhnv6uOjn0A1ccue0BG4paUFXViXnYdpAXbQ2OtXT3HLMy6GzDr1zXcWeb7agKJ5AI3eYzFZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=PFNfzz9g; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="PFNfzz9g"
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout2.routing.net (Postfix) with ESMTP id 8F6955FB2B;
	Sun,  6 Oct 2024 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1728228894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IWeFgd5hlsv2/xyaiRcsDg8tz/JqEjHhkgHy+35HE3s=;
	b=PFNfzz9gQNsGqn8hMC00Sq3iLT+1E2H89S1dQFOZjsQcDqKlgfob+vsaWQzAcYwHLDxJp2
	DfrKU2koOH2HQHoSuOUmI3QPg8BCq8a8HL7oE8nyshniKdlq0GuV3sr+LWNSY26oBQkLX0
	L6K9IcJjXO9Rltzwbcl5d9AOAEUCeqM=
Received: from frank-u24.. (fttx-pool-217.61.153.101.bambit.de [217.61.153.101])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id C844C1006B2;
	Sun,  6 Oct 2024 15:34:53 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wenbin Mei <wenbin.mei@mediatek.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	daniel@makrotopia.org,
	john@phrozen.org,
	eladwf@gmail.com,
	ansuelsmth@gmail.com
Subject: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Add mt7988 SoC
Date: Sun,  6 Oct 2024 17:34:45 +0200
Message-ID: <20241006153447.41377-2-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241006153447.41377-1-linux@fw-web.de>
References: <20241006153447.41377-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 41a1ca86-a817-4286-a596-c271918febff

From: Frank Wunderlich <frank-w@public-files.de>

Add binding definitions for mmc on MT7988 SoC.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v2:
- fixed minItems to 4
---
 .../devicetree/bindings/mmc/mtk-sd.yaml       | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index c532ec92d2d9..7380f72ea189 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -21,6 +21,7 @@ properties:
           - mediatek,mt7620-mmc
           - mediatek,mt7622-mmc
           - mediatek,mt7986-mmc
+          - mediatek,mt7988-mmc
           - mediatek,mt8135-mmc
           - mediatek,mt8173-mmc
           - mediatek,mt8183-mmc
@@ -263,6 +264,29 @@ allOf:
             - const: bus_clk
             - const: sys_cg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt7988-mmc
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          items:
+            - description: source clock
+            - description: HCLK which used for host
+            - description: Advanced eXtensible Interface
+            - description: Advanced High-performance Bus clock
+        clock-names:
+          minItems: 3
+          items:
+            - const: source
+            - const: hclk
+            - const: axi_cg
+            - const: ahb_cg
+
   - if:
       properties:
         compatible:
-- 
2.43.0

