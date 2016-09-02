From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/3] mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS
 support
Date: Fri, 2 Sep 2016 15:50:11 +0800
Message-ID: <c06cdf40-48a7-3ed4-dd22-fdd26dcf333f@rock-chips.com>
References: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com>
 <1472739890-3384-3-git-send-email-alex.lemberg@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.136]:47054 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751589AbcIBHuf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Sep 2016 03:50:35 -0400
In-Reply-To: <1472739890-3384-3-git-send-email-alex.lemberg@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: alex lemberg <alex.lemberg@sandisk.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, avi.shchislowski@sandisk.com

Hi,

On 2016/9/1 22:24, alex lemberg wrote:
> Signed-off-by: alex lemberg <alex.lemberg@sandisk.com>

It would be nice to add some change log.:)

This part is still on my TODO list, so very nice to see
you provide patches for this. But I don't see we reach
an agreement at that time for whether it would be sane to
set this bit for kernel. I remember Adrian's opinion was to
let userspace take over the ownership of this, and Ulf maybe
had no hard opinon for this(Ulf, right? :)).


> ---
>  drivers/mmc/core/mmc.c   | 6 ++++++
>  include/linux/mmc/card.h | 1 +
>  include/linux/mmc/mmc.h  | 1 +
>  3 files changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f2d185c..e2e987f 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -531,6 +531,12 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  			if (!card->ext_csd.man_bkops_en)
>  				pr_debug("%s: MAN_BKOPS_EN bit is not set\n",
>  					mmc_hostname(card->host));
> +			card->ext_csd.auto_bkops_en =
> +					(ext_csd[EXT_CSD_BKOPS_EN] &
> +						EXT_CSD_AUTO_BKOPS_MASK);
> +			if (!card->ext_csd.auto_bkops_en)
> +				pr_debug("%s: AUTO_BKOPS_EN bit is not set\n",
> +					mmc_hostname(card->host));
>  		}
>
>  		/* check whether the eMMC card supports HPI */
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 73fad83..aaedb68 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -84,6 +84,7 @@ struct mmc_ext_csd {
>  	unsigned int		hpi_cmd;		/* cmd used as HPI */
>  	bool			bkops;		/* background support bit */
>  	bool			man_bkops_en;	/* manual bkops enable bit */
> +	bool			auto_bkops_en;	/* auto bkops enable bit */
>  	unsigned int            data_sector_size;       /* 512 bytes or 4KB */
>  	unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
>  	unsigned int		boot_ro_lock;		/* ro lock support */
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index c376209..0fe3908 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -436,6 +436,7 @@ struct _mmc_csd {
>   * BKOPS modes
>   */
>  #define EXT_CSD_MANUAL_BKOPS_MASK	0x01
> +#define EXT_CSD_AUTO_BKOPS_MASK	0x02
>
>  /*
>   * MMC_SWITCH access modes
>


-- 
Best Regards
Shawn Lin

