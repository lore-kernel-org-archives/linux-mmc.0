Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE618DB09;
	Fri,  7 Mar 2025 05:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326896; cv=none; b=ejRbgi/pndb3JL8OmkeBuuBRu86K2Sn+wpDwkzxb+9yq7aJfBbAwV2z3YLzm5i6NDUvcG+d4KZOGIbSOL94s6akvEHklkk32cQKnLxol6haRB1YWhcJmKS/XvX+T8bnca3UbRysL3a5Q62dXBaezGqiYxyKwV8augEvigY7gsns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326896; c=relaxed/simple;
	bh=OhobIH36SElrBRrR9xlBtbM4ljdbiJGVn6a0IJ6ZmIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dl/OwVUXNM6zLyhgS6MBb/jDvQW8p9jaK3rx5hiMPwr3o8auvsjhiUPAC+ou4GHvtxQaR528szvS3bGAV7HuNRQhzeRDse1/PaHabSnvgMlfLE/fIL7xP3UM/AcHrGkcm2ZDgjefDPsyVMS76lzPmeh3fNMU5pJ3G0usBAmPQc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=aQ1AS8QJ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="aQ1AS8QJ"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 790E223CA6;
	Fri,  7 Mar 2025 06:54:52 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GEDfSjYbRJfd; Fri,  7 Mar 2025 06:54:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741326882; bh=OhobIH36SElrBRrR9xlBtbM4ljdbiJGVn6a0IJ6ZmIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aQ1AS8QJQnkqsjN6cCDhEslz1d7op9C+MUyuNcjmdwVvv9aj/jf046pMvlSwTDFLe
	 JdjylhVLOBu5OhPar3AT7/wLW/k+O2v2ezX4Doy9ucxYQBmKe6oCf2rnARVh5pszmC
	 KwlRCPeupk9T7U6pren2Kc7QXQ1hrvzpRe/RejNap3+4k7EcpS4FAeoOE33YSKRLjg
	 Frh7rHwFAuCkH4m56VZYphHMJgocffkPKppGe9TDWxWEZkd17G+lwUDzOgUzsyavHp
	 7LeOKmEqw9Cl9yWRRWDyooo9qpSVouUh0mLS9VMCebr+YQ3TLxsQa1pODij+tF7YRf
	 EHiDkQboMaEcw==
Date: Fri, 7 Mar 2025 05:54:27 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, cristian.ciocaltea@collabora.com,
	detlev.casanova@collabora.com, devicetree@vger.kernel.org,
	heiko@sntech.de, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 7/8] arm64: dts: rockchip: Add SDMMC/SDIO controllers
 for RK3528
Message-ID: <Z8qKEzmTFxhHKApG@pie>
References: <20250305194612.47171-1-ziyao@disroot.org>
 <20250306140009.384469-1-amadeus@jmu.edu.cn>
 <Z8nPjjbZvpRJ2R5B@pie.lan>
 <3d3db030-26e6-4fe1-9158-85f8cebef89c@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d3db030-26e6-4fe1-9158-85f8cebef89c@kwiboo.se>

On Fri, Mar 07, 2025 at 12:05:16AM +0100, Jonas Karlman wrote:
> On 2025-03-06 17:43, Yao Zi wrote:
> > On Thu, Mar 06, 2025 at 10:00:09PM +0800, Chukun Pan wrote:
> >> Hi,
> >>
> >>> +		sdio0: mmc@ffc10000 {
> >>> +			compatible = "rockchip,rk3528-dw-mshc",
> >>> +				     "rockchip,rk3288-dw-mshc";
> >>> +			reg = <0x0 0xffc10000 0x0 0x4000>;
> >>> +			clocks = <&cru HCLK_SDIO0>,
> >>> +				 <&cru CCLK_SRC_SDIO0>,
> >>> +				 <&cru SCLK_SDIO0_DRV>,
> >>> +				 <&cru SCLK_SDIO0_SAMPLE>;
> >>> +			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> >>> +			fifo-depth = <0x100>;
> >>> +			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> >>> +			max-frequency = <150000000>;
> >>> +			pinctrl-names = "default";
> >>> +			pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>,
> >>> +				    <&sdio0_det>, <&sdio0_pwren>;
> >>
> >> The sdio module is usually "non-removable", no need det,
> >> and pwren may be other gpio (use mmc-pwrseq). So it should
> >> be `pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>;`
> > 
> > This doesn't affect the fact that these two pins are assigned as
> > functional pins for SDIO0, as pointed out by the datasheet[1].
> > 
> > But with more digging, I found the reference design[2] of Rockchip
> > actually uses the two pins as normal GPIOs. This is more obvious in
> > downstream devicetree of an EVB[3]. Most of the existing boards (Radxa
> > 2A, ArmSOM Sige 1) follow the reference design.
> > 
> > For me, it's kind of surprising that the SDIO IP functions with two
> > functional pins assigned as different modes. I'm not sure whether we
> > should apply pin configuration for these two pins in the SoC devicetree.
> > Jonas, what do you think about it?
> 
> I think it make sense to match the pins used by reference boards, i.e.
> the pinconf most likely to be used by majority of boards that will use
> the sdio interface.

Thanks, will take it.

> Of my RK3528 boards, only ArmSoM Sige1 use sdio for onboard wifi and
> there I currently have following in my work-in-progress board DT [4]:
> 
>   pinctrl-names = "default";
>   pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>, <&clkm1_32k_out>;
> 
> The Radxa ROCK 2A/2F seem to use USB for wifi/bt.
> 
> [4] https://github.com/Kwiboo/linux-rockchip/blob/next-20250305-rk3528/arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
> 
> Regards,
> Jonas
> 
> > 
> >>> +			resets = <&cru SRST_H_SDIO0>;
> >>> +			reset-names = "reset";
> >>> +			status = "disabled";
> >>> +		};
> >>> +
> >>> +		sdio1: mmc@ffc20000 {
> >>> +			compatible = "rockchip,rk3528-dw-mshc",
> >>> +				     "rockchip,rk3288-dw-mshc";
> >>> +			reg = <0x0 0xffc20000 0x0 0x4000>;
> >>> +			clocks = <&cru HCLK_SDIO1>,
> >>> +				 <&cru CCLK_SRC_SDIO1>,
> >>> +				 <&cru SCLK_SDIO1_DRV>,
> >>> +				 <&cru SCLK_SDIO1_SAMPLE>;
> >>> +			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> >>> +			fifo-depth = <0x100>;
> >>> +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> >>> +			max-frequency = <150000000>;
> >>> +			pinctrl-names = "default";
> >>> +			pinctrl-0 = <&sdio1_bus4>, <&sdio1_clk>, <&sdio1_cmd>,
> >>> +				    <&sdio1_det>, <&sdio1_pwren>;
> >>
> >> Same here.
> >>
> >>> +			resets = <&cru SRST_H_SDIO1>;
> >>> +			reset-names = "reset";
> >>> +			status = "disabled";
> >>> +		};
> >>
> >> Thanks,
> >> Chukun
> >>
> >> -- 
> >> 2.25.1
> >>
> > 
> > Best regards,
> > Yao Zi
> > 
> > [1]: https://github.com/DeciHD/rockchip_docs/blob/main/rk3528/Rockchip%C2%A0RK3528%C2%A0Datasheet%C2%A0V1.0-20230522.pdf
> > [2]: https://github.com/DeciHD/rockchip_docs/blob/main/rk3528/RK3528_BOX_REF_V10_20230525.pdf
> > [3]: https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3528-evb1-ddr4-v10.dtsi#L128
> 

Best regards,
Yao Zi
