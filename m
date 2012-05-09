From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mmc: core: Prevent eMMC VCC supply to be cut from late
 init
Date: Wed, 9 May 2012 16:56:23 +0100
Message-ID: <20120509155622.GE3955@opensource.wolfsonmicro.com>
References: <1336572926-21013-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2+IiqX0tbFQDLF7Q"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:38993 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758178Ab2EIP41 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 May 2012 11:56:27 -0400
Content-Disposition: inline
In-Reply-To: <1336572926-21013-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Jasi Brar <jassisinghbrar@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>


--2+IiqX0tbFQDLF7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2012 at 04:15:26PM +0200, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>=20
> For eMMC cards that has been initialized from a bootloader,
> the VCC voltage supply must not be cut in an uncontrolled
> manner, without first sending SLEEP or POWEROFF_NOTIFY.
>=20
> The regulator_init_complete late initcall, may cut the VCC
> regulator if it's reference counter is zero. To be able to
> prevent the regulator from being cut, mmc_start_host, which
> should execute at device init and thus before late init,
> calls mmc_power_up. Then the host driver is able to increase
> the reference to the regulator.

This looks like a good, simple solution - working out how we avoid extra
power ups will probably be more invasive and might not be worth the
effort for something that's boot time only.

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--2+IiqX0tbFQDLF7Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqpOYAAoJEBus8iNuMP3dLRkP/1u2gOtDEd9iSozBecqN6iRK
yKNYziQIKEXx2wqj7ZUdSn94+/QC9yHIHq3uOYXjpqxNDVXmcF0obt4EpDop34Yd
iyZeN/xmyXJoI0QLy6+OxSKkyXNZZuI1OaK8bDfqAk+DhId4FoJ0Oi0Pwc5HlgiI
30/yCy6cKWDD0CsmgdlFKcOtz080ULLTuT4ZdDiKFmlcytCpIS30ARFBFwtFi0Ic
Mj9lhy4K7sUjsZQ8dawWCz0ZWVdUgWNr3mHUD7QPQoDagh/dyIHgltnbiElyi74n
EgMWPJRQItBg9LYeAeyNwh6uy7+oRUAcxhfEJifwL4r4oq2oaNt6SEaZxhplsbmX
g3oMa8HqrSOxTzfBSUbtScFW0YodwhUbpxMQJcyA0cRrGwcd/zXvwhg4AedFTTgM
MBMgns3dqZlqk36Wb6ZFQhL0qT8g/F9gNOUfC82PfIdUIf+NhrKuVBAFVBnUSQ8h
T02Yh4RAYhni8xShcCfQJUFhO2PThFBjujYQD7sd1GaG76R9hnnQvjyY7ndpWs4I
AOFd1Ly673ZcO/n7DDFHa/9gfU9DU2LD3jdjqw9eGnL6BJL7ka3fR9qkPFDlmzvs
rvqWM5Du/fB0VvLD7A1Nkztl51uSIrMAX2q7CR/OARP0DmOdJ3VdSBgyle1iNdai
dbHKiHL6MEq9DsDYiGJ3
=oAnk
-----END PGP SIGNATURE-----

--2+IiqX0tbFQDLF7Q--
