From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 19/25] of: add const to struct *of_device_id.data
Date: Mon, 23 Jul 2012 08:32:13 -0700
Message-ID: <20120723153213.GC19571@kroah.com>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-20-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53721 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab2GWPcT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jul 2012 11:32:19 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so11040704pbb.19
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jul 2012 08:32:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343034810-3386-20-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>, Ben Dooks <ben-linux@fluff.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, cbe-oss-dev@lists.ozlabs.org, Chris Ball <cjb@laptop.org>, Kevin Hilman <khilman@ti.com>, Kumar Gala <galak@kernel.crashing.org>, Linus Walleij <linus.walleij@stericsson.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Paul Mackerras <paulus@samba.org>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, spi-devel-general@lists.sourceforge.net, Timur Tabi <timur@freescale.com>, Vinod Koul <vinod.koul@intel.com>, Wim Van Sebroeck <wim@iguana.be>, Wolfram Sang <w.>

On Mon, Jul 23, 2012 at 11:13:24AM +0200, Uwe Kleine-K=F6nig wrote:
> Drivers should never need to modify the data of a device id. So it ca=
n
> be const which in turn allows more consts in the driver.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
