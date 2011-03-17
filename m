From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/3] dw_mmc: support mmc power control with regulator
Date: Thu, 17 Mar 2011 14:13:42 -0400
Message-ID: <m3ei65pqcp.fsf@pullcord.laptop.org>
References: <4D670F0E.7000800@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58746 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752780Ab1CQSQl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Mar 2011 14:16:41 -0400
In-Reply-To: <4D670F0E.7000800@samsung.com> (Jaehoon Chung's message of "Fri,
	25 Feb 2011 11:08:14 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>

Hi Jaehoon,

On Thu, Feb 24 2011, Jaehoon Chung wrote:
> This patch is applied the power control with regulator.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c  |   25 +++++++++++++++++++++++++
>  include/linux/mmc/dw_mmc.h |    2 ++
>  2 files changed, 27 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 46e5a89..338fedc 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -32,6 +32,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/dw_mmc.h>
>  #include <linux/bitops.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include "dw_mmc.h"
>  
> @@ -1438,6 +1439,13 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	}
>  #endif /* CONFIG_MMC_DW_IDMAC */
>  
> +	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
> +	if (IS_ERR(host->vmmc)) {
> +		printk(KERN_INFO "%s: no vmmc regulator found\n", mmc_hostname(mmc));
> +		host->vmmc = NULL;
> +	} else
> +		regulator_enable(host->vmmc);
> +
>  	if (dw_mci_get_cd(mmc))
>  		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
>  	else

I think you want an "#ifdef CONFIG_REGULATOR" around this hunk.
Please try building the driver with CONFIG_REGULATOR=n.

The other hunks in the patch shouldn't need it, because they test
"host->vcc" before making any regulator calls.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
