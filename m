Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE2028690;
	Wed,  1 Jul 2026 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917080; cv=none; b=Ca6EutYZibuEIev/ONP2IWf1d0J3+uN7G1dKUoz2OSqb3U68xV58yMZZ+Yj6GRqYh+x/LkT8HsJ2LLFdva3CBYq+iSpQSWL7eeWcHkZtiZfhEXiM1qvbONj9cF1H72ouxm6ldG/JpHbtPTl3GCjfiDRxaEXCZ7Mct/ySUGHyrcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917080; c=relaxed/simple;
	bh=tZpKvDZlB9soTN2cRNYslYLJsX+eIX7hVXfQ9nGwd0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eyjTSNkskom3Pem/cG4cT4razhTMf+ymiympu5Zpy7QUg5Kf/O2yUi8DaV3YKc0Xix3bR+2r7++7sgGcU5K0OuF4F5hw/WLkAkrPhb/JIbvOZs1iOQYoTr7z/vW9p6jgDG9r7gclWhDTgEDS4CvL1dFOJEnRdGX/MvpPnHXSqMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ahvtcu2+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ahvtcu2+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782917077;
	bh=tZpKvDZlB9soTN2cRNYslYLJsX+eIX7hVXfQ9nGwd0A=;
	h=From:Date:Subject:To:Cc:From;
	b=ahvtcu2+VeacQEEnG2Z9NQn0diy7la11Hcl2KEf2sgGq/j7HRTT4rHKdXgCTfZetO
	 ja4hjssoV/1uQNj8/yX55ylPiD5W5nOOkTf71xbEQqBb2FgVUne9If6kpJ4iWaXYeC
	 AJNwpQD+BoSKmG3gzoyBkMQxZBuw3b1PAQhOoJkpzOj+DTbR1wyq37Xt90Br6Kf8w9
	 ZIVKKrxf2mncfR3cg9GVV29PD7S40/g/zdpNIJ7vfevy4t0+oV71egPLCYj4cbeZNA
	 VI/nByVlEnM6ygC3Rr1azb8cMlcqYrVD8qRtw/HXO/0Vvv+YMUzH6T190OkHareIU1
	 860VNJn2/KtqQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BD83517E010F;
	Wed,  1 Jul 2026 16:44:36 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 01 Jul 2026 16:44:26 +0200
Subject: [PATCH] dt-bindings: mmc: mtk-sd: Document extra clocks for MT8189
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-mt8189-mmc-dt-bindings-fix-v1-1-e75f241a275b@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQ6DIBAAv0L23E3ABop+pfEgsLV7AFvAxsT49
 xI9zhxmdiiUmQoMYodMPy68pAbqJsC/pzQTcmgMneyMfEiFsVple4zRY6joOAVOc8EXb9i87r3
 VQTsDLfDJ1PQZf44XZ/qu7VEvCW4qhH6JkesgEm0Vz4+5SxiP4w+tXqFVnQAAAA==
X-Change-ID: 20260701-mt8189-mmc-dt-bindings-fix-18959c85d5b6
To: Chaotian Jing <chaotian.jing@mediatek.com>, 
 Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Wenbin Mei <wenbin.mei@mediatek.com>
Cc: kernel@collabora.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782917076; l=2496;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=tZpKvDZlB9soTN2cRNYslYLJsX+eIX7hVXfQ9nGwd0A=;
 b=jpUjw2cMbJ5XQ8Hgo+osXrEb0d7+wM28LWJl7HBta3RRWAk5YSnysdJl0DTb/Q6tKUOTeYHEs
 8v0hP9nJkNiBkEMG/qS3JbXHVtsOMi6E/HTv6eAiPBuLkCprOb3JYiy
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

MT8189 SoC MMC Controller IP has 4 additional clocks.
Describe them in the dt-bindings for this SoC.

Fixes: 7514f64780a4 ("dt-bindings: mmc: mtk-sd: Add support for MT8189 SoC")
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
The patch is based on linux-next tree (tag: next-20260630) and has
been tested on Mediatek Genio 520-EVK (MT8371) and 720-EVK (MT8391)
boards with board hardware enablement patch series.

Additional note:
There is currently no use of "mediatek,mt8189-mmc" compatible in
Mediatek board devicetrees.
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 29 ++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index eb3755bdfdf7..a4d032224dce 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -193,7 +193,6 @@ allOf:
             - mediatek,mt8183-mmc
             - mediatek,mt8186-mmc
             - mediatek,mt8188-mmc
-            - mediatek,mt8189-mmc
             - mediatek,mt8195-mmc
             - mediatek,mt8196-mmc
             - mediatek,mt8516-mmc
@@ -348,6 +347,34 @@ allOf:
             - const: axi_cg
             - const: ahb_cg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8189-mmc
+    then:
+      properties:
+        clocks:
+          minItems: 6
+          items:
+            - description: source clock
+            - description: HCLK which used for host
+            - description: independent source clock gate
+            - description: bus clock used for internal register access
+            - description: peripheral bus clock gate
+            - description: AXI bus clock gate
+            - description: crypto clock used for data encrypt/decrypt (optional)
+        clock-names:
+          minItems: 6
+          items:
+            - const: source
+            - const: hclk
+            - const: source_cg
+            - const: bus_clk
+            - const: pclk_cg
+            - const: axi_cg
+            - const: crypto
+
 unevaluatedProperties: false
 
 examples:

---
base-commit: ba7c57499e5999aeae8dd4f954eb2600589d80aa
change-id: 20260701-mt8189-mmc-dt-bindings-fix-18959c85d5b6

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

