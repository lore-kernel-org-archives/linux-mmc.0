From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mmc_mxc: Allow selection only for the correct
	platforms
Date: Wed, 9 Feb 2011 00:54:52 +0000
Message-ID: <20110209005452.GA23675@void.printf.net>
References: <1295542979-10329-1-git-send-email-fabio.estevam@freescale.com> <20110121103517.GD9041@pengutronix.de> <F09210E57DF486449C294B7BFB86534713C019@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54167 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755128Ab1BIAyy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Feb 2011 19:54:54 -0500
Content-Disposition: inline
In-Reply-To: <F09210E57DF486449C294B7BFB86534713C019@039-SN1MPN1-003.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Estevam Fabio-R49496 <R49496@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <s.hauer@pengutronix.de>

Hi Fabio,

On Wed, Feb 09, 2011 at 12:40:51AM +0000, Estevam Fabio-R49496 wrote:
> On Thu, Jan 20, 2011 at 03:02:59PM -0200, Fabio Estevam wrote:
> > Currently MMC_MXC driver can be selected by all i.MX devices.
> > 
> > Restrict its use only for the appropriate processors.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks for the ping -- I've pushed this to mmc-next with Sascha's ACK now.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
