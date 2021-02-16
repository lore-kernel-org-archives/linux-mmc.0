Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC033C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Feb 2021 08:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894D964E08
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Feb 2021 08:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhBPIdr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Feb 2021 03:33:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:56308 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhBPIdq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 16 Feb 2021 03:33:46 -0500
IronPort-SDR: O4gpjuVIEGo0vPMD6G0iweaf9Bqs4OudnGjJtfZpXC+nb/P3m1/GxXKjFm6j49+S6q6qYpqx/g
 t3ueeRHrQFiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="202023149"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="202023149"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 00:33:01 -0800
IronPort-SDR: s22jTpqsYFEfNdpbzG9d49/YW1ytrvlJGDL9veb/b0Evfi+xY1Kh9V+OmeKgqZ5Qxf9CjJfcbX
 /CAQX5B/lpfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="438841975"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.149]) ([10.237.72.149])
  by orsmga001.jf.intel.com with ESMTP; 16 Feb 2021 00:32:58 -0800
Subject: Re: [PATCH 1/2] mmc: core: Drop superfluous validations in
 mmc_hw|sw_reset()
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Pierre Ossman <pierre@ossman.eu>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
References: <p2/0002-mmc-core-Drop-reference-counting-of-the-bus_ops.patch>
 <20210212131532.236775-1-ulf.hansson@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <673dd1f3-d5b7-8590-093a-f01ef54ca40a@intel.com>
Date:   Tue, 16 Feb 2021 10:32:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210212131532.236775-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/02/21 3:15 pm, Ulf Hansson wrote:
> The mmc_hw|sw_reset() APIs are designed to be called solely from upper
> layers, which means drivers that operates on top of the struct mmc_card,
> like the mmc block device driver and an SDIO functional driver.
> 
> Additionally, as long as the struct mmc_host has a valid pointer to a
> struct mmc_card, the corresponding host->bus_ops pointer stays valid and
> assigned.
> 
> For these reasons, let's drop the superfluous reference counting and the
> redundant validations in mmc_hw|sw_reset().
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Note, ideally mmc_hw|sw_reset() shall be converted to take a struct mmc_card*
> as an in-parameter, rather than the current struct mmc_host*, but that is left
> to a future/separate change.
> 
> ---
>  drivers/mmc/core/block.c |  2 +-
>  drivers/mmc/core/core.c  | 21 +--------------------
>  2 files changed, 2 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index b877f62df366..b7d3f5a73388 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -947,7 +947,7 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
>  	md->reset_done |= type;
>  	err = mmc_hw_reset(host);
>  	/* Ensure we switch back to the correct partition */
> -	if (err != -EOPNOTSUPP) {
> +	if (err) {
>  		struct mmc_blk_data *main_md =
>  			dev_get_drvdata(&host->card->dev);
>  		int part_err;
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 1136b859ddd8..2e41fa598bd6 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2080,18 +2080,7 @@ int mmc_hw_reset(struct mmc_host *host)
>  {
>  	int ret;
>  
> -	if (!host->card)
> -		return -EINVAL;
> -
> -	mmc_bus_get(host);
> -	if (!host->bus_ops || host->bus_dead || !host->bus_ops->hw_reset) {
> -		mmc_bus_put(host);
> -		return -EOPNOTSUPP;
> -	}
> -
>  	ret = host->bus_ops->hw_reset(host);
> -	mmc_bus_put(host);
> -
>  	if (ret < 0)
>  		pr_warn("%s: tried to HW reset card, got error %d\n",
>  			mmc_hostname(host), ret);
> @@ -2104,18 +2093,10 @@ int mmc_sw_reset(struct mmc_host *host)
>  {
>  	int ret;
>  
> -	if (!host->card)
> -		return -EINVAL;
> -
> -	mmc_bus_get(host);
> -	if (!host->bus_ops || host->bus_dead || !host->bus_ops->sw_reset) {
> -		mmc_bus_put(host);
> +	if (!host->bus_ops->sw_reset)
>  		return -EOPNOTSUPP;
> -	}
>  
>  	ret = host->bus_ops->sw_reset(host);
> -	mmc_bus_put(host);
> -
>  	if (ret)
>  		pr_warn("%s: tried to SW reset card, got error %d\n",
>  			mmc_hostname(host), ret);
> 

