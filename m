From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH V2 2/4] mmc: pwrseq: Document DT bindings for the simple
 MMC power sequence
Date: Fri, 16 Jan 2015 07:53:08 +1300
Message-ID: <20150116075308.3f4e250a@notabene.brown>
References: <1421240530-7971-1-git-send-email-ulf.hansson@linaro.org>
	<1421240530-7971-3-git-send-email-ulf.hansson@linaro.org>
	<20150115165825.GL16217@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/G6QNO4ykORx7wMNJN/Q8qVO"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57750 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbbAOSyb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 15 Jan 2015 13:54:31 -0500
In-Reply-To: <20150115165825.GL16217@leverpostej>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Doug Anderson <dianders@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

--Sig_/G6QNO4ykORx7wMNJN/Q8qVO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Jan 2015 16:58:26 +0000 Mark Rutland <mark.rutland@arm.com> wrot=
e:

> Hi Ulf,
>=20
> On Wed, Jan 14, 2015 at 01:02:08PM +0000, Ulf Hansson wrote:
> > The simple MMC power sequence provider, intends to supports a set of
> > common properties between SOC designs. It thus enables us to re-use the
> > same provider for several SOCs.
> >=20
> > In this initial step, let's add the top level description of the MMC
> > power sequence and describe the compatible string for the simple MMC
> > power sequence provider.
> >=20
> > Following patches will step by step add support for new properties to
> > the simple MMC power sequence provider.
> >=20
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >=20
> > Changes in v2:
> > 	- None.
> >=20
> > ---
> >  .../devicetree/bindings/mmc/mmc,pwrseq-simple.txt      | 18 ++++++++++=
++++++++
> >  Documentation/devicetree/bindings/mmc/mmc.txt          |  5 +++++
> >  2 files changed, 23 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/mmc,pwrseq-si=
mple.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.tx=
t b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
> > new file mode 100644
> > index 0000000..e1b7f9c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
> > @@ -0,0 +1,18 @@
> > +* The simple MMC power sequence provider
> > +
> > +System on chip designs may specify a specific MMC power sequence. To
> > +successfully detect an (e)MMC/SD/SDIO card, that power sequence must be
> > +maintained while initializing the card.
> > +
> > +The simple MMC power sequence provider, intends to supports a set of c=
ommon
> > +properties between SOC designs. It thus enables us to re-use the same =
provider
> > +for several SOC designs.
> > +
> > +Required properties:
> > +- compatible : contains "mmc,pwrseq-simple".
>=20
> Nit: "mmc" is not a vendor prefix.
>=20
> > +
> > +Example:
> > +
> > +	sdhci0_pwrseq {
> > +		compatible =3D "mmc,pwrseq-simple";
> > +	}
>=20
> I'm a little confused here. What specific sequence is described by this
> node? We don't appear to have referred to any resources used as part of
> that sequence, and the description above only mentions that there could
> be a specific sequence, not what that sequence is.
>=20
> So I don't think this makes sense on its own, and should probably be
> folded with patches adding the initial support for the resources used as
> part of the sequence (e.g. the GPIOs added in a later patch).
>=20

I guess I assumed that this "simple" referred to the current behaviour, whi=
ch
includes some of vmmc-supply, vqmmc-supply, vmmc_aux-supply and pbias-supply
being switched at "appropriate" times.

Would it make sense to bring all of these explicitly under the "pwrseq"
umbrella, leaving the current behaviour only when no pwrseq node is provide=
d?

Also, it isn't clear to me whether the need for power/reset is a function of
the mmc-host, or a function of the device attached to the host.  I suspect
some are needed by one, some by the other.  Any by both?

Should the two needs be kept separate?

NeilBrown


--Sig_/G6QNO4ykORx7wMNJN/Q8qVO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVLgMlDnsnt1WYoG5AQKeLQ/8CJcQcQov+aWtrLwSzVT/KMrXfNICn37r
Kofg3G2ZzVE/2gFvkc7VS/mvHIdvOXbg/F4MRNl+bbZ/0oTybXkFUE06xBK937+u
5q6cc7IgFK4OUE3BXpgYuYln0PWswvJ9ec6fg/jFSzfAb6E7Oc8qimGLeGGfACcH
/Uf7eIBDhvikC60djn/V7dQuUHFhq6j/7hIEtzf034wVF8VZvAljSWUsmsp2lPrl
Ne5uJOD9feCiBYVkUUCzYazZr3ffLVLwDjwRhmKR8q2BUfyABW+o+jeSAV2As1Td
PTPE/Qys06X3bhvV7Ue4ERd1bmxHgPU2agZYnuTPUw8N/XDB5dff+5ER2KTnExR5
28qjq6jd2QzooPS/4rg9mr+eiXNx/Eslf+933mWhtjIIqdL2VktttP2ATrnyaWw6
+1cyNL1qIqDYFiEbMVQz+67l92iZdK79X8GNe8yfquEao2aT/FBP2ykv25zgo6W9
UiaDdsGxGAVb1HRdwqiKYLp+/PvoDT9JhqJDbo3vhEvl/mr9gbw19K9PyPAi0WID
FiOCE/p0j2DRcrfV5yYu6ysi/GrTj5BuAiy8L9nX7fq9we/HCXVf5VzFpBk+sWF4
/s0RPH+NEZkl5o8ixPUWW1pAHTKpHccbNzkhKj3tew1Vz6Nuykjxzj24plNSwrSM
2//4sYnYMMo=
=FXOL
-----END PGP SIGNATURE-----

--Sig_/G6QNO4ykORx7wMNJN/Q8qVO--
