Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BF7C4332F
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Nov 2023 14:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjKFOxf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Nov 2023 09:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjKFOxe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Nov 2023 09:53:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E1BB6
        for <linux-mmc@vger.kernel.org>; Mon,  6 Nov 2023 06:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699282412; x=1730818412;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pfk4eFeRtF9zoWcqHKRJ6q46xvsN0e0PE5IXuKZotXI=;
  b=jYC0Y7IFfHzpNrPKaZxptXQh+Sg83avcy3yjioQvN95pLBPQ7bhOry6/
   WOjpHDNt3kcfXMAUdcI8G00HCjwGX6qyIlEE3e5atdIgzfdbKs/vl+QLx
   EgM5+O83e7NRFgd62nBFjY3t9TqNaWV1Cbjx4tuplMQI3Gd+mS17AM0Yn
   kMMzGJUdSzLti2hyP06lLAfhZBQy3Y93y6vl/o1N2JQ4lmaZjptZHfmcG
   z1EaqyS1V5bHmlLg1EUm8D3DOXuuPHPK937nallRbjD6QOciN/oTbgfI2
   BJIVh9FSEyb6Cz5SHfMBdkc5dTf77T2dTjKbp+bm1Mj6ixI/G7CkuNRv6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475523011"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="475523011"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 06:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="797327255"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="797327255"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.215.231])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 06:53:28 -0800
Message-ID: <557eb489-3e1d-4cbd-b62d-d3046870a4cc@intel.com>
Date:   Mon, 6 Nov 2023 16:53:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: Use mrq.sbc in close-ended ffu
Content-Language: en-US
To:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
References: <20231030090906.1897035-1-avri.altman@wdc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231030090906.1897035-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/10/23 11:09, Avri Altman wrote:
> Field Firmware Update (ffu) may use close-ended or open ended sequence.
> Each such sequence is comprised of a write commands enclosed between 2
> switch commands - to and from ffu mode. So for the close-ended case, it
> will be: cmd6->cmd23-cmd25-cmd6.
> 
> Some host controllers however, get confused when multi-block rw is sent
> without sbc, and may generate auto-cmd12 which breaks the ffu sequence.
> I encountered  this issue while testing fwupd (github.com/fwupd/fwupd)
> on HP Chromebook x2, a qualcomm based QC-7c, code name - strongbad.
> 
> Instead of a quirk, or hooking the request function of the msm ops,
> it would be better to fix the ioctl handling and make it use mrq.sbc
> instead of issuing SET_BLOCK_COUNT separately.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c | 41 ++++++++++++++++++++++++++++++++++++++--
>  include/linux/mmc/mmc.h  |  1 +
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 3a8f27c3e310..6d94617ef206 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -400,6 +400,10 @@ struct mmc_blk_ioc_data {
>  	struct mmc_ioc_cmd ic;
>  	unsigned char *buf;
>  	u64 buf_bytes;
> +	unsigned int flags;
> +#define MMC_BLK_IOC_DROP	BIT(0)	/* drop this mrq */
> +#define MMC_BLK_IOC_SBC	BIT(1)	/* use mrq.sbc */
> +
>  	struct mmc_rpmb_data *rpmb;
>  };
>  
> @@ -479,6 +483,9 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>  	if (!card || !md || !idata)
>  		return -EINVAL;
>  
> +	if (idata->flags & MMC_BLK_IOC_DROP)
> +		return 0;
> +
>  	/*
>  	 * The RPMB accesses comes in from the character device, so we
>  	 * need to target these explicitly. Else we just target the
> @@ -532,14 +539,19 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>  			return err;
>  	}
>  
> -	if (idata->rpmb) {
> +	if (idata->rpmb || (idata->flags & MMC_BLK_IOC_SBC)) {
> +		u32 sbc_arg = data.blocks;
> +
>  		sbc.opcode = MMC_SET_BLOCK_COUNT;
>  		/*
>  		 * We don't do any blockcount validation because the max size
>  		 * may be increased by a future standard. We just copy the
>  		 * 'Reliable Write' bit here.
>  		 */
> -		sbc.arg = data.blocks | (idata->ic.write_flag & BIT(31));
> +		if (idata->rpmb)
> +			sbc_arg |= (idata->ic.write_flag & BIT(31));

What about supporting more generic use-cases with other information
in the arg of CMD23 idata, such as reliable write etc?  Perhaps
link the other idata and populate sbc opcode and arg from that.

> +
> +		sbc.arg = sbc_arg;
>  		sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
>  		mrq.sbc = &sbc;

Also could copy the sbc response back to the "CMD23" idata
after mmc_wait_for_req().

>  	}
> @@ -1032,6 +1044,28 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
>  	md->reset_done &= ~type;
>  }
>  
> +/* close-ended ffu */
> +static void mmc_blk_check_ce_ffu(struct mmc_queue_req *mq_rq)
> +{
> +	struct mmc_blk_ioc_data **idata = mq_rq->drv_op_data;
> +
> +	if (mq_rq->ioc_count != 4)
> +		return;
> +
> +	if (idata[0]->ic.opcode != MMC_SWITCH)
> +		return;
> +
> +	if (MMC_EXTRACT_INDEX_FROM_ARG(idata[0]->ic.arg) !=
> +			EXT_CSD_MODE_CONFIG)
> +		return;
> +
> +	if (idata[1]->ic.opcode == MMC_SET_BLOCK_COUNT &&
> +	    idata[2]->ic.opcode == MMC_WRITE_MULTIPLE_BLOCK) {
> +		idata[1]->flags |= MMC_BLK_IOC_DROP;
> +		idata[2]->flags |= MMC_BLK_IOC_SBC;
> +	}

Could this be more generic e.g. simply

	for (i = 1; i < mq_rq->ioc_count; i++)
		if (idata[i - 1]->ic.opcode == MMC_SET_BLOCK_COUNT &&
		    mmc_op_multi(idata[i + 1]->ic.opcode)) {
			idata[i - 1]->flags |= MMC_BLK_IOC_DROP;
			idata[i]->flags |= MMC_BLK_IOC_SBC;
		}

with no need to check for 4 cmds, MMC_SWITCH or EXT_CSD_MODE_CONFIG

> +}
> +
>  /*
>   * The non-block commands come back from the block layer after it queued it and
>   * processed it with all other requests and then they get issued in this
> @@ -1059,6 +1093,9 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
>  			if (ret)
>  				break;
>  		}
> +
> +		mmc_blk_check_ce_ffu(mq_rq);
> +
>  		fallthrough;
>  	case MMC_DRV_OP_IOCTL_RPMB:
>  		idata = mq_rq->drv_op_data;
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

