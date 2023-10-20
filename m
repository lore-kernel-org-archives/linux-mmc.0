Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52008CDB47E
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Oct 2023 05:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjJTFsm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Oct 2023 01:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjJTFsl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2023 01:48:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94521A6
        for <linux-mmc@vger.kernel.org>; Thu, 19 Oct 2023 22:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697780919; x=1729316919;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FpgDk+at6ksAxwFb0FZfFJQtvz0hDqFpxXMRsL6ENOw=;
  b=UU3djE5pfR9+QOOGYZJnA4KYyy0lPNL92JZiQgJUkdPKHso04GktyMdm
   aTjEZA8qtQvplgJOnZHHOmrXfQpxUZEUfAm0ps5/jFJ562i+g67N3fXUI
   JqHZkkRjxcibTyfgUe2xb/HBe3bRZR7OOHe22dwSKDOZhInlm8ATrVQM7
   boi53q8dssU0n8BE9o0PPOg3T/sg+iOo/aqRXv62GakjoRd/CIrSzdjza
   2xzQYU8udGzXQTUQT3oG2A4vSwT6+c5kBXazZONdU1XMq3bo0LdssP0Nh
   eI6GsAmQr11TbyIUJRp7FWBz5yCvBvajXH19kbW+r3/mMLYGLjWz0DJNX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="366667268"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="366667268"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 22:48:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="823120470"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="823120470"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.209.150])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 22:48:37 -0700
Message-ID: <d1505d2f-90f9-4fd6-a928-a590b72fce37@intel.com>
Date:   Fri, 20 Oct 2023 08:48:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mmc: core: Mark close-ended ffu in progress
Content-Language: en-US
To:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
References: <20231012184041.1837455-1-avri.altman@wdc.com>
 <20231012184041.1837455-3-avri.altman@wdc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231012184041.1837455-3-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/10/23 21:40, Avri Altman wrote:
> The SDHCI_QUIRK2_FFU_ACMD12 quirk was invented to prevent from those
> bogus sdhci to use auto-cmd12 after cmd25 in a close-ended ffu process.
> Capture the applicable mrq and mark it so it won't use auto-cmd12 post
> that cmd25.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c | 25 +++++++++++++++++++++++++
>  include/linux/mmc/mmc.h  |  1 +
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 3a8f27c3e310..d92e7322c6da 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -114,6 +114,8 @@ struct mmc_blk_data {
>  	unsigned int	flags;
>  #define MMC_BLK_CMD23	(1 << 0)	/* Can do SET_BLOCK_COUNT for multiblock */
>  #define MMC_BLK_REL_WR	(1 << 1)	/* MMC Reliable write support */
> +#define MMC_BLK_FFU	(1 << 2)	/* FFU in progress */
> +#define MMC_BLK_CE	(1 << 3)	/* close-ended FFU in progress */
>  
>  	struct kref	kref;
>  	unsigned int	read_only;
> @@ -548,6 +550,29 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>  	    (cmd.opcode == MMC_SWITCH))
>  		return mmc_sanitize(card, idata->ic.cmd_timeout_ms);
>  
> +	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_MODE_CONFIG) &&
> +	    (cmd.opcode == MMC_SWITCH)) {
> +		u8 value = MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg);
> +
> +		if (value == 1) {
> +			md->flags |= MMC_BLK_FFU;
> +		} else if (value == 0) {
> +			/* switch back to normal mode is always happening */
> +			md->flags &= ~MMC_BLK_FFU;
> +			md->flags &= ~MMC_BLK_CE;
> +		}
> +	}
> +
> +	if ((md->flags & MMC_BLK_FFU) && cmd.opcode == MMC_SET_BLOCK_COUNT) {
> +		md->flags &= ~MMC_BLK_FFU;
> +		md->flags |= MMC_BLK_CE;
> +	}
> +
> +	if ((md->flags & MMC_BLK_CE) && mmc_op_multi(cmd.opcode)) {
> +		mrq.ffu = true;
> +		md->flags &= ~MMC_BLK_CE;
> +	}

Could it be a separate helper function so it ends up like

	mrq.ffu = mmc_is_ffu_cmd(&cmd)

But perhaps then mrq.ffu is not needed and sdhci-msm.c
could call mmc_is_ffu_cmd() directly?

> +
>  	/* If it's an R1B response we need some more preparations. */
>  	busy_timeout_ms = idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS;
>  	r1b_resp = (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B;
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 6f7993803ee7..d4d10cabaa57 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -254,6 +254,7 @@ static inline bool mmc_ready_for_data(u32 status)
>   */
>  
>  #define EXT_CSD_CMDQ_MODE_EN		15	/* R/W */
> +#define EXT_CSD_MODE_CONFIG		30	/* R/W */
>  #define EXT_CSD_FLUSH_CACHE		32      /* W */
>  #define EXT_CSD_CACHE_CTRL		33      /* R/W */
>  #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */

