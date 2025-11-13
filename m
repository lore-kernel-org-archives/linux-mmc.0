Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295E22E6127;
	Thu, 13 Nov 2025 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076101; cv=none; b=pbY+qxTTd98+x/S15VGmJYWa+Wxg1Z+jFw6jmTiZLOF7MXn7Ae2Ws5wzC59GK4Uz2UTIcPgwxKiYcga4vT7Y/lGj1RWRyN8rehy9nX0YtvXIu2idAIwblRF7AoN3livT880ujGqjqtAeBmwZVBBYLwmxZTsOLNVc8KGM4dgEIE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076101; c=relaxed/simple;
	bh=2NSFCeoijNJWf4COT/RA6eLKsrXnLBFu4ii7q3TrtqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fn0xMtVrBDe3Z6DvxaxV7/NBK8kr31tMKcUQFUn6sUenEPxEboDYsM53XMGETNMI4zaI9FFKp/Ddax33KO2SmywoLHsGkak0mqTqLu9qwbSBOoVEZKmRQlwo45wJOb3ATXAvY2SgSTi4OqcSDGNKPibxFMGAoy6f+KmGqtJVA7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=HSIzbNu6; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="HSIzbNu6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=MUCMochQrd1DfpxoWgDSOw9hEbqaoIKOIax/Q5hH7zc=; b=HSIzbNu6WDSeZZs1nCUH8/kupF
	pWNShvr04SQpnuTi2V/8XmS9x74UV8cBytjaZtdZaoCLRnU/BqMAVFNDtcYsYucK/rV0XzQhNZ0o8
	G6ED+pofk+Oc2XH/DMdHJ4LaxU/v85DxjnG+PCOuOa5ZaCfxwxJbh49hotxpdRozJ0fF4JmnR0P+B
	iTjuQziQqRyIOQUTjFSummn4OjhqV/cBag+xOxudKUs9taiyNbZKuwUaqbWbwArTCQ2OaUO5gtD2S
	tiiKp4c5zXZH8egdtlT6MwwHY2FNAFuOqNtpN3FkBeguqYpTzoX9m0XIIB+WQaxa2gvJq68IeX0Mr
	3CHwgn1A==;
Received: from i53875a11.versanet.de ([83.135.90.17] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vJgdB-0005o9-HN; Fri, 14 Nov 2025 00:21:33 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: Re: (subset) [PATCH v2 0/2] mmc: sdhci-of-dwcmshc: Add command queue support for Rockchip SOCs
Date: Fri, 14 Nov 2025 00:21:31 +0100
Message-ID: <176307608061.496957.2197880320790247592.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251031-rockchip-emmc-cqe-support-v2-0-958171f5edad@collabora.com>
References: <20251031-rockchip-emmc-cqe-support-v2-0-958171f5edad@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 31 Oct 2025 16:58:22 +0100, Sebastian Reichel wrote:
> Right now at least the recent Rockchip SoCs do not support system
> suspend with the mainline kernel. I'm currently looking into
> improving support for the RK3576 platform.
> 
> On the Sige5 one of the issues is the eMMC controller, which fails
> to suspend when trying to disable CQE support. While investigating
> I found a missing Rockchip quirk in the Rockchip kernel, which is
> needed for CQE. Since the RK3576 DT has been upstreamed with the
> 'supports-cqe' property (RK3588 does not yet have it), we run into
> this problem for that platform.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: rockchip: add eMMC CQE support for rk3588
      commit: 9d856aa1c81930a5d8df0e29d6cb0faa3fa87206

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
