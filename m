From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 9/9] mmc: sdhi: Add r8a7795 support
Date: Thu, 11 Feb 2016 01:07:16 +0100
Message-ID: <20160211000716.GA2058@tetsubishi>
References: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
 <1453749316-1848-10-git-send-email-wsa@the-dreams.de>
 <CAPDyKFo6oXEAy562p7MTxw0eKYZe_nnT2q+hbLKF4Lv2kMUvGg@mail.gmail.com>
 <20160210163623.GA15453@katana>
 <CAPDyKFrzFA_3MnkOPGLD7Fy84XAyx7+=utERbNF1cX31KWxHMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:42403 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbcBKAHZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Feb 2016 19:07:25 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFrzFA_3MnkOPGLD7Fy84XAyx7+=utERbNF1cX31KWxHMg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I suspect you are using a delayed work in this driver to deal with
> request timeouts.
>=20
> The value for the delay that is used, needs to be informed towards the
> mmc core via the "->max_busy_timeout".

Shouldn't that be a seperate patch? In patch 9, I add support for
another SoC. But your requested change will affect all SoCs.

> One more thing, as the documentation of your host controllers lacks
> some information about the busy mode, perhaps it's worth to add some
> comments about this in the code and as well in the change-log!?

Do you mean documenting my findings with the mmc_test driver? Or
something else?

Thanks,

   Wolfram


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWu9C0AAoJEBQN5MwUoCm2zfUQAJqV43W7ZtB/ye+0X8k0U2+y
Baywmad4k1QZAhev5Lset6xUAksB+2CgK63dSj73z134CX8kZ16707tnQXkEGh24
Ql+hmKp2RhM868Iz4RlizBU+a3n03mjTqsvk5VmbuCRnyX7PU2ocCYMlWkLpmYyV
lhuGYZi8yIH7URqvrquN5p/D1b3mUz5CvvizmiywMQYXl1BRRlY1LDNiTk5zASI9
HVAfAiKy6A9t3bRbukmS2OxKF3MLpZVyrUcCaLj2Njpo003opPw2JPBBrs3uS/Uk
z/0ibblqtFWgJb+dbuY17f70+fEuTbSL5/sAbs8uKSynqcTU+0u05/PDXSMumn9N
WDmfd2nXWKxA9xL8nJjaMs3a2WL3F1nnur2q/lGWzXEnAWTsVFaiiP5C6gfvUsS0
dQHjrDx/sF3GIRY/1DndpifZsLr+wc6epo/2QO0j4GMlEtHOgXmYVlub6dIKJ0nH
v66aU6s8LG9uYN/IaOKKV4nnacEUvB1eXxVvPVS18yD9gpN2k9+lqcrC1Rt/tEQQ
iaX3jQeZ6yli+Yz+XwL96h2rDZCKWRcwuKY4Ap3/iEUfO6zpKEILP4ICTl+L84JE
IAG5MJCzx0ZUx8ysBP8+rwPdbqCZ00hfYKSLvue5YsLeWFaV/B4Ca7bvcedEVPDh
XaoMMcy1XWts48HKmUD3
=ViJ0
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
