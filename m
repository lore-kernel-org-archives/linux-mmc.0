Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2591A255A;
	Wed,  9 Oct 2024 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492956; cv=none; b=ShqwLv8CA8CsSHiOmlxpqfs57VSWIPwqKTlauc+A6GhHd1B/BQf5wyxboiUCswz2wpiRid+mQ/NsV5FV4LRUYW6B9ggRbbTHYF06AsfJOa5BuR0UPX7BFEZGLHwg/iPiGnvGR7vOyAKgmOFnKj0Reb/G7t2nJVnKGE5ZF+AqtxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492956; c=relaxed/simple;
	bh=DEi1cBSFHKuZs2fumvcXnBwnFPPwKC0cx8YDDRfHkWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWBd0pYz6TGPZpFrb8S9nglwuAA6RxBc+lii53qddMoKTg4CudMIgbwwUp8ebkV6JgJvNWn5p4iwLujjM5fDPFSPSU5A4bRRBN7HxSah/fCuOGmAjVDEr3oTbAYNQpxj9P9SGvKUOt50mah83RHN1rxq803WGrJQxnTg9qhXmP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=nPwcRHUE; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="nPwcRHUE"
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout1.routing.net (Postfix) with ESMTP id 39BBD4105D;
	Wed,  9 Oct 2024 16:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1728492953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xvumcaz9LMidfFIP90W2O23YVGZiQ4aWOQ5hzZZ1KJ8=;
	b=nPwcRHUEdi6VOFAYuJfqkaRKXg+zoRGehoAnpSu8pmhXdrkaodzkaKgLCZA/artmtNARhU
	TOPz4uu6OIu9KUog53WqrKHvvYp3nv1LnZVl8hifc03gpgOHRrI29Qv0gHsTqjlGH/MlsE
	rITFFt3dFttNChPQadjUARm8CHdnzvk=
Received: from frank-u24.. (fttx-pool-217.61.150.182.bambit.de [217.61.150.182])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 4F06310030B;
	Wed,  9 Oct 2024 16:55:52 +0000 (UTC)
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
Subject: [PATCH v3 2/2] mmc: mtk-sd: add support for mt7988
Date: Wed,  9 Oct 2024 18:55:42 +0200
Message-ID: <20241009165547.5959-3-linux@fw-web.de>
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
X-Mail-ID: 4d18607f-4818-410b-874c-06e44f110b2b

From: Frank Wunderlich <frank-w@public-files.de>

Add support for mmc on MT7988 SoC.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
changes:

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

