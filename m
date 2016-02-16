From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v5 01/13] mmc: sdhci-bcm2835: use sdhci_pltfm_init for private allocation
Date: Tue, 16 Feb 2016 10:10:59 -0800
Message-ID: <87y4ak4jbg.fsf@eliezer.anholt.net>
References: <1455628111-5583-1-git-send-email-jszhang@marvell.com> <1455628111-5583-2-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:46453 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755747AbcBPSLE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Feb 2016 13:11:04 -0500
In-Reply-To: <1455628111-5583-2-git-send-email-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, arnd@arndb.de, ludovic.desroches@atmel.com, swarren@wwwdotorg.org, lee@kernel.org, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com, kernel@stlinux.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>

--=-=-=
Content-Type: text/plain

Jisheng Zhang <jszhang@marvell.com> writes:

> Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
> allows users of sdhci_pltfm to allocate private space in calls to
> sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates sdhci-bcm2835
> to this allocation.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWw2YzAAoJELXWKTbR/J7oTkoP/R37bu8dv96gem8FYlC2Hyjn
+jCcoCBswalifmxkcl4nMD0RH7OwY+i0MlD/pEMa/VHvTGbJcCU4+xKVPFNGD6/1
caGOMdu/MXEYzSKzYn/ooJez/nHKe3Z0pkd80xhfan+Vuwz/+EQ5viCL4ZGgS+na
kJR/2ttP0eOnQpKCiJJVgsN8WUNcFnRG4vbr4fhHQLkpHMVRyXHBLXkDy7UplxWx
3/M1DWFuq6lUge2BQARvpAuz3EP26FKXUiG03r7yW2sIBmGHFACS4dDkOrXrd2yY
vmIhgBlKu7PkRLZvjx9ZTz5VZ3Y9Cq1mrgz7oWdqmGibVuFrZoysNzooDf0Kjrm8
7agNbBWyMwzjCJzPdc142ofgFccMdDx0E1bZXnK3Y4kRbJKmvf0XFYEhRFEqwnCd
w7QH1WY9zQj/sVtSnH2V1kbE8Qwn5wt226Lo0r6myn4C+cWE0QFTSvO0b49n17RN
E0uv5/hIaXJ2mRT54a9bX8qHGSAFGydmNhQZIwIV4qrcep6Sm76t3z39tePpKW9L
L80fjpDRKBRuKItWgyhw0g7AL+4Lj00Hk46AEPx05yRq/WHBll8JwIrTrKVq8lyU
S7+ZK2uVWb1lgO4Z6oZAIp3Vb3SmAb2BBgKK3UyFXNIOFCGmfjMVzFzTgyEqk6dD
CU5i91QPRMWDYjjNXHfX
=Py2S
-----END PGP SIGNATURE-----
--=-=-=--
