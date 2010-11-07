From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
Date: Sun, 7 Nov 2010 22:51:37 +0000
Message-ID: <20101107225137.GE13608@void.printf.net>
References: <20101022231203.GA6502@void.printf.net> <1287791842-706-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53452 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439Ab0KGWvj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 7 Nov 2010 17:51:39 -0500
Content-Disposition: inline
In-Reply-To: <1287791842-706-1-git-send-email-eric@eukrea.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.gsc@gmail.com, w.sang@pengutronix.de, nicolas.pitre@linaro.org, r65037@freescale.com, amit.kucheria@linaro.org

Hi Eric,

On Sat, Oct 23, 2010 at 01:57:21AM +0200, Eric B=E9nard wrote:
> this patch fix timeout problems on i.MX's sdhci as suggested by
> Richard Zhu.
>=20
> Tested on :
> - i.MX257 : not needed
> - i.MX357 : needed
> - i.MX515 : needed
>=20
> more details can be found here :
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/02=
9748.html
>=20
> Signed-off-by: Eric B=E9nard <eric@eukrea.com>
> Tested-by: Shawn Guo <shawn.gsc@gmail.com>
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Thanks, I've pushed and queued these two patches for 2.6.37.

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
