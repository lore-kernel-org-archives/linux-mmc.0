Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A073828A73C;
	Tue,  6 May 2025 02:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746498136; cv=none; b=ILoPmZuKX/haSKWA7kUyFYguI5xfCe86jUGaiBDrQSr9rXYfqP3APmuTyXKZ3hu6eNwaG1TNU9Yb6sQJnei+TTRAYIoveNf6h/O1+TsigP2mhTDdlapnXOz/uS7qka3kR6L/M2QPFkUDXnyI0eFtli2+Bb/93pKsnuZg5by2xIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746498136; c=relaxed/simple;
	bh=RzobY4XVcgkDJ0doe1YwuuhTaZEvjGgriYp4dbdw2KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un8hYaRZnsyY19BwtfOzTlOdLj12b2eyXtf6CnMkv8p8PwIfdUEnIPYh2abteasoECbULiCLVNX3NyjN7iNPfTsmcGvxl5eKPsb9UJ4rIKPZ9pzbukyKwqYhI5DRbDiYOAsAvIee427YrIDxNkWPbx8mIg3NmH9DXO74TZNVGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=LGeMnYHh; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="LGeMnYHh"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CDEBD257FC;
	Tue,  6 May 2025 04:22:05 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4JOhvh70GMPC; Tue,  6 May 2025 04:22:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1746498124; bh=RzobY4XVcgkDJ0doe1YwuuhTaZEvjGgriYp4dbdw2KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LGeMnYHh13eXvQTo6b7jVRLViK27EHHbt6IGVuHYYHpsIFoAkHvSmHGbngDO7cfAz
	 wAsobVQPuGvv4+GR4WyjeK9NNLXQMp4Ov1vGVlIpk4dtb2liJA3MXhc38OlFxaMU9j
	 oAEUu46pPkg24ZfAdG7sMr8L4CLSgOzPjJMjKhDWKB7y4JjZiJopx5LtZLzPHqWnDT
	 UDaPlS9B27kMd8W9tEo0PLmUBQtLqFyGDJ7dtc2EY/YdGr9pzXMluLcTsHdPUw8yCk
	 xArCj1nQZ7LzlKsbwlRfcStwfM25FiVr7y5bIMV+7hpL7JRqgXEHbYIub5rU9vq1lj
	 C51EJbsxNlGmg==
Date: Tue, 6 May 2025 02:21:48 +0000
From: Yao Zi <ziyao@disroot.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v4 2/5] clk: rockchip: Support MMC clocks in GRF region
Message-ID: <aBlyPL_1TFh9lNr3@pie.lan>
References: <20250417143647.43860-1-ziyao@disroot.org>
 <20250417143647.43860-3-ziyao@disroot.org>
 <2737556.Isy0gbHreE@diego>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2737556.Isy0gbHreE@diego>

On Mon, May 05, 2025 at 11:39:05PM +0200, Heiko Stübner wrote:
> Hi,
> 
> Am Donnerstag, 17. April 2025, 16:36:44 Mitteleuropäische Sommerzeit schrieb Yao Zi:
> > Registers of MMC drive/sample clocks in Rockchip RV1106 and RK3528
> > locate in GRF regions. Adjust MMC clock code to support register
> > operations through regmap. Also add a helper to ease registration of GRF
> > clocks.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> 
> > diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> > index cbf93ea119a9..ce2f3323d84e 100644
> > --- a/drivers/clk/rockchip/clk.c
> > +++ b/drivers/clk/rockchip/clk.c
> > @@ -590,6 +590,7 @@ void rockchip_clk_register_branches(struct rockchip_clk_provider *ctx,
> >  				list->name,
> >  				list->parent_names, list->num_parents,
> >  				ctx->reg_base + list->muxdiv_offset,
> > +				NULL, 0,
> >  				list->div_shift
> >  			);
> >  			break;
> > @@ -619,6 +620,11 @@ void rockchip_clk_register_branches(struct rockchip_clk_provider *ctx,
> >  			break;
> >  		case branch_linked_gate:
> >  			/* must be registered late, fall-through for error message */
> > +		case branch_mmc_grf:
> > +			/*
> > +			 * must be registered through rockchip_clk_register_grf_branches,
> > +			 * fall-through for error message
> > +			 */
> >  			break;
> 
> please don't create separate structures for specific clock-types.
> Being able to "just define" clock branches is helpful and starting
> to require separate blocks just causes issues down the road.
> 
> For handling multiple GRF sources, I just merged Nicolas' patches for
> handling auxiliary GRFs [0] and GRF-gate clock type [1] .

Thanks for the hint, it does look like a better style which I'll adapt
in the next version.

> So ideally, please base off from there.
> 
> Thanks a lot
> Heiko
> 

Regards,
Yao Zi

> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=70a114daf2077472e58b3cac23ba8998e35352f4
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=e277168cabe9fd99e647f5dad0bc846d5d6b0093
> 
> 
