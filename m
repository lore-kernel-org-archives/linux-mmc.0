Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98DA20B7F8;
	Thu,  6 Mar 2025 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268200; cv=none; b=ggulcX1mKvK1etfyEi7g0C6YC9g5RfhzT3m679QkhUpT+h2W8um1c99seJA8Zg3qeZkD5ThrJzbLxRyss1PTAJyVQFQGdr0u84NfHWQurrjDNxyoP6TPo6AhKSkD6L7PxKwU/T0zQXKLiY5qgiBf0xq7BX2wRDH7hNVioYsV+W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268200; c=relaxed/simple;
	bh=89na8aEyy6PeC9priobZs3cNkeHT5uhFC166aKaR6Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JecGv0Wvpv3LR0XnFIz+reQDdQoCoO9No6CiNulORXELopK8UT/Mu9HY6hV3bm5N0FKAgfp0kMdkzV2Gbh7AwQaO3zv4ymSL5WzOYKTIO8BF1XDdZJgFFAql9cb5m74H9WkEnNFCeZ1nuVSNAhTT3syjyZPDQBHpaDZysiJV1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=A+w0f7Rv; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="A+w0f7Rv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p2MHZq557DZLmu8HoDAX+Ak6NqSl7I/7w5qQt+/fGYg=; b=A+w0f7RvRtsuAyx5NFTDD8uU2l
	mNPisZuKkW+KoACpYl1xCpSqeUiK71ycK4fKV14rQOEtNw7Drgj9TN8xCfek9MZ+B2wguVybUZ6fR
	E7H1siM4ZsCfyA+gfYw8g9mTzLYAu7AXPyCXO7n+hqm4LI4YRQLJtEY5V0AYo7yG+tHtDcbqv3daw
	LDT64gyOShAlzBZriEXPoJGanytmsW7GDPtByasV2gwXgcBVkqElh1Z1EFNCdj82SFyWPCpJ4lbiN
	RaWgzVN5DRps4RsJ4+9guH48ioSpXJVpdyknlc5eq+tfyB4jmBQNOdKb4+xZqZgXYAf/W9DuIwmYq
	9sqCXMeQ==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tqBOm-0003OH-Hz; Thu, 06 Mar 2025 14:36:28 +0100
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
Subject: Re: (subset) [PATCH v2 0/8] Support SD/SDIO controllers on RK3528
Date: Thu,  6 Mar 2025 14:36:26 +0100
Message-ID: <174126816885.664640.17521271236710485903.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250305194217.47052-1-ziyao@disroot.org>
References: <20250305194217.47052-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 05 Mar 2025 19:42:09 +0000, Yao Zi wrote:
> RK3528 features two SDIO controllers and one SD/MMC controller. This
> series adds essential support for their tuning clocks, document the
> controller in dt-bindings and bring the SD/MMC one up on Radxa E20C
> board. Both HS and SDR104 mode are verified.
> 
> This is based on v2 of the SARADC series[1]
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: soc: rockchip: Add RK3528 VO GRF syscon
      commit: efc1bc1f36568a4297d20a691758b68c121cf982
[2/8] dt-bindings: soc: rockchip: Add RK3528 VPU GRF syscon
      commit: 8f814d7c9f6cdffc1f5cc97637e12cd699ff9085

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
