From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 3/4] ARM: dts: berlin: add the SDHCI nodes for the BG2Q
Date: Thu, 17 Apr 2014 08:54:20 +0200
Message-ID: <534F7A9C.2080609@gmail.com>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com> <1397652011-21284-4-git-send-email-antoine.tenart@free-electrons.com> <20140417113306.545ca4a7@xhacker>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:48805 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbaDQGy1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Apr 2014 02:54:27 -0400
In-Reply-To: <20140417113306.545ca4a7@xhacker>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart@free-electrons.com>
Cc: "chris@printf.net" <chris@printf.net>, "anton@enomsg.org" <anton@enomsg.org>, "alexandre.belloni@free-electrons.com" <alexandre.belloni@free-electrons.com>, Jimmy Xu <zmxu@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 04/17/2014 05:33 AM, Jisheng Zhang wrote:
> On Wed, 16 Apr 2014 05:40:10 -0700
> Antoine T=C3=A9nart <antoine.tenart@free-electrons.com> wrote:
>> Add the SDHCI nodes for the Marvell Berlin BG2Q, using the berlin-sd=
hci
>> driver.
[...]
>> +		sdhci0: sdhci@ab0000 {
>> +			compatible =3D "marvell,berlin2q-sdhci";
>> +			reg =3D <0xab0000 0x200>;
>> +			clocks =3D <&sdio1clk>;
>> +			interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
>> +			keep-power-in-suspend;
>> +			enable-sdio-wakeup;
>> +			broken-cd;
>> +			status =3D "disabled";
>> +		};
>> +
>> +		sdhci1: sdhci@ab0800 {
>> +			compatible =3D "marvell,berlin2q-sdhci";
>> +			reg =3D <0xab0800 0x200>;
>> +			clocks =3D <&sdio1clk>;
>> +			interrupts =3D <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
>> +			keep-power-in-suspend;
>> +			enable-sdio-wakeup;
>> +			status =3D "disabled";
>> +		};
>> +
>> +		sdhci2: sdhci@ab1000 {
>> +			compatible =3D "marvell,berlin2q-sdhci";
>> +			reg =3D <0xab1000 0x200>;
>> +			interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&sdio1clk>;
>> +			keep-power-in-suspend;
>> +			enable-sdio-wakeup;
>> +			broken-cd;
>> +			status =3D "disabled";
>> +		};
>=20
> could we put sdhci@ab1000 at the first of sdhci lists? For two reason=
s:

Don't reorder the nodes, but use aliases.

> 1. sdhci@ab0000 and sdhci@ab0800 is called as sdhci1 and sdhci2 in mr=
vl
> internal discussion, so this would make the name consistent when we
> upgrade linux kernel to one mainline version.

How about we only move the node labels?

> 2. sdhci@ab1000 is always used for emmc. if sdhci@ab0800 is put at th=
e
> head of sdhci@ab1000, and there's one sdcard in it, mmcblock0 would b=
e
> the sdcard rather than emmc.

And label this one sdhci0?

> I dunno whether there's elegant solutions for these two issues. alias=
? Could
> anyone kindly help?

Have a look at drivers/mmc/host/dw_mmc.c:

ctrl_id =3D of_alias_get_id(host->dev->of_node, "mshc");

this also requires an aliases node in berlin2foo.dtsi:

aliases {
	mshc0 =3D &sdhci0;
	mshc1 =3D &sdhci1;
	mshc2 =3D &sdhci2;
};

Rather than using "mshc", I'd prefer something like "sdio" or "mmc".

Also, if that alias would be part of generic mmc OF code would be
good too, but we'll have to wait for Chris' call here.

Sebastian
