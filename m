From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: SDHI clock imbalance
Date: Tue, 6 Jun 2017 12:49:44 +0200
Message-ID: <20170606104944.6zewibifk3xfxetk@ninjato>
References: <CAMuHMdX7_u_3TFK22inUp367LR3R77S72RAtRWPFnKE9-cUtpw@mail.gmail.com>
 <CAPDyKFpfff0AwbKwJEhH_-Vkn+i+1bXp5P-OWiZ2O=71s+s5vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pibgxcti7gnrdqqq"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55649 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbdFFKtq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 6 Jun 2017 06:49:46 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFpfff0AwbKwJEhH_-Vkn+i+1bXp5P-OWiZ2O=71s+s5vw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms@verge.net.au>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>


--pibgxcti7gnrdqqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> The driver calls pm_runtime_set_active() during ->probe(), which means
> genpd's ->runtime_resume() callback isn't invoked during that point.
> In other words, the clocks managed by the clock domain isn't enabled
> during ->probe() as genpd's doesn't get to run pm_clk_resume() from
> its ->runtime_resume() callback. Unless I am missing something. :-)

So, in my words: in that case, the device is not really active since the
clocks are not enabled?

> I think this is the reason to the following problems. How to fix it?
>=20
> The driver needs to call pm_runtime_get_sync() instead of
> pm_runtime_set_active(), however that may requires some careful
> changes if one wants the driver to be able to enable clocks also when
> CONFIG_PM is unset.

We have tmio_mmc_clk_enable() already for that, I'd think. Or am I
misunderstanding?

> Add a "init" flag to host struct, and set that flag before calling
> pm_runtime_get_sync() in ->probe(). When the driver's
> ->runtime_resume() callbacks get called when the "init" flag is set,
> just do an early return 0, as t means ->probe() is running and has
> already taken care of the enabling the clock. When probe is done, and
> before dropping runtime usage count with pm_runtime_put(), reset the
> "init" flag.

Welllll... I hope we can avoid this ;)

Thanks for your thoughts, Ulf. And thanks to Geert for bringing up the
issue which I can reproduce here. We need to do a bigger PM
re-evaluation anyhow, I'll add it to the list...


--pibgxcti7gnrdqqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlk2iMgACgkQFA3kzBSg
KbZKsg//Zsq83wzm57qYfVXbkB2ILynMExIDGNJildnJFGyGhiM1IFJ4knKpAIZ8
8WhFMcd9kY3ORDJbm9/F6e15rI7u9+5DFDrRYxQBlaPFrKB7RgEIQNXR4XcX9/zR
6zRDnTK+SHT9yjz67KiftJGMxNCwI7h5nqk1qk1VV1AGI2uUwAgvkFp/9jqmXjjw
cH4Knd8E1Adz/Q8L0ARZwziQmYDYmzgOMgMuVjcZrT+CdcCr7JhjJtbyeKZ4G4pc
MwPxwLn+YKlvEKpe+cUMTteWzbXtt176vlz+lp9DGCkX/VUp9bcFVwlLMbH9zL/Z
cyP3A2SmehPilzw/BUmhglFqsQlxWa6+TtBGvoO8t9xjIQvbhlMJMdm5XV88ri0Y
g2Fclt8i1w2BryXUPks1pO/407gPnjGlkcNlb09POLRyun3+9WPVpT2S0QsjpK2S
ytE5NVJqeZtKn6OxosEX5wH/4VwfgDfJBs+8uFHWItqzP/duYaoq0RlJ+hJjBQ2h
KV8PItpvfoXAB8TP9CcFxpXXnzumhj/bv0hIURoBUqE16xoNe4ONMcp5iKFcv9G7
J7eFt2XcDzWtl7TdtP5pkf82gVY5YepgoiwRH2qZDDnUJYb7YmhcynFgFhOfUWji
xYa42dXWU2Z9i99MDLZNH92pEZUaK0e/C5CWOyHZ0aYlaCpbzyI=
=4H7w
-----END PGP SIGNATURE-----

--pibgxcti7gnrdqqq--
