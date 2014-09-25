From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 00/27] add
	pm_runtime_last_busy_and_autosuspend() helper
Date: Thu, 25 Sep 2014 13:27:18 +0530
Message-ID: <20140925075718.GW24663@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
 <6374313.I12loOK9hA@vostro.rjw.lan>
 <20140924201558.GX17997@saruman>
 <2322320.9rETJijE2n@vostro.rjw.lan>
 <20140924203219.GZ17997@saruman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0566900095=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20140924203219.GZ17997@saruman>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Felipe Balbi <balbi@ti.com>
Cc: linux-wireless@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, patches@opensource.wolfsonmicro.com, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Chris Ball <chris@printf.net>, dri-devel@lists.freedesktop.org, Marcin Wojtas <mw@semihalf.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Herrmann <dh.herrmann@gmail.com>, Shinya Kuribayashi <skuribay@pobox.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Jingoo Han <jg1.han@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Jani Nikula <jani.nikula@intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alan Stern <stern@rowland.harvard.edu>, Ben Skeggs <bskeggs@redhat.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Wolfram Sang <wsa@the-dreams>
List-Id: linux-mmc@vger.kernel.org


--===============0566900095==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eNMatiwYGLtwo1cJ"
Content-Disposition: inline


--eNMatiwYGLtwo1cJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2014 at 03:32:19PM -0500, Felipe Balbi wrote:
> > > > OK, I guess this is as good as it gets.
> > > >=20
> > > > What tree would you like it go through?
> > >=20
> > > Do we really need this new helper ? I mean, the very moment when we
> > > decide to implement ->runtime_idle() we will need to get rid of this
> > > change. I wonder if it's really valid...
> >=20
> > I'm not sure I'm following?  This seems to simply implement what drivers
> > have been doing already as one function.  Why would it be invalid to re=
duce
> > code duplication?
>=20
> For two reasons:
>=20
> 1) the helper has no inteligence whatsoever. It just calls the same
> functions.
>=20
> 2) the duplication will vanish whenever someone implements
> ->runtime_idle() and have that call pm_runtime_autosuspend() (like PCI
> and USB buses are doing today). This will just be yet another line that
> needs to change.
>=20
> Frankly though, no strong feelings, I just think it's a commit that
> doesn't bring that any benefits other than looking like one line was
> removed.
and yes that is what it tries to do nothing more nothing less. If in future
there are no users (today we have quite a few), then we can remove the dead
macro, no harm. But that is not the situation today.

Thanks
--=20
~Vinod


--eNMatiwYGLtwo1cJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUI8reAAoJEHwUBw8lI4NH7iUQAI/dJy4cYCZgJFK0u2QRL4Kd
SWRQc+4wR1nBjQGUXerHL07UjXyr3ZR9BohfNggAqBrAHV/ecdBp/0xslMiub+RQ
dP50Gh6BnO3JWvJ7PRib5Y4grzczodaQKmdYaaLzVWLK2V6AAa1SDN2jl3RLhWEc
rz84lo3sRGAkzloG5XB9M/xjRYiXxl3CAsKJL9nXeAhPj/owMBwtHHgNB4O5KU+W
WxabjUY1rp7T4ThAO+3Lay5iWO7rhMR2tWo0qP8YieoEpDSrQjEeyzxRbmmeM7EE
l9+t4C6M72XMIZsZvn1ElQSPr95Rvjk38f6XKtIixRowLCbelhMpVXeVwSCWNJ+0
3YA62bsfZPCXUknj2foA3yRvvUTpWz3ndnu/6FuBti2yU0iv+HvYeBadvtGNvwe4
w7QUA8JTa0V7kX2UqZ9Iw+RDlZGp3pAMC7W1WRfHQzPM4xthJ1/a8ImsfTFGtLRf
Gdjnf7xq0aOzNeHOd1jzhGdtwOnnokTvJe6JNhlo/r4e5tgm3jxViEfVTFUcJCZf
FVxrDQ0s2a0XKdjMOOCEQADUzwv5gj4+/HvhXeSoVYjGn5eIeIZG7jTQPf2rtHVF
lROVSqr18dI0gXyzr9ZXeEQjW39pL8xrjgNIP90s1tr39ba4HrV/C+DJgne6F2yD
nVfd1ryI3YoxO/ok++NZ
=C09N
-----END PGP SIGNATURE-----

--eNMatiwYGLtwo1cJ--

--===============0566900095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============0566900095==--
