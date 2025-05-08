Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59B4278E44;
	Thu,  8 May 2025 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729072; cv=none; b=F3qRBtIm1h6inaqyHvcPrnGEvOrXP4dUOypa4QYesgDJ8z/1JWPzfEA1YZnpuN/RpPfW4Uh6hfOb5a/F4RZWtUVnqtYbbriDYhck1uY9C8tri1X/Mk/7O/U+Zzbcce57bg14RnsOofyPaQjQOdmeSvJ0lCdTM0MmKQhPYLlA2ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729072; c=relaxed/simple;
	bh=V5gf55hXPX0qq/TTam1PSJX1LbH9PfNYfCT1v2WldW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euVEZpNpuZb5dCIBctKjI2wcILvdGIoACO5Ha8YXJxwjgtRf/1oM5HHX/LNCvghiKTK90m4zsHfkWxUsNadKsmIC0PQ7UWG3fcCCIl4osN56sHOo7BAL8X1RoQJuLLY/WIIvGL+Qqfp/ki4XOeP7ldAMh5sFvfbSYoir2LZOzgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=y7dGOpSa; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="y7dGOpSa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mZvOWQHwZVwyJf6BVvOEiNtKPaJ2rgizuAGd5TEgutw=; b=y7dGOpSaTguEXKJjJT2GCbwAz1
	RF10UCNO6oVUQkWcapDMzWaIp3xCxC/6ApPzPPXZEqtjTgK4hiShc0zDrHGbzYazGixvUr/xmxTV2
	YrksQtRrKsCRkzJruR+BOuwyuo6xkDyaUVU6cWXRyI3Ol36uv7V8YtaAoTMMRaZTmR46gL2Q/cl8i
	GkenBKWdoMfABDY3drgeAAZ6ubvfMRkA30bMqiEw59PKenfkzeZxVjhn1INTEyYUsBnORgsaQNQbm
	87A+Wxe5hj1BlWVZcWh1uhmAIGI7uebz385DD1vSWPXmXZIJ+yxg87ZGftezCdNm2Ll1UB0XJGK4g
	ApFqhayw==;
Received: from [61.8.144.177] (helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uD61M-0000vi-RN; Thu, 08 May 2025 20:31:00 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Yao Zi <ziyao@disroot.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/5] Support SD/SDIO controllers on RK3528
Date: Thu,  8 May 2025 20:30:47 +0200
Message-ID: <174672902826.1927548.11499970123396406769.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250506092206.46143-1-ziyao@disroot.org>
References: <20250506092206.46143-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 06 May 2025 09:22:01 +0000, Yao Zi wrote:
> RK3528 features two SDIO controllers and one SD/MMC controller. This
> series adds essential support for their tuning clocks and brings the
> SD/MMC one up on Radxa E20C board. Both HS and SDR104 mode are verified.
> 
> - Changed from v4
>   - rk3528 clock driver
>     - Switch to auxiliary GRF
>     - drop rockchip_clk_register_grf_branches
>     - Rename branch_mmc_grf to branch_grf_mmc to make style consistent
>       (with branch_grf_gate)
>   - Link to v4: https://lore.kernel.org/all/20250417143647.43860-1-ziyao@disroot.org/
> - Changed from v3
>   - Drop applied binding patch of MMC controller
>   - Rebase on top of linux-rockchip/for-next
>   - Link to v3: https://lore.kernel.org/all/20250309055348.9299-1-ziyao@disroot.org/
> - Changed from v2
>   - Apply review tags
>   - Rebase on top of linux-rockchip/for-next and drop applied patches
>   - RK3528 devicetree
>     - Fix accidentally dropped status property of saradc node
>     - drop det and pwren pinctrls for SDIO{0,1} according to the
>       reference design
>     - Correct max-frequency for SDIO{0,1}
>   - rk3528-radxa-e20c devicetree
>     - Don't disable sdio for sdmmc as claimed in the hw design guide
>   - Link to v2: https://lore.kernel.org/all/20250305194217.47052-1-ziyao@disroot.org/
> - Changed from v1
>   - Apply review tags
>   - Rebase on top of linux-rockchip/for-next and saradc v2 series
>   - rk3528 clock driver:
>     - explicitly include minmax.h, replace MAX() with more robust max()
>     - readability improvements
>     - fix error checks: ERR_PTR(-ENODEV), instead of ERR_PTR(ENODEV), is
>       returned when syscon_regmap_lookup_by_compatible() fails for missing
>       such syscon
>   - RK3528 devicetree
>     - Add default pinctrl
>     - Move the per-SoC property, rockchip,default-sample-phase, into the
>       SoC devicetree
>   - rk3528-radxa-e20c devicetree
>     - Assign sdcard to mmc1
>     - Add missing regulators
>     - Apply no-sdio for the sdmmc controller
>     - Sort nodes
>   - Link to v1: https://lore.kernel.org/all/20250301104250.36295-1-ziyao@disroot.org/
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: clock: Add GRF clock definition for RK3528
      commit: 8a023e86f3d999007f2687952afe78ef34a6aa91
[2/5] clk: rockchip: Support MMC clocks in GRF region
      commit: 621ba4d9f6db560a7406fd732af1b495ff5aa103
[3/5] clk: rockchip: rk3528: Add SD/SDIO tuning clocks in GRF region
      commit: 306d2f5ddaa765f04ffb54fc9437a6318f904b53

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
