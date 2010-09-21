From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] add support PXA168/PXA910/MMP2 SD Host Controller
Date: Tue, 21 Sep 2010 04:24:39 -0400
Message-ID: <AANLkTin0ZDmTJ5gea65BiU+dWy+nD=wjp_xDOgYzxZF8@mail.gmail.com>
References: <AANLkTi=jeL0J1kfT+toB3BEAGJ5Cc5jZsHstD1hutNQB@mail.gmail.com>
	<20100920095042.GC4058@pengutronix.de>
	<AANLkTin28uj+L+AyUYVwoAyaUOmpfw3tc6JFEcVgtXBy@mail.gmail.com>
	<20100920131055.GE4058@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62262 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756436Ab0IUI3R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2010 04:29:17 -0400
Received: by iwn5 with SMTP id 5so4969268iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Sep 2010 01:29:16 -0700 (PDT)
In-Reply-To: <20100920131055.GE4058@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

On Mon, Sep 20, 2010 at 9:10 AM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
> On Mon, Sep 20, 2010 at 08:09:26AM -0400, zhangfei gao wrote:
>> On Mon, Sep 20, 2010 at 5:50 AM, Wolfram Sang <w.sang@pengutronix.de=
> wrote:
>> > On Mon, Sep 20, 2010 at 05:46:02PM +0800, zhangfei gao wrote:
>> >
>> >> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhc=
i-pxa.c
>> >> new file mode 100644
>> >> index 0000000..3e091c1
>> >> --- /dev/null
>> >> +++ b/drivers/mmc/host/sdhci-pxa.c
>> >> @@ -0,0 +1,253 @@
>> >> +/* linux/drivers/mmc/host/sdhci-pxa.c
>> >> + *
>> >> + * Copyright 2010 Marvell
>> >> + * =A0 =A0 =A0Zhangfei Gao <zhangfei.gao@marvell.com>
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or=
 modify
>> >> + * it under the terms of the GNU General Public License version =
2 as
>> >> + * published by the Free Software Foundation.
>> >> + */
>> >> +
>> >> +/* Supports:
>> >> + * SDHCI support for MMP2/PXA910/PXA168
>> >> + *
>> >> + * Based on sdhci-platfm.c
>> >> + */
>> >
>> > Why is it only "based on" and not directly using it?
>>
>> Thanks for your suggestion.
>> This is the first stage, already implement sd card function, we will
>> have some patches later to enhance the driver.
>> We have to access many private registers to enable specific control.
>> Besides some sdio device need some specific control, like marvell 87=
87
>> host sleep, it is much reasonable to implement inside the driver.
>
> Hmm, which hooks are missing for you to implement this as an extensio=
n
> of the pltfm-driver? Maybe it makes sense to simply add this hook?

We refered several mmc host drivers, such as sdhci-s3c.c,
sdhci-spear.c, and we want to align with others, which also meet pxa
requirement and low risk to transfer from the existing driver.

We have three or four device in one soc with the same driver, for
example one for sd, one for wifi, one for emmc, etc.
Each device have specific clock provider, which should be opened at
start, and closed when no operation to same power.
Specific quirk is needed for different device, which should be
transfered from platform data, for example on-chip wifi alwayes stay
on chip and emmc may require sd_clk free running to init.
The max_speed also may be different for board issue though controller
support max is 50M, which could get from capability.

>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAkyXXV8ACgkQD27XaX1/VRtAxQCfafH+k4+HhWiDxM+cRqDn8KYC
> Mq0AnRrh3v5192K7LdpIlLIxVBQI4ljW
> =3DRPet
> -----END PGP SIGNATURE-----
>
>
