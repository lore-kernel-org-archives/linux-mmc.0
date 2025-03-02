Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8212AAD39;
	Sun,  2 Mar 2025 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932218; cv=none; b=D/QrnF/4ndMcl6zDZkFsBJWrA0AyEQhT2ueyHctXdMKnWF4lHn6nif1fcORhGj2cDd8J4ZYCpaCUM1sBxazlNYl8UeZT+2v13hP14apJrv2JkOUP3Sb2+wDGV4NRuVDnlR/9ALxCHyIRGvpFPk3JK6cbExzYPQJ+1ZCsDOVNe24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932218; c=relaxed/simple;
	bh=24etwHDO43cgkA43Fvv7V97Li/I7jEmBfGtyam7R4FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqto+fPvqbpI91dZdVOB09lAqDGxqYX+0gGKFPTwLJwoIgo5AJJk/IeK9Sqz3qQ4idAv+h4Epyo5O3bTu2MCU/abKdA+WXfkr0dG2ZKYhA5fXSyjFVCpegDIqJmJLrsOJzNLS1i1k2K9K/yOtGfClSXI3Tu80H3799ssNP9Ulbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=K1qDYU19; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="K1qDYU19"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B59DD25286;
	Sun,  2 Mar 2025 17:16:54 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K8mzO5PnjFYc; Sun,  2 Mar 2025 17:16:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740932213; bh=24etwHDO43cgkA43Fvv7V97Li/I7jEmBfGtyam7R4FA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K1qDYU19UIJxtbJclJuBESKTf/+cG2z3j4fCzAWLSJ9qrzXbEly5vnmFqOixyoZfL
	 0YPsoEXi3eeNwH4/i/1i1RNlVaQMXfmRDqO/i1dBqMQacCT6F8bDcT7Hc0vun21Ny2
	 N+XPzWaSuRmyvo1zfibKrIh+YWmsRFm2vMMNp4rTXSqqMv352pA7lnEo+6bkCIb1l1
	 AW7Cb3a5kG7vtkED73cKZ2x5E9CxGarKuG77IBb1zvY1z447ghKpySnuSaWUwo52ev
	 yQMAJ7Rj4YQyrAao7Beif4DJi0VdjqFuzXaGZci0YY91a6k8HdZuX0FGztJptwfRhE
	 Bxtu6nu9FtxqA==
Date: Sun, 2 Mar 2025 16:16:36 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jonas Karlman <jonas@kwiboo.se>, FUKAUMI Naoki <naoki@radxa.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 8/8] arm64: dts: rockchip: Enable SD-card interface on
 Radxa E20C
Message-ID: <Z8SEZOoQWiS4jl7n@pie.lan>
References: <20250301104250.36295-1-ziyao@disroot.org>
 <20250301104835.36439-1-ziyao@disroot.org>
 <0aefd292-7980-434d-9c18-4ab9f6a0b40e@kwiboo.se>
 <Z8MklJfFz2EA6oNS@pie.lan>
 <d6928adc-1df2-494f-a3d3-7b028c220547@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6928adc-1df2-494f-a3d3-7b028c220547@kwiboo.se>

On Sun, Mar 02, 2025 at 12:56:42PM +0100, Jonas Karlman wrote:
> Hi Yao Zi,
> 
> On 2025-03-01 16:15, Yao Zi wrote:
> > On Sat, Mar 01, 2025 at 02:01:05PM +0100, Jonas Karlman wrote:
> >> Hi,
> >>
> >> On 2025-03-01 11:48, Yao Zi wrote:
> >>> SD-card is available on Radxa E20C board.
> >>>
> >>> Signed-off-by: Yao Zi <ziyao@disroot.org>
> >>> ---
> >>>  arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts | 14 ++++++++++++++
> >>>  1 file changed, 14 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
> >>> index d2cdb63d4a9d..473065aa4228 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
> >>> @@ -12,6 +12,10 @@ / {
> >>>  	model = "Radxa E20C";
> >>>  	compatible = "radxa,e20c", "rockchip,rk3528";
> >>>  
> >>> +	aliases {
> >>> +		mmc0 = &sdmmc;
> >>
> >> Suggest using mmc1 for sd-card because the e20c typically have onboard
> >> emmc, compared to removable sd-card.
> > 
> > My board doesn't have an eMMC: it's optional as well, but all variants
> > of Radxa E20C come with an SD-card interface. The vendor devicetree sets
> > sdmmc as mmc0 as well[1].
> 
> This is strange as Radxa typically want to align with mmc0=emmc and
> mmc1=sd-card, as seen in [3] and [4].
> 
>   Align with other Radxa products.
>   - mmc0 is eMMC
>   - mmc1 is microSD
> 
> Also mainline U-Boot for Rockchip SoCs typically always treat mmc0 as
> emmc and mmc1 as sd-card, and for most SoCs it will even override the
> board aliases to have some predictability across boards.
> 
> > 
> > I won't insist on it and am willing to take the change if you still
> > consider mmc0 is better.
> 
> Yes, my position is that we should use following:

Ack. I got your point but there's a typo (s/mmc0/mmc1) in my reply.

>   mmc0 = &sdhci;
>   mmc1 = &sdmmc;
> 
> I will send out a short sdhci series based on top of v2 of this series.
> Driver changes was not needed to get basic sdhci working on RK3528 and
> is only required to get HS400 modes working.
> 
> [3] https://lore.kernel.org/r/20240620224435.2752-1-naoki@radxa.com
> [4] https://lore.kernel.org/r/20240619050047.1217-2-naoki@radxa.com
> 
> > 
> >>> +	};
> >>> +
> >>>  	chosen {
> >>>  		stdout-path = "serial0:1500000n8";
> >>>  	};
> >>> @@ -20,3 +24,13 @@ chosen {
> >>>  &uart0 {
> >>>  	status = "okay";
> >>>  };
> >>> +
> >>> +&sdmmc {
> 
> This node should be placed above &uart0 to be in alphabetical order.
> 

The original patch keeps the order of nodes in the SoC devicetree
(sorted by MMIO address), but alphabetical order seems more common. Will
fix in v2, thanks.

> >>> +	bus-width = <4>;
> >>> +	cap-mmc-highspeed;
> >>> +	cap-sd-highspeed;
> >>> +	disable-wp;
> >>> +	rockchip,default-sample-phase = <90>;
> >>> +	sd-uhs-sdr104;
 
Thanks,
Yao Zi
