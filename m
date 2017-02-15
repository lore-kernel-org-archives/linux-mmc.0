From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: use eMMC lifetime info to warn user
Date: Wed, 15 Feb 2017 12:39:25 +0900
Message-ID: <51a12f4e-0b5e-828a-efd0-52fa49a35046@samsung.com>
References: <CGME20170214205341epcas5p4ae3f0765636eb49b0d923f40594ba880@epcas5p4.samsung.com>
 <b3f67c2a-fbf7-b2fb-c05e-138fbdd77e39@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60661 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751509AbdBODj3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 22:39:29 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OLE02LG3CTQVW00@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 15 Feb 2017 12:39:26 +0900 (KST)
In-reply-to: <b3f67c2a-fbf7-b2fb-c05e-138fbdd77e39@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Jungseung Lee <js07.lee@samsung.com>

Hi,

On 02/15/2017 05:53 AM, Heiner Kallweit wrote:
> Now that the new lifetime parameters are available in struct mmc_ext_csd
> we can use this information to warn the user if card is close to or
> beyond end of its lifetime.

I don't know this patch has which benefit to user.
I think it doesn't need to show the life time in kernel side.

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mmc/core/bus.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 30124651..ab20d242 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -345,6 +345,22 @@ int mmc_add_card(struct mmc_card *card)
>  			uhs_bus_speed_mode, type, card->rca);
>  	}
>  
> +	if (card->ext_csd.device_life_time_est_typ_a == 0xb ||
> +	    card->ext_csd.device_life_time_est_typ_b == 0xb)
> +		pr_err("%s: memory has exceeded its life time",
> +			mmc_hostname(card->host));
> +	else if (card->ext_csd.device_life_time_est_typ_a == 0xa ||
> +		 card->ext_csd.device_life_time_est_typ_b == 0xa)
> +		pr_warn("%s: memory has used more than 90%% of its life time\n",
> +			mmc_hostname(card->host));
> +
> +	if (card->ext_csd.pre_eol_info == 3)
> +		pr_err("%s: out of reserved blocks\n",
> +			mmc_hostname(card->host));
> +	else if (card->ext_csd.pre_eol_info == 2)
> +		pr_warn("%s: more than 80%% of reserved blocks consumed\n",
> +			mmc_hostname(card->host));
> +
>  #ifdef CONFIG_DEBUG_FS
>  	mmc_add_card_debugfs(card);
>  #endif
> 

