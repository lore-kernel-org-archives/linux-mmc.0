Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE40738DDB;
	Sat,  1 Mar 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740836035; cv=none; b=o3tIQodoAOmtimzfku/UYwVlJm/o+bzj2Y8XcNNdRScVMWwK/wa4KYTV1H/YzeJnwzgQyOQYOTJ1rslwbru9btYbq/p2PFXGKTOa4kpL29ChH2BxV4RA9CWMj484TH2MenZY5KOgsaH3aL4HgnmyLjRoQ4n+XnRGZRc0mH38edw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740836035; c=relaxed/simple;
	bh=xXhNfYs+Cv3fr3hX+44GY6JZm8B/alrDUCYDIA/ILNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MABZhRLRCINZs+juEW459pjf1dmgA6TSM8AGPhn35VePLB5yLkv5U4oGh3fUvOpdszuOyyIRivpNv3tDU03zYVPXlSMtq63B8LZigCvaHXZXdr6KCB2QLs0/oJ/HkywFYXpoR88GN7lfRDks+qkmt7waPBhAbYXjcuUC6mY/YzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=QTMG5tFI; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="QTMG5tFI"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E788925D49;
	Sat,  1 Mar 2025 14:33:49 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hNqLrBIrmw-s; Sat,  1 Mar 2025 14:33:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740836025; bh=xXhNfYs+Cv3fr3hX+44GY6JZm8B/alrDUCYDIA/ILNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QTMG5tFIqlv9LH5jixi4XxdUJKRFJpm4Rs5l2NruS3JwN2+12m0f5f1cVWZmwGD0k
	 w84ZoPqHAOjEyFradRFbRJxjfkAsjZLtCBVDmwr3VN6EjKybTPe/w4bR7t3HwwzkIr
	 D0FynI+BR+izgsEsEMEZUfeceFlVar3wYfI9KqgfRuLj19mx4L/CBz6ZH7hRO8Pt0T
	 R3HllikmI8V/V7/P+NT8CuQRCfKijIQ7aaCQ/Ljjw8JR7mFPM+tqQP0SrbjULnUCY6
	 gObIsg3FpsedbizyfKVUuhjJ5DwIAGmHP2cTlX8BKjXgD6Ko/fj0UFVYP/zOawg9gq
	 2okGgpIGJffJQ==
Date: Sat, 1 Mar 2025 13:33:15 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jonas Karlman <jonas@kwiboo.se>
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
Subject: Re: [PATCH 7/8] arm64: dts: rockchip: Add SDMMC/SDIO controllers for
 RK3528
Message-ID: <Z8MMm7X31p_CrStZ@pie>
References: <20250301104250.36295-1-ziyao@disroot.org>
 <20250301104749.36423-1-ziyao@disroot.org>
 <9fd51bcb-3e6a-46b6-b1f7-ff16fa562d9e@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fd51bcb-3e6a-46b6-b1f7-ff16fa562d9e@kwiboo.se>

