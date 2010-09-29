From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch 1/3] sdhci-pltfm: add call back get_quirk
Date: Wed, 29 Sep 2010 09:51:50 +0800
Message-ID: <AANLkTik6+_J9TW9pxKM8nqw569N0fvTP5OoTed-56qt9@mail.gmail.com>
References: <AANLkTimjF_rL7CcPQDo=LUa6GfofmqM0uGRJ1ZjVMDZn@mail.gmail.com>
	<AANLkTinY_zdF457ePv0tTMRsxz_49BN4Y7h=+u0c+Eud@mail.gmail.com>
	<20100928142023.GH4441@pengutronix.de>
	<AANLkTik_UXUxESmzWCEBxCdME0E-GOpVYxTa=31Lc1-V@mail.gmail.com>
	<20100928193956.GA11280@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59483 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab0I2Bvv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 21:51:51 -0400
Received: by iwn5 with SMTP id 5so380426iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2010 18:51:50 -0700 (PDT)
In-Reply-To: <20100928193956.GA11280@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

On Wed, Sep 29, 2010 at 3:39 AM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
>> > I might be blind, but I can't see why you can't handle that in ini=
t()?
>>
>> The issue is not init, but the common quirk in pdata.
>> If using only one quirks in pdata combined with one driver, then
>> different device would impact each other.
>> for example device.0 set QUIRK_BROKEN_A to pdata->quirks, the device=
=2E1
>> would use this quirk as default one, device.1 set QUIRK_BROKEN_B to
>> pdata->quirks, then what device.2 default quirk would become
>> QUIRK_DEFAULT | QUIRK_BROKEN_A | QUIRK_BROKEN_B.
>>
>> So differnet device should have quirk by iteslf, and pltfm.c would g=
et
>> such quirk after init.
>
> Aren't devices .0, .1 and .2 own platform_devices and as such have
> independent platform_data?

Take sdhci_cns3xxx as example, only one sdhci_csn3xx_pdata with one .qu=
irks
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkyiRIwACgkQD27XaX1/VRuG/QCgqaP16S0vKezI4zgmuRAdxrd8
> IWkAoLAW0WgpbjiLlOH95a+M7B2fISNA
> =3DX72n
> -----END PGP SIGNATURE-----
>
>
