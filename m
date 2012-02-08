From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH 1/4] mmc: core: add high-capacity erase size capability
 flag
Date: Wed, 8 Feb 2012 17:32:25 +0100
Message-ID: <4F32A399.4050609@stericsson.com>
References: <1328618935-25175-1-git-send-email-adrian.hunter@intel.com> <1328618935-25175-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:45250 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754067Ab2BHQcj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Feb 2012 11:32:39 -0500
In-Reply-To: <1328618935-25175-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 02/07/2012 01:48 PM, Adrian Hunter wrote:
> Let drivers specify the use of high-capacity erase size.
>
> Signed-off-by: Adrian Hunter<adrian.hunter@intel.com>
> ---
>   drivers/mmc/core/mmc.c   |    3 ++-
>   include/linux/mmc/host.h |    1 +
>   2 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 6b13776..bd2f71f 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -949,7 +949,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>   	 * If enhanced_area_en is TRUE, host needs to enable ERASE_GRP_DEF
>   	 * bit.  This bit will be lost every time after a reset or power off.
>   	 */
> -	if (card->ext_csd.enhanced_area_en) {
> +	if (card->ext_csd.enhanced_area_en ||
> +	    (card->ext_csd.rev>= 3&&  (host->caps2&  MMC_CAP2_HC_ERASE_SZ))) {

This will default disable this feature. Is that what we want?
Why the need to disable this at all?

>   		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>   				 EXT_CSD_ERASE_GROUP_DEF, 1,
>   				 card->ext_csd.generic_cmd6_time);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 20d7c82..c7ce9d2 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -258,6 +258,7 @@ struct mmc_host {
>   #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
>   				 MMC_CAP2_HS200_1_2V_SDR)
>   #define MMC_CAP2_BROKEN_VOLTAGE	(1<<  7)	/* Use the broken voltage */
> +#define MMC_CAP2_HC_ERASE_SZ	(1<<  8)	/* High-capacity erase size */
>
>   	mmc_pm_flag_t		pm_caps;	/* supported pm features */
>   	unsigned int        power_notify_type;

Br
Ulf Hansson
