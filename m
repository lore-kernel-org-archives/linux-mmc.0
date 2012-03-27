From: Eric =?ISO-8859-1?B?QuluYXJk?= <eric@eukrea.com>
Subject: Re: [MX25][MMC] mmc esdhc failure in 3.3
Date: Tue, 27 Mar 2012 10:12:59 +0200
Message-ID: <20120327101259.73525f9d@eb-e6520>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
	<20120312132423.GC2459@pengutronix.de>
	<9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
	<0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
	<a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
	<85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/l86hndlqHNLOhLd.vQxn4yj"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:43837 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab2C0INo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Mar 2012 04:13:44 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 6746A79435E
	for <linux-mmc@vger.kernel.org>; Tue, 27 Mar 2012 10:13:40 +0200 (CEST)
In-Reply-To: <85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: joancarles <joancarles@fqingenieria.es>
Cc: Zhu Richard-R65037 <r65037@freescale.com>, shawn.guo@linaro.org, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, linux-arm-kernel@lists.infradead.org

--MP_/l86hndlqHNLOhLd.vQxn4yj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Le Tue, 27 Mar 2012 09:32:36 +0200,
joancarles <joancarles@fqingenieria.es> a =E9crit :

> G'day
>=20
> This is still present, and we have absolutely no idea where to continue=20
> searching for the solution of the problem. Any pointers? Any git trees=20
> of mmc driver changes we could try? Anybody else with a MX25 that has=20
> this issue?
>=20
does that attached patch fix your problem ?

Eric

--MP_/l86hndlqHNLOhLd.vQxn4yj
Content-Type: text/x-patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=0001-esdhc-imx-unbreak-on-i.MX25.patch

=46rom 6b41fd664bdb4755a0c22abdbe5524a76ac74330 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Eric=3D20B=3DC3=3DA9nard?=3D <eric@eukrea.com>
Date: Mon, 12 Mar 2012 22:17:05 +0100
Subject: [PATCH] esdhc-imx: unbreak on i.MX25
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-es=
dhc-imx.c
index 4dc0028..fe0da1c 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -400,8 +400,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platf=
orm_device *pdev)
 	clk_enable(clk);
 	pltfm_host->clk =3D clk;
=20
-	if (!is_imx25_esdhc(imx_data))
-		host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+	host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
=20
 	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
 		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
--=20
1.7.7.6


--MP_/l86hndlqHNLOhLd.vQxn4yj--
