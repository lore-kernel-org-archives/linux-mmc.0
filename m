Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091C214A09E;
	Sun,  9 Mar 2025 05:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741499691; cv=none; b=qn1G0uDnCQvjyHYXK91Ja8jYgnFLyyMsdS2RSSZavI+OmCUOg5XvCVPIJ9iEMuNidEV0KFD7MaB4JmxfjZTibLrp/mjVIgx//IdpuxlUQJCBH8b8/l9V/4Ru++MhTiRvxLZDlOa6KFMgY7j2dUB4rc9vlPX0GT14vPFk/ktpn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741499691; c=relaxed/simple;
	bh=hoZkBR56sD6NFx4a8yX3ETRtAM+INGPus9jC5Fe/z+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFNLIuXIxpyEp4hqdE61Yfuio1iDv7HVZWdCE6bsksSS1fgepBtAqdTtqhtvnYTF0BCtQMa8OGHrA4uyUTpBImxOeGDZn+dwSRG8NY2psHAJ3ivKrzfXpXrBzLNqkXH5g33CEcMCVDatOdxb07+MO7bRCkcHutPZmVB5wYdhReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ilixXpBt; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ilixXpBt"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 828F325DB4;
	Sun,  9 Mar 2025 06:54:47 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Q0W_tnWplUN; Sun,  9 Mar 2025 06:54:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741499686; bh=hoZkBR56sD6NFx4a8yX3ETRtAM+INGPus9jC5Fe/z+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ilixXpBtHHCKnyjWHRbhaNVWJGAavEiuU+qNmZ5wvKdvvhOsRy9sSKJyb0Ix79XIY
	 pg2RUPOMayMomKz4ZdICAf8JZkND6WBZQ6WJJlikvklAi/hw3gfx8PXIgrQNsGq9Ov
	 bm48DXzDwCvkecXp/Tk2ZyPM1rYIQYAnmiNiyFrnbwUxmF60h+3Va/e2x88ETziP7S
	 Za7GyUY75gPww3EGEDLM1j73umJ0AcHiI7s1kCr/eD5RRIO/ln87rKFhwUOjIjZqtC
	 UcTvXWPaZFNd5g1Nz/C5dJcjPL7nWcKxmzISJzO5CTXHe7Wew3G5WEjzW08mojo2ee
	 L1s1/tr4YhEgw==
From: Yao Zi <ziyao@disroot.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/6] dt-bindings: clock: Add GRF clock definition for RK3528
Date: Sun,  9 Mar 2025 05:53:44 +0000
Message-ID: <20250309055348.9299-3-ziyao@disroot.org>
In-Reply-To: <20250309055348.9299-1-ziyao@disroot.org>
References: <20250309055348.9299-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These clocks are for SD/SDIO tuning purpose and come with registers
in GRF syscon.

Signed-off-by: Yao Zi <ziyao@disroot.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/clock/rockchip,rk3528-cru.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/clock/rockchip,rk3528-cru.h b/include/dt-bindings/clock/rockchip,rk3528-cru.h
index 55a448f5ed6d..0245a53fc334 100644
--- a/include/dt-bindings/clock/rockchip,rk3528-cru.h
+++ b/include/dt-bindings/clock/rockchip,rk3528-cru.h
@@ -414,6 +414,12 @@
 #define MCLK_I2S2_2CH_SAI_SRC_PRE	402
 #define MCLK_I2S3_8CH_SAI_SRC_PRE	403
 #define MCLK_SDPDIF_SRC_PRE		404
+#define SCLK_SDMMC_DRV			405
+#define SCLK_SDMMC_SAMPLE		406
+#define SCLK_SDIO0_DRV			407
+#define SCLK_SDIO0_SAMPLE		408
+#define SCLK_SDIO1_DRV			409
+#define SCLK_SDIO1_SAMPLE		410
 
 /* scmi-clocks indices */
 #define SCMI_PCLK_KEYREADER		0
-- 
2.48.1

