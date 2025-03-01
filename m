Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1256633E1;
	Sat,  1 Mar 2025 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740842167; cv=none; b=IGrIfi+Qd3caQ3tOiALtNJhHHapZgs9VHGSVG9Jawi31SvRmxBGpsviZIsBod2SJePjxkhY0XYSOFRsqeKvQEk18SF/yhRWjolgLnOvqYSBsA8cjj5c7gXntSqh26YCjvQRbAl59RZINbRWioQt3YuMRW3kjRHiMG5PRVAaN4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740842167; c=relaxed/simple;
	bh=OmrR4xD/XRUKk2rcMTrbTAl5fxjRwq+7cvLzauhy6QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsF3NIjJywSh69G1d2FdSbiFKsaDXOjWvDrkNA9zrDF4VhPxtGcO/kHHrJvYiloQ6vuJ7yfXzZaA7MXnXnLhZhqkArXZeNOqC9ujWltMN6pskB2oEkEmf6d8LO/k2QrON0FkGuyK1sv8Sfq40v/ANYCYDAAbujIxrO01yLU83vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=EBrD/O9R; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="EBrD/O9R"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4033220523;
	Sat,  1 Mar 2025 16:15:59 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0iebN7Isx1Km; Sat,  1 Mar 2025 16:15:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740842157; bh=OmrR4xD/XRUKk2rcMTrbTAl5fxjRwq+7cvLzauhy6QI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EBrD/O9RrVrUYRP+VtXW2Qnd/HbT6/xhYVGcT888/R1u+nZe8io1CWfIKSlqN+xVh
	 uosX1SmQ+uG6WyBFrvoMmT17JPz6bItHX9gMyXNllu8xgSfizzV9/xYzM1LbNK//Et
	 VcfncIB0U4fB6PdG2Wr0kCCH4CPj0lKLyBnVPppk3SVEeRppfh+BHYiHR7srIIZm6A
	 ZuNv1C5GeFy9qJKkYwH4vp2FPQ8LHcyP+uq4wv0TAsSn/7aviqrzZh7AF4LU9X0ETQ
	 SdYn8QlV+4DLyohYjHZH6LlYQEMSzJDnHQBh8QLhYMBEBNdU96iGwsLn5J5LXGnR6b
	 mXqu6/2U4c1gw==
Date: Sat, 1 Mar 2025 15:15:32 +0000
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
Subject: Re: [PATCH 8/8] arm64: dts: rockchip: Enable SD-card interface on
 Radxa E20C
Message-ID: <Z8MklJfFz2EA6oNS@pie.lan>
References: <20250301104250.36295-1-ziyao@disroot.org>
 <20250301104835.36439-1-ziyao@disroot.org>
 <0aefd292-7980-434d-9c18-4ab9f6a0b40e@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aefd292-7980-434d-9c18-4ab9f6a0b40e@kwiboo.se>

On Sat, Mar 01, 2025 at 02:01:05PM +0100, Jonas Karlman wrote:
> Hi,
> 
> On 2025-03-01 11:48, Yao Zi wrote:
> > SD-card is available on Radxa E20C board.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
> > index d2cdb63d4a9d..473065aa4228 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
> > @@ -12,6 +12,10 @@ / {
> >  	model = "Radxa E20C";
> >  	compatible = "radxa,e20c", "rockchip,rk3528";
> >  
> > +	aliases {
> > +		mmc0 = &sdmmc;
> 
> Suggest using mmc1 for sd-card because the e20c typically have onboard
> emmc, compared to removable sd-card.

My board doesn't have an eMMC: it's optional as well, but all variants
of Radxa E20C come with an SD-card interface. The vendor devicetree sets
sdmmc as mmc0 as well[1].

I won't insist on it and am willing to take the change if you still
consider mmc0 is better.

> > +	};
> > +
> >  	chosen {
> >  		stdout-path = "serial0:1500000n8";
> >  	};
> > @@ -20,3 +24,13 @@ chosen {
> >  &uart0 {
> >  	status = "okay";
> >  };
> > +
> > +&sdmmc {
> > +	bus-width = <4>;
> > +	cap-mmc-highspeed;
> > +	cap-sd-highspeed;
> > +	disable-wp;
> > +	rockchip,default-sample-phase = <90>;
> > +	sd-uhs-sdr104;
> 
> Are you sure uhs-sdr104 works as is should?

In fact yes, tuning succeeds at 148.5MHz and results in 66MB/s reading
speed.

> Vendor kernel use a different "v2" tuning

This isn't a problem. IMHO V2 tuning is more like a quick path, which
tries inheritting the phase from firmware and then re-tunes roughly.
Fine tunning is still a fallback here in case of failure, see the commit
message in the downstream kernel[2]. And testing proves it's okay for
RK3528 to issue fine-tuning always.

> and this is also missing the vccio_sd vqmmc-supply to switch between
> 3v3 and 1v8.

But this is a problem, thanks for catching it! Somehow my card managed
to run at 148.5MHz with 3v3 voltage level, but it's definitely a
compatiblity issue. I'm surprised that the driver doesn't complain when
switching to SDR modes without a regulator configured.

> You could add following regulator for sdmmc:
> 
> 	vccio_sd: regulator-vccio-sd {
> 		compatible = "regulator-gpio";
> 		gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&sdmmc_vol_ctrl_h>;
> 		regulator-name = "vccio_sd";
> 		regulator-min-microvolt = <1800000>;
> 		regulator-max-microvolt = <3300000>;
> 		states = <1800000 0x0>, <3300000 0x1>;
> 	};
>
> and following pinctrl:
> 
> 	sdmmc {
> 		sdmmc_vol_ctrl_h: sdmmc-vol-ctrl-h {
> 			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> 		};
> 	};
> 
> add then the power supplies to the sdmmc node:
> 
> 	vmmc-supply = <&vcc_3v3>;
> 	vqmmc-supply = <&vccio_sd>;
> 
> That matches the schematics for e20c, and works when testing non-uhs modes.

Thanks for the hints. Will rebase on your pinctrl series and get
regulators and pinctrl settings applied in the next version.

> Regards,
> Jonas
> 
> > +	status = "okay";
> > +};
> 

Cheers,
Yao Zi

[1]: https://github.com/radxa/kernel/blob/2b0c8de7dc4c68947cda206dcc2e457e9677e426/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts#L22-L26
[2]: https://github.com/rockchip-linux/kernel/commit/795e052cc8610aa59a64b104f975cc4a45493d5d
