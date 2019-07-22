From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 03/18] ARM: dts: bcm283x: Move BCM2835/6/7 specific to
 bcm2835-common.dtsi
Date: Mon, 22 Jul 2019 10:54:27 -0700
Message-ID: <87d0i2eyzw.fsf@anholt.net>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
 <1563774880-8061-4-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3969614884286244014=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1563774880-8061-4-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Stefan Wahren <wahrenst@gmx.net>
List-Id: linux-mmc@vger.kernel.org

--===============3969614884286244014==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Stefan Wahren <wahrenst@gmx.net> writes:

> As preparation we want all common BCM2711 + BCM2835/6/7 functions in
> bcm283x.dtsi and all BCM2835/6/7 specific in the new bcm2835-common.dtsi.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

For display:

We should probably move HDMI to bcm2835-common.dtsi as well, as the
block has very thoroughly changed.

The pixelvalves have also changed and will probably need to be separate
for 2711.

DSI, DPI, and VEC I belive are the same thing at the same address still.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAl01+FMACgkQtdYpNtH8
nuhNHg/+Kh+yQKGTRWQP2MLJ7DLvk+gXyEFVpdOkBDEUZ0VgeOgNkhVPV5v/jS+5
XSmTkAXPSerrT01GwkGw7c8Df/94Jqmt3CXNqI8+35rCYWB6Xj1kw+YhuXzTQafb
7IS6VYlp+3RoFhPGYYivunRWDv/Q2zQt/ML8LxLLQ+xfqlzwsLICZRC88jnJLabs
cJAs22DioTwqgFqmsSCaPLFRe4prW/Y3RV3QNGwfh5GtaYTUQQma/vAPqhfqorlL
zEUik/0nY7/n+j2lDf8jHDZ4wEbGz6miKcIu5NuBBxYw09iK3vDzDnPfKjNd3GZN
NVnyML39lLAlZfPYYKlGLb1k9brDXtdCWvHAJ8evrpA6pg78QNZgVZPPHpJ21Dxj
MUEHw8ZaTrDcj015kmDVEntQrdMrEJz74U/V+kSVLYkmxMwss3zl/oh7c3scZwCU
/ED57Gfl3L6jusiZExmvgmoirrg3B+Nv7y66LdjHGA7o/eTSfrTcfXz2AsF5D+ym
25ZYalODm+22UO/Spxoak3hP67CO8L9iqU5Nm+7PTVZwuMZPVcwOz1+2taiqXwrT
iYheIGIxYFZorb+ojg7NMDJf7i0VWGVcn+/D/1+FBlV6aNyfqU1bJcs2BNRv1pXK
aWm4pX9+rl6ylR9VuGwb6GCGF4y2vPHDDUWYXIaAS91HaVeDcSo=
=oOH1
-----END PGP SIGNATURE-----
--=-=-=--


--===============3969614884286244014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3969614884286244014==--
