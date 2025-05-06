Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D7D265CDF;
	Tue,  6 May 2025 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523389; cv=none; b=GTdGtK8MGWxD4sYc9cpg7R3t8foymKLZF79E57SfKRSkgpDj/MK9V6AJVggqvcmH6Dfhz+HCbH2IkCuPU1E7kQ5+V6BHF/2Pkq6yHam29WHUsjsyYG1XIpgMg0CFoPt/Di++kRqH37WY5c0fNRM0f1Kfcz3K6UXRETB+8+Sj/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523389; c=relaxed/simple;
	bh=6edIhBaoWOfTotZiCQe2Htao2lyDgYNn+iXUNDszYqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGCxM3Z1an8EQm3M80Z4AjEU4u9t8KupsVc4c45B+ei60DMEegsmlhZYimRnCK9pby6cF1+ZrZUjt1c9qG1VtLSU0rauasdeFA8GLf62VQ9NkielsmJZsgB7rUngxOaCzJYspsdDos6w8ORkEUcyBRqW/Fktg7/ZbslExaVFJAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PEXv7FAk; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PEXv7FAk"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C1D7725DAD;
	Tue,  6 May 2025 11:23:05 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zlEt75JLCS3Q; Tue,  6 May 2025 11:23:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1746523383; bh=6edIhBaoWOfTotZiCQe2Htao2lyDgYNn+iXUNDszYqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PEXv7FAkxF4Xaa98EkEnBJK1K56wPSHTU6h3KDcDodfS1SefgI90HkoQkjRXl9ppj
	 8Ix9WzY/s+fAyzLvmbZmP6siIXGYWRDwcIzJGFkPeSRJDkZO8Ibf5aLiX/6QLjRZNJ
	 6tc+AsN4A4FPklIPjI4A/btU9LSUAiYfjqEu8bJU0ajsdEcdxoPMV88wYV151zKhkG
	 bEG++nFZDsrt+hvpkFl8kydzf9S2oEwm74djD07VmMSEkzmwyu11AFrjG82pREBdYZ
	 PU93gdXc9XknOZEzjALI1jmJan6D+/lqWPMUlhXUeK3HRBbQO3qKGmwQU6i6PeOoP8
	 GHF2kerJMDVDQ==
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
Subject: [PATCH v5 1/5] dt-bindings: clock: Add GRF clock definition for RK3528
Date: Tue,  6 May 2025 09:22:02 +0000
Message-ID: <20250506092206.46143-2-ziyao@disroot.org>
In-Reply-To: <20250506092206.46143-1-ziyao@disroot.org>
References: <20250506092206.46143-1-ziyao@disroot.org>
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
2.49.0

