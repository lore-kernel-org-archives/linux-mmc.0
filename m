Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D641C2512F6;
	Wed,  5 Mar 2025 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203776; cv=none; b=sc4wTNMA8iQkorMnKoBiPU3qi4KXFhimZH0ny6vUxys0x4Jx1tDFuM6eYISF+JrObbfZY3o/1T5qXzDVuKU499dG1SyzBdMsjEnU2PORMQQ1KTkJ74Nx668vDzxpZINZqAc6gvegCARwtLkXmoQv0QlPb0tqiYc79l9dG2ptU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203776; c=relaxed/simple;
	bh=xhnqWstTVBqsoGCfx5R5bpNmekaP3M85MkZUJ3rzXvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFZDkFWb8XQHKNIaBtLQjQfk2KAaWJcgAQ34QOFUY3SSMh8OAfnZTFDmn0EIXsum1cn7RESCF71UEgKZIpRYFAKToFISPC0cc05jPzD02kMyMFcOd2ktv8u5VgZFGjZYJKP+jbb1JOijUaAyPi5wcBQ1tYLQCEA4viOZkJ10nOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=BHsjmw1N; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="BHsjmw1N"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id AEBE820A23;
	Wed,  5 Mar 2025 20:42:51 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jLjYbJU3XEKF; Wed,  5 Mar 2025 20:42:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741203767; bh=xhnqWstTVBqsoGCfx5R5bpNmekaP3M85MkZUJ3rzXvI=;
	h=From:To:Cc:Subject:Date;
	b=BHsjmw1NIdU8Vfb/85SnYm8FxLRazHlpx5yPR5c2KLnT645/cqBdRgqVeP1bmahOi
	 Oyp6VqYtoI/BEa/elWERqHd89ixylu8sBKE8rxrEnRVoid+OvpXsvkX7Q6JPxEaVDt
	 IiQBPZB4NubJ6Z3cd2B7/SbjJ2Xs0cY1lg57sssGtcAgr3BNSma06qCVM98ISlDD//
	 obyzDfFulvUggNZHymTaNuQ04t8grtiKHmM7qFwufypzqgvIF/vKKM+OgBqnmXH8wD
	 8MuhLKl915iuJcwGltjGtit45NvV1dEhbqlBWE2WkChXC92a1g45kv0M7iz6vkJ+G/
	 aSrEWYkQi/U0Q==
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
Subject: [PATCH v2 0/8] Support SD/SDIO controllers on RK3528
Date: Wed,  5 Mar 2025 19:42:09 +0000
Message-ID: <20250305194217.47052-1-ziyao@disroot.org>
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

This is based on v2 of the SARADC series[1]

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

[1]: https://lore.kernel.org/all/20250304201642.831218-1-jonas@kwiboo.se/

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
 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   | 34 +++++++++
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 70 +++++++++++++++++++
 drivers/clk/rockchip/clk-mmc-phase.c          | 24 +++++--
 drivers/clk/rockchip/clk-rk3528.c             | 61 ++++++++++++++--
 drivers/clk/rockchip/clk.c                    | 42 +++++++++++
 drivers/clk/rockchip/clk.h                    | 23 +++++-
 .../dt-bindings/clock/rockchip,rk3528-cru.h   |  6 ++
 9 files changed, 252 insertions(+), 11 deletions(-)

-- 
2.48.1

