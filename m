From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Subject: Re: [PATCH] mmc: omap_hsmmc: support deferred probing for GPIOs
Date: Thu, 14 Feb 2013 11:43:37 +0100
Message-ID: <1360838617.3892.27.camel@coredoba.hi.pengutronix.de>
References: <1359536837-14874-1-git-send-email-jlu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56867 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933549Ab3BNKnC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Feb 2013 05:43:02 -0500
In-Reply-To: <1359536837-14874-1-git-send-email-jlu@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, 2013-01-30 at 10:07 +0100, Jan Luebbe wrote:
> If the CD/WP-GPIOs are not provided by the SoC's GPIO controller,
> we need to handle the case where omap_hsmmc is probed earlier than
> the GPIO controller chosen in the device tree.
> 
> Fix this by checking the return value of of_get_named_gpio against
> -EPROBE_DEFER and passing it through to the probe function.
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>

Balaji, since you seem to be the new OMAP HSMMC maintainer, do you have
any comments on this patch?

Thanks,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

