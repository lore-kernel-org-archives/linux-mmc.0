Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB5BC33CA1
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 07:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C292C2077C
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 07:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgATHPG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:15:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:10941 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgATHPF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Jan 2020 02:15:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 23:15:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,341,1574150400"; 
   d="scan'208";a="274939706"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jan 2020 23:15:03 -0800
Subject: Re: [PATCH v2] mmc: sdhci: fix an issue of mixing different types
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Faiz Abbas <faiz_abbas@ti.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-mmc@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>
References: <20200120031023.32482-1-zhang.chunyan@linaro.org>
 <20200120033223.897-1-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <65f7272c-ecea-03de-433b-21ba2e672d20@intel.com>
Date:   Mon, 20 Jan 2020 09:14:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120033223.897-1-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/01/20 5:32 am, Chunyan Zhang wrote:
> Fix an issue reported by sparse, since mixed types of parameters are
> used on calling dmaengine_prep_slave_sg().
> 
> Fixes: 36e1da441fec (mmc: sdhci: add support for using external DMA devices)

That commit number is only in next

> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes from v1:
> * address comments from Nathan Chancellor
> - define a new variable to avoid type conversions.
> ---
>  drivers/mmc/host/sdhci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 30b5a624b50e..f9e0b5f2c692 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1201,6 +1201,7 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
>  				    struct mmc_command *cmd)
>  {
>  	int ret, i;
> +	enum dma_transfer_direction dir;
>  	struct dma_async_tx_descriptor *desc;
>  	struct mmc_data *data = cmd->data;
>  	struct dma_chan *chan;
> @@ -1234,8 +1235,8 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
>  	if (sg_cnt <= 0)
>  		return -EINVAL;
>  
> -	desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
> -				       mmc_get_dma_dir(data),
> +	dir = data->flags & MMC_DATA_WRITE ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
> +	desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len, dir,
>  				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!desc)
>  		return -EINVAL;
> 

