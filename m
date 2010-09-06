From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [RFC] thoughts about recent Samsung related patches
Date: Mon, 6 Sep 2010 20:16:49 +0900
Message-ID: <AANLkTikoC35Rg52jJ5NMwvtMh9PfxgS7RqtfvfBeD6LV@mail.gmail.com>
References: <20100906110059.GC2617@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34018 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010Ab0IFLQu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2010 07:16:50 -0400
Received: by wwj40 with SMTP id 40so6382991wwj.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Sep 2010 04:16:49 -0700 (PDT)
In-Reply-To: <20100906110059.GC2617@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, pierre-list@ossman.eu, gdavis@mvista.com, cbouatmailru@gmail.com, m.szyprowski@samsung.com, akpm@linux-foundation.org, =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>

Hi

On Mon, Sep 6, 2010 at 8:00 PM, Wolfram Sang <w.sang@pengutronix.de> wr=
ote:
> Hi,
>
> while working on the esdhc-controller for the imx-platform, I noticed
> the recently comitted changes for Samsung controllers and have some
> remarks (sorry for being late):
>
> 1) Checking conditions for of host->ops->get_min_clock
>
> The original commit e9510176ff728135383f0cdfc9c90cfe57f9e162 (sdhci: =
be
> more strict with get_min_clock() usage) states why the additional che=
cks
> were added. Under this light, it could be argued that commit
> cfd1f82f20e0c557a061189f7d8c30d623fbe313 (sdhci: remove useless
> set_clock() check) could be reverted and this commit
> ce5f036bbbfc6c21d7b55b8fdaa2e2bd56392d94 (sdhci-s3c: add support for =
the
> non standard minimal clock value) could also be reverted if the samsu=
ng
> platform driver just uses SDHCI_QUIRK_NONSTANDARD_CLOCK without setti=
ng
> ops->set_clock?
In our case we only want to use the min_clock at probe time without
NONSTANDARD_CLOCK. and no need to NONSTANDARD_CLOCK at set_clock since
we need other parts also at sdhci.c
>
> 2) 8-Bit data transfer support
>
> The comitted version ae6d6c92212e94b12ab9365c23fb73acc2c3c2e7 (sdhci:
> 8-bit data transfer width support) looks different from another RFC
> posted in February:
> http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg01250.html
>
> As those two already differ, I think it might be wiser to move
> 8-bit-mode-handling to the platform-specific code? Even the documente=
d
> features of a SDHC differ across implementations, I fear side-effects
> when using this kind of undocumented feature (official spec says
> "reserved" when describing this bit).

Okay it looks different from Samsung Spec.
WIDE8[5]: Extended Data Transfer Width (It is for MMC 8-bit card).
1: 8-bit operatoin
0: Bit width is designated by the bit 1(Data Transfer Width)
So no need to set the BIT 1 and BIT5 simultaneously.
I also wonder other Specs how described it.

>
> 3) NO_HI_SPD
>
> Commit 5193250168ccdf87364e35a11965336dc088578c (sdhci: add no hi-spe=
ed
> bit quirk support) adds a quirk which can be avoided by using
> io-accessors like in sdhci-of-esdhc.c. Maybe we can even get rid of
> more, older quirks this way to save precious quirk flags. Have to che=
ck
> that later.
>
> I hope my comments are applicable; because there is no freely availab=
le
> datasheet, I can't verify all of my assumptions. Looking forward to
> comments.
Good, I think it's possible. I'll try and send a patch.
>
> Kind regards,
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
> iEYEARECAAYFAkyEyesACgkQD27XaX1/VRsm/QCePflpNSE0iQQWSUjf/PY723qK
> ZbEAoLxAIS7jIJY/lUQpQvbkJMN6ve19
> =3D98xD
> -----END PGP SIGNATURE-----
>
>
