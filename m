From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH]omap hsmmc: fix incorrect capability reporting
Date: Tue, 30 Mar 2010 10:47:19 -0500
Message-ID: <002a01cad020$47be5fb0$544ff780@am.dhcp.ti.com>
References: <618f0c911003300737w5562c18as1bfcb21671919718@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41316 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679Ab0C3PrZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Mar 2010 11:47:25 -0400
In-Reply-To: <618f0c911003300737w5562c18as1bfcb21671919718@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Venkatraman S' <svenkatr@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, kishore.kadiyala@ti.com



> -----Original Message-----
> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of
> Venkatraman S
> Sent: Tuesday, March 30, 2010 9:37 AM
> To: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org;
> kishore.kadiyala@ti.com
> Cc: Madhusudhan Chikkature
> Subject: [PATCH]omap hsmmc: fix incorrect capability reporting
> 
> MMC slots that support 8 bit mode also support 4 bit mode.
> The capability flag has to reflect this, otherwise SDHC cards operate
> in 1 bit mode.
> 
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 83f0aff..dbf83a6 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2093,7 +2093,7 @@ static int __init omap_hsmmc_probe(struct
> platform_device *pdev)
> 
>  	if (mmc_slot(host).wires >= 8)
>  		mmc->caps |= MMC_CAP_8_BIT_DATA;
> -	else if (mmc_slot(host).wires >= 4)
> +	if (mmc_slot(host).wires >= 4)
>  		mmc->caps |= MMC_CAP_4_BIT_DATA;
> 

Since 8-bit is the max how about:

  	if (mmc_slot(host).wires == 8)
  		mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA;
	if (mmc_slot(host).wires == 4)
  		mmc->caps |= MMC_CAP_4_BIT_DATA;

This would be little easy to read the code.

Regards,
Madhu

>  	if (mmc_slot(host).nonremovable)
> --
> 1.6.3.3

