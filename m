From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 2/4] mmc: mvsdio: avoid compiler warning
Date: Thu, 5 Jun 2014 19:51:28 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1406051950490.25775@knanqh.ubzr>
References: <1402002881-1986640-1-git-send-email-arnd@arndb.de> <1402002881-1986640-3-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:46154 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbaFEXvb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jun 2014 19:51:31 -0400
Received: by mail-qa0-f44.google.com with SMTP id j7so2519256qaq.3
        for <linux-mmc@vger.kernel.org>; Thu, 05 Jun 2014 16:51:30 -0700 (PDT)
In-Reply-To: <1402002881-1986640-3-git-send-email-arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>

On Thu, 5 Jun 2014, Arnd Bergmann wrote:

> gcc correctly points out that hw_state can be used uninitially
> in the mvsd_setup_data() function. This rearranges the function
> to ensure it always contains a proper value.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Chris Ball <chris@printf.net>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: linux-mmc@vger.kernel.org

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  drivers/mmc/host/mvsdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index 9377284..6b4c5ad 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -79,11 +79,11 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
>  		unsigned long t = jiffies + HZ;
>  		unsigned int hw_state,  count = 0;
>  		do {
> +			hw_state = mvsd_read(MVSD_HW_STATE);
>  			if (time_after(jiffies, t)) {
>  				dev_warn(host->dev, "FIFO_EMPTY bit missing\n");
>  				break;
>  			}
> -			hw_state = mvsd_read(MVSD_HW_STATE);
>  			count++;
>  		} while (!(hw_state & (1 << 13)));
>  		dev_dbg(host->dev, "*** wait for FIFO_EMPTY bit "
> -- 
> 1.8.3.2
> 
