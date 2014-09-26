From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 00/12] clk: sunxi: Improve MMC clocks support
Date: Fri, 26 Sep 2014 08:55:07 +0200
Message-ID: <20140926065507.GO15315@lukather>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140922113133.GF15315@lukather>
 <20140926004218.19023.88602@quantum>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G23JYFG0d77Z6i/3"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59625 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752976AbaIZHAG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Sep 2014 03:00:06 -0400
Content-Disposition: inline
In-Reply-To: <20140926004218.19023.88602@quantum>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, wens@csie.org


--G23JYFG0d77Z6i/3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Thu, Sep 25, 2014 at 05:42:18PM -0700, Mike Turquette wrote:
> Quoting Maxime Ripard (2014-09-22 04:31:33)
> > Mike,
> >=20
> > On Thu, Sep 11, 2014 at 10:18:14PM +0200, Maxime Ripard wrote:
> > > Hi everyone,
> > >=20
> > > Here is an attempt at improving the MMC clock support in the Allwinner
> > > SoCs.
> > >=20
> > > Until now, the MMC clocks were having a custom phase function that was
> > > directly setting an obscure value in the right register, because we
> > > were not really having any idea of what these values were.
> > >=20
> > > Now that we have more informations, we can introduce a common function
> > > call to get and set the phase of a particular clock, and use this in
> > > both our provider and our client.
> >=20
> > It would be great that we have that custom phase API out of the kernel
> > for 3.18, and you were one of the greatest supporters to that idea,
> > could we please have your view on this?
>=20
> Patches all look good to me. Did you want the whole series to go through
> the clk tree?

I guess it would be where it most make sense yes.

> If so we'll need an Ack for the MMC patch and for the ARM DTS
> patches as well.

We already have an Ack from Ulf on the MMC patch, and I'm the
maintainer of the DTS involved, so we should be ok :)

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--G23JYFG0d77Z6i/3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUJQ3LAAoJEBx+YmzsjxAgmwEP/RaTxW7Bk80ewS8n+5x1iY5Z
ZoU9KSH19up57Bi2YdjqOQAPYkiORR3P6ndaaWj5ggFNFdKVyZN6NaP3FsLq8iOo
Alfwl4cY/KH5KiqJ+VFq7mziQMU+TcRmjGEE8dnhS+K6YrNsPe8azUyDLTr/V24r
J3oIAZ73qKiu2D7sTCJuhgBcptj7usOYWybKlgzCkmIhgJgcJDVKwrm2l2POgqVt
HmxED/6oCvZxlrrKoCzLchkMBozDvGwXf4c700VTpmunQwB0B1nv/b1Nk008p7Lj
NiTOYb6VQstkrOgCLCohqvtAoLwydhRT0a9ouxAHUPzPTCSiTl/KaeRz8UFVuCp/
s3trQm6PJiQjhnEVt9b2NEbuAXaMarIZOhveLg7raF6npnB9w1TAc+zhthD/ax93
lI0Z00nj34HuzTA0L75ITCayQDidXpg3JsjopBFkeoU+FkVI7YjZMsT2LlV58DwI
Bia0vE8+t/Zl4ZlGAcm1j9aiSd8PNiWNnKWY7h/rvx+sOmtVPEypB6aFPKBjh7NF
bx7ydv9cg39HFSdNH+8lKQ2I+/GGJEVNe2kxWl0fiKgsUnjj6FFh1OFbR8Eb0wBh
yQ1C28aloEugSOOQN1XsnjsdZLtQHRR7PI1bYU4K2JQzCUKAOAC4aJkKRoamDg9v
xzH+nlY4tIA1r1gFwhcf
=7oy/
-----END PGP SIGNATURE-----

--G23JYFG0d77Z6i/3--
