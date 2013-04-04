From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: mxs-mmc: add non-removeable property
Date: Thu, 04 Apr 2013 10:07:16 -0400
Message-ID: <87r4iqpey3.fsf@octavius.laptop.org>
References: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
	<1364223751-28253-3-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50546 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760186Ab3DDOHW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 4 Apr 2013 10:07:22 -0400
In-Reply-To: <1364223751-28253-3-git-send-email-mkl@pengutronix.de> (Marc
	Kleine-Budde's message of "Mon, 25 Mar 2013 16:02:31 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Hi,

On Mon, Mar 25 2013, Marc Kleine-Budde wrote:
> +	host->non_removeable = of_property_read_bool(np, "non-removable");
> +	if (host->non_removeable)
> +		mmc->caps |= MMC_CAP_NONREMOVABLE;

The correct spelling is "non_removable", as used in the DT property.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
