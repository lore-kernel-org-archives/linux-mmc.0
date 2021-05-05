Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B548CC433ED
	for <linux-mmc@archiver.kernel.org>; Wed,  5 May 2021 04:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DFD6112D
	for <linux-mmc@archiver.kernel.org>; Wed,  5 May 2021 04:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhEEElq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 May 2021 00:41:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:34368 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbhEEElp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 May 2021 00:41:45 -0400
IronPort-SDR: IGoKLNLLNHhCEgKhG1JOcV9eBZGyOltGLfu4Ktn2Y6QxolqYzB8qNR8cFUXawkZ4HjkQl1nIHx
 WBE/1hlu8O9A==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="259414605"
X-IronPort-AV: E=Sophos;i="5.82,274,1613462400"; 
   d="scan'208";a="259414605"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 21:40:47 -0700
IronPort-SDR: EUm5EbxTp/09v8jlfq6iwnQIXBGWm/gbeOYvxvksA+2FLby6EHuXiGDV+SDOx+hNqDzvTrdvXC
 rklXzGvgcHIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,274,1613462400"; 
   d="scan'208";a="607264834"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga005.jf.intel.com with ESMTP; 04 May 2021 21:40:44 -0700
Subject: Re: [PATCH v1] mmc: block: Disable CMDQ on the ioctl path
To:     Bean Huo <huobean@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>,
        Michael Brunner <Michael.Brunner@kontron.com>
References: <20210504203209.361597-1-huobean@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7607d4e2-d586-e0a0-d436-ff29cd960f9d@intel.com>
Date:   Wed, 5 May 2021 07:41:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210504203209.361597-1-huobean@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/05/21 11:32 pm, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> According to the eMMC Spec:
> "When command queuing is enabled (CMDQ Mode En bit in CMDQ_MODE_EN
> field is set to ‘1’) class 11 commands are the only method through
> which data transfer tasks can be issued. Existing data transfer
> commands, namely CMD18/CMD17 and CMD25/CMD24, are not supported when
> command queuing is enabled."
> which means if CMDQ is enabled, the FFU commands will not be supported.
> To fix this issue, just simply disable CMDQ on the ioctl path, and
> re-enable CMDQ once ioctl request is completed.
> 
> Tested-by: Michael Brunner <Michael.Brunner@kontron.com>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/block.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 689eb9afeeed..21fb99883b1e 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1004,6 +1004,11 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
>  
>  	switch (mq_rq->drv_op) {
>  	case MMC_DRV_OP_IOCTL:
> +		if (card->ext_csd.cmdq_en) {
> +			ret = mmc_cmdq_disable(card);
> +			if (ret)
> +				break;
> +		}
>  	case MMC_DRV_OP_IOCTL_RPMB:
>  		idata = mq_rq->drv_op_data;
>  		for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
> @@ -1014,6 +1019,8 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
>  		/* Always switch back to main area after RPMB access */
>  		if (rpmb_ioctl)
>  			mmc_blk_part_switch(card, 0);
> +		else if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
> +			mmc_cmdq_enable(card);
>  		break;
>  	case MMC_DRV_OP_BOOT_WP:
>  		ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BOOT_WP,
> 

