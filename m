Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A8325485F;
	Wed,  5 Mar 2025 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203798; cv=none; b=jt/fEUYBNPWCQL1mlbzae841Me6TD7eeW8X0O3QPOZa9NX37bx4fUzGyx8CsQrelQY3sqybV+Qn5M/TPHX5YLGALhjl96Ir7MPjKh0+2VWTXEndxb7UBSDRdMctQeu8USxVipD2kJOvDqUQj/M+12cYhNcWOEbLJyUxRrE+BBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203798; c=relaxed/simple;
	bh=zwk+LtszMoHSIYjGCAqbuOU0QSVYlP5K54ulz6VjFyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrV1dPppOmfC1yb0zlnWOLpFAARmLiCcWulh+rCU3z/xFh9Q/Bgmbf8B/eeqMVwlIbmSPpWLpRGNBIDxl47BOu+y2xQf9Y0j9GqNt2R1i+lYk85UIAugNZon1TiWs6s3ZtyDcN8vA5VpsfXMXQrQFK6SU8gccEDJz2Nx/YXDyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=dMOyrpQq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="dMOyrpQq"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E157A2027D;
	Wed,  5 Mar 2025 20:43:15 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id digvX98RG3a5; Wed,  5 Mar 2025 20:43:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741203795; bh=zwk+LtszMoHSIYjGCAqbuOU0QSVYlP5K54ulz6VjFyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dMOyrpQqgPQSf1wp0pYbJprF2EN5v9yjL9wWhs8kYXE+EVTxh2kF/8EEXwp9LZlL5
	 9JTvqmWW/8nK9FBxN/XPXaJLUOJkzM9DAobzzZGdIAuCK1Q4i93f3H4MQmtvVDLneF
	 6VQro+WO3BjeGpP5rLXOExNnFhEohf+vCxfyTWYGDBg/sWisgkT7R6e6h2KLbMOEp/
	 JG09CuDSUactnqyXv+S7yQcxMLSuwTT3xR7iji38yqDsNI0B7UapMRwNSJPcWh19gY
	 FK9d+DtTS34YFuvaYGQYgzv35IYi9KaTwm4Tnj3NRMFNNmfUgPnkCkmmSv3EuF2fQo
	 k5jQZ4B4aPBBQ==
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
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 4/8] dt-bindings: clock: Add GRF clock definition for RK3528
Date: Wed,  5 Mar 2025 19:42:13 +0000
Message-ID: <20250305194217.47052-5-ziyao@disroot.org>
In-Reply-To: <20250305194217.47052-1-ziyao@disroot.org>
References: <20250305194217.47052-1-ziyao@disroot.org>
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

