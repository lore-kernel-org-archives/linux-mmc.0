From: Alex Lemberg <Alex.Lemberg@sandisk.com>
Subject: RE: [PATCH] mmc: host: don't access at boot partition when mode is
 HS200/HS400.
Date: Wed, 13 Aug 2014 13:27:49 +0000
Message-ID: <282CEDFCBC30114F83C499CB8F2ED5333AE6E2E8@SACMBXIP01.sdcorp.global.sandisk.com>
References: <1407905176-6847-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2lp0203.outbound.protection.outlook.com ([207.46.163.203]:22823
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750757AbaHMN2H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Aug 2014 09:28:07 -0400
In-Reply-To: <1407905176-6847-1-git-send-email-jh80.chung@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

Hi,

HS200 & HS400 mode is not supported during boot operation, but I think this specific change 
will prevent any boot operation or access to boot partition on all hosts with HS200 & HS400 capabilities in general,
even in case then the eMMC card is DDR52 type.
The actual bus clock speed need to be checked in order to prevent/allow boot operation, but not the host capabilities.

As for regular R/W access to boot partition, as far as I see from the JEDEC spec - it can work in HS200 & HS400 modes, so no change is required.
Please correct me if I wrong.

Thanks,
Alex



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Jaehoon Chung
> Sent: Wednesday, August 13, 2014 7:46 AM
> To: linux-mmc
> Cc: Chris Ball; Ulf Hansson; Jaehoon Chung
> Subject: [PATCH] mmc: host: don't access at boot partition when mode is
> HS200/HS400.
> 
> HS200/HS400 mode is not supported during boot operation.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  include/linux/mmc/host.h |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
> 7960424..ce5db96 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -445,6 +445,10 @@ static inline int mmc_host_cmd23(struct mmc_host
> *host)
> 
>  static inline int mmc_boot_partition_access(struct mmc_host *host)  {
> +	/* HS200 & HS400 mode is not supported during boot operation */
> +	if (host->caps2 & (MMC_CAP2_HS200 | MMC_CAP2_HS400))
> +		return 0;
> +
>  	return !(host->caps2 & MMC_CAP2_BOOTPART_NOACC);  }
> 
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
