Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C12D1C5D79;
	Sat,  1 Mar 2025 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740825809; cv=none; b=iDWrdiXoWN1cb1ZYFnl8p7OCapdHprVMdAQyPXUNj35qwHD0YnYhuZ8XcbcrWe2wRljwrc6dmn5mOlSzjZC5wNGFsvbVpIm8IROiZGEUSPzAst8ssjFtjdXc95WPiR1u+JV/ZFhM8Es00WgFS9VqtQl+fs4xKyxcpAEh/PxLw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740825809; c=relaxed/simple;
	bh=WnMErFQKGyzYsxdI0ujG7rvJaR/CFTazd4MxR3w0Rdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gf7TeyppEUS0ZXfIo/g9BsvfkGjP7xmDokjNdGnGg+Xz8K1etJHEbOcaYu8yN7vqvL4Pk+9jiEG/xoEqGPHNV+fPSz1hsVyzJto9K98/Ty79atIUSEGSF8Oe6dJB1hPPWCoqAK4NXAzptr1R5nHJUQGP8pB6K2sm/1FVlTwtSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=EZiQOsYq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="EZiQOsYq"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2D81B25DBB;
	Sat,  1 Mar 2025 11:43:24 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EC3Mny1iksiZ; Sat,  1 Mar 2025 11:43:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740825802; bh=WnMErFQKGyzYsxdI0ujG7rvJaR/CFTazd4MxR3w0Rdw=;
	h=From:To:Cc:Subject:Date;
	b=EZiQOsYqB3kMpB6EpYaGSf8co4UUq1tvB9+SYpPqC6XHSQA2L4QNRzW8yl7nB72f1
	 GqPDxGQz6ElTk0i6U7eFTdWU6EOm+DDiuw9lksbmJdZtNiPXzRzUjpmCNiF386isKQ
	 putn946KHxayUU9Iym2nHZmjGtKacKO6izBgYIcU5nACc5Nlk7XAkhNhfWpCbCFY2q
	 jzTUVsCic9/AI8mtLUaErntianqZUvhp7mLy/Z258dmNF1/2yWN0LbcPt3t60cfgOs
	 vytP3zPP1Q9+6lpX5hhgQf9wWxE02zFKufcVkWxAbyrSa5bMgZOLcs++jzOL8lrOMV
	 /0CQyjINCzeAg==
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
Subject: [PATCH 0/8] Support SD/SDIO controllers on RK3528
Date: Sat,  1 Mar 2025 10:42:42 +0000
Message-ID: <20250301104250.36295-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3528 features two SDIO controllers and one SD/MMC controller. This
series adds essential support for their tuning clocks, document the
controller in dt-bindings and bring the SD/MMC one up on Radxa E20C
board with pinctrl set up by the previous bootloader. Both HS and SDR104
mode are verified.

Yao Zi (8):
  dt-bindings: soc: rockchip: Add RK3528 VO GRF syscon
  dt-bindings: soc: rockchip: Add RK3528 VPU GRF syscon
  dt-bindings: mmc: rockchip-dw-mshc: Add compatible string for RK3528
  dt-bindings: clock: Add GRF clock definition for RK3528
  clk: rockchip: Support MMC clocks in GRF region
  clk: rockchip: rk3528: Add SD/SDIO tuning clocks in GRF region
  arm64: dts: rockchip: Add SDMMC/SDIO controllers for RK3528
  arm64: dts: rockchip: Enable SD-card interface on Radxa E20C

 .../bindings/mmc/rockchip-dw-mshc.yaml        |  1 +
 .../devicetree/bindings/soc/rockchip/grf.yaml |  2 +
 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   | 14 +++++
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 62 +++++++++++++++++++
 drivers/clk/rockchip/clk-mmc-phase.c          | 24 +++++--
 drivers/clk/rockchip/clk-rk3528.c             | 56 +++++++++++++++--
 drivers/clk/rockchip/clk.c                    | 42 +++++++++++++
 drivers/clk/rockchip/clk.h                    | 23 ++++++-
 .../dt-bindings/clock/rockchip,rk3528-cru.h   |  6 ++
 9 files changed, 220 insertions(+), 10 deletions(-)

-- 
2.48.1

