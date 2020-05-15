Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38AEC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 13:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B16520657
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 13:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgEONix (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 09:38:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:60438 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgEONix (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 May 2020 09:38:53 -0400
IronPort-SDR: 2MdteKxO0zjaZjATrhEpsNkPY1XlPe2UxN5Y9Bs032ZD/+WDjJWtfm5f+So1a7q1Clk5MNTtcw
 hFNtrVKwWEuQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 06:38:52 -0700
IronPort-SDR: D2FrE4M9KSTHAz1IOxi3JDX/N5BklvSOm99TB8g38Bn/G/IN9EmPhNPh4GTM7SU9Ob1yO53p0D
 ebwDarModJ7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="281219394"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga002.jf.intel.com with ESMTP; 15 May 2020 06:38:49 -0700
Subject: Re: [PATCH v4 2/3] mmc: sdhci: add quirks for be to le byte swapping
To:     Angelo Dureghello <angelo.dureghello@timesys.com>,
        ulf.hansson@linaro.org, gerg@linux-m68k.org
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org
References: <20200513204133.2540568-1-angelo.dureghello@timesys.com>
 <20200513204133.2540568-2-angelo.dureghello@timesys.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d1be973e-87b6-f45c-bea6-4b6660a8465c@intel.com>
Date:   Fri, 15 May 2020 16:39:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513204133.2540568-2-angelo.dureghello@timesys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/05/20 11:41 pm, Angelo Dureghello wrote:
> Some controller as the ColdFire eshdc may require an endianness
> byte swap, becouse DMA read endianness is not configurable.
> 
> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> ---
> Changes for v3:
> - add post request callback
> Changes for v4:
> none
> ---
>  drivers/mmc/host/sdhci.c | 7 +++++++
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3f716466fcfd..d3bfbb6e11d5 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -637,6 +637,13 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
>  			sg_copy_to_buffer(data->sg, data->sg_len,
>  					  host->bounce_buffer,
>  					  length);
> +
> +			/*
> +			 * Endianness can't be swapped in the sg list,
> +			 * since the sg list is processed again later on.
> +			 */

The data in the sg list must not be changed because we don't know how
else it might be being used.  Maybe leave out the comment.

> +			if (host->ops->pre_dma_transfer)
> +				host->ops->pre_dma_transfer(host, data);

Let's make this slightly more generic i.e.

			if (host->ops->copy_to_bounce_buffer) {
				host->ops->copy_to_bounce_buffer(host, data);
			} else {
				sg_copy_to_buffer(data->sg, data->sg_len,
						  host->bounce_buffer,
						  length);
			}


>  		}
>  		/* Switch ownership to the DMA */
>  		dma_sync_single_for_device(host->mmc->parent,
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 79dffbb731d3..076054308423 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -653,6 +653,8 @@ struct sdhci_ops {
>  	void	(*voltage_switch)(struct sdhci_host *host);
>  	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
>  				   dma_addr_t addr, int len, unsigned int cmd);
> +	void	(*pre_dma_transfer)(struct sdhci_host *host,
> +				    struct mmc_data *data);
>  	void	(*request_done)(struct sdhci_host *host,
>  				struct mmc_request *mrq);
>  };
> 

