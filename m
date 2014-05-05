From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v10 00/15] ARM: sunxi: Add driver for SD/MMC hosts found
 on Allwinner sunxi SoCs
Date: Sun, 4 May 2014 23:00:26 -0500
Message-ID: <20140505040026.GB11606@lukather>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399046249-19472-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2014 at 05:57:14PM +0200, Hans de Goede wrote:
> Hi All,
>=20
> Here is v10 of the sunxi-mmc patch-set David Lanzend=F6rfer and I have be=
en
> working on, this has some minor changes since v9, the plan for upstreamin=
g is
> still the same:
>=20
> The first 2 patches are depenencies which should go in through the clk tr=
ee,
> Mike can you pick these 2 up please ?  :
>=20
> "clk: sunxi: factors: automatic reparenting support"
> Is uncontroversial and has been favorably reviewed by various people.
>=20
> "clk: sunxi: Implement MMC phase control"
> Is somewhat more controversial as there has been lots of discussion about
> adding a generic phase control method to the clk framework. The problem is
> that there has been a lot of talk about such a generic phase control meth=
od
> but not a single patch. Therefor I would like to move forwards with using
> a platform specific method for now. I hereby promise that once we've a ge=
neric
> method I'll write patches to convert the sunxi code to that method.
>=20
> The third patch is the patch adding the actual mmc driver and should go in
> through the mmc tree.
>=20
> All the other patches are devicetree patches hooking things up, and should
> go upstream through Maxime's sunxi-dt tree.

Applied patches 4 to 14.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTZwzaAAoJEBx+YmzsjxAgd6cP/Atp92k/Wape9n7f9yQV1id3
E+AEKL1wULRaFsSUraIB90xXoBOIfBJC0+YEGtI+SC0HeYqQGCcwTrd/AvFeaZ0Z
TEe/PKOtYociYJKd8TGblQdt1LE6P4YrMTa+Iy6szzxvrfOasbmjjH9KLtmx+lM8
9+LX8VdPC4YE64zkSfWSrlb6r/7veUppVihFyM9v2EyAe8q0CzMftVDmW2ms+vBM
L8++bJPvBNNm7RKVs6hMvl2i91kS0KjM8c0VnjAaPOhs/diISVCY8Saqar6FZ2FE
unF4tTOyytVhIRklKBBY5IDi8r+R0VVpwxWzruD785BghCFcy+G+fD8OcHUB8Xp1
FdUL118RofYv8iCwVFkvvf6BMZrTUkw9WEZZlqDJ+52G3AG8LTsGvyiSzRcFuXsx
d5AzlUKuIwA7MaQ1bNb6SKC0XzHyFayW4sQWAMXmdu8I/ZqI1LmpfUsMP2rJK0Dj
S+BPLqP9jn50IRKb/4YjHhZEP+jZt9YKW9uBsvDD5uV+PEzCKZQ1pcQujN7rBRir
oYLaGiwGlLYfjou3nvzx18ll3eb5f4fQKFzCxi8V7pcb25RSts+Cq+o3KI9bVYhl
qIA2o2xKurHtjvwlF+CoqiIhcoMPV2m/m6sjy5lGrJOdsaIGwhW3eiNjTgF3a18u
3e2cMR4+ZU2pyBUcJjZF
=uSAG
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
