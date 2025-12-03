Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511722E0B59;
	Wed,  3 Dec 2025 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762349; cv=none; b=D2ZvkqLYcv8tolRbNts/BDS15DBk0yNM1CPKh7jaDvA5rozUIi1yzZmjRcfRbMEZArpcK+F4roOmxA/vmxFxhyFZwCc1mjSRBPTWN4FG9+SHYUnVRkxJxH2qwz1tO1VRqilsEi8fKJ7lem5xmw6hIS6e3R5LsP7XDX8vTslVK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762349; c=relaxed/simple;
	bh=rSrS/g3GzIPfmw34zxW71s8tJc9N+7opnT4NQUPvLbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PZmRRCgJbSQZ5TNVwGSDaiNSAxBBC28z17s7bOiKA0nhZquV37am7jJMDsnmgmeQx6p78421KDLPRokvwa5TbefaNk+54lpPezPl3z7VbAV/LFisNuv7yKI2Ino+uRo3Nv2IcfdKhdIbvKjenMlIVt4rMeFUv6SzNRsuAoMEA/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kUIP8m03; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kUIP8m03"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764762345;
	bh=rSrS/g3GzIPfmw34zxW71s8tJc9N+7opnT4NQUPvLbs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kUIP8m03uVX3YSkENNi5EZ9TI0ShKToihyvXNkhsKuGWkf9B4oEYeHoRdyZ/irGN+
	 KHs0/oSDbnRpTltz83vxJxrUyFofIZH72R0Ug9Kf0vv3JIiIRFMfDHpfG/xDoHq8Uz
	 9X2BBYqi1/StLLB1Who3syAAcJoP0DB3LB0sf2AuE9b3i589Udcubh++27YErifIxi
	 1X6vUvDxVev3gYRtPeypYtHM2P9tldNbHzKd40XuIK1moa+IjHKlVn8wbWYrHWk5ox
	 8giMK9u6cps6JpTE1yJMPaKnuPhsmSYDZiwvYq59OXZYTlVKxlAiyJE+H416umVzTq
	 whGHDNq75H1GA==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F1DBA17E1339;
	Wed,  3 Dec 2025 12:45:44 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 03 Dec 2025 12:45:34 +0100
Subject: [PATCH 1/3] dt-bindings: mmc: mtk-sd: Add support for MT8189 SoC
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-mt8189-add-mmc-support-v1-1-f5ce43212fe9@collabora.com>
References: <20251203-mt8189-add-mmc-support-v1-0-f5ce43212fe9@collabora.com>
In-Reply-To: <20251203-mt8189-add-mmc-support-v1-0-f5ce43212fe9@collabora.com>
To: Chaotian Jing <chaotian.jing@mediatek.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Wenbin Mei <wenbin.mei@mediatek.com>
Cc: kernel@collabora.com, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764762344; l=1508;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=rSrS/g3GzIPfmw34zxW71s8tJc9N+7opnT4NQUPvLbs=;
 b=qLmM9GZBF3m4ar3KUTOZb9GLigL1SpHLreXl0Q6p5wNsluo9feCpmh2tnL9pj5Hc2vU5b+qcK
 /V9eWbtSqbWARtj8OPkzNOQb95BKu4x7Yi34jDqPq2o5Le2P3WyCEyC
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add a new compatible for MMC IP in MT8189 SoC.
Even though this is partially compatible with the one found in MT8196
SoC, the MT8189 SoC register layout has some slight differences and
additional features.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index 6dd26ad314916a3e40cf55ff69a7d93ed63dbdd4..eb3755bdfdf7e001602c3eb870898275085df3e6 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -25,6 +25,7 @@ properties:
           - mediatek,mt8135-mmc
           - mediatek,mt8173-mmc
           - mediatek,mt8183-mmc
+          - mediatek,mt8189-mmc
           - mediatek,mt8196-mmc
           - mediatek,mt8516-mmc
       - items:
@@ -192,6 +193,7 @@ allOf:
             - mediatek,mt8183-mmc
             - mediatek,mt8186-mmc
             - mediatek,mt8188-mmc
+            - mediatek,mt8189-mmc
             - mediatek,mt8195-mmc
             - mediatek,mt8196-mmc
             - mediatek,mt8516-mmc
@@ -240,6 +242,7 @@ allOf:
               - mediatek,mt7986-mmc
               - mediatek,mt7988-mmc
               - mediatek,mt8183-mmc
+              - mediatek,mt8189-mmc
               - mediatek,mt8196-mmc
     then:
       properties:

-- 
2.52.0

