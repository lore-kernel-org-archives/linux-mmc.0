From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 2/3] mmc: protect against clockgate races
Date: Tue, 16 Nov 2010 17:27:09 +0000
Message-ID: <4CE2BEED.9080705@csr.com>
References: <1289926612-14049-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:46627 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505Ab0KPR1U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Nov 2010 12:27:20 -0500
Received: from rly53d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly53d.srv.mailcontrol.com (MailControl) with ESMTP id oAGHRFlY022677
	for <linux-mmc@vger.kernel.org>; Tue, 16 Nov 2010 17:27:17 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly53d.srv.mailcontrol.com (MailControl) id oAGHRCGX021774
	for <linux-mmc@vger.kernel.org>; Tue, 16 Nov 2010 17:27:12 GMT
In-Reply-To: <1289926612-14049-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

Linus Walleij wrote:
> This adds a mutex to protect from races between gate and ungate
> calls colliding.

Can you rework this to not require both host->clk_gate_mutex and
host->clk_lock?  Is host->clk_lock necessary any more?

David

> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> This should fix the race observed by Ohad earlier.
> ---
>  drivers/mmc/core/host.c  |   11 ++++++++---
>  include/linux/mmc/host.h |    1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index f74b386..92e3370 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -68,9 +68,9 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
>  	unsigned long flags;
>  
>  	if (!freq) {
> -		pr_err("%s: frequency set to 0 in disable function, "
> -		       "this means the clock is already disabled.\n",
> -		       mmc_hostname(host));
> +		pr_debug("%s: frequency set to 0 in disable function, "
> +			 "this means the clock is already disabled.\n",
> +			 mmc_hostname(host));
>  		return;
>  	}
>  	/*
> @@ -94,6 +94,7 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
>  		spin_unlock_irqrestore(&host->clk_lock, flags);
>  		return;
>  	}
> +	mutex_lock(&host->clk_gate_mutex);
>  	spin_lock_irqsave(&host->clk_lock, flags);
>  	if (!host->clk_requests) {
>  		spin_unlock_irqrestore(&host->clk_lock, flags);
> @@ -103,6 +104,7 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
>  		pr_debug("%s: gated MCI clock\n", mmc_hostname(host));
>  	}
>  	spin_unlock_irqrestore(&host->clk_lock, flags);
> +	mutex_unlock(&host->clk_gate_mutex);
>  }
>  
>  /*
> @@ -128,6 +130,7 @@ void mmc_host_clk_ungate(struct mmc_host *host)
>  {
>  	unsigned long flags;
>  
> +	mutex_lock(&host->clk_gate_mutex);
>  	spin_lock_irqsave(&host->clk_lock, flags);
>  	if (host->clk_gated) {
>  		spin_unlock_irqrestore(&host->clk_lock, flags);
> @@ -137,6 +140,7 @@ void mmc_host_clk_ungate(struct mmc_host *host)
>  	}
>  	host->clk_requests++;
>  	spin_unlock_irqrestore(&host->clk_lock, flags);
> +	mutex_unlock(&host->clk_gate_mutex);
>  }
>  
>  /**
> @@ -214,6 +218,7 @@ static inline void mmc_host_clk_init(struct mmc_host *host)
>  	host->clk_gated = false;
>  	INIT_WORK(&host->clk_gate_work, mmc_host_clk_gate_work);
>  	spin_lock_init(&host->clk_lock);
> +	mutex_init(&host->clk_gate_mutex);
>  }
>  
>  /**
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 955bc10..53496bb 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -178,6 +178,7 @@ struct mmc_host {
>  	struct work_struct	clk_gate_work; /* delayed clock gate */
>  	unsigned int		clk_old;	/* old clock value cache */
>  	spinlock_t		clk_lock;	/* lock for clk fields */
> +	struct mutex		clk_gate_mutex;	/* mutex for clock gating */
>  #endif
>  
>  	/* host specific block data */


-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
