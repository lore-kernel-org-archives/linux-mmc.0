From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] dw_mmc: modify quirks bit-shift control
Date: Wed, 16 Feb 2011 19:42:32 +0000
Message-ID: <20110216194232.GA17634@void.printf.net>
References: <4D5B6C70.2030809@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38902 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726Ab1BPTme (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Feb 2011 14:42:34 -0500
Content-Disposition: inline
In-Reply-To: <4D5B6C70.2030809@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Will Newton <will.newton@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Wed, Feb 16, 2011 at 03:19:28PM +0900, Jaehoon Chung wrote:
> If we need some quirks, maybe add quirks in future
> But now, quirks value set to integer..later we should be confused..
> So i think that need bit-shift control.
> 
> And If we need not any quirks, we didn't set anything..
> (Need not DW_MCI_QUIRK_NONE)
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  include/linux/mmc/dw_mmc.h |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 16b0261..8614832 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -165,14 +165,12 @@ struct dw_mci_dma_ops {
>  };
>  
>  /* IP Quirks/flags. */
> -/* No special quirks or flags to cater for */
> -#define DW_MCI_QUIRK_NONE		0
>  /* DTO fix for command transmission with IDMAC configured */
> -#define DW_MCI_QUIRK_IDMAC_DTO		1
> +#define DW_MCI_QUIRK_IDMAC_DTO		(1 << 0)
>  /* delay needed between retries on some 2.11a implementations */
> -#define DW_MCI_QUIRK_RETRY_DELAY	2
> +#define DW_MCI_QUIRK_RETRY_DELAY	(1 << 2)
>  /* High Speed Capable - Supports HS cards (upto 50MHz) */
> -#define DW_MCI_QUIRK_HIGHSPEED		4
> +#define DW_MCI_QUIRK_HIGHSPEED		(1 << 3)
>  

Why skip (1 << 1)?  (There's also BIT(0) -> BIT(2) if you prefer.)

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
