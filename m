Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D682D5258
	for <linux-mmc@vger.kernel.org>; Sun,  2 Mar 2025 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740913306; cv=none; b=lK3H4vKGx5lXxnXC6hLnmACW6CWC6LbeInc8hLmVE+yAbnOKplhsZjQ2/sUv0SjNh7G5kH4tJZamfz6SFDjk/L/KJ+zK0/WYKe2R8C0QnPHZMbsfdaRbXaPpblXLrPW0dpOzvVqjwK8XJB53LsJKERpjSo7n+UR7XaeinFHWcfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740913306; c=relaxed/simple;
	bh=KUnys3Xiy1jo/gO60D3Flc66sLahi2ZFD78MfTjqu5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HF7ywRLLcsCl+hGN8Y90u30EmNbtZzQs6tBHB623fWPjQdX4/61RkSaYUHw0BpvvMfnND8x/fEWXN4YTudl3K1AwRxCvCJ1x4lgEhLYfa0Lw9EbXiwiE7Acgvu+lfuxaC/cqiE2L1BV2nw3gT/lhxAMP++73suIUndZqR6hVDJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=F6SZ35Qc; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="F6SZ35Qc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1740913304;
 bh=5yKjuNQgVLhguVs5lWSzRacCXnEfMSyFuE69y4uYr1E=;
 b=F6SZ35QcmEoxitylcaFYi8C/E0sWLYAmOhZr6J11xvy/xVu1+xf4qFWm5OOvjGZgAgOAjBPax
 EM6HirQPBC55PzMh49Wsz3ZMKw1geHKYmwJ+EhOgEIT4nwEiep6MOAMERvMia7FeCbzACPdxG5r
 57k59CfxTi7oySNM8h2MARO1abFtHfgs5khALP5LzAoS6goVVR0+OR7BC1JhS8imTMrdtZYk6vr
 OPEqBuwYNLAP+SudlBrzGTw4xhS3SKBWvFErGS0e4JrFa6+Pc/xfSovwwAWt388IoqqtIPoXJDN
 Bb4ox3LL0QVEDAQXpI/4POft/yHn8Qd4ixexuR5JuiJA==
X-Forward-Email-ID: 67c43a8f4a29b97c03d4da98
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3cb87f70-1838-4492-b78e-0cd98457cb83@kwiboo.se>
Date: Sun, 2 Mar 2025 12:01:29 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] arm64: dts: rockchip: Add SDMMC/SDIO controllers for
 RK3528
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Yao Zi <ziyao@disroot.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Frank Wang <frank.wang@rock-chips.com>,
 Shresth Prasad <shresthprasad7@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20250301104250.36295-1-ziyao@disroot.org>
 <20250301104749.36423-1-ziyao@disroot.org>
 <9fd51bcb-3e6a-46b6-b1f7-ff16fa562d9e@kwiboo.se> <3574922.QJadu78ljV@diego>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <3574922.QJadu78ljV@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Heiko,

On 2025-03-01 13:55, Heiko Stübner wrote:
> Hey Joas,
> 
> Am Samstag, 1. März 2025, 13:47:47 MEZ schrieb Jonas Karlman:
>> On 2025-03-01 11:47, Yao Zi wrote:
>>> RK3528 features two SDIO controllers and one SD/MMC controller, describe
>>> them in devicetree. Since their sample and drive clocks are located in
>>> the VO and VPU GRFs, corresponding syscons are added to make these
>>> clocks available.
>>>
>>> Signed-off-by: Yao Zi <ziyao@disroot.org>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 62 ++++++++++++++++++++++++
>>>  1 file changed, 62 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>> index 5b334690356a..078c97fa1d9f 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>> @@ -7,6 +7,7 @@
>>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>  #include <dt-bindings/clock/rockchip,rk3528-cru.h>
>>> +#include <dt-bindings/reset/rockchip,rk3528-cru.h>
>>>  
>>>  / {
>>>  	compatible = "rockchip,rk3528";
>>> @@ -122,6 +123,16 @@ gic: interrupt-controller@fed01000 {
>>>  			#interrupt-cells = <3>;
>>>  		};
>>>  
>>> +		vpu_grf: syscon@ff340000 {
>>> +			compatible = "rockchip,rk3528-vpu-grf", "syscon";
>>
>> vpu_grf is also used for gmac1, so should possible be a "syscon",
>> "simple-mfd", or have I misunderstood when to use simple-mfd ?
> 
> simple-mfd is needed when the additional device is completely contained
> inside the particular syscon.
> 
> For example, the usb2phy0 on rk3588 is completely living inside the
> usb2phy0-grf.
> 
> Similarly the power-domains are living inside the rk3588 pmugrf.
> But the pmugrf also contains more stuff, so the power-domains are a
> subset of the pmugrf.
> 
> Both of these above are a case for a simple-mfd.
> 
> 
> Similarly, gmac1 on rk3588 is ethernet@fe1c0000 , so a completely separate
> io-memory area, but references both the sysgrf as well as the php-grf
> as syscons for additional settings.
> 
> So here the syscon does not need to be a simple-mfd.
> 
> 
> Hope that helps a bit

Thanks for this explanation, it helped me better understand the meaning
of simple-mfd :-)

Regards,
Jonas

> Heiko
> 
> 

