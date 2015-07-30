From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Subject: Re: [PATCH v3 2/6] mmc: sdhci-esdhc-imx: add tuning-step seting
 support
Date: Thu, 30 Jul 2015 18:25:06 +0200
Message-ID: <1438273506.26075.2.camel@pengutronix.de>
References: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
	 <1438160637-28061-3-git-send-email-haibo.chen@freescale.com>
Reply-To: jlu@pengutronix.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39800 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbbG3QZb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jul 2015 12:25:31 -0400
In-Reply-To: <1438160637-28061-3-git-send-email-haibo.chen@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@freescale.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ulf.hansson@linaro.org, aisheng.dong@freescale.com, fabio.estevam@freescale.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, johan.derycke@barco.com, b29396@freescale.com, linux-arm-kernel@lists.infradead.org

On Mi, 2015-07-29 at 17:03 +0800, Haibo Chen wrote:
> tuning-step is the delay cell steps in tuning procedure. The default
> value of tuning-step is 1. For imx6 series usdhc, tuning procedure ca=
n
> be passed when the tuning-step value is 1. But imx7d usdhc need the
> tuning-step value as 2, otherwise it can't pass the tuning procedure.
>=20
> So this patch add the tuning-step setting in driver, so that user can
> set the tuning-step value in dts.

=46rom your description, the correct tuning-step value only depends on =
the
SoC. Why not derive it from the compatible string?

Regards,
Jan L=C3=BCbbe
--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

