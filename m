From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: MMC_NUM_PHY_PARTITION is not right.
Date: Wed, 13 Aug 2014 17:01:10 +0200
Message-ID: <CAPDyKFq5uToDGTCsF_FQxjtgPG7WQ-_pARb7t_Rz7jzpoic4MA@mail.gmail.com>
References: <1407908042-12931-1-git-send-email-yi.y.sun@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:53456 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbaHMPBL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Aug 2014 11:01:11 -0400
Received: by mail-qg0-f41.google.com with SMTP id q107so11093105qgd.28
        for <linux-mmc@vger.kernel.org>; Wed, 13 Aug 2014 08:01:10 -0700 (PDT)
In-Reply-To: <1407908042-12931-1-git-send-email-yi.y.sun@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yi Sun <yi.y.sun@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 13 August 2014 07:34, Yi Sun <yi.y.sun@intel.com> wrote:
> eMMC card can support up to 7 partitions, including 2 boot,
> 1 RPMB and 4 GPs. But MMC_NUM_PHY_PARTITION is defined to
> 6 so we should fix it to 7.
>
> Signed-off-by: Yi Sun <yi.y.sun@intel.com>

Thanks! I queued this one for 3.18. I took the liberty to update the
author name and made some minor clarifications to the commit message.
You should probably update your .gitconfig for future patches, to get
the correct name.

Kind regards
Uffe

> ---
>  include/linux/mmc/card.h |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index d424b9d..bde5147 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -214,11 +214,12 @@ enum mmc_blk_status {
>  };
>
>  /* The number of MMC physical partitions.  These consist of:
> - * boot partitions (2), general purpose partitions (4) in MMC v4.4.
> + * boot partitions (2), general purpose partitions (4) and
> + * RPMB partition (1) in MMC v4.4.
>   */
>  #define MMC_NUM_BOOT_PARTITION 2
>  #define MMC_NUM_GP_PARTITION   4
> -#define MMC_NUM_PHY_PARTITION  6
> +#define MMC_NUM_PHY_PARTITION  7
>  #define MAX_MMC_PART_NAME_LEN  20
>
>  /*
> --
> 1.7.9.5
>
