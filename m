Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6535B186E2E;
	Sat, 12 Oct 2024 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728743927; cv=none; b=OXlu/uUJQ9FQFspSUTFxOW4sHSuXhwzT+MvVejHda1PgJwOppdmwJ0y3qo8De81Y7Rd0fY1PSxmrn4I08pgvtXvpNT5U1Cpzk8pUlaw7Uy+ZKs4yWca0PA1rlB1qKrxjRYwqw+jMIrcm+td9tkR1fCLw/7o/DStSfaMc5VQ5lcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728743927; c=relaxed/simple;
	bh=09kIYuGGp88LopxrY4/emGax05kQ+XlgIJJ/psxjw1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIrSHVaIsmaDllOFb55CKjXCZw72pc0qzKXKPu9tcVCdwZwQFL8coxku1WaxyOuVFmFa6FkfYT0AaJ7myfWTh+WP0Op8qmEMRW+QAWr6cglT8YUy+ULFZh3Oxb5J35emWcuiCmKrt7jy1sqZUP2IZRxR3uYjM6Kte9e2lQAY2fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=UNyd+OKN; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="UNyd+OKN"
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
	by mxout4.routing.net (Postfix) with ESMTP id BC341100305;
	Sat, 12 Oct 2024 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1728743917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UaDhF10SS6RhxqXi+RrAJwgaKwDFw9LZ+vBZFwz0rD4=;
	b=UNyd+OKN5i7UKNGbpU5QvhGkG18ZWX2nM+oOivTQx7bcmYRwy6Q93B6qiP6dVetPy3ekIp
	T87veGPabnrMqRlpgOec2XuPiYnHGbZE9ZX3YCi2EE51bIqvdLZn0EyP4Yz4HBG/Pbjf0x
	szfuxTKoVEpMLkZembHabWCSYsfotcA=
Received: from frank-u24.. (fttx-pool-217.61.155.16.bambit.de [217.61.155.16])
	by mxbox1.masterlogin.de (Postfix) with ESMTPSA id C790940192;
	Sat, 12 Oct 2024 14:38:36 +0000 (UTC)
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
Subject: [PATCH v4 2/2] mmc: mtk-sd: add support for mt7988
Date: Sat, 12 Oct 2024 16:38:23 +0200
Message-ID: <20241012143826.7690-3-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012143826.7690-1-linux@fw-web.de>
References: <20241012143826.7690-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 81c63b52-cdcf-46c0-90ed-8ce7b26ea792

From: Frank Wunderlich <frank-w@public-files.de>

Add support for mmc on MT7988 SoC.

We can use mt7986 platform data in driver, but mt7988 needs different
clocks so for binding we need own compatible.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
changes:
v4:
- explain mt7988 compatible with mt7986 platform data in commit description
v3:
- reuse mt7986 platform data instead of copy
---
 drivers/mmc/host/mtk-sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 89018b6c97b9..aaf27fd211c1 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -629,6 +629,7 @@ static const struct of_device_id msdc_of_ids[] = {
 	{ .compatible = "mediatek,mt7620-mmc", .data = &mt7620_compat},
 	{ .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
 	{ .compatible = "mediatek,mt7986-mmc", .data = &mt7986_compat},
+	{ .compatible = "mediatek,mt7988-mmc", .data = &mt7986_compat},
 	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
 	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
 	{ .compatible = "mediatek,mt8183-mmc", .data = &mt8183_compat},
-- 
2.43.0

