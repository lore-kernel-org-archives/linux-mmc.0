From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: omap_hsmmc: Add support for slot-name property in DT
Date: Mon, 28 Dec 2015 15:28:48 +0100
Message-ID: <201512281528.48097@pali>
References: <1431724489-32359-1-git-send-email-pali.rohar@gmail.com> <201512251353.11491@pali> <1600826.3aUcPX7Ju6@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1978773.41G0JSRRTJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1600826.3aUcPX7Ju6@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--nextPart1978773.41G0JSRRTJ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 28 December 2015 15:14:50 Arnd Bergmann wrote:
> On Friday 25 December 2015 13:53:11 Pali Roh=C3=A1r wrote:
> > On Monday 18 May 2015 17:07:57 Arnd Bergmann wrote:
> > > On Monday 18 May 2015 08:06:07 Tony Lindgren wrote:
> > > > * Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> [150515 14:26]:
> > > > > On Friday 15 May 2015 23:22:37 Pali Roh=C3=A1r wrote:
> > > > If setting up the generic binding is expected to take a while,
> > > > you can naturally pass it in pdata while waiting for the
> > > > generic binding to get merged.
> > >=20
> > > Yes, good idea. So the n900 machine can use auxdata to pass this
> > > for the time being, while the binding and generic implementation
> > > is being worked out.
> >=20
> > Ok, so what is needed to finish this patch series?
>=20
> I don't know where we are at this point. Has either the auxdata
> approach or the generic binding been worked on at all?

What are auxdata data? And what do you mean with "generic binding"=20
approach?

> If not, please try to get the auxdata variant to work, it should not
> be hard at all because there is no dependency on a generic binding.
>=20
> 	Arnd


=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart1978773.41G0JSRRTJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaBRyAACgkQi/DJPQPkQ1K7/wCgvCvOluhLY+3ReUANJq9ODUY9
eiEAn3J+mgOd1pk6lws6LPKZtOJfN6mD
=gR56
-----END PGP SIGNATURE-----

--nextPart1978773.41G0JSRRTJ--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
