From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH v4] arm: mach-mmp: brownstone.c support multiple sd slots
Date: Thu, 7 Jul 2011 00:12:19 +0800
Message-ID: <CAMPhdO-M9wsnop_1s3inO4LcDE_USTjGSpE-JisRKLvPr3UVSQ@mail.gmail.com>
References: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
 <20110427093328.GU17290@n2100.arm.linux.org.uk> <161C3F6C-0986-4364-B458-DBA4D08456FD@marvell.com>
 <1F336A22-BAC3-41E3-8D4E-5DF27874D1EA@marvell.com> <20110428095127.GX17290@n2100.arm.linux.org.uk>
 <3BFCE791-3BAD-42ED-BC87-A27F40D6C77C@marvell.com> <CAMPhdO-TTRP-k7J-zrG2_rQJsmNDRhTgpqiiX2yqW+Egf8+t2A@mail.gmail.com>
 <CAMj5BkiK17RMY-vEENDqQiDOmfG0Esnp7QDooKWVrhkQL4g6Ow@mail.gmail.com>
 <CAMPhdO-b_dpC2ueexEFujr6p_NRb2JwDc0-UEx3cfOSVcZ-d6w@mail.gmail.com>
 <67F311C7-B489-41E6-BC85-C06DACC7263A@marvell.com> <6AAC67C8-1C8F-4F15-9CED-5BA83CA21C39@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39458 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab1GFQMj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2011 12:12:39 -0400
Received: by vxb39 with SMTP id 39so40875vxb.19
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jul 2011 09:12:39 -0700 (PDT)
In-Reply-To: <6AAC67C8-1C8F-4F15-9CED-5BA83CA21C39@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Zhangfei Gao <zhangfei.gao@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Zhangfei Gao <zgao6@marvell.com>

On Thu, Jul 7, 2011 at 12:08 AM, Philip Rakity <prakity@marvell.com> wr=
ote:
> Eric,
>
> Not sure what to suggest.
>
> If it makes more sense to take V3 which powers on the wifi card but d=
oes not do power handling per
> new spec take that. =C2=A0At least wifi card works and then wait for =
power code. =C2=A0New code could delete
> power code as part of the mod.
>
> If it makes more sense to wait for power code -- take V4.
>

No worries. I'll wait for v4.

> Philip
>
>
>
>
> V4
> =3D=3D
> remove code to enable power for wifi. =C2=A0Coming in separate patch
> (by others) that conforms to new power architecture.
>
> V3
> =3D=3D
> Change since V2 -- delete mmc3 since it was committed
> to linux next.
>
> enable mmc1 used for wifi (8688) and marked PERMANENT.
> Wifi requires enabling of power on the device by
> toggling the gpio lines for power and reset.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
> =C2=A0arch/arm/mach-mmp/brownstone.c | =C2=A0 =C2=A08 +++++++-
> =C2=A01 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brown=
stone.c
> index c79162a..7634b2f 100644
> --- a/arch/arm/mach-mmp/brownstone.c
> +++ b/arch/arm/mach-mmp/brownstone.c
> @@ -180,6 +180,11 @@ static struct sdhci_pxa_platdata mmp2_sdh_platda=
ta_mmc0 =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.clk_delay_cycles =3D 0x1f,
> =C2=A0};
>
> +static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 =3D {
> + =C2=A0 =C2=A0 =C2=A0 .clk_delay_cycles =3D 0x1f,
> + =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D P=
XA_FLAG_CARD_PERMANENT,
> +};
> +
> =C2=A0static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.clk_delay_cycles =3D 0x1f,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D PXA_FLAG_CARD_PERMANENT
> @@ -195,8 +200,9 @@ static void __init brownstone_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmp2_add_uart(1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmp2_add_uart(3);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brow=
nstone_twsi1_info));
> - =C2=A0 =C2=A0 =C2=A0 mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /=
* SD/MMC */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2=
); /* eMMC */
> + =C2=A0 =C2=A0 =C2=A0 mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /=
* SD/MMC */
> + =C2=A0 =C2=A0 =C2=A0 mmp2_add_sdhost(1, &mmp2_sdh_platdata_mmc1); /=
* Wifi */
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* enable 5v regulator */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_device_register(&brownstone_v_5vp=
_device);
> --
> 1.7.0.4
>
>
>
