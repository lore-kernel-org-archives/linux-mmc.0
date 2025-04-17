Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311572522B3;
	Thu, 17 Apr 2025 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900637; cv=none; b=DsLQE2+6ESvieaN/Ax8F2jt8SO4ERPumVAyEIjy2g9lKjP44Zn+O6OHpqFq5g94rkfj7EZfnSQQlYo33gfDCsRFxqNMww0Gi4KwTy3XTW0OrXyTNikwpwuCGW6n8sAtpfMckQVNKQ9u8ISzK9/sQjdtVLURmdYK1NV2tupCi2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900637; c=relaxed/simple;
	bh=6edIhBaoWOfTotZiCQe2Htao2lyDgYNn+iXUNDszYqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9WeNNBL/CdDvE9gv3Irvh9hHlXRZQ5V9ym+bJZJm1uS3f3fBfmYw+/+Mbu46T4KhsqkH1zXokBFAtzb8bpJSWlhCdO9/twLp2um1Oy5EOybPA4QNmrij2OKTfgtrR/yUMpxPHBAe4akpladRZZVfM72/gcfebypvBLpGieO4GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=WgQSCRhH; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="WgQSCRhH"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5940725984;
	Thu, 17 Apr 2025 16:37:13 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JHofJYrXWWn4; Thu, 17 Apr 2025 16:37:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1744900632; bh=6edIhBaoWOfTotZiCQe2Htao2lyDgYNn+iXUNDszYqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WgQSCRhHb3j6VTjSb7tAJl7FuhzDXhX21D04crHYaG2JOAxw2rx5kgcWY047ydd5C
	 vjgUXdhfcX1B8CfGHrRSI0H4beVeA+vGXTqbA9KxVtSsIvU7TlArqb/83633nnM7WZ
	 vCsURFm17faiN6K/nEOQWNw7OjV60A06Rqb19Y3ks2iOSqDX6BHpk0eAt010NoznfT
	 TAN3WPRqDl6xcardsY7P8D+P4Gw8dKG1BzBdKQstI9NKkIVL7sgh7u8N04BXH760/1
	 D8pihXbzU6ekDe4eV7j/6OXZrx5OGMle1DqvT0oKjGw/mAIZteNh8rAnDqiS7QjCOd
	 tMJie+Pv0THSg==
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
Subject: [PATCH v4 1/5] dt-bindings: clock: Add GRF clock definition for RK3528
Date: Thu, 17 Apr 2025 14:36:43 +0000
Message-ID: <20250417143647.43860-2-ziyao@disroot.org>
In-Reply-To: <20250417143647.43860-1-ziyao@disroot.org>
References: <20250417143647.43860-1-ziyao@disroot.org>
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

