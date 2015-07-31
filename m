From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH v3 2/6] mmc: sdhci-esdhc-imx: add tuning-step seting
 support
Date: Fri, 31 Jul 2015 12:41:49 +0800
Message-ID: <20150731044146.GA27806@shlinux1.ap.freescale.net>
References: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
 <1438160637-28061-3-git-send-email-haibo.chen@freescale.com>
 <1438273506.26075.2.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0118.outbound.protection.outlook.com ([157.56.110.118]:60048
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750804AbbGaEuh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 31 Jul 2015 00:50:37 -0400
Content-Disposition: inline
In-Reply-To: <1438273506.26075.2.camel@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan =?iso-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Cc: Haibo Chen <haibo.chen@freescale.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ulf.hansson@linaro.org, fabio.estevam@freescale.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, johan.derycke@barco.com, b29396@freescale.com, linux-arm-kernel@lists.infradead.org

On Thu, Jul 30, 2015 at 06:25:06PM +0200, Jan L=FCbbe wrote:
> On Mi, 2015-07-29 at 17:03 +0800, Haibo Chen wrote:
> > tuning-step is the delay cell steps in tuning procedure. The defaul=
t
> > value of tuning-step is 1. For imx6 series usdhc, tuning procedure =
can
> > be passed when the tuning-step value is 1. But imx7d usdhc need the
> > tuning-step value as 2, otherwise it can't pass the tuning procedur=
e.
> >=20
> > So this patch add the tuning-step setting in driver, so that user c=
an
> > set the tuning-step value in dts.
>=20
> From your description, the correct tuning-step value only depends on =
the
> SoC. Why not derive it from the compatible string?
>=20

'tuning-step' actually depends on board and card.
The commit message should be reformed a bit.

Regards
Dong Aisheng

> Regards,
> Jan L=FCbbe
> --=20
> Pengutronix e.K.                           |                         =
    |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0=
    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5=
555 |
>=20
