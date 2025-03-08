Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769F7482;
	Sat,  8 Mar 2025 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741442786; cv=none; b=oWk9ez8MKSWYH4BoinUpuJRpnQhrB9ftJC/MHfzGpVuxoZlfPgOfWZfH6gD/myACd8pAKSC8eWS06TolExxYd5J9QlGDGKCE25g2P1jNyA2t+e8g3wFkOOhtuuIsVgX3h2Z4bvK+mQQVKYAA3jiuQDEG0TK+JlSpGKo/2Ud1oWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741442786; c=relaxed/simple;
	bh=kGemAZ9EVDuCpSfW33snc8SJJJ1dseQQAUsecXVAtcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3dPn6QH4fjeIRnLFTtWay+mMMWVAbnNSXh4FAzNXD6zy86bWv+GPIuwWHtmE4aCLH5Y5UMYEEsaY/6Gbb3gw4HGU2pgQG2UEXiUH95Uqc0enkEd4rbwSkkv/BoJCm3wG0GTS75tZJtTYxOjxzdC+cV+f0p0gDBLW89+8gmvSRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Ng0E9bDJ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Ng0E9bDJ"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 211B825D93;
	Sat,  8 Mar 2025 15:06:22 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id preILQABPQVZ; Sat,  8 Mar 2025 15:06:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741442777; bh=kGemAZ9EVDuCpSfW33snc8SJJJ1dseQQAUsecXVAtcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ng0E9bDJucpkyJhzo+6yIzH66iSp0oNsv9ZSg44P/KyxctIGSs9wnhL2rp+IwWsRZ
	 WjkB0pK7LqQxgnt7AgzYku0wiM3bXJIs40NPXJvOyvQd9+0WoeM3Y9FZM7T/foMIJ1
	 RnQGVuXdJpeu5jQULN0gIixh9PFqdOkgC8Nm1Jdd4DTEZ4kPaJZlubQLcSnmRatsXp
	 ZIrM+UHeucNDRvoEqTN27oS7sSEfpJzO6S2j5somCX80RMpci0UnF1vU7StNghauPr
	 4qE7T4/kcmEA2adZg5y0BeH+MtD9exyyXQrYwI3yVigIBd5vToyuAce+4a4WxVmie8
	 LqmTuoIAN7Yvg==
Date: Sat, 8 Mar 2025 14:05:53 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Chukun Pan <amadeus@jmu.edu.cn>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 7/8] arm64: dts: rockchip: Add SDMMC/SDIO controllers
 for RK3528
Message-ID: <Z8xOwbfNqBfkRAi6@pie>
References: <20250305194217.47052-1-ziyao@disroot.org>
 <20250305194612.47171-1-ziyao@disroot.org>
 <56181131-3e48-4c76-87c7-2388a9964727@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56181131-3e48-4c76-87c7-2388a9964727@kwiboo.se>

On Sat, Mar 08, 2025 at 12:22:48AM +0100, Jonas Karlman wrote:
> Hi Yao Zi,
> 
> On 2025-03-05 20:46, Yao Zi wrote:
> > RK3528 features two SDIO controllers and one SD/MMC controller, describe
> > them in devicetree. Since their sample and drive clocks are located in
> > the VO and VPU GRFs, corresponding syscons are added to make these
> > clocks available.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 70 ++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > index d3e2a64ff2d5..363023314e9c 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > @@ -130,6 +130,16 @@ gic: interrupt-controller@fed01000 {
> >  			#interrupt-cells = <3>;
> >  		};
> >  
> > +		vpu_grf: syscon@ff340000 {
> > +			compatible = "rockchip,rk3528-vpu-grf", "syscon";
> > +			reg = <0x0 0xff340000 0x0 0x8000>;
> > +		};
> > +
> > +		vo_grf: syscon@ff360000 {
> > +			compatible = "rockchip,rk3528-vo-grf", "syscon";
> > +			reg = <0x0 0xff360000 0x0 0x10000>;
> > +		};
> > +
> >  		cru: clock-controller@ff4a0000 {
> >  			compatible = "rockchip,rk3528-cru";
> >  			reg = <0x0 0xff4a0000 0x0 0x30000>;
> > @@ -274,6 +284,66 @@ saradc: adc@ffae0000 {
> >  			resets = <&cru SRST_P_SARADC>;
> >  			reset-names = "saradc-apb";
> >  			#io-channel-cells = <1>;
> > +		};
> 
> Look like this patch accidentally drops status = "disabled" from the
> adc@ffae0000 node.

It's a mistake during rebasing, I'll fix it in v3.

> Regards,
> Jonas

Thanks,
Yao Zi
