Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC62C7E1;
	Sun,  9 Mar 2025 05:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741499668; cv=none; b=VI83mXvZpipq4zpCnOajArnWQPFRdyBGxjVnXCM43IMecW3wfXxHc0ivsxJdEq2qVXUyAXX428JJovhSWMA5KiqJ/xnVbmnfyjdFLo9mzD0d3CcF5FUTUjz0XmVLW7TUYUe6EeO6tpJZu/G0oTDXqpX7QTbzMHX2WQZc3vbHdkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741499668; c=relaxed/simple;
	bh=jW0prezCvhfoXx1hseKEs6i70MPMNW9XLXcHofe/Z90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jS1zQtKKiiHA0b77s4mnRYiaDUJR8e5IAUitNgFFD5nMJOqhnUJCwXK/RXxIXAcmu96t/OYWGXX2iEH6tEzFVUi9G2ckDQm7pETXdsJNB/BCGhVqBQfjG+Sah7f1YUQJJT6+Yq337IjGzFmGjDsGFlk4jiJToUbpYb9OtGFdSWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FuwHSHjN; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FuwHSHjN"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D4F7725DCD;
	Sun,  9 Mar 2025 06:54:16 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8LWI8nxrMLlW; Sun,  9 Mar 2025 06:54:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741499655; bh=jW0prezCvhfoXx1hseKEs6i70MPMNW9XLXcHofe/Z90=;
	h=From:To:Cc:Subject:Date;
	b=FuwHSHjNhgaQ/9ZDTlNAHaKkr+AAnhgiC9GGSqpQEJ3irDH7o7GS9pW3u8hg+Butu
	 czIc6Zfi64+EJ/rSj0BK7DjqcpZZ/edH503G5J51gOELkAbGkpiGDz3bdXwd245FUS
	 K5wSti2P52wZ+jv2Bj1bllmEry8Xya3YhmOyhPdMItr8BebDmNmCFdoH2I64JjeWfL
	 WDQ0E7iiqokny5CDP7ICX2bRrjIHi7QF9+CAs6chmMP9EeYCftlb+AqxGlYxn35vI/
	 QXs979nsvMkXiBEAF3mB6/ThQr8M+9ndUKaoD/Wz/OvN5yUf6gtFp4f/yoXepnYwVQ
	 RBw/6LYwGe2jw==
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
Subject: [PATCH v3 0/6] Support SD/SDIO controllers on RK3528
Date: Sun,  9 Mar 2025 05:53:42 +0000
Message-ID: <20250309055348.9299-1-ziyao@disroot.org>
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
board. Both HS and SDR104 mode are verified.

- Changed from v2
  - Apply review tags
  - Rebase on top of linux-rockchip/for-next and drop applied patches
  - RK3528 devicetree
    - Fix accidentally dropped status property of saradc node
    - drop det and pwren pinctrls for SDIO{0,1} according to the
      reference design
    - Correct max-frequency for SDIO{0,1}
  - rk3528-radxa-e20c devicetree
    - Don't disable sdio for sdmmc as claimed in the hw design guide
  - Link to v2: https://lore.kernel.org/all/20250305194217.47052-1-ziyao@disroot.org/
- Changed from v1
  - Apply review tags
  - Rebase on top of linux-rockchip/for-next and saradc v2 series
  - rk3528 clock driver:
    - explicitly include minmax.h, replace MAX() with more robust max()
    - readability improvements
    - fix error checks: ERR_PTR(-ENODEV), instead of ERR_PTR(ENODEV), is
      returned when syscon_regmap_lookup_by_compatible() fails for missing
      such syscon
  - RK3528 devicetree
    - Add default pinctrl
    - Move the per-SoC property, rockchip,default-sample-phase, into the
      SoC devicetree
  - rk3528-radxa-e20c devicetree
    - Assign sdcard to mmc1
    - Add missing regulators
    - Apply no-sdio for the sdmmc controller
    - Sort nodes
  - Link to v1: https://lore.kernel.org/all/20250301104250.36295-1-ziyao@disroot.org/

Thanks for your time and review.

Yao Zi (6):
  dt-bindings: mmc: rockchip-dw-mshc: Add compatible string for RK3528
  dt-bindings: clock: Add GRF clock definition for RK3528
  clk: rockchip: Support MMC clocks in GRF region
  clk: rockchip: rk3528: Add SD/SDIO tuning clocks in GRF region
  arm64: dts: rockchip: Add SDMMC/SDIO controllers for RK3528
  arm64: dts: rockchip: Enable SD-card interface on Radxa E20C

 .../bindings/mmc/rockchip-dw-mshc.yaml        |  1 +
 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   | 33 +++++++++
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 69 +++++++++++++++++++
 drivers/clk/rockchip/clk-mmc-phase.c          | 24 +++++--
 drivers/clk/rockchip/clk-rk3528.c             | 61 ++++++++++++++--
 drivers/clk/rockchip/clk.c                    | 42 +++++++++++
 drivers/clk/rockchip/clk.h                    | 23 ++++++-
 .../dt-bindings/clock/rockchip,rk3528-cru.h   |  6 ++
 8 files changed, 248 insertions(+), 11 deletions(-)

-- 
2.48.1

