From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] of_mmc_spi: Need to include irq.h and of_irq.h
Date: Thu, 24 Mar 2011 18:55:30 -0400
Message-ID: <m3vcz8m8m5.fsf@pullcord.laptop.org>
References: <20110318.150023.27819221.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40766 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932915Ab1CXW7G (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Mar 2011 18:59:06 -0400
In-Reply-To: <20110318.150023.27819221.davem@davemloft.net> (David Miller's
	message of "Fri, 18 Mar 2011 15:00:23 -0700 (PDT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: grant.likely@secretlab.ca, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 18 2011, David Miller wrote:
> Since these are the headers that provide irq_of_parse_and_map()
> and NO_IRQ.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>
>
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> index 5530def..e2aecb7 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -15,9 +15,11 @@
>  #include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/slab.h>
> +#include <linux/irq.h>
>  #include <linux/gpio.h>
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
> +#include <linux/of_irq.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/mmc_spi.h>
>  #include <linux/mmc/core.h>

Pushed to mmc-next for .39-rc2 with Grant's ACK, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
