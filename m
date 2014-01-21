From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Add support for Erratum 2.1.1.128 in
 device tree boot
Date: Tue, 21 Jan 2014 13:45:17 -0600
Message-ID: <20140121194517.GU30451@saruman.home>
References: <1390260542-22213-1-git-send-email-nm@ti.com>
 <20140120233941.GG6516@saruman.home> <52DEB078.5030005@ti.com>
 <20140121180549.GS30451@saruman.home>
 <CAGo_u6qHFmgb9s9Taw2NAuBgjLY5tDW5XHbfik7PHcTArW7szg@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0113747501521406002=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGo_u6qHFmgb9s9Taw2NAuBgjLY5tDW5XHbfik7PHcTArW7szg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: dt list <devicetree@vger.kernel.org>, Balaji T K <balajitk@ti.com>, Tony Lindgren <tony@atomide.com>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, balbi@ti.com, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

--===============0113747501521406002==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="worL9B4ITIAQZ1FS"
Content-Disposition: inline

--worL9B4ITIAQZ1FS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2014 at 01:39:20PM -0600, Nishanth Menon wrote:
> On Tue, Jan 21, 2014 at 12:05 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Tue, Jan 21, 2014 at 11:38:00AM -0600, Nishanth Menon wrote:
> >> On 01/20/2014 05:39 PM, Felipe Balbi wrote:
> >> > On Mon, Jan 20, 2014 at 05:29:02PM -0600, Nishanth Menon wrote:
> >> >> When device is booted using devicetree, platforms impacted by
> >> >> Erratum 2.1.1.128 is not detected easily in the mmc driver. This er=
ratum
> >> >> indicates that the module cannot do multi-block transfers.
> >> >>
> >> >> Handle this by providing a boolean flag to indicate to driver that =
it is
> >> >> working on a hardware with mentioned limitation.
> >> >
> >> > sure there's no way of reading the revision register to figure this =
one
> >> > out without having to add a new DT attribute ?
> >> >
> >> I did a quick patch to read the Module revision register:
> >> http://slexy.org/view/s21TKvlWlR
> >>
> >> sdp2430: Revision: 1.2, Spec: 0.0, normal interrupt
> >>
> >> OMAP3430-ldp: (ES2.1): Revision: 2.6, Spec: 0.0, normal interrupt
> >> SDP3430:(ES3.0) Revision: 2.6, Spec: 0.0, normal interrupt
> >> AM3517-evm: (ES1.1): Revision: 2.6, Spec: 0.0, normal interrupt
> >> AM3517-crane:(ES1.1): Revision: 2.6, Spec: 0.0, normal interrupt
> >>
> >> AM37x-evm: (ES1.2) Revision: 2.6, Spec: 0.0, normal interrupt
> >> OMAP3630-beag-xm (ES1.2): Revision: 2.6, Spec: 0.0, normal interrupt
> >>
> >> am335x-evm:(ES1.0): Revision: 3.1, Spec: 0.1, normal interrupt
> >> am335x-sk: (ES2.1): Revision: 3.1, Spec: 0.1, normal interrupt
> >> am335x-beaglebone-black:(ES2.0): Revision: 3.1, Spec: 0.1, normal
> >> interrupt
> >>
> >> sdp4430.txt: (ES2.2): Revision: 3.1, Spec: 0.1, normal interrupt
> >>
> >> OMAP4460-panda-es (ES1.1): Revision: 3.1, Spec: 0.1, normal interrupt
> >>
> >> OMAP5uevm:(ES2.0): Revision: 3.3, Spec: 0.2, normal interrupt
> >> dra7-evm (es1.1): Revision: 3.3, Spec: 0.2, normal interrupt
> >>
> >>
> >> OMAP3430-ldp seems to be the only one impacted with module revision
> >> 2.6 -> so using revision information is not really helpful here. Hence
> >> the usage of a flag in dt attribute to indicate hardware impacted by
> >> erratum.
> >
> > alright, that's too bad. Seems like revision in this module isn't very
> > useful :-(
>=20
> Can I take that as an acked-by?

sure

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--worL9B4ITIAQZ1FS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJS3s5NAAoJEIaOsuA1yqREZiMP/0NwwNmHcFGqmHThms4IJfXN
c7DL8TAVQZ0mIlbAx8TJJ5G9DoPSuyEduKvRUEmIP6h5kSc/g5wsIME7qyrdyx4T
DeG1J7itUOptefPlPRTWN/8ptnIOltpxXoJ37aI92NySuKnRw3QnqPn685iPRbC8
0hKOa2WY+lSmJDu1R90rgLFUZUo+vG3XTo99Zbep3OMB6nTO7ZRLr1Omv5+cYykA
2leBvbKeeVIXdZXhrIZunvpS4MyE6EBIGbYz+zSAQCuO667thvBJzDwJO1oGJvSe
H+oPoeey5Hh7bUe1sH7Si1eAgnZM1hqvjLfP92WZRvxRFda7nbtghHWQACoPEOF3
dGMicatxHCtohVI5gL5j6KKv1vrz3Tkb9NreU9n/wK6Imy9xl6IfHv/CbaAZpeaU
JtnDRvnx8udTRH0PlhTRdJKaUVOJKp9KNT4z22MgzEd7SjON04JYhLAhiH992Bne
47TjpWTtyU1UzypHJT6hHpOGD7Qn587MRRuKuk232Y4qnb7r+g32SlchEyU3j9H7
zdgteNn14IygI/ZLgVRq4p2fSYFmZJXf3sFkVKT4Pkhq0SaeodnCfxrA7okAgTq3
d3aB0mRFUhBiXeEKcU54W4Bb1fJc04k3PJLAM3WC1IJgv2BVoh2ZnP3tKWK7IVmz
VksUtSnfFL4wUqq9AnMi
=f3J1
-----END PGP SIGNATURE-----

--worL9B4ITIAQZ1FS--


--===============0113747501521406002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0113747501521406002==--
