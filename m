Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554841F4262;
	Mon,  5 May 2025 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746481158; cv=none; b=Sf559Wiu0M774yK7xekuwI9XtwE/dAg8D+hVXcnGQRiVLv9gbq5TcSegWXzkGfOm2kBj9omC1O9+3XFNUd+CNPf+Wk/QH7TFOxXp9h77uouPLxBigGTXNDy3zWYh4CxjzVB9+fmFZX1ZpmaOXZ9DEQwqMvFa/WUsNYiNl7C3oWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746481158; c=relaxed/simple;
	bh=OFXDbJsxKqoQMWwXs8OFPxoxsBnWaETf9qmgoQvbyuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VL/QAOm/qZsWenHUxFvIxfgkrUKDpxIYlCNqCKr8iJHhnjS67t0CuyBwt2mADC8pSCogixXN6cHQNjxXub63+/Q1T/+ggdwZwjuuQNDJKvKm1kRGSUQr94DfktziW1XI979y7rGlgBQyenrm7Pb6Xy+DPKbLawfyy/GuiXRfCww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=FeGwC3yb; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="FeGwC3yb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6l/heqGk/UTexwAtKZZUGycS/exQ3H0HSuobkgefF30=; b=FeGwC3ybr75HKO+AnpNeCgzn/7
	btsDdrILnjyQaO/niTyoI+k6DOd+zI2DjMDahPHyW1S+qJWTNi0H2Lsuz350DFJhPV9SdniI/GYLF
	Xd6/nOyeAHNNPzl+xoOAk+ZZTV+7OO0R2i1m72KUSi3QcD3F/rhDfIWZANPyKk6VVRcAkk7JlkBcA
	b5WQw9/xIH8e2CoRXD5XxQLqt9/LuYMAhN3ueSCZO5msI9Ov/3FC7AkVruNvjUz91YSu4TMHdDYAM
	qU04+Mv/pU7+PdBUpTZ8J1GsDPHp6bp1sqi3O0R5XmJVeZPWsK+JK+IFeQoNNWGoc8JmzVDc3iyQ0
	N1V1vSxg==;
Received: from i53875a1d.versanet.de ([83.135.90.29] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uC3Wk-00006o-S3; Mon, 05 May 2025 23:39:06 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Shresth Prasad <shresthprasad7@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>,
 Yao Zi <ziyao@disroot.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Yao Zi <ziyao@disroot.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v4 2/5] clk: rockchip: Support MMC clocks in GRF region
Date: Mon, 05 May 2025 23:39:05 +0200
Message-ID: <2737556.Isy0gbHreE@diego>
In-Reply-To: <20250417143647.43860-3-ziyao@disroot.org>
References:
 <20250417143647.43860-1-ziyao@disroot.org>
 <20250417143647.43860-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Donnerstag, 17. April 2025, 16:36:44 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Yao Zi:
> Registers of MMC drive/sample clocks in Rockchip RV1106 and RK3528
> locate in GRF regions. Adjust MMC clock code to support register
> operations through regmap. Also add a helper to ease registration of GRF
> clocks.
>=20
> Signed-off-by: Yao Zi <ziyao@disroot.org>

> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index cbf93ea119a9..ce2f3323d84e 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -590,6 +590,7 @@ void rockchip_clk_register_branches(struct rockchip_c=
lk_provider *ctx,
>  				list->name,
>  				list->parent_names, list->num_parents,
>  				ctx->reg_base + list->muxdiv_offset,
> +				NULL, 0,
>  				list->div_shift
>  			);
>  			break;
> @@ -619,6 +620,11 @@ void rockchip_clk_register_branches(struct rockchip_=
clk_provider *ctx,
>  			break;
>  		case branch_linked_gate:
>  			/* must be registered late, fall-through for error message */
> +		case branch_mmc_grf:
> +			/*
> +			 * must be registered through rockchip_clk_register_grf_branches,
> +			 * fall-through for error message
> +			 */
>  			break;

please don't create separate structures for specific clock-types.
Being able to "just define" clock branches is helpful and starting
to require separate blocks just causes issues down the road.

=46or handling multiple GRF sources, I just merged Nicolas' patches for
handling auxiliary GRFs [0] and GRF-gate clock type [1] .

So ideally, please base off from there.

Thanks a lot
Heiko


[0] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.gi=
t/commit/?id=3D70a114daf2077472e58b3cac23ba8998e35352f4
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.gi=
t/commit/?id=3De277168cabe9fd99e647f5dad0bc846d5d6b0093


