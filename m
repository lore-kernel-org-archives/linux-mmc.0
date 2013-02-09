From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v3 03/13] mmc: provide a standard MMC device-tree
 binding parser centrally
Date: Sat, 9 Feb 2013 14:37:51 +0100
Message-ID: <20130209133751.GA25584@pengutronix.de>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
 <1360180020-18555-4-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38182 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab3BINhy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Feb 2013 08:37:54 -0500
Content-Disposition: inline
In-Reply-To: <1360180020-18555-4-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>

On Wed, Feb 06, 2013 at 08:46:50PM +0100, Guennadi Liakhovetski wrote:
> +	/* Parse Card Detection */
> +	if (of_find_property(np, "non-removable", &len)) {
> +		host->caps |= MMC_CAP_NONREMOVABLE;
> +	} else {
> +		bool explicit_inv_cd, gpio_inv_cd = false;
> +
> +		explicit_inv_cd = !!of_find_property(np, "cd-inverted", &len);

You could use of_property_read_bool here

> +	/* Parse Write Protection */
> +	explicit_inv_wp = !!of_find_property(np, "wp-inverted", &len);

and here.

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
