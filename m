From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4] mmc: Make ID freq configurable
Date: Fri, 17 Dec 2010 01:09:32 +0000
Message-ID: <20101217010930.GG17239@void.printf.net>
References: <4C80187D.9000304@yahoo.es> <1291288582.15187.91.camel@stummala-linux.in.qualcomm.com> <4CF80DC6.1020801@yahoo.es> <20101202223812.GA2685@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50106 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364Ab0LQBKL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Dec 2010 20:10:11 -0500
Content-Disposition: inline
In-Reply-To: <20101202223812.GA2685@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Cc: Hein_Tibosch <hein_tibosch@yahoo.es>, Sahitya Tummala <stummala@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>, Pierre Ossman <pierre@ossman.eu>, Ben Nizette <bn@niasdigital.com>, Sascha Hauer <s.hauer@pengutronix.de>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Fleming <matt@console-pimps.org>

Hi Micha=C5=82, Sahitya,

On Thu, Dec 02, 2010 at 11:38:12PM +0100, Michal Miroslaw wrote:
> mmc: fix detection of memory part of SD-combo card with broken SDIO
>=20
> In case of failure, mmc_attach_sdio() will power off the SD bus.
> Power it up and reinitialize before trying SD memory detection.
>=20
> Reported-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Thanks, this looks correct to me too; I've pushed it to mmc-next for .3=
8.

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
