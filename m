Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896561DDC1B
	for <linux-mmc@vger.kernel.org>; Sun,  2 Mar 2025 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740916615; cv=none; b=JZdu02LYfHp9xdfaYj0sud9Xe7d0PwwXJO/2T0sIs97FXAaAEjOEIqNIFEt7R1AdscEmEjEy4QXs9bRvJZOVTAhDEuWmAASsjIMUIxsZAYPZmUZODd2yAaThAZZDqoaKjv164ZOjTGH6nZVx2MvL3EhCzorUWDTZjz+pNZAgs08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740916615; c=relaxed/simple;
	bh=LeU1/j2GyN8/R98di9cex4/Y8KIZ4qEiGtA3Wac87iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rix2Cg2t3a6Nr4yDQyeFm8gN+4BE3gxLENxG8k3Wu0W0E9uJG3qpFwmEaTZoaI+KPXU8gCr1AG9CC/lDSmJIoVU5GHN5XW8iKhxM1aY6GaVlSblGQFUyW0FFRi/YCbSy1a2nd9duxSlApEsGN4KdPSiKxALqsdGE096NIymOgRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=uRC8Zjvo; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="uRC8Zjvo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1740916612;
 bh=29q7YvoaMhP8FsAjh3s2NLiuI28mnOHAXYyx1jVG3xA=;
 b=uRC8ZjvoDjKXWExYgESFLw4p9Kp38v6cmhWo3Bdm19UIKvOOFhcgg2zNJir8JAm3M0Yr+TCvw
 yqzJ5G6eEbWTk2h01ARLei6yQlQBtzHhcADJs9e96CIy6k4wPS/rZRyADRQKVjJI4WnS+Q0+2Mo
 DNyr1SZ7YMY+BBrnxA/COLD+AwC/RkJPJg/719EkwgScAdTpnOeqeZDoKbY0TETd0Cc2b2awZ1m
 vvcnYLIHpjCFEPr6WbN7IYl2AtS5Oeo0hARmoWWU2X3tGinN35JVwuTgfDLJk3ttTdHpZTc1FrP
 0J8nFPMybkSC2X64ZJdTXP7UjRIGHbAUk8bIbPXeSN7w==
X-Forward-Email-ID: 67c447804a29b97c03d4e25b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d6928adc-1df2-494f-a3d3-7b028c220547@kwiboo.se>
Date: Sun, 2 Mar 2025 12:56:42 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: dts: rockchip: Enable SD-card interface on
 Radxa E20C
To: Yao Zi <ziyao@disroot.org>, FUKAUMI Naoki <naoki@radxa.com>
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
 <0aefd292-7980-434d-9c18-4ab9f6a0b40e@kwiboo.se> <Z8MklJfFz2EA6oNS@pie.lan>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <Z8MklJfFz2EA6oNS@pie.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yao Zi,

