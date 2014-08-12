From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: MMC_NUM_PHY_PARTITION is not right.
Date: Tue, 12 Aug 2014 11:51:12 +0200
Message-ID: <CAPDyKFrY-i-OPNAg-j-L+2ou5-TTvECeD0M=payKe6EnAkr9yw@mail.gmail.com>
References: <1406876600-9376-1-git-send-email-yi.y.sun@intel.com>
	<525EAED47491124EB5123A51BD2FC791019D95FD@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:48094 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbaHLJvN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 05:51:13 -0400
Received: by mail-qa0-f47.google.com with SMTP id i13so8710442qae.6
        for <linux-mmc@vger.kernel.org>; Tue, 12 Aug 2014 02:51:13 -0700 (PDT)
In-Reply-To: <525EAED47491124EB5123A51BD2FC791019D95FD@SHSMSX101.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Sun, Yi Y" <yi.y.sun@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 12 August 2014 11:29, Sun, Yi Y <yi.y.sun@intel.com> wrote:
> Hi, Ulf,
>
> Could you please check this fix? Thanks!
>
> BRs,
> Sun Yi
>
> -----Original Message-----
> From: Sun, Yi Y
> Sent: Friday, August 01, 2014 3:03 PM
> To: linux-mmc@vger.kernel.org
> Cc: Sun, Yi Y
> Subject: [PATCH] mmc: MMC_NUM_PHY_PARTITION is not right.
>
> eMMC card can support up to 7 partitions, including 2 boot,
> 1 RPMB and 4 GPs. But MMC_NUM_PHY_PARTITION is defined to
> 6 so we should fix it to 7.
>
> Signed-off-by: yisun1 <yi.y.sun@intel.com>

Could you please update your name in SOB tag to your proper name.

> ---
>  include/linux/mmc/card.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h index d424b9d..6dadac2 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -218,7 +218,7 @@ enum mmc_blk_status {
>   */

There are a small comment in the code just prior these defines, could
update it so that it becomes obvious why MMC_NUM_PHY_PARTITION shall
be 7.

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

I think we should handle this a fix and it should go stable as well.

Kind regards
Uffe
