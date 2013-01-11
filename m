From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC PATCH] MAINTAINERS: Add an orphaned entry for the dw_mmc driver.
Date: Fri, 11 Jan 2013 12:31:01 -0500
Message-ID: <87wqvjmxt6.fsf@laptop.org>
References: <CAFbHwiRX19Zm=O2dNZrbTDGZxnXDOx0zJ3pvTkfC1q8m5DBFug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45542 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754373Ab3AKRcQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Jan 2013 12:32:16 -0500
In-Reply-To: <CAFbHwiRX19Zm=O2dNZrbTDGZxnXDOx0zJ3pvTkfC1q8m5DBFug@mail.gmail.com>
	(Will Newton's message of "Fri, 11 Jan 2013 17:26:38 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: linux-mmc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, James Hogan <james.hogan@imgtec.com>

Hi,

On Fri, Jan 11 2013, Will Newton wrote:
> I submitted this driver but will shortly no longer have access
> to hardware that uses it. The driver is quite widely used so
> there may be someone out there that feels strongly enough to
> step up and maintain it.
> ---
>  MAINTAINERS |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f940e81..88329bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6558,6 +6558,12 @@ F:	include/linux/dw_dmac.h
>  F:	drivers/dma/dw_dmac_regs.h
>  F:	drivers/dma/dw_dmac.c
>
> +SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER
> +L:	linux-mmc@vger.kernel.org
> +S:	Orphaned
> +F:	include/linux/mmc/dw_mmc.h
> +F:	drivers/mmc/host/dw_mmc*
> +
>  TIMEKEEPING, NTP
>  M:	John Stultz <johnstul@us.ibm.com>
>  M:	Thomas Gleixner <tglx@linutronix.de>

Thanks for your work on the driver, Will!  I'm CC'ing some recent
committers so they can volunteer to take over if they're interested.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
