Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F6315A868;
	Thu, 17 Apr 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900633; cv=none; b=bEZaB4QOdgbxQORLejGLWJGQwakkvSlOuJupERW9slDswbbF5S07jx+yWJgRl8DMbORX2eiPAC0RdWJ8zHSWIEOT4NqFh7+jqQpFLIJyQdrapUnWcO74Dc+hBQRKxv1y4BSWM0EJLiPlsQA1oz5GXdL+7jI3/om5bIqrQ5HyKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900633; c=relaxed/simple;
	bh=sYtHglBTVqXwt7DqWYSQlT7eDYzzYmQoAxAuuz6prkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uRhFVX/ip4fnDGdKM8QHGK/dFW9fSpZD+CnjcUgHaLZeUO+dIL4dPtQjNq+df58ztabxmO22LXqSWAGuArbJpcSRESuMfSorP1FMGy6Op189vtv/zyBVY3o2otyRdBNjYVPg6j4WH9MF+GRI857ClmaI4AIRHgaRJSGntNU1Myw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=CtFTaMrS; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="CtFTaMrS"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 79C0F2023B;
	Thu, 17 Apr 2025 16:37:07 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5kFlxYkdvA7D; Thu, 17 Apr 2025 16:37:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1744900626; bh=sYtHglBTVqXwt7DqWYSQlT7eDYzzYmQoAxAuuz6prkY=;
	h=From:To:Cc:Subject:Date;
	b=CtFTaMrS9Q+TSxO0qI73LNZSjfy2Si13/GMGsEFMoe+/mbx6pkaJ4d7SQW1fH/MiM
	 8eo6JtCxzDkmC7Yte3Imi8kjGbp0cE4ModoLDgaG2oCSKAyuaWnX6SP05y8mNHlvxn
	 dDQPBNp83KXEqMK3ETDBlmz9i3oEAQ4DAqcm6rhg8eBjfX20HYjYhoEs0zKezUgaOK
	 raFIThbYXrOOgl1zf/Ct5aMuNNm/1eG6JwtGJ6J3//yN0eKjp2sDvQXDRVxfoEQmZx
	 zKMcAbvX+41WNYubZCIIx+HHNoy8A9gb/G6Ugh8v5oIHn3d48QS2Sgv/tsFLxIKmzp
	 BmBrZEj1P1Ymw==
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
Subject: [PATCH v4 0/5] Support SD/SDIO controllers on RK3528
Date: Thu, 17 Apr 2025 14:36:42 +0000
Message-ID: <20250417143647.43860-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3528 features two SDIO controllers and one SD/MMC controller. This
series adds essential support for their tuning clocks and brings the
SD/MMC one up on Radxa E20C board. Both HS and SDR104 mode are verified.

- Changed from v3
  - Drop applied binding patch of MMC controller
  - Rebase on top of linux-rockchip/for-next
  - Link to v3: https://lore.kernel.org/all/20250309055348.9299-1-ziyao@disroot.org/
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

Yao Zi (5):
  dt-bindings: clock: Add GRF clock definition for RK3528
  clk: rockchip: Support MMC clocks in GRF region
  clk: rockchip: rk3528: Add SD/SDIO tuning clocks in GRF region
  arm64: dts: rockchip: Add SDMMC/SDIO controllers for RK3528
  arm64: dts: rockchip: Enable SD-card interface on Radxa E20C

 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   | 30 ++++++++
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 69 +++++++++++++++++++
 drivers/clk/rockchip/clk-mmc-phase.c          | 24 +++++--
 drivers/clk/rockchip/clk-rk3528.c             | 61 ++++++++++++++--
 drivers/clk/rockchip/clk.c                    | 42 +++++++++++
 drivers/clk/rockchip/clk.h                    | 23 ++++++-
 .../dt-bindings/clock/rockchip,rk3528-cru.h   |  6 ++
 7 files changed, 244 insertions(+), 11 deletions(-)

-- 
2.49.0

