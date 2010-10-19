From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
Date: Tue, 19 Oct 2010 05:44:55 -0400
Message-ID: <AANLkTims6QCCT6iDGxx1LPHzAfhTuM_VUVEs1yMcWuG6@mail.gmail.com>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com>
	<20101018145833.GB22538@pengutronix.de>
	<AANLkTikNVu6UaCbm-335KNd4x2TX_SUz1FQHn6ODUX43@mail.gmail.com>
	<20101019020348.GB3485@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34109 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239Ab0JSJoz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Oct 2010 05:44:55 -0400
Received: by iwn7 with SMTP id 7so698306iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 19 Oct 2010 02:44:55 -0700 (PDT)
In-Reply-To: <20101019020348.GB3485@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, eric.y.miao@gmail.com, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>

On Mon, Oct 18, 2010 at 10:03 PM, Wolfram Sang <w.sang@pengutronix.de> =
wrote:
>> Currently platform driver can not support well of the requirement fo=
r
>> several device sharing one driver, =A0each one has different quirk,
>> different max_speed, and each device need some specific vectors.
>> We prefer using independent driver first.
>
> What about a custom init-call reading out the platform_data?

Which one are you talking?
=46or the different quirk, we have already discussed before, the quirk
in sdhci_pltfm_data is shared in different device, which may impact
each other.
We don't want to be blocked in using what manner.

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
> iEYEARECAAYFAky8/IQACgkQD27XaX1/VRuYkQCfaPUOLkDwZ+mCW9ztlGJnAy85
> S4oAn1MEL5UhA7bTi8+H5fcMSEEPmZwC
> =3D6MTu
> -----END PGP SIGNATURE-----
>
>
