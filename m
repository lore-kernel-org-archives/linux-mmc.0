From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: add AM33XX MMC support
Date: Sat, 15 Jun 2013 01:26:31 +0300
Message-ID: <20130614222537.GA25428@arwen.pp.htv.fi>
References: <41fde401c8e646689123d7c6d3a2dffc@DLEE71.ent.ti.com>
 <20130307141235.GQ6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC20C57@DBDE01.ent.ti.com>
 <20130307144656.GR6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC20CCA@DBDE01.ent.ti.com>
 <20130307150408.GU6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC20D27@DBDE01.ent.ti.com>
 <20130307160236.GV6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC213C8@DBDE01.ent.ti.com>
 <CAD=GYpb3+nvoz863+VKO7iJijRHnM5RzsVj-5VJfQ-OHoUy19Q@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0322827643757966550=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAD=GYpb3+nvoz863+VKO7iJijRHnM5RzsVj-5VJfQ-OHoUy19Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joel A Fernandes <agnel.joel@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Russell King <linux@arm.linux.org.uk>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Hiremath,
 Vaibhav" <hvaibhav@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

--===============0322827643757966550==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline

--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 14, 2013 at 02:54:33PM -0500, Joel A Fernandes wrote:
> Hi Tony, Vaibhav,
>=20
> >> I just doublechecked MMC rootfs on bone and evmsk as it's the standard
> >> smoke test. My EVM is intermittent now so trying to coax it to power up
> >> to reverify.
> >>
> >
> > Matt,
> >
> > Your branch is working for me, I tested it on EVM. Not sure what is wro=
ng with manual rebasing
> > I did yesterday. I will try to nail-down root-cause here.
> >
> > And you can submit the next version fixing the comments I have given.
>=20
> The only comment I could find in the whole discussion was adding of
> the interrupts property. I tested I don't have any problem booting
> with Matt's patch, without having the interrupts property.

might very well be, but we want to figure out why adding "intrrupts"
causes issues. Why does it have to come through hwmod ? You might have
uncovered a real problem which needs fixing. Besides, at the end of the
day, we want to remove the redundant hwmod data if we already have DTS
bindings covering the same requirements.
--=20
balbi

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRu5iXAAoJEIaOsuA1yqRE5l0P/iHsoyrL4UuOAcKCyFnB+Biw
UrRREW9xlAd4IG7Uiqhy3C04JVv0KCPtF1ngUiiNU1Nb0BhPrLKpgUpuOM0DyIOx
r3pLNqoq5PsMGp7XNzjSdOwCm6y+Yu3wDuDaaO9OGuuLBmKucNXqYgGfJM+g+24s
110vwTGpPqxW1TndYfzhNlw5qN/5OIbTJVORuuMQLhO/mK5EaNtb+7TAv68VBuub
Xo4cDWfzYwNujV0QTzUOJYP0L/qNHWi5hnLpGlI5tZZf9N+z/QJo52A4B5paWGmb
HCsfgMM2FUy3EMkXzjz2FDI72mSAPVgc0N7QVq5f4e25lJFgd/l/Xu34AZdUdxeo
GYBIYkK6G+xAPT9uRAuadXizprEn+3FlVxGzFvrgKrW5B1HS/+8W3SIB9GO3keYz
DLhjbNFBiEl7wnMr7DA5SjJ3rtopLirkn6bFd+KJXft867AOZnPu+rh5GgwfdbuO
0dbxVJ16BrxPrIgPxYbi1EqpsrjLF9dCOel56zs/KBBeB3MN4srLP115P3MNg2OX
VduXg7JsqSUPBfkaSEV5g0Ng2LZpTdCTblBKg6slVRak41iejjslChV62I9ORIZu
SjvM8tFel/231KWoVdAHlVe8qaegUpYR87UFXBBLV4QLwUvERM01tQrumdnfszJg
h+mXiEgLTS5iw+LeiteZ
=R0Oe
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--


--===============0322827643757966550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0322827643757966550==--
