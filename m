From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2 1/7] mmc: lock: Use the kernel "KEYS" subsystem to get a card's password
Date: Sun, 01 Sep 2013 19:53:34 +0100
Message-ID: <86li3gcr0x.fsf@void.printf.net>
References: <1377893665-26754-1-git-send-email-alcooperx@gmail.com>
	<1377893665-26754-2-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42982 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756660Ab3IASxg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 1 Sep 2013 14:53:36 -0400
In-Reply-To: <1377893665-26754-2-git-send-email-alcooperx@gmail.com> (Al
	Cooper's message of "Fri, 30 Aug 2013 16:14:19 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org

Hi Al,

On Fri, Aug 30 2013, Al Cooper wrote:
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -26,3 +26,11 @@ config MMC_CLKGATE
>  	  support handling this in order for it to be of any use.
>  
>  	  If unsure, say N.
> +
> +config MMC_LOCK
> +	bool "MMC/SD password based card lock/unlock"
> +	select KEYS
> +	help
> +	  This will add the ability to lock/unlock SD and MMC cards.
> +
> +	  If unsure, say N.

Is there a good reason to have this behind a Kconfig entry, rather
than just enabled for everyone?  I'm happy to just enable it if we
don't expect any downside.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
