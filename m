From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
Date: Mon, 18 Oct 2010 23:25:16 +0800
Message-ID: <AANLkTikNVu6UaCbm-335KNd4x2TX_SUz1FQHn6ODUX43@mail.gmail.com>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com>
	<20101018145833.GB22538@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58137 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332Ab0JRPZR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Oct 2010 11:25:17 -0400
Received: by iwn35 with SMTP id 35so175921iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 18 Oct 2010 08:25:17 -0700 (PDT)
In-Reply-To: <20101018145833.GB22538@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, eric.y.miao@gmail.com, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>

On Mon, Oct 18, 2010 at 10:58 PM, Wolfram Sang <w.sang@pengutronix.de> =
wrote:
> On Mon, Oct 18, 2010 at 08:32:46AM -0400, zhangfei gao wrote:
>> Update with comments from Matt and Eric.
>> Test with sd and emmc.
>
> Sorry if I am blind, but why again can't you use the (updated) platfo=
rm driver?

Currently platform driver can not support well of the requirement for
several device sharing one driver,  each one has different quirk,
different max_speed, and each device need some specific vectors.
We prefer using independent driver first.

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
> iEYEARECAAYFAky8YJkACgkQD27XaX1/VRtQqACfUOXAYcCu0ui25S/2pXIaQdWK
> hJEAn3ZW7tKsIn7cSg8gkehIzPS8im4p
> =3D04el
> -----END PGP SIGNATURE-----
>
>
