From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/3] mmc: tmio: add eMMC HS400 mode support
Date: Tue, 13 Feb 2018 14:00:44 +0100
Message-ID: <20180213130044.zu22wwhq2y4phnri@katana>
References: <20180119133906.11280-1-horms+renesas@verge.net.au>
 <20180119133906.11280-3-horms+renesas@verge.net.au>
 <20180207222012.5hxmo2sdelur4uoj@ninjato>
 <20180213113353.tioy73y2ggsat7m3@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fyhy6gch5wtsizgd"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:41530 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935077AbeBMNAp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 13 Feb 2018 08:00:45 -0500
Content-Disposition: inline
In-Reply-To: <20180213113353.tioy73y2ggsat7m3@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--fyhy6gch5wtsizgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 12:33:53PM +0100, Simon Horman wrote:
> On Wed, Feb 07, 2018 at 11:20:12PM +0100, Wolfram Sang wrote:
> >=20
> > Hi Simon,
> >=20
> > > +	void (*disable_scc)(struct mmc_host *mmc);
> >=20
> > Do we really need this callback? I'd think it can be folded into
> > reset_hs400_mode() because it is called only once?
> >=20
> > > +	void (*prepare_hs400_tuning)(struct mmc_host *mmc, struct mmc_ios *=
ios);
> >=20
> > Can't we use the host->ops->prepare_hs400_tuning() callback invoked by
> > the core?
>=20
> Empirically that does not seem to work.

:( Pity.

> > > +	void (*reset_hs400_mode)(struct mmc_host *mmc);
> >=20
> > Maybe we can get rid of this, too? See later...
> >=20
> > > +	if (host->disable_scc)
> > > +		host->disable_scc(mmc);
> >=20
> > (Here, this can be folded into the next callback)
>=20
> Yes, agreed. I've folded the callbacks as you suggest.

Cool, thanks!

> > > +
> > > +	/* reset HS400 mode */
> > > +	if (ios->timing !=3D MMC_TIMING_MMC_HS400 && host->reset_hs400_mode)
> > > +		host->reset_hs400_mode(mmc);
> >=20
> > I wonder: If for any ios which is !=3D MMC_TIMING_MMC_HS400, the
> > hs400_mode needs to be reset. Couldn't we as well then disable the mode
> > always after the MMC_TIMING_MMC_HS400 tuning was selected? Just
> > brainstorming here...
>=20
> Perhaps but I'm unsure where we would hook in this change, any ideas?

I think this becomes moot if we can't get the prepare-callback of the
core to work. I'd think it makes sense to have both callbacks from here
moved to the core or none to keep at least one kind of symmetry.


--fyhy6gch5wtsizgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqC4XsACgkQFA3kzBSg
KbbcRg/+O59B89Qf172d0C53k9mLM4Hcx1x1EWveULZQx84NMrSxaU6kkvB2W7uA
7BxVtE1+aYLxD3gklx8OarK6aGel9/zN/m4ERqbYVoP2tOZpOgvhJKBdC3IjFwPq
8OG0F0Tgi/BJOpfMxnF07sj2MiCkP3lksjO7ZU4AfdtJHo11rb9uCnCkz4/6zC8o
/PzssM+d2mJ1VSxIE3rOdQke5F432C/PHPtMq3tplJVYQcfahtRt9Hv0RqNrhT2C
y+dDj6D85T5zRU0GF9cd74HhWUPLbkAm7Ch4fEwpg9PITMeH04dbE2PhclyxnoTo
BN+MU+cSXUlxCvM4eqkw/lK5mO481BVac8f4kf22mVYagh9xypmwP4Zv3dD1w9BG
X4VnATu5mhlP8lfoESub1sC7AvSy6z4FFSBPuzhzNA4zvgdBWETJZSZE/zlX9wSu
+SAhQNNZDUAGjo6cT/HCad+YgEml2ziCA/mo7FdsqWNnf3biheNhwh/UKee0eBPh
VhjoDosgVWX8qn5LNxoCR5MqDe5Ho0v6ok1w0BmIswFTfd+z83SVbPpX8UI2Qv+9
BqoqBfEwzpCbc6h/tR25oHSpaHoMTzd79R+vH51E1Bo6+KpIAYCMytn64PzbvCF7
hOr559iHtm2wwYRp9XSFrOkDQbe+JB5hvr1LQ2lcyvqHvoTaO2I=
=MgwO
-----END PGP SIGNATURE-----

--fyhy6gch5wtsizgd--
