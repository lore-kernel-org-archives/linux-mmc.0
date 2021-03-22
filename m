Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15111C433C1
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 18:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF2F619A0
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 18:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhCVS70 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 14:59:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:63231 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232118AbhCVS6x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Mar 2021 14:58:53 -0400
IronPort-SDR: d5PpxvhGQ9h2zaLysXySFsWmDXnUQ6xoqHQ4xpiFobg56GZM6g+mt2FuxwB2oBLp41WUXmxQIA
 yim4QD9+u2Nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="190425724"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="190425724"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 11:58:52 -0700
IronPort-SDR: JcmCca+q+mbHurgTFhqUnenc2gcc4b+YxsNFGmrlyrpEziFMkAqlllhuG1PLGKKB0EtObfNuWN
 WSBN5SsMqOtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="407948533"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 22 Mar 2021 11:58:50 -0700
Subject: Re: [PATCH 2/2] mmc: block: Update ext_csd.cache_ctrl if it was
 written
To:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210322133645.4901-1-avri.altman@wdc.com>
 <20210322133645.4901-3-avri.altman@wdc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <017e203c-e53f-b07e-fcea-e357d8947d43@intel.com>
Date:   Mon, 22 Mar 2021 20:59:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210322133645.4901-3-avri.altman@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22/03/21 3:36 pm, Avri Altman wrote:
> The cache function can be turned ON and OFF by writing to the CACHE_CTRL
> byte (EXT_CSD byte [33]).  However,  card->ext_csd.cache_ctrl is only
> set on init if cache size > 0.
> 
> Fix that by explicitly setting ext_csd.cache_ctrl on ext-csd write.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index a93c66aa91db..4c816d001ac1 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -571,6 +571,14 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>  		main_md->part_curr = value & EXT_CSD_PART_CONFIG_ACC_MASK;
>  	}
>  
> +	/* Make sure to update CACHE_CTRL in case it was changed */

It might be worth noting that the cache will get turned back
on if the card is re-initialized, for example suspend/resume or
hw reset in recovery.

> +	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_CACHE_CTRL) &&
> +	    (cmd.opcode == MMC_SWITCH)) {
> +		u8 value = MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg) & 1;
> +
> +		card->ext_csd.cache_ctrl = value;
> +	}
> +
>  	/*
>  	 * According to the SD specs, some commands require a delay after
>  	 * issuing the command.
> 

