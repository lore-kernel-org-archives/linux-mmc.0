From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [RFC] thoughts about recent Samsung related patches
Date: Tue, 14 Sep 2010 09:05:30 +0900
Message-ID: <AANLkTi=zpAz+0VT0GGGrMP3KOJiWqvypWVfxuDZDpoSx@mail.gmail.com>
References: <20100906110059.GC2617@pengutronix.de>
	<AANLkTikoC35Rg52jJ5NMwvtMh9PfxgS7RqtfvfBeD6LV@mail.gmail.com>
	<20100913123108.GA5497@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55441 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab0INAFb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Sep 2010 20:05:31 -0400
Received: by wyf22 with SMTP id 22so6836309wyf.19
        for <linux-mmc@vger.kernel.org>; Mon, 13 Sep 2010 17:05:30 -0700 (PDT)
In-Reply-To: <20100913123108.GA5497@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, pierre-list@ossman.eu, gdavis@mvista.com, cbouatmailru@gmail.com, m.szyprowski@samsung.com, akpm@linux-foundation.org, =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>

On Mon, Sep 13, 2010 at 9:31 PM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
>> > I hope my comments are applicable; because there is no freely avai=
lable
>> > datasheet, I can't verify all of my assumptions. Looking forward t=
o
>> > comments.
>> Good, I think it's possible. I'll try and send a patch.
>
> Any news on this ?

I tried and no problem to work, but I'm thinking does it really
required for reducing one quirk?
With this change sdhci-s3c should use the
CONFIG_MMC_SDHCI_IO_ACCESSORS and it introduces the io functions for
every io access.

So I'm not sure these change is required for s3c sdhci.

Give you opinions.

Thank you,
Kyungmin Park
>
> Regards,
>
> =A0 Wolfram
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
> iEYEARECAAYFAkyOGYwACgkQD27XaX1/VRt27wCgkDJcNU61qyoor1Wzkrce5R/A
> 44YAnRvNMzJ1WbB5IbCgmV+kLuP1+h2C
> =3DmOsI
> -----END PGP SIGNATURE-----
>
>
