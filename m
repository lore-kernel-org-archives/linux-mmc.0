From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 00/11] mmc: document mmc_regulator_get_supply and fix
 users
Date: Sat, 14 Oct 2017 21:15:24 +0200
Message-ID: <20171014191524.uwvtueyctyozzjzx@ninjato>
References: <20171007103658.16868-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFoAZri8N79eZMFJeT6bN19XZPCvCD6oBmr5EXCj_KSTVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="25h4426ancotwraq"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44270 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751660AbdJNTP1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 14 Oct 2017 15:15:27 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFoAZri8N79eZMFJeT6bN19XZPCvCD6oBmr5EXCj_KSTVQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>


--25h4426ancotwraq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Or perhaps even coccinelle needs an update to be adopted to
> requirement from checkpatch?

No, it was my scripts. I missed to set the gitcommit filetype when
editing the message template. I fixed that in my scripts and will resend
in a minute. And I missed to set the flag for checkpatch checking. It is
now default. Thanks!


--25h4426ancotwraq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlniYkgACgkQFA3kzBSg
Kbbk4A/+NJwHDnqrxTmRhbQRTV+tgECBJPs5Pefg7l5kKL9DudLufB19cvjFPUa/
XgOpAVnuxFliOmf+Nm7IS+vDFzWwuuoJydAKANTpk1PDsBZADp05i2Qqi/y7ASGX
L5AL3PN0nNRIcQuG2KAIr5UI2S8J33Vod5hfCBqg+jhqEWQ6AV6jf5Ca8RUcHG80
yvULX4SutQcI/Mt8sjkAjLe4hoF2F7DMrAkyFt0pat+v3KtqtfMPALB95glSsOzb
7jdjL8qwZpHWiz3drfcBNJoA0ZrAwc++dEPyiiNy5O+fA3V4a72AJ4UwUmC4Ox0r
5kS5ik7rJ4966H7QVRxI1oyR2rXZCQDXG9f4IjE3Lo8A683+NfGeJG65yo5hlx3a
wjIOpBFyo4Qlsyc81Jrq3qOUa5SSFO6tC1w9WFgPABd9BkkzOMNSlSdg1xKX4R0/
lVBwxfCaY1fF9hbqsyOaMHpu4C2WfKatW6AAIdgxIVQAT4esmbziYtPS2JrjbomT
lGMcQQNMilwypQkwSDBpP99xPbWS1m6pKHvLHETu39gdFEV3ACYcT2neluc/WJDx
nuSio1bX+Zzy/pLzWAZgM5xa1OUOc7i855OZOtkwryT5dA2BzLUDD3OGBkGFZ845
pbBn463WSNsdJjz5m4HurAuGzKQ0xpge1N/DhF/T+wsYuLzUUKY=
=/NXv
-----END PGP SIGNATURE-----

--25h4426ancotwraq--
