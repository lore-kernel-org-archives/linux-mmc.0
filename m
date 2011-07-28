From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] Detect the mmc v4.5
Date: Thu, 28 Jul 2011 18:32:22 -0400
Message-ID: <m239hqjatl.fsf@bob.laptop.org>
References: <20110726081237.GA15049@july>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35805 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756090Ab1G1Wc2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Jul 2011 18:32:28 -0400
In-Reply-To: <20110726081237.GA15049@july> (Kyungmin Park's message of "Tue,
	26 Jul 2011 17:12:37 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, jh80.chung@samsung.com

Hi Kyungmin,

On Tue, Jul 26 2011, Kyungmin Park wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
>
> As eMMC v4.5 Spec is released, prepare the eMMC v4.5
>
> EXT_CSD_REV	Extended CSD Revision
> 255-7		Reserved
> 6		Revision 1.6 (for MMC v4.5)
> 5		Revision 1.5 (for MMV v4.41)
> ...
>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index aa7d1d7..5700b1c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -259,7 +259,7 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  	}
>  
>  	card->ext_csd.rev = ext_csd[EXT_CSD_REV];
> -	if (card->ext_csd.rev > 5) {
> +	if (card->ext_csd.rev > 6) {
>  		printk(KERN_ERR "%s: unrecognised EXT_CSD revision %d\n",
>  			mmc_hostname(card->host), card->ext_csd.rev);
>  		err = -EINVAL;

Pushed to mmc-next for 3.1, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
