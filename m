Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7838205E2B;
	Wed,  5 Mar 2025 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170125; cv=none; b=uLQDS03cgiklxdxmPPfSMQU4nYeajRyL0jdlE94mtPG3+VKxSK7xp0fvleO5ndIu4N+6GfGC60zl295s68tz9vmwnqzdQhsgPABL/zL4zAB3kOQc50vIrEhGbjXKUSOciDjEZ6zyy0HVP3iQGRo1C+d8lyPZS3wW3O2c/R3AycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170125; c=relaxed/simple;
	bh=qgf5P/v7yPasakxwS7LQgahj0RyJAU/WZ6WgZMKJKO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekujYAzvwMmnoCzIzoLvDBM8c/k3qERj/hUnj2Rdv2XBIylcaY69N/BGWWSvmC3c2I4fxPHo9MupmAyHiiF8fsobkEFyxXt7UQhdAsAwZ0qJ9CrL9+o9Q2LnzM+ovi2GjCnd3VBqPN7jvZM1yo14YuwNO+mh+b8fMduLw1a9Atw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=pJid1FHl; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="pJid1FHl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n4fDAkyw/uhxe8G05E84yrw6xnoFmgWvI3tKZtq2rSs=; b=pJid1FHlhmvhTprAPkmVDlJvPu
	wlwKv9FuKC1W+fwINcrFCnwCZMlBklUf16MB23bCw4dYQnEdsgf2oK86Dq8q7hykrf/j7nWSZ9i1I
	7lUJRhifm328x9fW03maoX2vFjcUB1GFKXFHMWTlBwIPW8/mO+gCkBYOZi4nDfSQmAyUNj85WSWau
	GsnxrHVqkW0bxdWiiTlHMwIG9P8zcwpZyyITy6dzyBNjkAXLVAOUlR/RESFl0FAg8nIBLybMHPJHX
	uI+fOnea8woEelqoHcL/DO8aIyJrQYazfVQ6IHS2wnU1gHr6QMRbhMzInehBh40QDKBP60hyY6Wzo
	4ash0VHQ==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tplsr-0001Y0-7Q; Wed, 05 Mar 2025 11:21:49 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Frank Wang <frank.wang@rock-chips.com>,
 Shresth Prasad <shresthprasad7@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>, Yao Zi <ziyao@disroot.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Yao Zi <ziyao@disroot.org>
Subject:
 Re: [PATCH 6/8] clk: rockchip: rk3528: Add SD/SDIO tuning clocks in GRF
 region
Date: Wed, 05 Mar 2025 11:21:48 +0100
Message-ID: <2583035.OBFZWjSADL@diego>
In-Reply-To: <20250301104724.36399-1-ziyao@disroot.org>
References:
 <20250301104250.36295-1-ziyao@disroot.org>
 <20250301104724.36399-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Samstag, 1. M=C3=A4rz 2025, 11:47:24 MEZ schrieb Yao Zi:
> These clocks locate in VO and VPU GRF, serving for SD/SDIO controller
> tuning purpose. Add their definitions and register them in driver if
> corresponding GRF is available.

(no critique, just an observation :-) )

this puts a completely new meaning on the "general register files"
as dumping ground ;-) .

Whoever got the idea of making sdmm/sdio tuning controls part
of GRFs that are supposed display and/or video encoder parts :-D


> GRFs are looked up by compatible to simplify devicetree binding.
>=20
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---

>  static int __init clk_rk3528_probe(struct platform_device *pdev)
>  {
> +	unsigned long nr_vpu_branches =3D ARRAY_SIZE(rk3528_vpu_clk_branches);
> +	unsigned long nr_vo_branches =3D ARRAY_SIZE(rk3528_vo_clk_branches);
> +	unsigned long nr_branches =3D ARRAY_SIZE(rk3528_clk_branches);
>  	struct rockchip_clk_provider *ctx;
>  	struct device *dev =3D &pdev->dev;
>  	struct device_node *np =3D dev->of_node;
> -	unsigned long nr_branches =3D ARRAY_SIZE(rk3528_clk_branches);
> -	unsigned long nr_clks;
> +	struct regmap *vo_grf, *vpu_grf;
>  	void __iomem *reg_base;
> -
> -	nr_clks =3D rockchip_clk_find_max_clk_id(rk3528_clk_branches,
> -					       nr_branches) + 1;
> +	unsigned long nr_clks;
> =20
>  	reg_base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(reg_base))
>  		return dev_err_probe(dev, PTR_ERR(reg_base),
>  				     "could not map cru region");
> =20
> +	nr_clks =3D rockchip_clk_find_max_clk_id(rk3528_clk_branches,
> +					       nr_branches) + 1;
> +
> +	vo_grf =3D syscon_regmap_lookup_by_compatible("rockchip,rk3528-vo-grf");
> +	if (!IS_ERR(vo_grf))

for readability, please make this into something like
	if (!IS_ERR(vo_grf)) {
		nr_vo_clks =3D rockchip_clk_find_max_clk_id(rk3528_vo_clk_branches,
							   nr_vo_branches) + 1;
		nr_clks =3D max(nr_vo_clks, nr_clks);
	}

> +	else if (PTR_ERR(vo_grf) !=3D ENODEV)
> +		return dev_err_probe(dev, PTR_ERR(vo_grf),
> +				     "failed to look up VO GRF\n");
> +
> +	vpu_grf =3D syscon_regmap_lookup_by_compatible("rockchip,rk3528-vpu-grf=
");
> +	if (!IS_ERR(vpu_grf))
> +		nr_clks =3D MAX(rockchip_clk_find_max_clk_id(rk3528_vpu_clk_branches,
> +							   nr_vpu_branches) + 1,
> +			      nr_clks);

same here please

> +	else if (PTR_ERR(vpu_grf) !=3D ENODEV)
> +		return dev_err_probe(dev, PTR_ERR(vpu_grf),
> +				     "failed to look up VPU GRF\n");
> +
>  	ctx =3D rockchip_clk_init(np, reg_base, nr_clks);
>  	if (IS_ERR(ctx))
>  		return dev_err_probe(dev, PTR_ERR(ctx),

Thanks
Heiko