On Sat, Mar 01, 2025 at 01:47:47PM +0100, Jonas Karlman wrote:
> Hi,
> 
> On 2025-03-01 11:47, Yao Zi wrote:
> > RK3528 features two SDIO controllers and one SD/MMC controller, describe
> > them in devicetree. Since their sample and drive clocks are located in
> > the VO and VPU GRFs, corresponding syscons are added to make these
> > clocks available.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 62 ++++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > index 5b334690356a..078c97fa1d9f 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > @@ -7,6 +7,7 @@
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/clock/rockchip,rk3528-cru.h>
> > +#include <dt-bindings/reset/rockchip,rk3528-cru.h>
> >  
> >  / {
> >  	compatible = "rockchip,rk3528";
> > @@ -122,6 +123,16 @@ gic: interrupt-controller@fed01000 {
> >  			#interrupt-cells = <3>;
> >  		};
> >  
> > +		vpu_grf: syscon@ff340000 {
> > +			compatible = "rockchip,rk3528-vpu-grf", "syscon";
> 
> vpu_grf is also used for gmac1, so should possible be a "syscon",
> "simple-mfd", or have I misunderstood when to use simple-mfd ?

Just as Heiko explained, "simple-mfd" is only required when the child
nodes should be populated automatically. Here these two GRFs are only
referenced and have no child, thus "simple-mfd" compatible isn't useful.

> > +			reg = <0x0 0xff340000 0x0 0x8000>;
> > +		};
> > +
> > +		vo_grf: syscon@ff360000 {
> > +			compatible = "rockchip,rk3528-vo-grf", "syscon";
> 
> similar here, vo_grf is also used for gmac0.
> 
> > +			reg = <0x0 0xff360000 0x0 0x10000>;
> > +		};
> > +
> >  		cru: clock-controller@ff4a0000 {
> >  			compatible = "rockchip,rk3528-cru";
> >  			reg = <0x0 0xff4a0000 0x0 0x30000>;
> > @@ -251,5 +262,56 @@ uart7: serial@ffa28000 {
> >  			reg-shift = <2>;
> >  			status = "disabled";
> >  		};
> > +
> > +		sdio0: mmc@ffc10000 {
> > +			compatible = "rockchip,rk3528-dw-mshc",
> > +				     "rockchip,rk3288-dw-mshc";
> > +			reg = <0x0 0xffc10000 0x0 0x4000>;
> > +			clocks = <&cru HCLK_SDIO0>,
> > +				 <&cru CCLK_SRC_SDIO0>,
> > +				 <&cru SCLK_SDIO0_DRV>,
> > +				 <&cru SCLK_SDIO0_SAMPLE>;
> > +			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> > +			fifo-depth = <0x100>;
> > +			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> > +			max-frequency = <150000000>;
> > +			resets = <&cru SRST_H_SDIO0>;
> > +			reset-names = "reset";
> > +			status = "disabled";
> > +		};
> > +
> > +		sdio1: mmc@ffc20000 {
> > +			compatible = "rockchip,rk3528-dw-mshc",
> > +				     "rockchip,rk3288-dw-mshc";
> > +			reg = <0x0 0xffc20000 0x0 0x4000>;
> > +			clocks = <&cru HCLK_SDIO1>,
> > +				 <&cru CCLK_SRC_SDIO1>,
> > +				 <&cru SCLK_SDIO1_DRV>,
> > +				 <&cru SCLK_SDIO1_SAMPLE>;
> > +			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> > +			fifo-depth = <0x100>;
> > +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> > +			max-frequency = <150000000>;
> > +			resets = <&cru SRST_H_SDIO1>;
> > +			reset-names = "reset";
> > +			status = "disabled";
> > +		};
> > +
> > +		sdmmc: mmc@ffc30000 {
> > +			compatible = "rockchip,rk3528-dw-mshc",
> > +				     "rockchip,rk3288-dw-mshc";
> > +			reg = <0x0 0xffc30000 0x0 0x4000>;
> > +			clocks = <&cru HCLK_SDMMC0>,
> > +				 <&cru CCLK_SRC_SDMMC0>,
> > +				 <&cru SCLK_SDMMC_DRV>,
> > +				 <&cru SCLK_SDMMC_SAMPLE>;
> > +			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> > +			fifo-depth = <0x100>;
> > +			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> > +			max-frequency = <150000000>;
> > +			resets = <&cru SRST_H_SDMMC0>;
> > +			reset-names = "reset";
> 
> Suggest adding default pinctrl props here:
> 
>   pinctrl-names = "default";
>   pinctrl-0 = <&sdmmc_bus4>, <&sdmmc_clk>, <&sdmmc_cmd>, <&sdmmc_det>;
> 
> And possible also for sdio0 and sdio1.
> 
> Regards,
> Jonas

It makes sense. As mentioned in the cover letter, I depended on the
bootloader to setup pinctrl, to minimize dependency of the series.

Will complete the pinctrl properties in next version.

> > +			status = "disabled";
> > +		};
> >  	};
> >  };
> 

Best regards,
Yao Zi
