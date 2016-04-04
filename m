From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 0/9] r8a7790: add UHS-I (SDR50) support to Lager
Date: Mon, 4 Apr 2016 17:21:53 +0200
Message-ID: <20160404152153.GG2983@katana>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
 <CAPDyKFocCsLmPbFAuN989w4MCH_QKZzS8_YxqKvTZU5+yApZVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFocCsLmPbFAuN989w4MCH_QKZzS8_YxqKvTZU5+yApZVw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The documentation of mmc is quite poor. There are both code and
> specification that needs to be understand, so some more help from
> kernel doc could clearly help.

I agree.

> Anyway, I noticed that patch 6 helps to improve some documentation,
> that's great - thanks!

You're welcome. It wasn't too much work and maybe it helps someone with
debugging. I found some bug reports on the web which sounded somewhat
similar.

> I only had one minor comment on patch 7, the rest looks good to me!

Do you want me to resend or could you fix it before applying?

Thanks for the review!

   Wolfram


--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXAoaRAAoJEBQN5MwUoCm2UPIP/iSOjzfkGDqCLBMoLs2hPZVh
wcIVaaitDgfb6pp5ZKleDJyRPfa+Bo39/vSEyKfRLxFJJ9kRG4/mjYJuJrqovQi9
ZK2z2f3DKgGEJC5q4+qdrCbpRV7eAm4AVHvKiQ08GJaAMgLcRkovj3zOKUXDOHLv
OSzkUP3JrH2fJgWiCnx6EZEW9mNshsrvTustR4WKiE5f+BJhA5sRA1qInAAH2M2S
T3uVrGDrxTkAopDf6if8HYDC91kaqndi/mmV4DxQAS2lgNDEX8Fs4Ma68Gm/+ytb
nDu/BfMii6Vk7EMjbL0u3vH8NkmT3OmjyKyixtHRvDurxd4JwIK+3y/SqffsmoL5
GyHszEYdel3/0Jz4SmD2Q5n3LKA2wVlmudskyJGC4R0R06Xg1afLkBnjIWprri6r
h3PVhTU/LhVWiAdhCr8//+To642Ay7mdr+Ba3+G73GJsSYJd7GW7WHFjjA8eJ6gI
seY4JEykis5Walc8ePjviLsH8IZoUbpOKGwP1q9nOVAaSz2yqLSeSjaE+99DZUzz
FzCExCfQUBgHnlmJqRvCmIv14Z9neiAFCGiOD0UDk4X57VvLsyf2APjQau0L2EIZ
CvZIk1fO2lkfAepE6u2E5l/yv68w3vwNCqUCa1vdJzKWBL57zOYSkIR50+6zw/pC
t0u+s6L/NePK0S/v5qc/
=VpoS
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--
