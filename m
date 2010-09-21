From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] add support PXA168/PXA910/MMP2 SD Host Controller
Date: Tue, 21 Sep 2010 18:18:00 +0800
Message-ID: <AANLkTi=5DAh6WGWCXOGoEJc08HeuL0R3iy+0zK1XpAgh@mail.gmail.com>
References: <AANLkTi=jeL0J1kfT+toB3BEAGJ5Cc5jZsHstD1hutNQB@mail.gmail.com>
 <20100920095042.GC4058@pengutronix.de> <AANLkTin28uj+L+AyUYVwoAyaUOmpfw3tc6JFEcVgtXBy@mail.gmail.com>
 <20100920131055.GE4058@pengutronix.de> <AANLkTin0ZDmTJ5gea65BiU+dWy+nD=wjp_xDOgYzxZF8@mail.gmail.com>
 <20100921101116.GE3168@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:53772 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152Ab0IUKSV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2010 06:18:21 -0400
Received: by qyk33 with SMTP id 33so5281411qyk.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Sep 2010 03:18:21 -0700 (PDT)
In-Reply-To: <20100921101116.GE3168@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>, Haojian Zhuang <haojian.zhuang@gmail.com>

On Tue, Sep 21, 2010 at 6:11 PM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
>> >> >> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/s=
dhci-pxa.c
>> >> >> new file mode 100644
>> >> >> index 0000000..3e091c1
>> >> >> --- /dev/null
>> >> >> +++ b/drivers/mmc/host/sdhci-pxa.c
>> >> >> @@ -0,0 +1,253 @@
>> >> >> +/* linux/drivers/mmc/host/sdhci-pxa.c
>> >> >> + *
>> >> >> + * Copyright 2010 Marvell
>> >> >> + * =C2=A0 =C2=A0 =C2=A0Zhangfei Gao <zhangfei.gao@marvell.com=
>
>> >> >> + *
>> >> >> + * This program is free software; you can redistribute it and=
/or modify
>> >> >> + * it under the terms of the GNU General Public License versi=
on 2 as
>> >> >> + * published by the Free Software Foundation.
>> >> >> + */
>> >> >> +
>> >> >> +/* Supports:
>> >> >> + * SDHCI support for MMP2/PXA910/PXA168
>> >> >> + *
>> >> >> + * Based on sdhci-platfm.c
>> >> >> + */
>> >> >
>> >> > Why is it only "based on" and not directly using it?
>> >>
>> >> Thanks for your suggestion.
>> >> This is the first stage, already implement sd card function, we w=
ill
>> >> have some patches later to enhance the driver.
>> >> We have to access many private registers to enable specific contr=
ol.
>> >> Besides some sdio device need some specific control, like marvell=
 8787
>> >> host sleep, it is much reasonable to implement inside the driver.
>> >
>> > Hmm, which hooks are missing for you to implement this as an exten=
sion
>> > of the pltfm-driver? Maybe it makes sense to simply add this hook?
>>
>> We refered several mmc host drivers, such as sdhci-s3c.c,
>> sdhci-spear.c, and we want to align with others, which also meet pxa
>> requirement and low risk to transfer from the existing driver.
>
> I see. It is true that the pltfm-part is not widely used up to now. T=
he
> question is if it might be a good idea to change this? There have bee=
n
> voices asking to merge the s3c-driver into the pltfm one. If you look=
 at
> sdhci-cns3xxx.c, it looks clearer and reduces code duplication. The
> current state of the pltfm-driver might not cover all cases (yet), tr=
ue,
> but those should be at least identified IMHO. This will help us for
> similar decisions in the future.
>
>> We have three or four device in one soc with the same driver, for
>> example one for sd, one for wifi, one for emmc, etc.
>> Each device have specific clock provider, which should be opened at
>> start, and closed when no operation to same power.
>> Specific quirk is needed for different device, which should be
>> transfered from platform data, for example on-chip wifi alwayes stay
>> on chip and emmc may require sd_clk free running to init.
>> The max_speed also may be different for board issue though controlle=
r
>> support max is 50M, which could get from capability.
>
> I guess to fully understand all constraints, one must really working
> with your platform, what I don't do. I agree that a nicely working
> driver is better than no driver; however, I fear once a driver hit th=
e
> mainline being non-pltfm, it will hardly be converted later, even if =
it
> was considered to be worthwhile. So this is why I ask initially if it
> couldn't be done.
>

My two cents, considering the quirks and several other things that
sdhci-pltfm.c is missing, e.g. suspend/resume and clk handling. I'd
prefer a diverge at this time, until we figure out what is common to
all sdhci platform bus based driver, and get those common part back
into sdhci-pltfm.c

> Chris, do you see a rule of thumb here? Or what are your preferences?
>
> Kind regards,
>
> =C2=A0 Wolfram
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Wolfram Sang =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAkyYhMQACgkQD27XaX1/VRsK1wCfaGVLkGpVEsrn+OQrpPBVHa54
> yDAAniBRPOamvs7wU8krhKMjjWqMxn9q
> =3DzQvu
> -----END PGP SIGNATURE-----
>
>
