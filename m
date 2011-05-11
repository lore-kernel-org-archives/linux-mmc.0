From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR
Date: Wed, 11 May 2011 12:26:56 +0200
Message-ID: <20110511122656.de4cfbec.ospite@studenti.unina.it>
References: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
	<20110509202325.GD16919@n2100.arm.linux.org.uk>
	<20110509203612.GC21323@opensource.wolfsonmicro.com>
	<20110510220214.916621d1.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__11_May_2011_12_26_56_+0200_FUJetW8prhhjVjR."
Return-path: <openezx-devel-bounces@lists.openezx.org>
In-Reply-To: <20110510220214.916621d1.ospite@studenti.unina.it>
List-Unsubscribe: <https://lists.openezx.org/mailman/options/openezx-devel>,
	<mailto:openezx-devel-request@lists.openezx.org?subject=unsubscribe>
List-Archive: <http://lists.openezx.org/pipermail/openezx-devel>
List-Post: <mailto:openezx-devel@lists.openezx.org>
List-Help: <mailto:openezx-devel-request@lists.openezx.org?subject=help>
List-Subscribe: <https://lists.openezx.org/mailman/listinfo/openezx-devel>,
	<mailto:openezx-devel-request@lists.openezx.org?subject=subscribe>
Sender: openezx-devel-bounces@lists.openezx.org
Errors-To: openezx-devel-bounces@lists.openezx.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: openezx-devel@lists.openezx.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

--Signature=_Wed__11_May_2011_12_26_56_+0200_FUJetW8prhhjVjR.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 10 May 2011 22:02:14 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:
=20
> I was blindly trusting code already in mainline again, and for that I
> apologize, I finally took the time to look at the implementation
> of IS_ERR() and test its use, and being IS_ERR(NULL) true it is not what
> we want indeed, see the attached test program.
>=20

Just for the records, I meant to say "being IS_ERR(NULL) _false_" but
you got it anyways.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__11_May_2011_12_26_56_+0200_FUJetW8prhhjVjR.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3KZHAACgkQ5xr2akVTsAGmLgCgl5w4Dtv83Eyd0O1oXT0q17X/
EEsAn3+KPyfhRHtFUAz8Ai1+w3jJN1r+
=3IwB
-----END PGP SIGNATURE-----

--Signature=_Wed__11_May_2011_12_26_56_+0200_FUJetW8prhhjVjR.--