On 2025-03-01 16:15, Yao Zi wrote:
> On Sat, Mar 01, 2025 at 02:01:05PM +0100, Jonas Karlman wrote:
>> Hi,
>>
>> On 2025-03-01 11:48, Yao Zi wrote:
>>> SD-card is available on Radxa E20C board.
>>>
>>> Signed-off-by: Yao Zi <ziyao@disroot.org>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
>>> index d2cdb63d4a9d..473065aa4228 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
>>> @@ -12,6 +12,10 @@ / {
>>>  	model = "Radxa E20C";
>>>  	compatible = "radxa,e20c", "rockchip,rk3528";
>>>  
>>> +	aliases {
>>> +		mmc0 = &sdmmc;
>>
>> Suggest using mmc1 for sd-card because the e20c typically have onboard
>> emmc, compared to removable sd-card.
> 
> My board doesn't have an eMMC: it's optional as well, but all variants
> of Radxa E20C come with an SD-card interface. The vendor devicetree sets
> sdmmc as mmc0 as well[1].

This is strange as Radxa typically want to align with mmc0=emmc and
mmc1=sd-card, as seen in [3] and [4].

  Align with other Radxa products.
  - mmc0 is eMMC
  - mmc1 is microSD

Also mainline U-Boot for Rockchip SoCs typically always treat mmc0 as
emmc and mmc1 as sd-card, and for most SoCs it will even override the
board aliases to have some predictability across boards.

> 
> I won't insist on it and am willing to take the change if you still
> consider mmc0 is better.

Yes, my position is that we should use following:

  mmc0 = &sdhci;
  mmc1 = &sdmmc;

I will send out a short sdhci series based on top of v2 of this series.
Driver changes was not needed to get basic sdhci working on RK3528 and
is only required to get HS400 modes working.

[3] https://lore.kernel.org/r/20240620224435.2752-1-naoki@radxa.com
[4] https://lore.kernel.org/r/20240619050047.1217-2-naoki@radxa.com

> 
>>> +	};
>>> +
>>>  	chosen {
>>>  		stdout-path = "serial0:1500000n8";
>>>  	};
>>> @@ -20,3 +24,13 @@ chosen {
>>>  &uart0 {
>>>  	status = "okay";
>>>  };
>>> +
>>> +&sdmmc {

This node should be placed above &uart0 to be in alphabetical order.

>>> +	bus-width = <4>;
>>> +	cap-mmc-highspeed;
>>> +	cap-sd-highspeed;
>>> +	disable-wp;
>>> +	rockchip,default-sample-phase = <90>;
>>> +	sd-uhs-sdr104;
>>
>> Are you sure uhs-sdr104 works as is should?
> 
> In fact yes, tuning succeeds at 148.5MHz and results in 66MB/s reading
> speed.
> 
>> Vendor kernel use a different "v2" tuning
> 
> This isn't a problem. IMHO V2 tuning is more like a quick path, which
> tries inheritting the phase from firmware and then re-tunes roughly.
> Fine tunning is still a fallback here in case of failure, see the commit
> message in the downstream kernel[2]. And testing proves it's okay for
> RK3528 to issue fine-tuning always.

Thanks for this information, I did not inspect exactly what the v2
tuning meant, only observed that vendor kernel (incorrectly) used a DT
prop to indicate when v2 tuning should be used.

> 
>> and this is also missing the vccio_sd vqmmc-supply to switch between
>> 3v3 and 1v8.
> 
> But this is a problem, thanks for catching it! Somehow my card managed
> to run at 148.5MHz with 3v3 voltage level, but it's definitely a
> compatiblity issue. I'm surprised that the driver doesn't complain when
> switching to SDR modes without a regulator configured.
> 
>> You could add following regulator for sdmmc:
>>
>> 	vccio_sd: regulator-vccio-sd {
>> 		compatible = "regulator-gpio";
>> 		gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
>> 		pinctrl-names = "default";
>> 		pinctrl-0 = <&sdmmc_vol_ctrl_h>;
>> 		regulator-name = "vccio_sd";
>> 		regulator-min-microvolt = <1800000>;
>> 		regulator-max-microvolt = <3300000>;
>> 		states = <1800000 0x0>, <3300000 0x1>;

This should also have something like:

  vin-supply = <&vcc5v0_sys>;

>> 	};
>>
>> and following pinctrl:
>>
>> 	sdmmc {
>> 		sdmmc_vol_ctrl_h: sdmmc-vol-ctrl-h {
>> 			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
>> 		};
>> 	};
>>
>> add then the power supplies to the sdmmc node:
>>
>> 	vmmc-supply = <&vcc_3v3>;
>> 	vqmmc-supply = <&vccio_sd>;
>>
>> That matches the schematics for e20c, and works when testing non-uhs modes.
> 
> Thanks for the hints. Will rebase on your pinctrl series and get
> regulators and pinctrl settings applied in the next version.

Thanks :-)

Regards,
Jonas

> 
>> Regards,
>> Jonas
>>
>>> +	status = "okay";
>>> +};
>>
> 
> Cheers,
> Yao Zi
> 
> [1]: https://github.com/radxa/kernel/blob/2b0c8de7dc4c68947cda206dcc2e457e9677e426/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts#L22-L26
> [2]: https://github.com/rockchip-linux/kernel/commit/795e052cc8610aa59a64b104f975cc4a45493d5d

