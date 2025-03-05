Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F391220B7E7;
	Wed,  5 Mar 2025 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171796; cv=none; b=bKieDIhYLKTOf9yIugP0gDwMPNw/2mYwm5zRBojESnDJytrPgcXZphO7OCk4bbnBRTDWD5KjgbUIOvEkyPxCLWizqx+YrzcpHuq1Bsz6VD/7CP7NeXMxzDBPUM08uHhJR+xoCYLd8rkoVt9xIjxcWqzfmjEup6x1xxe+7gxrfZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171796; c=relaxed/simple;
	bh=UT5t5cKf18CdLlG0v7nt8XdrJciuVrvT8/nabp56tK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvsQAYz6iVo7lHPbccmqVMMz85KR+n4XOFAdG4sXmAktnHHAVAH9C5XFykPW97YPcHmu6uE4LmKq8gVVVoyvzVHi8N/GrRMZX2ZLba7L6o3/qZwFfGgFWVHKj8TgyPqoqaSeyhkFs/A50PWo7VZyTnOpG59ZyGugbC2iD9s4e50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hV3BorJw; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hV3BorJw"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 09A8B2026E;
	Wed,  5 Mar 2025 11:49:45 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AvyoDwTIs3tR; Wed,  5 Mar 2025 11:49:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741171784; bh=UT5t5cKf18CdLlG0v7nt8XdrJciuVrvT8/nabp56tK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hV3BorJwYoE13cl35C7YCol2tfRnljeZvqKhzt+XpD0CAmG+tdRxaNJ9nniIDL62w
	 Q+qx6Z/AuWBqSKQuz8YW7ya4O+anACfd1937x6bQDqGOFNBzcSHpqdEQICG8tInvyH
	 bIpHKcCIFIubZS2n1U5bGC9FKaUupPgoc++iIhMTCkG83hWrC0N/hRxd5LjNAbT9hM
	 DZ9ee0boow8/b/1Ng5rWTYa3aG3mW6yqlIMLdyU4ckOU/h85w6heOv+9nEJdRGSndP
	 zxmwNxvibzGEGcBcK33uJZbMqO9foC9JhSFgCQHXdim6ldgoRuCQswkFOtolLggMHX
	 M/L8+zNE9m14A==
Date: Wed, 5 Mar 2025 10:49:21 +0000
From: Yao Zi <ziyao@disroot.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 6/8] clk: rockchip: rk3528: Add SD/SDIO tuning clocks in
 GRF region
Message-ID: <Z8gsGlZ7GgNF-zoc@pie.lan>
References: <20250301104250.36295-1-ziyao@disroot.org>
 <20250301104724.36399-1-ziyao@disroot.org>
 <2583035.OBFZWjSADL@diego>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2583035.OBFZWjSADL@diego>

On Wed, Mar 05, 2025 at 11:21:48AM +0100, Heiko Stübner wrote:
> Hi,
> 
> Am Samstag, 1. März 2025, 11:47:24 MEZ schrieb Yao Zi:
> > These clocks locate in VO and VPU GRF, serving for SD/SDIO controller
> > tuning purpose. Add their definitions and register them in driver if
> > corresponding GRF is available.
> 
> (no critique, just an observation :-) )
> 
> this puts a completely new meaning on the "general register files"
> as dumping ground ;-) .
> 
> Whoever got the idea of making sdmm/sdio tuning controls part
> of GRFs that are supposed display and/or video encoder parts :-D

Yes, the register layout is quite weird. Additionally some USB2 phy
registers locate in VO GRF as well...

> 
> > GRFs are looked up by compatible to simplify devicetree binding.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> 
> >  static int __init clk_rk3528_probe(struct platform_device *pdev)
> >  {
> > +	unsigned long nr_vpu_branches = ARRAY_SIZE(rk3528_vpu_clk_branches);
> > +	unsigned long nr_vo_branches = ARRAY_SIZE(rk3528_vo_clk_branches);
> > +	unsigned long nr_branches = ARRAY_SIZE(rk3528_clk_branches);
> >  	struct rockchip_clk_provider *ctx;
> >  	struct device *dev = &pdev->dev;
> >  	struct device_node *np = dev->of_node;
> > -	unsigned long nr_branches = ARRAY_SIZE(rk3528_clk_branches);
> > -	unsigned long nr_clks;
> > +	struct regmap *vo_grf, *vpu_grf;
> >  	void __iomem *reg_base;
> > -
> > -	nr_clks = rockchip_clk_find_max_clk_id(rk3528_clk_branches,
> > -					       nr_branches) + 1;
> > +	unsigned long nr_clks;
> >  
> >  	reg_base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(reg_base))
> >  		return dev_err_probe(dev, PTR_ERR(reg_base),
> >  				     "could not map cru region");
> >  
> > +	nr_clks = rockchip_clk_find_max_clk_id(rk3528_clk_branches,
> > +					       nr_branches) + 1;
> > +
> > +	vo_grf = syscon_regmap_lookup_by_compatible("rockchip,rk3528-vo-grf");
> > +	if (!IS_ERR(vo_grf))
> 
> for readability, please make this into something like
> 	if (!IS_ERR(vo_grf)) {
> 		nr_vo_clks = rockchip_clk_find_max_clk_id(rk3528_vo_clk_branches,
> 							   nr_vo_branches) + 1;
> 		nr_clks = max(nr_vo_clks, nr_clks);
> 	}

Thanks for the suggestion, will take it.

> > +	else if (PTR_ERR(vo_grf) != ENODEV)
> > +		return dev_err_probe(dev, PTR_ERR(vo_grf),
> > +				     "failed to look up VO GRF\n");
> > +
> > +	vpu_grf = syscon_regmap_lookup_by_compatible("rockchip,rk3528-vpu-grf");
> > +	if (!IS_ERR(vpu_grf))
> > +		nr_clks = MAX(rockchip_clk_find_max_clk_id(rk3528_vpu_clk_branches,
> > +							   nr_vpu_branches) + 1,
> > +			      nr_clks);
> 
> same here please
> 
> > +	else if (PTR_ERR(vpu_grf) != ENODEV)
> > +		return dev_err_probe(dev, PTR_ERR(vpu_grf),
> > +				     "failed to look up VPU GRF\n");
> > +
> >  	ctx = rockchip_clk_init(np, reg_base, nr_clks);
> >  	if (IS_ERR(ctx))
> >  		return dev_err_probe(dev, PTR_ERR(ctx),
> 
> Thanks
> Heiko
> 

Cheers,
Yao Zi
