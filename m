Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B516D2500BE;
	Wed, 12 Mar 2025 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808339; cv=none; b=CdMNaTs3U99TDKgEeK7mLG6TLSrwqWXBITMwBVoPFZiBZ17bdY2e5HZ1wB95BEqtwaSsTtLKUOFrC3Mpen8BP4qdZUs2Qh/X+U/1OyfDmLOcvz708mBDYO9Gu4z5GdGFFwMXfQA2dXFeNotxZrAur/JFVicXdioHO31EuBVWujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808339; c=relaxed/simple;
	bh=6D7TPM9fIWmxp7fQ8s1JIDBlYRWkbhrWVq0EcEUKk+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McAFQpR+XrzPMJFoHzHjhcHhxqJFmoY1AMZLZmnUjwfsUUrncUk6qh5ScS0ka8btE9bufK+8vPYAxZ9Fu7KtFZh5oLxfZI9Q1gALDc1AF7i/Mfe3KHYJ7D48sdUsFQRRQTS1FRdbHFHjapZ4YfbOEncEh9vLePOAHYXxnHim3SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=n4GTqQQI; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="n4GTqQQI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Yd22Qxz7kDBJnd2ZYEgaGoACeEuIVuHffsOhyto1sRk=; b=n4GTqQQIMhcq4YAluRDwHbKnoH
	TjRQEBWJJBqEZkeSd4FKjYrt9GreyYhsgoTZR94NU60koVcyszyVg93Ok/x/yhCH1z+2etja3CmAG
	fapBW4qGaRMl858/NCffQUMfIL7I9NdoZyt9mUhK2mxXC1ZhPC5M1lTwndqyDR/+8fnzli1Kf0N/g
	agHyq1cycPPK0l33SRcZ1GootxNikCN5N1NJB1tkMtHJkb7nRMrWzndEalbAQP6Z8rxxYz2DFPBKk
	RPJXWf6mVOGO2n+z9J0loh5YfjRbPaENRvDfT1lZsrtop/7HjjhYCsXGKUqc1V9vQdx3QHzshm30s
	G3FYU4gA==;
Received: from p3ee2c254.dip0.t-ipconnect.de ([62.226.194.84] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tsRuk-0001qz-2J; Wed, 12 Mar 2025 20:38:50 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] rockchip: Add support for onboard eMMC on Radxa E20C
Date: Wed, 12 Mar 2025 20:38:48 +0100
Message-ID: <174180832194.262650.6974587881042851056.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250305214108.1327208-1-jonas@kwiboo.se>
References: <20250305214108.1327208-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 05 Mar 2025 21:41:01 +0000, Jonas Karlman wrote:
> The Radxa E20C may come with an onboard eMMC (8GB / 16GB / 32GB / 64GB).
> 
> This series add dt-binding and SoC DT node for the SDHCI controller
> and enable use of the SDCHI controller on the Radxa E20C.
> 
> This series add support for the onboard eMMC on Radxa E20C.
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: rockchip: Add SDHCI controller for RK3528
      commit: d62917b63e9f2c876bd9abf019a25313bd9cbc07
[3/3] arm64: dts: rockchip: Enable onboard eMMC on Radxa E20C
      commit: f25c3b93f50387849db692891e2b2c6f9cc7d055

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
