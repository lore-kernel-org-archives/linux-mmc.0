From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/5] OMAP2420: hwmod data: Add HSMMC
Date: Tue, 08 Feb 2011 14:36:59 -0800
Message-ID: <877hdajgqc.fsf@ti.com>
References: <1296660462-28489-1-git-send-email-kishore.kadiyala@ti.com>
	<1296660462-28489-2-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:39873 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753425Ab1BHWhE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Feb 2011 17:37:04 -0500
In-Reply-To: <1296660462-28489-2-git-send-email-kishore.kadiyala@ti.com>
	(Kishore Kadiyala's message of "Wed, 2 Feb 2011 20:57:38 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, paul@pwsan.com

Kishore Kadiyala <kishore.kadiyala@ti.com> writes:

> Update the omap2420 hwmod data with the HSMMC info.
> Add a device attribute structure which will be used
> by the host driver to find whether the HSMMC controller
> supports DUAL VOLT cards.
>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>

[...]

> --- a/arch/arm/plat-omap/include/plat/mmc.h
> +++ b/arch/arm/plat-omap/include/plat/mmc.h
> @@ -43,6 +43,13 @@
>  
>  #define OMAP_MMC_MAX_SLOTS	2
>  
> +/* omap_hwmod integration data */
> +#define OMAP_HSMMC_SUPPORTS_DUAL_VOLT	BIT(1)
> +
> +struct mmc_dev_attr {
> +	u8 flags;
> +};
> +
>  struct omap_mmc_platform_data {
>  	/* back-link to device */
>  	struct device *dev;

This part should be broken out as a separate patch. 

Kevin

