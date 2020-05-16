Return-Path: <SRS0=UNP7=66=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854B3C433DF
	for <linux-mmc@archiver.kernel.org>; Sat, 16 May 2020 18:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7126E20657
	for <linux-mmc@archiver.kernel.org>; Sat, 16 May 2020 18:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgEPSGY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 16 May 2020 14:06:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:6278 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgEPSGX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 16 May 2020 14:06:23 -0400
IronPort-SDR: iQj8uy5xI4dOCVoKrK8b/9OkS7MeiCscQ2NVEtrzuV1LYjxAtuIyCegFYd+d7ZtuO/mlzwHjjf
 TXiG9PWGzyfw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 11:06:23 -0700
IronPort-SDR: ayDH0DYpVPVH6H0/QixJtpzhWL2phJ2tuKfWz65kvwhZlyUB+XhEn32uI5NhpnOQ/d5Zsr2bPR
 YckBWQDB7oGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,400,1583222400"; 
   d="scan'208";a="263522471"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga003.jf.intel.com with ESMTP; 16 May 2020 11:06:21 -0700
Subject: Re: [PATCH v5 2/3] mmc: sdhci: add quirks for be to le byte swapping
To:     Angelo Dureghello <angelo.dureghello@timesys.com>,
        ulf.hansson@linaro.org, gerg@linux-m68k.org
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org
References: <20200515222730.967105-1-angelo.dureghello@timesys.com>
 <20200515222730.967105-2-angelo.dureghello@timesys.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5209eb87-f210-8bc0-e323-4a894d6f6bbe@intel.com>
Date:   Sat, 16 May 2020 21:06:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515222730.967105-2-angelo.dureghello@timesys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/05/20 1:27 am, Angelo Dureghello wrote:
> Some controller as the ColdFire eshdc may require an endianness
> byte swap, becouse DMA read endianness is not configurable.

becouse -> because

Needs a bit more explanation i.e.

Facilitate using the bounce buffer for this by adding ->copy_to_bounce_buffer().

Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> ---
> Changes for v3:
> - add post request callback
> Changes for v4:
> none
> Changes for v5:
> - remove useless comment before swapping bounce buffer
> - rename pre_dma_transfer to copy_to_bounce_buffer
> ---
>  drivers/mmc/host/sdhci.c | 9 ++++++---
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3f716466fcfd..b7ba43e3b7c5 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -634,9 +634,12 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
>  		}
>  		if (mmc_get_dma_dir(data) == DMA_TO_DEVICE) {
>  			/* Copy the data to the bounce buffer */
> -			sg_copy_to_buffer(data->sg, data->sg_len,
> -					  host->bounce_buffer,
> -					  length);
> +			if (host->ops->copy_to_bounce_buffer) {
> +				host->ops->copy_to_bounce_buffer(host, data);
> +			} else {
> +				sg_copy_to_buffer(data->sg, data->sg_len,
> +						  host->bounce_buffer, length);
> +			}
>  		}
>  		/* Switch ownership to the DMA */
>  		dma_sync_single_for_device(host->mmc->parent,
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 79dffbb731d3..632ea297bb60 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -653,6 +653,8 @@ struct sdhci_ops {
>  	void	(*voltage_switch)(struct sdhci_host *host);
>  	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
>  				   dma_addr_t addr, int len, unsigned int cmd);
> +	void	(*copy_to_bounce_buffer)(struct sdhci_host *host,
> +					 struct mmc_data *data);
>  	void	(*request_done)(struct sdhci_host *host,
>  				struct mmc_request *mrq);
>  };
> 

