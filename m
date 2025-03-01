Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A555E1DED4B
	for <linux-mmc@vger.kernel.org>; Sat,  1 Mar 2025 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740834082; cv=none; b=SuQVHmSQfUE/WGO+/faeGIH/k6j8g6t9TyCaLdTbp5jtQ47rwVFjguVddyFa3OysUosD0pa2WoZEoXgDUr1763dW/NI72mjn5+RRsVfF9NfdLOp1Toviha2kZC5kh//WQvwQ3xRYsEZFeKfH7iz+shc43E4RC76rtel0YOyiL98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740834082; c=relaxed/simple;
	bh=9R505GuXCUgZibhXev+FfmDNPeBOSs3xDQi+XM/lnoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8/SpRbafyVfdVWqUwkkV9qrDNBLK3Kl2l+82EJ1D+xprJVR4uCsP/UENS84GHDHj45jX+IeppT0QPONT2rc7uJtovTge28lezB7sze7njUUi1xHTpjGSo/0Q2qdN548TPO+rbeoalaMuKRJyCPbyaNunI73Ii6Uc1RT1ew+HdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=weLrExoW; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="weLrExoW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1740834074;
 bh=9mCWNbcP5IQDd/FsJf4daDu5xuhSLsVfWH9gMluMv00=;
 b=weLrExoWL72K9p5bFJMPXLySLvsElVRUL8wrMkRaK145pcKTjerJ8zh35bHgoMnwl95XfueXR
 kAu7w+4oOgnS7WIc9LTo/mOQ54pv3uN6wC7vSnfZsPjTKOrhCbTvs/FB7/fpQETIYWGMib7Yrq2
 swV784/9lRimUWZJH/zs7jP+x2urWi2hJ/12gYh5MERvcEKP9MvNWCvwHBcJ9UVR/K8RfyV/QzZ
 vO1hunvAh/my8QD75BoMLohjg//hS/g/Tul4eBI7CC73fvRmYhza2bRs9v97vwKGZ4cBs17xe21
 aETKriUDC0dTTVAJyLnYfPox2V2X8xdeNqUvbW5S2HJQ==
X-Forward-Email-ID: 67c3051690cf55d47dbe9027
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <0aefd292-7980-434d-9c18-4ab9f6a0b40e@kwiboo.se>
Date: Sat, 1 Mar 2025 14:01:05 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: dts: rockchip: Enable SD-card interface on
 Radxa E20C
To: Yao Zi <ziyao@disroot.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Frank Wang <frank.wang@rock-chips.com>,
 Shresth Prasad <shresthprasad7@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20250301104250.36295-1-ziyao@disroot.org>
 <20250301104835.36439-1-ziyao@disroot.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250301104835.36439-1-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2025-03-01 11:48, Yao Zi wrote:
> SD-card is available on Radxa E20C board.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
> index d2cdb63d4a9d..473065aa4228 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
> @@ -12,6 +12,10 @@ / {
>  	model = "Radxa E20C";
>  	compatible = "radxa,e20c", "rockchip,rk3528";
>  
> +	aliases {
> +		mmc0 = &sdmmc;

Suggest using mmc1 for sd-card because the e20c typically have onboard
emmc, compared to removable sd-card.

> +	};
> +
>  	chosen {
>  		stdout-path = "serial0:1500000n8";
>  	};
> @@ -20,3 +24,13 @@ chosen {
>  &uart0 {
>  	status = "okay";
>  };
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	rockchip,default-sample-phase = <90>;
> +	sd-uhs-sdr104;

Are you sure uhs-sdr104 works as is should? Vendor kernel use a
different "v2" tuning and this is also missing the vccio_sd vqmmc-supply
to switch between 3v3 and 1v8.

You could add following regulator for sdmmc:

	vccio_sd: regulator-vccio-sd {
		compatible = "regulator-gpio";
		gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
		pinctrl-names = "default";
		pinctrl-0 = <&sdmmc_vol_ctrl_h>;
		regulator-name = "vccio_sd";
		regulator-min-microvolt = <1800000>;
		regulator-max-microvolt = <3300000>;
		states = <1800000 0x0>, <3300000 0x1>;
	};

and following pinctrl:

	sdmmc {
		sdmmc_vol_ctrl_h: sdmmc-vol-ctrl-h {
			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
		};
	};

add then the power supplies to the sdmmc node:

	vmmc-supply = <&vcc_3v3>;
	vqmmc-supply = <&vccio_sd>;

That matches the schematics for e20c, and works when testing non-uhs modes.

Regards,
Jonas

> +	status = "okay";
> +};

