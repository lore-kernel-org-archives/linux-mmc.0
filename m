From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 7/7] ARM: mxc: remove esdhc.h and use the public one
Date: Mon, 9 May 2011 14:23:25 +0800
Message-ID: <20110509062324.GA2577@freescale.com>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
 <1304601778-13837-8-git-send-email-shawn.guo@linaro.org>
 <20110506083959.GS11574@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:4953
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750860Ab1EIGXv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 May 2011 02:23:51 -0400
Received: from mail21-ch1 (localhost.localdomain [127.0.0.1])	by
 mail21-ch1-R.bigfish.com (Postfix) with ESMTP id 57F12B68203	for
 <linux-mmc@vger.kernel.org>; Mon,  9 May 2011 06:23:49 +0000 (UTC)
Received: from CH1EHSMHS029.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.241])	by mail21-ch1.bigfish.com (Postfix) with ESMTP id
 3E8FD1430051	for <linux-mmc@vger.kernel.org>; Mon,  9 May 2011 06:23:49 +0000
 (UTC)
Received: from ubuntu.localdomain (vpn-10-213-32-4.ea.freescale.net
 [10.213.32.4])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
 p496NRZ5008282	for <linux-mmc@vger.kernel.org>; Mon, 9 May 2011 01:23:43
 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20110506083959.GS11574@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, sameo@linux.intel.com, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Mike Rapoport <mike@compulab.co.il>, Chris Ball <cjb@laptop.org>, linuxppc-dev@lists.ozlabs.org, Albert Herranz <albert_herranz@yahoo.es>, Xiaobo Xie <X.Xie@freescale.com>

Hi Uwe,

On Fri, May 06, 2011 at 10:39:59AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Shawn,
>=20
> On Thu, May 05, 2011 at 09:22:58PM +0800, Shawn Guo wrote:
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |    1 -
> >  arch/arm/plat-mxc/include/mach/devices-common.h    |    2 +-
> what about removing arch/arm/plat-mxc/include/mach/esdhc.h in this
> patch as advertised in the subject?
>=20
Yes, will do if the patch #4 will finally stands.  People are voting
for it.  Let's see Wolfram's position.

--=20
Regards,
Shawn


