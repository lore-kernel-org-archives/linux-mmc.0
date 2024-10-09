Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514A513634C;
	Wed,  9 Oct 2024 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492955; cv=none; b=eOjxVMSLc0ttl5xACXX19yYdUUJoGjVhqTx60xQqpOe3U8qIlcwJD1qVfw7oPvPEFzBovG6kJxvw2+FcuCuGOEksgj1FD3shj+Hqkca40iFd/5G07yzhggPGulRJXvhyE1tFpwU5L2G0bbs79aNxO9H1+UNGajPYVoPh4dX0vKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492955; c=relaxed/simple;
	bh=tfa6LVidkn/9cRXA9RJD87R8zMWIboFISCfLK7Cps6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCJAjVTKmTsHhUXwjUUd8W9kdhSDAaA6FmPk/72qcTlFbm0Ws0kb+5LozMZPVoQU+ctcPQOWQ+zx5l/GzkagAAn2dn5gU9/FeAl9MYM4nibBVBARXtX8vTbpqy4OH6DJlpCRHr2zookOhM/5/HcIGV4GCaOfE/O6yRE05Rrw4ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=Y1ff18U0; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Y1ff18U0"
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout3.routing.net (Postfix) with ESMTP id 5B6E26166E;
	Wed,  9 Oct 2024 16:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1728492952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoeJuySVhg+mmM+pa9MiXw+rnOgF1Rwkix0HnxJwfrk=;
	b=Y1ff18U0ZhCacPpVdUmC/yzs9sXTwitx/8LRYJJicOcSWYHbWM/WiRA6WTG24Iw4k+Vzij
	anu2mCSN5u0N2T3YgK+shwrRwasa6ooVZ9aEWqeDw+RFsgEg5oYEAfFWzIo0tIPy9YhU5b
	pIwVhAQVEzPwTk01liyhl8IPh4LEmyQ=
Received: from frank-u24.. (fttx-pool-217.61.150.182.bambit.de [217.61.150.182])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 750E51006CA;
	Wed,  9 Oct 2024 16:55:51 +0000 (UTC)
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
Subject: [PATCH v3 1/2] dt-bindings: mmc: mtk-sd: Add mt7988 SoC
Date: Wed,  9 Oct 2024 18:55:41 +0200
Message-ID: <20241009165547.5959-2-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009165547.5959-1-linux@fw-web.de>
References: <20241009165547.5959-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 87771506-25b3-4f4d-8bef-9c43895fea05

From: Frank Wunderlich <frank-w@public-files.de>

Add binding definitions for mmc on MT7988 SoC.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v3:
- fixed minItems on clock-names too
v2:
- fixed minItems to 4
---
 .../devicetree/bindings/mmc/mtk-sd.yaml       | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index c532ec92d2d9..bec0577b7508 100644
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
+          minItems: 4
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

