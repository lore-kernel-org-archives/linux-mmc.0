From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH 00/18] ARM: Add minimal Raspberry Pi 4 support
Date: Wed, 24 Jul 2019 10:37:45 +0200
Message-ID: <ab7af8537ebcbc7a7bdf04d2c06152ba6821b333.camel@suse.de>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
 <96113adb5fcab9c2f4bb5fa82b84ff5f9c07fd07.camel@suse.de>
 <bc650090-db86-ccac-01dc-23f08ad7b19b@gmx.net>
 <20190723093442.GA27239@lst.de>
 <04c5eaa03f3a124dbbce6186e11e19acc4539cc8.camel@suse.de>
 <b15509d6-bc2e-3d06-0eea-943e6e456d62@gmx.net>
 <5f9b11f54c66fd0487837f7e58af3adf7f86635f.camel@suse.de>
 <CAGb2v66-o23CW5iH9Bn1aELymPSiKrA43eJd2q6EZ7iubcogaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3865217106627090752=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGb2v66-o23CW5iH9Bn1aELymPSiKrA43eJd2q6EZ7iubcogaw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>, Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Christoph Hellwig <hch@lst.de>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "open list:BROADCOM BCM281XX..." <bcm-kernel-feedback-list@broadcom.com>, Matthias Brugger <mbrugger@suse.com>, "moderated list:BROADCOM BCM2835..." <linux-rpi-kernel@lists.infradead.org>, Michael Turquette <mturquette@baylibre.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Stefan Wahren <wahrenst@gmx.net>
List-Id: linux-mmc@vger.kernel.org


--===============3865217106627090752==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Rf1Vi16408MDtIxce0fT"


--=-Rf1Vi16408MDtIxce0fT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > > Does it fix the wifi issue too?
> >=20
> > Well it works as long as I revert this: 901bb98918 ("nl80211: require a=
nd
> > validate vendor command policy"). Which has nothing to do with DMA anyw=
ays.
> >=20
> > Was this the issue you where seeing?
> >=20
> > [    4.969679] WARNING: CPU: 2 PID: 21 at net/wireless/core.c:868
> > wiphy_register+0x8e8/0xbdc [cfg80211]
> > [...]
> > [    4.969974] ieee80211 phy0: brcmf_cfg80211_attach: Could not registe=
r
> > wiphy device (-22)
>=20
> We're seeing this on different platforms (allwinner / rockchip / amlogic)
> with Broadcom WiFi chips. So it's unlikely to be related with anything in
> this series.
>=20
> I believe a fix for this has already been queued up:
>=20
>=20
https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/?=
id=3D91046d6364afde646734c7ead1f649d253c386e9

Thanks for pointing it out, it fixes the issue alright.


--=-Rf1Vi16408MDtIxce0fT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl04GNkACgkQlfZmHno8
x/4D2wgAqq3ax066fAw16mhXFvRvsvt5N2yK9ur2hwqz0YVcIYT9FlKTnuFyrUOY
w1MvuMiaeLz+2xFpt+LVsmP/ygSqwzfzikUGJh/vHIu+mRqYPdbHrIKvLqutyQnF
oXe6qqy8bXRfT50JQRnyH7ysKXks44suhiyTrYpidvmqkFZnasP86QgelISZiuKo
umHPmmEck4luauMqSuQxzaNtbiJhLWzdKAWH3u+iufEHZT5Mbhi0v82jwviF2x+k
lHI6OQpyuuOyVlsbIcAKAuu3qafq8KWaIf13JUmRGdo+dAjpBQ/lsuxeQGH4mHHk
JvMKjYzUiMp4hvcgcoVTNcJ/Zz7zpw==
=vcHF
-----END PGP SIGNATURE-----

--=-Rf1Vi16408MDtIxce0fT--



--===============3865217106627090752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3865217106627090752==--
