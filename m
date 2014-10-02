From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 9/9] omap_hsmmc: remove unused slot_id parameter
Date: Thu, 2 Oct 2014 11:51:00 -0500
Message-ID: <20141002165100.GF7933@saruman>
References: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
 <1411983179-28677-10-git-send-email-afenkart@gmail.com>
 <20141002164252.GE7933@saruman>
 <20141002164528.GM3122@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141002164528.GM3122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Andreas Fenkart <afenkart@gmail.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com
List-Id: linux-mmc@vger.kernel.org

--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2014 at 09:45:29AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [141002 09:43]:
> > On Mon, Sep 29, 2014 at 11:32:59AM +0200, Andreas Fenkart wrote:
> > > omap_hsmmc only supports one slot. So slot id is always zero, and
> > > slot id is never used in the callbacks
> >=20
> > I wonder if this will break slot multiplexing on n8x0.
>=20
> It's a different driver from this. This series separates out
> the omap_mmc (with slot multiplexing) and omap_mmc_hs with no
> slot multiplexing.

alright, thanks for confirming :-) In that case, series looks pretty
good :-)

--=20
balbi

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJULYJ0AAoJEIaOsuA1yqRE0wMQAJxcs2TalDv/0fiu5+/QfSWF
xH+xdUOpagT2H9ncncBqdKMtvXNUoxjXO932T64y2rqoeG5yHQvtkECxr9leh3mj
iyzI/zH5Xvw38bkdhVfeDv1iUISfOUABn1PG7wZ4cFMqE0x0KU8ojrK9T3xzg/VL
p85miUNtGSv89m4HYdBQUBnls3RNhr8vp3QAy1HQW3W43KI//Pi4M47zCqUUsryJ
RK4uqPZeStukeYcV9iT8//hYuvKJfyEZsFf61mhWKswx+l3+uIIQYm0b+THPo4Uv
IE4Jiz8u6Yw9pqp8roZxU07ZWiTX+oIF7FV9bnDZl00wrNSC23dhsCkIW9qBbCGz
lKxTwjHjP03K6VsfUDPRyHdBv9bI1HCd91U7J3qkyKS4wqFlfJ0CNip8sphPA7c/
E+zubkJ4lBW84gjQgJ/i4XbNL4V2KEflkHlc0DLl0QeVq2P2UP67pWcuuGzRJCuO
WrlhiFI+9J21fEAuv2wun98mBPy4xoeYVFMnQuATvlDYhuJQ3gylND6oN2dj1ECK
ab8sEwLFU3bXK0pCckbbIYBpfCevgVB2e5Ltr8pypUs5ilpIPPxNYNTmUW/fFQ+r
MwBOIiSxkCfKdi92PUH7Ei58PzfnFvFzIubMnbiROHlX+4UmOjDbwTXxWh0UG8bS
smGkaiBlen5Won1nHgnc
=ZMPP
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--
