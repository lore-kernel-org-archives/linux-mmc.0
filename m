From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v8 00/17] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Wed, 23 Apr 2014 11:40:18 +0200
Message-ID: <20140423094018.GJ24905@lukather>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
 <53565B74.4000703@elopez.com.ar>
 <53565DDA.9020202@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AXxEqdD4tcVTjWte"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBLUX32NAKGQE6XI433I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53565DDA.9020202-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--AXxEqdD4tcVTjWte
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2014 at 02:17:30PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 04/22/2014 02:07 PM, Emilio L=F3pez wrote:
> > Hi Hans,
> >=20
> > El 22/04/14 08:01, Hans de Goede escribi=F3:
> >> Hi All,
> >>
> >> Here is v8 of the sunxi-mmc patch-set David Lanzend=F6rfer and I have =
been
> >> working on.
> >>
> >> The first 2 patches are depenencies which should go in through the clk=
 tree,
> >> Mike can you pick these 2 up please ?  :
> >>
> >> "clk: sunxi: factors: automatic reparenting support"
> >> Is uncontroversial and has been favorably reviewed by various people.
> >=20
> > I'll pick this one up for 3.16 if you're ok with that. Mike, let
> > me know if you have any objection to the patch, but I'm pretty
> > sure you (informally?) acked it in the past.
> >=20
> >> "clk: sunxi: Implement MMC phase control"
> >> Is somewhat more controversial as there has been lots of discussion ab=
out
> >> adding a generic phase control method to the clk framework. The proble=
m is
> >> that there has been a lot of talk about such a generic phase control m=
ethod
> >> but not a single patch. Therefor I would like to move forwards with us=
ing
> >> a platform specific method for now. I hereby promise that once we've a=
 generic
> >> method I'll write patches to convert the sunxi code to that method.
> >=20
> > Mike proposed a RFC for handling this better, and there were talks
> > with Allwinner people to see what did these phase controls
> > actually mean. We should be able to get a proper solution for it
> > during this cycle. I'd prefer to work towards that instead of
> > merging this, as we have more than a month to get it ready still.
>=20
> A month will be gone before you know it, and merging sunxi mmc support re=
ally
> is long overdue, and is the last thing keeping distros from shipping with=
 sunxi
> support ootb. So I would really prefer to just get this merged as is for =
now,
> changing it later should be easy, and merging an interim solution will ma=
ke
> some more time for doing the generic clk phase control method properly.

While I'd be inclined to agree, it will be up to Mike.

Mike?

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--AXxEqdD4tcVTjWte
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTV4qCAAoJEBx+YmzsjxAgWpwP/AwZ/Yxe4bYyMe2MmCX0zufb
tz5fjKvnC7H0s7Tnp8ZUI4fvIG8YTDV50FVzE5TcgMKPAfCiuY30ps4WpC+zIZ0Z
oRVhudkYP4jueQnTK7GRyrNkSA6uEwcjwyWNrWrUV8kxCW5jgOq91xmFp6mz9i6o
4/GbHf46lYOOLc+z9oJHU2rmYGNDdTM49s2R90asbgy5arRoMrolDt/UER4nSoaQ
MnplMfC2A2g8Rso1DuLsZ/WIKQIG517j2P+hJm9KyXZyMmpLWRVCi7t4wbP73q4G
rUJnjCNEO5jdjfn4mJYthEp6CTmtSk10obfHkyxkSrAvaDdp2yYGj0Sa4tMtFUae
B9T0o9zuFMxZhU/XsjhTzEL9+btMu84/Ejt1bjEJEpJxHC0KHwbJQRuMoyE/pnu9
ck99RENhnQSmEToe7jBrIvcPCQA5CVJuwQcAg/01zzmppf6IGnFTdMXow90aGAgR
4lIuPGTJ2gmN7/vz4FyAlXIBTxSSDRLtqj//n6poyF8w0pMhkJOlAOyT1of8ps53
qYmR/WLv29Q073wdN48EgHHOf0XaLfTqFH2zWbI5ezkn/VzHApI+JZw6uJyLSwoc
GsT/dio9n4bdkwsVqCgxgsk6eorBZjmecBwAuCkn8uqoDbQuIYl1Np6NeI1GELXm
AkAVyMPuxTlkLoJ7AyGX
=AYqj
-----END PGP SIGNATURE-----

--AXxEqdD4tcVTjWte--
