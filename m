From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Wed, 9 Feb 2011 08:46:18 +0100
Message-ID: <19794.17994.381937.158944@ipc1.ka-ro>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
	<1296872327-21166-2-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:60365 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325Ab1BIHrD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Feb 2011 02:47:03 -0500
In-Reply-To: <1296872327-21166-2-git-send-email-shawn.guo@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: cjb@laptop.org, s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Shawn,

Shawn Guo writes:
> This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> The driver calls into mxs-dma via generic dmaengine api for both pio
> and data transfer.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/include/mach/mmc.h |   15 +
>  drivers/mmc/host/Kconfig             |    9 +
>  drivers/mmc/host/Makefile            |    1 +
>  drivers/mmc/host/mxs-mmc.c           |  884 ++++++++++++++++++++++++=
++++++++++
>  4 files changed, 909 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/include/mach/mmc.h
>  create mode 100644 drivers/mmc/host/mxs-mmc.c
>=20
I've run the mmc-test kernel module with this driver on our TX28
module which fails in the following tests:
|mmc0: Test case 15. Correct xfer_size at write (start failure)...
|mmc0: Result: ERROR (-110)
|mmc0: Test case 16. Correct xfer_size at read (start failure)...
|mmc0: Result: ERROR (-110)
|mmc0: Test case 17. Correct xfer_size at write (midway failure)...
|mmc0: Result: ERROR (-110)
|mmc0: Test case 18. Correct xfer_size at read (midway failure)...
|mmc0: Result: ERROR (-110)

Could you try the test on your hardware?


Best regards,
Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
