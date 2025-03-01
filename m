Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F121DD526;
	Sat,  1 Mar 2025 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740825835; cv=none; b=i/9c12ip4XTZErA2InH87bzW0phtlgUA3cc9uxDqnjO/ljQKkAu+Xcarx/EqxWxjbwAMY5+jwt8/+mmgbMfqQat2q6KoniB5KkdgdLA5U5rNkDh5Qp76QCOGGdS5QQFTqxZbI5fiRt1dQVlr2EspAbfK37pZm2248/Gs093PelM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740825835; c=relaxed/simple;
	bh=zwk+LtszMoHSIYjGCAqbuOU0QSVYlP5K54ulz6VjFyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLvqP4Ga8i+2wArRiNgotyzj0gYTPsKc2gE1Y7mQqKdQHMqLp9F5ljffrsWavkV3NNKX8lk1yKR1piecSyjRyigLO/GAVSZEQe1mlR6ZxZGJKbC4S/EXtoY1YiANk45U8OpcEeHWrMwMzmTEnKO/ETHtGSCOdG6N2pce46tFiAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=WpKLDJjj; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="WpKLDJjj"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 21B4825D15;
	Sat,  1 Mar 2025 11:43:52 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ygrvAjcF8kzO; Sat,  1 Mar 2025 11:43:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740825831; bh=zwk+LtszMoHSIYjGCAqbuOU0QSVYlP5K54ulz6VjFyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WpKLDJjjycL5YphH8xb4T8i/1U35DpB9hvkImbiqAVf8w4H8Y7C4N/E+csmPuEuKu
	 KsCz0FZWc2l1JIQSCfrMHT2M03HFnDsDN4hd6SQAAi4mGe7GEBc1ic7OJ7nLHp52xn
	 WG9+gWc48PQy60j85cE7+1fnjquWnUNp/bLiCZN8YtZ62z2fCI7ZsThU0QZtbLPYPJ
	 DTtIAZkMnHGRu2RXnQ0wgJdHphnGZFpI4wiywJCgn7yaDiYjggOPvKvtf3XWoHBjks
	 IeWsZ1I1gN+6kbMc98oyvCjxHepKZu1J6DDt3i6jMVgWRTAC1MbwT2OzbzMpRGAmLx
	 ml4//om/geNWQ==
From: Yao Zi <ziyao@disroot.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 4/8] dt-bindings: clock: Add GRF clock definition for RK3528
Date: Sat,  1 Mar 2025 10:42:46 +0000
Message-ID: <20250301104250.36295-5-ziyao@disroot.org>
In-Reply-To: <20250301104250.36295-1-ziyao@disroot.org>
References: <20250301104250.36295-1-ziyao@disroot.org>
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

