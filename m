From: =?iso-8859-15?Q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 4/6] mmc: sdhci_pltfm: pass more data on custom init-call
Date: Thu, 30 Sep 2010 10:31:58 +0200
Message-ID: <19620.19198.88841.623775@ipc1.ka-ro>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
	<1285790884-3516-5-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([213.146.116.110]:35718 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab0I3IcI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2010 04:32:08 -0400
In-Reply-To: <1285790884-3516-5-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Zhu Richard-R65037 <r65037@freescale.com>, zhangfei gao <zhangfei.gao@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Philip Rakity <prakity@marvell.com>, linux-arm-kernel@lists.infradead.org

Hi,

Wolfram Sang writes:
> The custom init call may need more data to perform its job, so we pas=
s
> it a pointer to pdata, too. Also, always use the platform_id specific
> data even if platform_data is present. Doing that, platform_data can
> additionally be parsed by init() for board-specific information (via
> sdhci->mmc->parent).
>=20
Why not a pointer to the platform_device itself? Then the callback
function would have even more information (e.g. platform_device ID)
and could easily get at the platform_data too.


Lothar Wa=DFmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=DFe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=E4ftsf=FChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
