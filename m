From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 7/7] ARM: mxc: remove esdhc.h and use the public one
Date: Fri, 6 May 2011 10:39:59 +0200
Message-ID: <20110506083959.GS11574@pengutronix.de>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
 <1304601778-13837-8-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60981 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab1EFIkH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2011 04:40:07 -0400
Content-Disposition: inline
In-Reply-To: <1304601778-13837-8-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, sameo@linux.intel.com, Arnd Bergmann <arnd@arndb.de>, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, Saeed Bishara <saeed@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Grant Likely <grant.likely@secretlab.ca>, Xiaobo Xie <X.Xie@freescale.com>, kernel@pengutronix.de, Mike Rapoport <mike@compulab.co.il>, Olof Johansson <olof@lixom.net>, Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@lists.ozlabs.org, Albert Herranz <albert_herranz@yahoo.es>, linux-arm-kernel@lists.infradead.org

Hello Shawn,

On Thu, May 05, 2011 at 09:22:58PM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |    1 -
>  arch/arm/plat-mxc/include/mach/devices-common.h    |    2 +-
what about removing arch/arm/plat-mxc/include/mach/esdhc.h in this
patch as advertised in the subject?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
