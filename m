Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA02080EE;
	Thu,  6 Mar 2025 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253799; cv=none; b=ERnHbMhJdz+lWwKF9+I5y0XO/JyUzM77OrnbPK38/0m5WBeegTf685z7EMRpRQx5IWsWoD8Zf0q6apph3X7Dlaz+5FO50npl0VTbog/PHG0TZBm1QEl5UGxLt2wHdJD5JTSj1I25vvEGMCRVTfWifd/F1rHYBvBdy36NlncJA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253799; c=relaxed/simple;
	bh=Osg4Vntdck2fVcOyCIRV4uD4gndHJmCxrvfUHS/l3Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDn6EajFEypE6ru++qsJUjgDvDAWJlw9Yo1jZTJ7sviw9FrpfAnFqgDIY2raWZJ++Coz0tisES8RV3GNFunAW4be4wTpkhxgu+gub8VzFCt8ai6FkZgmiEwPm9z0cbDQ7WDtKsj9Htr2l7y5O4A36HkTEJkzAS2cH4dk8zregFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2pAfj0b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2pAfj0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED55AC4CEE2;
	Thu,  6 Mar 2025 09:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741253798;
	bh=Osg4Vntdck2fVcOyCIRV4uD4gndHJmCxrvfUHS/l3Hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J2pAfj0bUJGCO1GHfX8jLU2Ogzt0wHjo4X9Nz71bcOikYoXkWKFObwDpDTQW8h1a0
	 HikDodnBOpXLZodtMNdYhl0Rg3Kr57JpeLS1/YE58sOfzgZ44XGYmQbfZjJq3rGYoe
	 DeAzhiQXgqFyuUG3cxOitoY5kUqHqYgO12O58wePWjb7q/tYleGqEUvVasxfSaZnEt
	 leolnzzv5MBgE9NqZ1mWyNgawdACAAiQMxzkTbQ5J4ONU8s+1FMMO3m8roDP9aFc61
	 QGmpJ6NxNKTNDwGFb7A6fUWWj+JXjYDEoSBG+py9DVmvZRcuIxN/yMKtSQnEo0aAyD
	 ihYQWZ/Uhenpg==
Date: Thu, 6 Mar 2025 10:36:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, Yao Zi <ziyao@disroot.org>, 
	linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Add compatible
 string for RK3528
Message-ID: <20250306-frisky-spiffy-bullmastiff-ad9e49@krzk-bin>
References: <20250305214108.1327208-1-jonas@kwiboo.se>
 <20250305214108.1327208-2-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250305214108.1327208-2-jonas@kwiboo.se>

On Wed, Mar 05, 2025 at 09:41:02PM +0000, Jonas Karlman wrote:
> The SDHCI controller in Rockchip RK3528 is similar to the one included
> in RK3588.
> 
> Add compatible string for the SDHCI controller in RK3528.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---

No power domains here? Post complete support, so this won't have to be
changed in near future.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

