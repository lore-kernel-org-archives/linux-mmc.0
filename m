From: "vooon341@gmail.com" <vooon341@gmail.com>
Subject: Re: [PATCH] mmc: Add MPC512x SDHC driver.
Date: Tue, 29 Mar 2011 17:46:25 +0400
Message-ID: <AANLkTinZ25gT+Y=YJMh=bFeZdRE-fZ45wDt8=tDWVScd@mail.gmail.com>
References: <AANLkTi=cMzOj-NEc0uksDDBiBvyaKQWta9T9jtO12Gxr@mail.gmail.com> <20110329104231.GB18155@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48513 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab1C2Nqq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2011 09:46:46 -0400
In-Reply-To: <20110329104231.GB18155@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>

Hi Wolfram,

I'll try to add abstraction.
But I can return to this only after our hardware will done (around one =
month).

2011/3/29 Wolfram Sang <w.sang@pengutronix.de>:
> Hi Vladimir,
>
>> MPC512x have similar sdhc module as in MX2/MX3,
>> but use different access to the registers.
>
> There are quite some drivers abstracting the register-access
> (sdhci-esdhc for example which is also used on ppc and arm). If the
> state-machine is the same, this really should be done. Otherwise
> maintenance will be harder. I have mx2/3-hardware here and am willing=
 to
> test the changes. If the state-machine is significantly different, a
> seperate driver makes sense, of course.
>
> Regards,
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
> iEYEARECAAYFAk2Rt5cACgkQD27XaX1/VRupZQCfZBKjZDcAXYpWruv/YddLcrl6
> 5l4AnigRQQhsiy7kyVpMGYYDvtdlzziJ
> =3Dfihf
> -----END PGP SIGNATURE-----
>
>
