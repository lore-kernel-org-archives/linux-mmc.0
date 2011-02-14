From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 7/7] ARM: mxs/mx28evk: add mmc device
Date: Mon, 14 Feb 2011 11:26:46 +0100
Message-ID: <20110214102646.GB30100@pengutronix.de>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
 <1297650746-12841-8-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45759 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab1BNK0x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 05:26:53 -0500
Content-Disposition: inline
In-Reply-To: <1297650746-12841-8-git-send-email-shawn.guo@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: cjb@laptop.org, s.hauer@pengutronix.de, arnd@arndb.de, LW@KARO-electronics.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Shawn,

> +/* mmc */
> +static void __init mx28evk_mmc_slot_poweron(int gpio)
> +{
> +	int ret;
> +
> +	ret = gpio_request(gpio, "mmc-slot-power");
> +	if (ret) {
> +		pr_err("Failed to request gpio mmc-slot-power: %d\n", ret);
> +		return;
> +	}
> +
> +	ret = gpio_direction_output(gpio, 0);
> +	if (ret) {
> +		pr_err("Failed to drive gpio mmc-slot-power: %d\n", ret);
> +		return;
> +	}
> +}

Minor nit: You could use gpio_request_one(), and doing so maybe even get rid of
this function and simply do it the init-function. The advantage would be, that
you can name the two GPIOs independently.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
