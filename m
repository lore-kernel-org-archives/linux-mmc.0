Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BB725485F;
	Wed,  5 Mar 2025 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203793; cv=none; b=QGKB/ldyvLm3XBwqdKFhU1o+7JOQ00CVbnY4gBrk3C9K4r/t47Mpc2/I0XGv1D2r6ay3sqU8N1fkf9K0kAD2bU2qpGTTtg703/9kiEdF/eTdKxRuGbnkxIa5ouDf3Tu3HY0cixea4fox4NYIn+4W2l17VwgjGN2mOMKvuIlmHSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203793; c=relaxed/simple;
	bh=+LUmQPB+tURq91r5Yr6zdu4bs85M0PK3opWSYhnifBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zis0D61uU1Zj9kDH6l478PB4NBk1uFial3AkkvVweIJs8vt1vYfE3wlKL8LvMZ+dLf7P+n3GgJb/WYY4BzvmNd/mCt4XQCOqJBx74iPmZwROfpnxfMVLbavL31i0LjVtkzs0bLGuMzymE+uDq+PSCBR9UVAHZ+/WdrGaKEnXO+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=XQQG5nF+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="XQQG5nF+"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id F357B20D00;
	Wed,  5 Mar 2025 20:43:08 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fcFUuhmvejPn; Wed,  5 Mar 2025 20:43:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741203788; bh=+LUmQPB+tURq91r5Yr6zdu4bs85M0PK3opWSYhnifBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XQQG5nF+p1VSPixYAnYKKG3oBzbPUWg5oYFpWZV5o0jm9ODr0MIpT39jycMnDRltY
	 ipl507d/b96y6EDS6ZyP+Co/ssH/He+ZQ9ERa2/3gELnGLa63AuUMnkensjJm6k/qg
	 f+CH1Y/yipr3WBvWaLM3YrHl8BBjP+peLCIn4VWAA7qBYasfyXFz1Q2o6RzNJQGPsK
	 TfMlqaMBGMuNH+vL+ylSH0ix1GKHX1VobJblgfEJ+es3T+2UWZ5654NxWSMc6w2NWL
	 l7oKAg2GtM85dv+nv4iwKGbvC7wulY5OHDTHAqw6VALGSzfQZ9a7YwvgbWYlh5mdfu
	 FWCZDQgNh6+sg==
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
Subject: [PATCH v2 3/8] dt-bindings: mmc: rockchip-dw-mshc: Add compatible string for RK3528
Date: Wed,  5 Mar 2025 19:42:12 +0000
Message-ID: <20250305194217.47052-4-ziyao@disroot.org>
In-Reply-To: <20250305194217.47052-1-ziyao@disroot.org>
References: <20250305194217.47052-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RK3528 compatible string for SD/SDIO interface.

Signed-off-by: Yao Zi <ziyao@disroot.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index 06df1269f247..ea0feb733e32 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -38,6 +38,7 @@ properties:
               - rockchip,rk3328-dw-mshc
               - rockchip,rk3368-dw-mshc
               - rockchip,rk3399-dw-mshc
+              - rockchip,rk3528-dw-mshc
               - rockchip,rk3568-dw-mshc
               - rockchip,rk3588-dw-mshc
               - rockchip,rv1108-dw-mshc
-- 
2.48.1

