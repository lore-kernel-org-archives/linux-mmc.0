From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Mon, 17 Oct 2016 17:15:50 +0200
Message-ID: <20161017151550.GA1415@katana>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-3-chris.brandt@renesas.com>
 <CAPDyKFoeRggX-YMy2L+o6CBtwa46rT2YyJiXdPK_c3a1R1Nvgg@mail.gmail.com>
 <SG2PR06MB11656EAD9F036EC0FFEDFF7F8ADF0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <CAPDyKFrXYQPEfh8YMAFb4+0dr=WMyo8D-VCjd9KY5hpPxTv7PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrXYQPEfh8YMAFb4+0dr=WMyo8D-VCjd9KY5hpPxTv7PQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Brandt <Chris.Brandt@renesas.com>, Lee Jones <lee@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Is this still waiting on an ACK from Lee Jones because it touches the t=
mio.h file under include/linux/mfd/ ?
> >
>=20
> Yes, but more important is Wolfram's ack as he maintains
> drivers/mmc/host/tmio_mmc*

Sorry, LinuxCon and ELC Europe kept me very busy. Will do this week.


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYBOsmAAoJEBQN5MwUoCm21csP/064+gQwNViz/MEA+GpTbI1X
7lla4Nm99hptzd86cUabJvxpdquzU/zmU3AGinMvUPcMS2/TptFlW5RgnqOY8cAc
4tY+24ACluqAWwEq3AwRHbNlS8Qu9+4sQbLkJ+3AMAdIlf+IjyQd5TndyC0e+dEL
JoAEERNhlc7G+s3oV0BiMZvDSL7Pm/s18g4Pv7k0Qb9i/MORCCzOd2tubZxG0Sws
JAAV6LTuN2dnl1SK32/MEfP9NXs9TJFiJIl3aeKLK/1Tfb1Cb7yikFRTb9lJC4DH
TS+ZJXq2iklGnG/em85xSQtB1kepVpbw5vg2RvWT/RT3+bChnn1VqJ8KuUVw6QFe
LAZecr7jwSbI05b1FMqD2z2hXUxr9m0BQPmZ/XOuXUh5A2K++PzyX5AvTWtJbYia
N41UCRvu0rjYr3KY7Ei1uPlHmVo8nNNGbuPF7/LncOsOBYzWIcdkcvQ+gZmIGiV9
UO6QdCuX/54liLjrOVS+1l4ICcQ15Mu9cGbEvMaXlU1Knr4e+VTE4cJvogwnKL6N
wDNq+Lz+G2KOjeXswS0fLsGv3bKba1mpQNDOTGyLT4G30O+ClVHKSCpp9eLnmpKy
cN0ohabqt1zimzhScU4h1de8k+QpxQc59hIAa0d3CmkytyTxhTc81YaCm0c9SHjY
u1vWRj4cCu+C4xLLh+e1
=HYBZ
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
