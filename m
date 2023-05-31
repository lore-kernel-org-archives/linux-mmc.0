Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9609C77B7C
	for <linux-mmc@archiver.kernel.org>; Wed, 31 May 2023 05:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjEaFqR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 May 2023 01:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjEaFqQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 May 2023 01:46:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF771EE
        for <linux-mmc@vger.kernel.org>; Tue, 30 May 2023 22:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685511974; x=1717047974;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rIJ6HzFEW6zyOoD2erjHIVaNfRlYIEeAB8pbv3FVYBQ=;
  b=TvaTDlJi0+wwXW23ot6gjEJ8UVizqWBy23+kwlfMw2R/LQntichFsmJJ
   cCMZm8BDIL5cE7M5tlyN4367fEn4OXN7GwtTLbuXHZ101MzyV5Nb1uj6B
   qe8vmBsqE8uXTxfsy8BBxRXSqugXcskhLj547OGDJx+GaZziPjOZ0oam2
   Y3YiYBwRX18MQ8s3J3m8APreFIEak/1aphs7EW+VKwCsPOmFp6JPG8Mnd
   VLGxGi2TGEL7TYtbAJxOu3tjS2+GA0EkCmZxXLzUOFpw5HSP4yPua0TR3
   HxgDSIMTe28x4qaGyMfGlLQAJmFsLTKh5zZ4ZvRPqEtzVFvqvw/Nu2DvP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="383403735"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="383403735"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 22:46:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="881040071"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="881040071"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.175])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 22:46:10 -0700
Message-ID: <ecad717c-77b5-c78a-795b-2c3019b7452a@intel.com>
Date:   Wed, 31 May 2023 08:46:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] [RFC] Revert "mmc: core: Fixup support for
 writeback-cache for eMMC and SD"
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org
Cc:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <avri.altman@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Wu <michael@allwinnertech.com>,
        Ming Lei <ming.lei@redhat.com>,
        Seunghui Lee <sh043.lee@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20230531002740.1235620-1-marex@denx.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230531002740.1235620-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 31/05/23 03:27, Marek Vasut wrote:
> This reverts commit 08ebf903af57cda6d773f3dd1671b64f73b432b8.
> 
> On STM32MP153C DHCOR DRC Compact with microSD card
> Kingston Canvas Go! Plus MicroSDXC I 64 GiB U3/V30/A2 SDCG3/64GB
> it is no longer possible to mount ext4 filesystem.
> 
> Git bisect points to this commit which is being reverted here. A bit of
> investigation shows that for non-working microSD cards
>   cache_enabled=TRUE fua_enabled=false
> For working microSD card (Kingston Canvas React Plus, MicroSDXC II
> 64 GiB U3/V90/A1 SDCR2/64GB)
>   cache_enabled=FALSE fua_enabled=false
> 
> It seems enabling the cache for SD cards causes the issue. Before the
> reverted commit, the cache was not reported enabled for SD cards. I am
> not sure whether such blunt revert is the correct solution however, any
> ideas ?

This does not disable the cache, it disables the block layer from issuing
cache flushes (by telling it there is no cache being used).

It would be good to know what commands are failing, which should be visible
in the kernel messages if dynamic debug is enabled:

Dynamic debug for mmc
---------------------

    Kernel must be configured:

        CONFIG_DYNAMIC_DEBUG=y

    To enable mmc debug via sysfs:

        echo 'file drivers/mmc/core/* +p' > /sys/kernel/debug/dynamic_debug/control
        echo 'file drivers/mmc/host/* +p' > /sys/kernel/debug/dynamic_debug/control

    To enable mmc debug via kernel command line:

        dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"

    To disable mmc debug:

        echo 'file drivers/mmc/core/* -p' > /sys/kernel/debug/dynamic_debug/control
        echo 'file drivers/mmc/host/* -p' > /sys/kernel/debug/dynamic_debug/control

    More general information in kernel documentation in kernel tree:

        Documentation/admin-guide/dynamic-debug-howto.rst


> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "Christian Löhle" <CLoehle@hyperstone.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Michael Wu <michael@allwinnertech.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Seunghui Lee <sh043.lee@samsung.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> ---
>  drivers/mmc/core/block.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index db6d8a0999100..72aa47af11d37 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2413,8 +2413,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>  	struct mmc_blk_data *md;
>  	int devidx, ret;
>  	char cap_str[10];
> -	bool cache_enabled = false;
> -	bool fua_enabled = false;
>  
>  	devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
>  	if (devidx < 0) {
> @@ -2494,17 +2492,13 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>  			md->flags |= MMC_BLK_CMD23;
>  	}
>  
> -	if (md->flags & MMC_BLK_CMD23 &&
> +	if (mmc_card_mmc(card) &&
> +	    md->flags & MMC_BLK_CMD23 &&
>  	    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
>  	     card->ext_csd.rel_sectors)) {
>  		md->flags |= MMC_BLK_REL_WR;
> -		fua_enabled = true;
> -		cache_enabled = true;
> +		blk_queue_write_cache(md->queue.queue, true, true);
>  	}
> -	if (mmc_cache_enabled(card->host))
> -		cache_enabled  = true;
> -
> -	blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);
>  
>  	string_get_size((u64)size, 512, STRING_UNITS_2,
>  			cap_str, sizeof(cap_str));

