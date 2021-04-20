Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C2EC433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 11:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEC16139A
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 11:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhDTLW1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Apr 2021 07:22:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:40728 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232000AbhDTLWZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 20 Apr 2021 07:22:25 -0400
IronPort-SDR: stH7R77hV4DwLsNxmd9/vu/UFlE6hQQFxN4OglmJ4YsYFqPKGs5FmHgqEIYR9qEScqZxx+c2/+
 D8U0oACPfkZA==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="182981076"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="182981076"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 04:21:52 -0700
IronPort-SDR: vl9U8bhnqc/0zKk91IktvaYMeMqYtqWUgYPaZ9mmG5KNuzUjLVds+NqDeAyOR4hM4Fnq3A/+E9
 Ppbky0DBSdxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="445480363"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga004.fm.intel.com with ESMTP; 20 Apr 2021 04:21:50 -0700
Subject: Re: [PATCH v3 2/2] mmc: block: Update ext_csd.cache_ctrl if it was
 written
To:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210420055306.4858-1-avri.altman@wdc.com>
 <20210420055306.4858-3-avri.altman@wdc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <abd1ad9a-7ddf-b967-aea1-f268ba385661@intel.com>
Date:   Tue, 20 Apr 2021 14:22:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420055306.4858-3-avri.altman@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/04/21 8:53 am, Avri Altman wrote:
> The cache function can be turned ON and OFF by writing to the CACHE_CTRL
> byte (EXT_CSD byte [33]).  However,  card->ext_csd.cache_ctrl is only
> set on init if cache size > 0.
> 
> Fix that by explicitly setting ext_csd.cache_ctrl on ext-csd write.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/block.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 5b6501fc9fb7..8b07ed5e08de 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -572,6 +572,18 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>  		main_md->part_curr = value & EXT_CSD_PART_CONFIG_ACC_MASK;
>  	}
>  
> +	/*
> +	 * Make sure to update CACHE_CTRL in case it was changed. The cache
> +	 * will get turned back on if the card is re-initialized, e.g.
> +	 * suspend/resume or hw reset in recovery.
> +	 */
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

