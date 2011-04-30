From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] dw_mmc: fixed regulator control
Date: Sat, 30 Apr 2011 12:09:20 -0400
Message-ID: <m3iptv2027.fsf@pullcord.laptop.org>
References: <4DBA90BD.8070804@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48623 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755389Ab1D3QGD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 30 Apr 2011 12:06:03 -0400
In-Reply-To: <4DBA90BD.8070804@samsung.com> (Jaehoon Chung's message of "Fri,
	29 Apr 2011 19:19:41 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>

Hi Jaehoon,

On Fri, Apr 29 2011, Jaehoon Chung wrote:
> This patch fixed regulator control in dw_mmc.c
> If we didn't set CONFIG_REGULATOR, always entered error condition.
> But that's not error..because we didn't use regulator framework.
>
> So when we only used CONFIG_REGULATOR, i think that need to get regulator.
[..]
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 87e1f57..62b900f 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1441,12 +1441,14 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	}
>  #endif /* CONFIG_MMC_DW_IDMAC */
>  
> +#ifdef CONFIG_REGULATOR
>  	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
>  	if (IS_ERR(host->vmmc)) {
>  		printk(KERN_INFO "%s: no vmmc regulator found\n", mmc_hostname(mmc));
>  		host->vmmc = NULL;
>  	} else
>  		regulator_enable(host->vmmc);
> +#endif /* CONFIG_REGULATOR */
>  
>  	if (dw_mci_get_cd(mmc))
>  		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
[..]

As Lars pointed out, this doesn't make sense; without CONFIG_REGULATOR
host->vmmc becomes NULL, which isn't IS_ERR.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
