From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH 3/4] ARM: dts: berlin: add the SDHCI nodes for the BG2Q
Date: Thu, 17 Apr 2014 11:33:06 +0800
Message-ID: <20140417113306.545ca4a7@xhacker>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
	<1397652011-21284-4-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:61136 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756358AbaDQDfU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Apr 2014 23:35:20 -0400
In-Reply-To: <1397652011-21284-4-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Antoine =?UTF-8?B?VMOpbmFydA==?= <antoine.tenart@free-electrons.com>
Cc: "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>, "chris@printf.net" <chris@printf.net>, "anton@enomsg.org" <anton@enomsg.org>, "alexandre.belloni@free-electrons.com" <alexandre.belloni@free-electrons.com>, Jimmy Xu <zmxu@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Antoine,

On Wed, 16 Apr 2014 05:40:10 -0700
Antoine T=C3=A9nart <antoine.tenart@free-electrons.com> wrote:

> Add the SDHCI nodes for the Marvell Berlin BG2Q, using the berlin-sdh=
ci
> driver.
>=20
> Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com=
>
> ---
>  arch/arm/boot/dts/berlin2q.dtsi | 40
> ++++++++++++++++++++++++++++++++++++++++ 1 file changed, 40 insertion=
s(+)
>=20
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi
> b/arch/arm/boot/dts/berlin2q.dtsi index 5925e6a16749..8f897d461460 10=
0644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -67,6 +67,14 @@
>  		clock-div =3D <3>;
>  	};
> =20
> +	sdio1clk: sdio1clk {
> +		compatible =3D "fixed-factor-clock";
> +		#clock-cells =3D <0>;
> +		clocks =3D <&syspll>;
> +		clock-mult =3D <1>;
> +		clock-div =3D <4>;
> +	};
> +
>  	soc {
>  		compatible =3D "simple-bus";
>  		#address-cells =3D <1>;
> @@ -75,6 +83,38 @@
>  		ranges =3D <0 0xf7000000 0x1000000>;
>  		interrupt-parent =3D <&gic>;
> =20
> +		sdhci0: sdhci@ab0000 {
> +			compatible =3D "marvell,berlin2q-sdhci";
> +			reg =3D <0xab0000 0x200>;
> +			clocks =3D <&sdio1clk>;
> +			interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +			keep-power-in-suspend;
> +			enable-sdio-wakeup;
> +			broken-cd;
> +			status =3D "disabled";
> +		};
> +
> +		sdhci1: sdhci@ab0800 {
> +			compatible =3D "marvell,berlin2q-sdhci";
> +			reg =3D <0xab0800 0x200>;
> +			clocks =3D <&sdio1clk>;
> +			interrupts =3D <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> +			keep-power-in-suspend;
> +			enable-sdio-wakeup;
> +			status =3D "disabled";
> +		};
> +
> +		sdhci2: sdhci@ab1000 {
> +			compatible =3D "marvell,berlin2q-sdhci";
> +			reg =3D <0xab1000 0x200>;
> +			interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&sdio1clk>;
> +			keep-power-in-suspend;
> +			enable-sdio-wakeup;
> +			broken-cd;
> +			status =3D "disabled";
> +		};

could we put sdhci@ab1000 at the first of sdhci lists? For two reasons:

1. sdhci@ab0000 and sdhci@ab0800 is called as sdhci1 and sdhci2 in mrvl
internal discussion, so this would make the name consistent when we
upgrade linux kernel to one mainline version.

2. sdhci@ab1000 is always used for emmc. if sdhci@ab0800 is put at the
head of sdhci@ab1000, and there's one sdcard in it, mmcblock0 would be
the sdcard rather than emmc.

I dunno whether there's elegant solutions for these two issues. alias? =
Could
anyone kindly help?

Thanks in advance,
Jisheng
