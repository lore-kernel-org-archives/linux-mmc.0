From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] dw_mmc: fixed wrong regulator_enable in suspend/resume
Date: Wed, 11 May 2011 09:46:06 -0400
Message-ID: <m3pqnp2vvl.fsf@pullcord.laptop.org>
References: <4DCA3237.3080609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57203 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754646Ab1EKPph (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 May 2011 11:45:37 -0400
In-Reply-To: <4DCA3237.3080609@samsung.com> (Jaehoon Chung's message of "Wed,
	11 May 2011 15:52:39 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Wed, May 11 2011, Jaehoon Chung wrote:
> In suspend function, regulator_enable() need not.
> regulator_enable() should be locate in resume function.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 87e1f57..66dcddb 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1769,9 +1769,6 @@ static int dw_mci_suspend(struct platform_device *pdev, pm_message_t mesg)
>  	int i, ret;
>  	struct dw_mci *host = platform_get_drvdata(pdev);
>  
> -	if (host->vmmc)
> -		regulator_enable(host->vmmc);
> -
>  	for (i = 0; i < host->num_slots; i++) {
>  		struct dw_mci_slot *slot = host->slot[i];
>  		if (!slot)
> @@ -1798,6 +1795,9 @@ static int dw_mci_resume(struct platform_device *pdev)
>  	int i, ret;
>  	struct dw_mci *host = platform_get_drvdata(pdev);
>  
> +	if (host->vmmc)
> +		regulator_enable(host->vmmc);
> +
>  	if (host->dma_ops->init)
>  		host->dma_ops->init(host);
>  
>

Should the regulator be being disabled in the suspend function, then?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
