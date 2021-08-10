Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A5FC4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Aug 2021 08:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7410960EFF
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Aug 2021 08:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbhHJIYf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Aug 2021 04:24:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:14072 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237193AbhHJIYe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Aug 2021 04:24:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="214589556"
X-IronPort-AV: E=Sophos;i="5.84,309,1620716400"; 
   d="scan'208";a="214589556"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 01:24:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,309,1620716400"; 
   d="scan'208";a="439225806"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 10 Aug 2021 01:24:10 -0700
Subject: Re: [PATCH 1/3] mmc: sdhci: Fix issue with uninitialized
 dma_slave_config
To:     Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20210810081644.19353-1-tony@atomide.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c3c52c1f-be18-7dae-bbdc-99b5cf396590@intel.com>
Date:   Tue, 10 Aug 2021 11:24:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810081644.19353-1-tony@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/08/21 11:16 am, Tony Lindgren wrote:
> Depending on the DMA driver being used, the struct dma_slave_config may
> need to be initialized to zero for the unused data.
> 
> For example, we have three DMA drivers using src_port_window_size and
> dst_port_window_size. If these are left uninitialized, it can cause DMA
> failures at least if external TI SDMA is ever configured for sdhci.
> 
> For other external DMA cases, this is probably not currently an issue but
> is still good to fix though.
> 
> Fixes: 18e762e3b7a7 ("mmc: sdhci: add support for using external DMA devices")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1222,6 +1222,7 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
>  	if (!host->mapbase)
>  		return -EINVAL;
>  
> +	memset(&cfg, 0, sizeof(cfg));
>  	cfg.src_addr = host->mapbase + SDHCI_BUFFER;
>  	cfg.dst_addr = host->mapbase + SDHCI_BUFFER;
>  	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> 

