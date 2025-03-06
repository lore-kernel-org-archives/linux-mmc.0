Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600BE2135CF;
	Thu,  6 Mar 2025 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279469; cv=none; b=X8vqUYUYaQNOM0s/UyLFORNYrXVhwxMFYO/MVBNhFnDmV1snurkJVc3kCcAM4rdcZt7TnAC+Mtfa3dGwLRZgByMI2XkPNzT3qO+eY2WqcoQVtVUXC7nE+uctVITivYsaGGot59EYRw0y4VaWZXnp06ofqJ4e8QS9Dxbq+d6/HJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279469; c=relaxed/simple;
	bh=7IP4WYiQ3uqZxjps9WZ0ItIBn+105bQ4pKd1dSZCV54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrBHsXn2wPZTQpMCyW9vDJhLPIDFwwNudnC9MZR4PMa9INfL0koOf4DvGj5FpHQCGlWQdDc3vgNvBJa0oqHucKar+KOVqsp8gnDdVuFTtxkbP1IzkKk5umg8fyxL1WN/+x6yTCSApf+VqN6b2OT6FC44jbP1xNC4F2xgWB1WHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Jf8ScI9j; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Jf8ScI9j"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id BD6D02024D;
	Thu,  6 Mar 2025 17:44:23 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dSLASKqzoBGZ; Thu,  6 Mar 2025 17:44:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741279459; bh=7IP4WYiQ3uqZxjps9WZ0ItIBn+105bQ4pKd1dSZCV54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jf8ScI9jkEuLiR/sOtykcPvGSgXJ8+inW3qRRiIdlp/sxGRUyevCKvAsAZcbAFGQR
	 BbU895Oxz+Lxg7MULJW1vdE+AzEoAAZPVRbw0L8biaaaWthW7Q6d0mPfl2jkqMAoPN
	 8FT8KXjH//vrtkR4LGJWJwoR40wQ9QSmTkfgGGaHENKCm57Wua+d1ShJBLnKS/cDOz
	 5Vg3S5nSqtEkWFKQgzirDV2umLYIP9/4kICm/iH4CxucZsn/laSVkvJ8K3MntZMC+C
	 PZCWaAHnWlBSYJnsdfNBnjcvkkF4nd2eO+uRjVavp4dU5/auz0LwTgKT22+MYP05hp
	 f1P9lVdmK7Zhg==
Date: Thu, 6 Mar 2025 16:43:54 +0000
From: Yao Zi <ziyao@disroot.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, cristian.ciocaltea@collabora.com,
	detlev.casanova@collabora.com, devicetree@vger.kernel.org,
	heiko@sntech.de, jonas@kwiboo.se, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 7/8] arm64: dts: rockchip: Add SDMMC/SDIO controllers
 for RK3528
Message-ID: <Z8nPjjbZvpRJ2R5B@pie.lan>
References: <20250305194612.47171-1-ziyao@disroot.org>
 <20250306140009.384469-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306140009.384469-1-amadeus@jmu.edu.cn>

On Thu, Mar 06, 2025 at 10:00:09PM +0800, Chukun Pan wrote:
> Hi,
> 
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
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>,
> > +				    <&sdio0_det>, <&sdio0_pwren>;
> 
> The sdio module is usually "non-removable", no need det,
> and pwren may be other gpio (use mmc-pwrseq). So it should
> be `pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>;`

This doesn't affect the fact that these two pins are assigned as
functional pins for SDIO0, as pointed out by the datasheet[1].

But with more digging, I found the reference design[2] of Rockchip
actually uses the two pins as normal GPIOs. This is more obvious in
downstream devicetree of an EVB[3]. Most of the existing boards (Radxa
2A, ArmSOM Sige 1) follow the reference design.

For me, it's kind of surprising that the SDIO IP functions with two
functional pins assigned as different modes. I'm not sure whether we
should apply pin configuration for these two pins in the SoC devicetree.
Jonas, what do you think about it?

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
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&sdio1_bus4>, <&sdio1_clk>, <&sdio1_cmd>,
> > +				    <&sdio1_det>, <&sdio1_pwren>;
> 
> Same here.
> 
> > +			resets = <&cru SRST_H_SDIO1>;
> > +			reset-names = "reset";
> > +			status = "disabled";
> > +		};
> 
> Thanks,
> Chukun
> 
> -- 
> 2.25.1
> 

Best regards,
Yao Zi

[1]: https://github.com/DeciHD/rockchip_docs/blob/main/rk3528/Rockchip%C2%A0RK3528%C2%A0Datasheet%C2%A0V1.0-20230522.pdf
[2]: https://github.com/DeciHD/rockchip_docs/blob/main/rk3528/RK3528_BOX_REF_V10_20230525.pdf
[3]: https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3528-evb1-ddr4-v10.dtsi#L128
