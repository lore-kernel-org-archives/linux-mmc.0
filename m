From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 0/4] mmc: sdhci-s3c: use the sdhci-pltfm.c and move
 the header file
Date: Thu, 8 Mar 2012 11:01:06 +0000
Message-ID: <20120308110105.GD3638@opensource.wolfsonmicro.com>
References: <4F55ABF0.1060801@samsung.com>
 <20120306130054.GA9890@sirena.org.uk>
 <201203061415.18836.heiko@sntech.de>
 <CAELcNGS6UynrJPRk1KtEJT3Rm6Jb5_scLm4KKca+dJ1ZYDOVbg@mail.gmail.com>
 <20120306163052.GX19635@opensource.wolfsonmicro.com>
 <4F56D003.5070406@samsung.com>
 <20120307184843.GW3107@opensource.wolfsonmicro.com>
 <4F584539.9080007@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34557 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755877Ab2CHLBI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Mar 2012 06:01:08 -0500
Content-Disposition: inline
In-Reply-To: <4F584539.9080007@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, kgene kim <kgene.kim@samsung.com>


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 08, 2012 at 02:35:53PM +0900, Jaehoon Chung wrote:

> So i think no problem that removed "#include <plat/regs-sdhci.h>". is it wrong?
> Just touching the setup-gpio- files is problem?

It should be fine, like I say I didn't really read the patches in enough
detail as the diffstat set off alarm bells.

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWJFsAAoJEBus8iNuMP3dw0wP/3PrV1eGodaF0wjfL0wk9XKE
Wg2FkKQH9o4ksv2wIVTjSvMiFiiFrjid5HcmQDgIsARJcVmu7NJdNtf+4wsplHpf
jjaCkMOpEmuGjfvYYhLehKN3TMrbC1MjaLfFjHwn771CQz7B/cpUsySZ6rAq1jwF
71+Ov2fGaI5+6WmI4vPG88IS4M/k/TPe9A05lwUGllv9DmFcAOMXosKiPOXgXtiL
fYgyBG6y/GNOBx9iipjb3MFHi783WWq1/csuZuBceafNGHUCgICVc8NSuR/xTcL+
gjvv3uj7XV7iBgGDBXBh9DtV1DTFOCtFtFWs59NRiwdPSqp0ymm2fhYM0iPnUgnw
Q8uas0An4hDy5qU88CyxbdyB3nEBP8Er3fXnme3Nw/u+Nx8nvmDg82h0QTB0CqFr
Rinh24JgG/rHqXC6uT1NzilLw/AI+R6fWFAo8BLms72AUU6bXCxCUXPNXmnmdziK
81zsvthPwP5bdcmoj/JOygXhmvkAMhhEDXwRT39hu+tGprOyeBmHL+nLCvqky0lv
iJ7UlO4CkZmCgyv+lBjAHkzVWG/vgnyuyPVHb61B7cD1oh1SWeSpCyUxrTFWrNsg
llu3ZEp/nZkR+fs3olf5E06n4HCagF//+SY6fON8F3SqwSJcoG3owIiNMdCs7X/u
mS52kqhuc8ftYHMGO3Dy
=997l
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
