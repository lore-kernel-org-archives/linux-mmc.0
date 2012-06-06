From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: atmel-mci: fix data timeout issue
Date: Wed, 06 Jun 2012 06:02:36 -0400
Message-ID: <877gvk69mr.fsf@octavius.laptop.org>
References: <1337781135-23722-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60571 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180Ab2FFKCm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Jun 2012 06:02:42 -0400
In-Reply-To: <1337781135-23722-1-git-send-email-ludovic.desroches@atmel.com>
	(ludovic desroches's message of "Wed, 23 May 2012 15:52:15 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Wed, May 23 2012, ludovic.desroches@atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> The data timeout timer was configured after mmc_add_host call. So, with bad
> timings, it was possible to have a mmc request causing mod_timer call on a
> non setup timer.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/mmc/host/atmel-mci.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 93a1012..a25e23a 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2396,6 +2396,8 @@ static int __init atmci_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, host);
>  
> +	setup_timer(&host->timer, atmci_timeout_timer, (unsigned long)host);
> +
>  	/* We need at least one slot to succeed */
>  	nr_slots = 0;
>  	ret = -ENODEV;
> @@ -2434,8 +2436,6 @@ static int __init atmci_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	setup_timer(&host->timer, atmci_timeout_timer, (unsigned long)host);
> -
>  	dev_info(&pdev->dev,
>  			"Atmel MCI controller at 0x%08lx irq %d, %u slots\n",
>  			host->mapbase, irq, nr_slots);

Pushed to mmc-next for 3.5, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
