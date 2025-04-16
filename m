Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5EC24BBF8;
	Wed, 16 Apr 2025 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804970; cv=none; b=V0srfVzJxQS030yg/p4YyXeC189uFv7KaKVuDf0BbH0uAI7FA4x9NqeW1VX+H+RAAPgn8lBtCmapdMcOx6KvuKZVkcb48ayFcc1Vw4ik9hvkTuMZtYG/nwfq//7l/gvTOTZPOU5XnXb2c/K8UFxd6MTHrQyhOEBA1ByH3RzmWfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804970; c=relaxed/simple;
	bh=2lD/ft0CpNxmzJrbrqzSOdijVqDR3GRIlsEJ5QJz18I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWC6XgFfpi6Jm3EZRg/m7DG4dilvaiohQItrW3ksQaaOW6RGYPTa0qUSlFxiugY0Wd5IHswGOfR5+2CYiYXjSsibrbY6kSmtoLR1RBTv1IbkuOaO7GWTE9ZQIAVGHKOKkJYaxlZojm8QcUSw5GaJXGI7kNugfmDmtDHPYlqyVQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MGKOQyMf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MGKOQyMf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744804967;
	bh=2lD/ft0CpNxmzJrbrqzSOdijVqDR3GRIlsEJ5QJz18I=;
	h=From:To:Cc:Subject:Date:From;
	b=MGKOQyMfSZq2dVPxH2P3SEffDZWZUoUxkeOtuEml3PPr7ceMJgm+l9bKNGjaC8Sry
	 FkgQ699ZSSUUtqlT34KBbGbPfPYU/Dv8VeDNg+xATD4CGOgqyMheHEHddMiTb9oUQI
	 kuxRf/p4YQHGYaW/qpflFAvY6tgIT2S+pk/BSAHfUfFY4PQiDhEX6jrBEwrwUkEDEw
	 jiybXZnoBHM134OW3CihDZ42dIFfdw6lz9WUZRo2wKbU1rD2LybIZJXO3LxZsehPso
	 hUqFNYbDPSKX1gF7xJFq0iXXCEz+YwR+0gwKWyJd2FHyt97Q7GPsIzNWfq9v4uaH8f
	 6/YWJ7G1ba4eQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6602E17E35EB;
	Wed, 16 Apr 2025 14:02:46 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chaotian.jing@mediatek.com
Cc: ulf.hansson@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenbin.mei@mediatek.com,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] dt-bindings: mmc: mtk-sd: Add support for Dimensity 1200 MT6893
Date: Wed, 16 Apr 2025 14:02:45 +0200
Message-ID: <20250416120245.147951-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible for the MediaTek Dimensity 1200 (MT6893) SoC.
All of the MMC/SD controllers in this chip are compatible with
the ones found in MT8183, but do also make use of an optional
crypto clock when enabling HW disk encryption.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index 0debccbd6519..6dd26ad31491 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -32,6 +32,7 @@ properties:
           - const: mediatek,mt2701-mmc
       - items:
           - enum:
+              - mediatek,mt6893-mmc
               - mediatek,mt8186-mmc
               - mediatek,mt8188-mmc
               - mediatek,mt8192-mmc
@@ -299,6 +300,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - mediatek,mt6893-mmc
             - mediatek,mt8186-mmc
             - mediatek,mt8188-mmc
             - mediatek,mt8195-mmc
-- 
2.49.0

