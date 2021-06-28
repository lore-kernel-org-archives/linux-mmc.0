Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF875C2B9F4
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Jun 2021 13:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E516128C
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Jun 2021 13:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhF1Nqx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Jun 2021 09:46:53 -0400
Received: from foss.arm.com ([217.140.110.172]:59696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232131AbhF1Nqw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 28 Jun 2021 09:46:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5CD21042;
        Mon, 28 Jun 2021 06:44:26 -0700 (PDT)
Received: from [10.57.8.89] (unknown [10.57.8.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FF6D3F718;
        Mon, 28 Jun 2021 06:44:24 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] mmc: meson-gx: use sg_copy_to/from_io instead of
 local version
To:     Neil Armstrong <narmstrong@baylibre.com>, jgg@ziepe.ca,
        leon@kernel.org, m.szyprowski@samsung.com, ulf.hansson@linaro.org
Cc:     torvalds@linux-foundation.org, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210628123411.119778-1-narmstrong@baylibre.com>
 <20210628123411.119778-3-narmstrong@baylibre.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <cfd6c96a-b5eb-bc0b-1861-c409f0a7e4f0@arm.com>
Date:   Mon, 28 Jun 2021 14:44:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628123411.119778-3-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2021-06-28 13:34, Neil Armstrong wrote:
> Use the proper sg_copy_to_io & sg_copy_from_io instead of having a local
> sg_copy_buffer variant to handle the I/O mapped buffer case.
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   drivers/mmc/host/meson-gx-mmc.c | 53 +++++++--------------------------
>   1 file changed, 10 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 3f28eb4d17fe..c13436efb414 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -746,47 +746,6 @@ static void meson_mmc_desc_chain_transfer(struct mmc_host *mmc, u32 cmd_cfg)
>   	writel(start, host->regs + SD_EMMC_START);
>   }
>   
> -/* local sg copy to buffer version with _to/fromio usage for dram_access_quirk */
> -static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data,
> -				  size_t buflen, bool to_buffer)
> -{
> -	unsigned int sg_flags = SG_MITER_ATOMIC;
> -	struct scatterlist *sgl = data->sg;
> -	unsigned int nents = data->sg_len;
> -	struct sg_mapping_iter miter;
> -	unsigned int offset = 0;
> -
> -	if (to_buffer)
> -		sg_flags |= SG_MITER_FROM_SG;
> -	else
> -		sg_flags |= SG_MITER_TO_SG;
> -
> -	sg_miter_start(&miter, sgl, nents, sg_flags);
> -
> -	while ((offset < buflen) && sg_miter_next(&miter)) {
> -		unsigned int len;
> -
> -		len = min(miter.length, buflen - offset);
> -
> -		/* When dram_access_quirk, the bounce buffer is a iomem mapping */
> -		if (host->dram_access_quirk) {
> -			if (to_buffer)
> -				memcpy_toio(host->bounce_iomem_buf + offset, miter.addr, len);
> -			else
> -				memcpy_fromio(miter.addr, host->bounce_iomem_buf + offset, len);
> -		} else {
> -			if (to_buffer)
> -				memcpy(host->bounce_buf + offset, miter.addr, len);
> -			else
> -				memcpy(miter.addr, host->bounce_buf + offset, len);
> -		}
> -
> -		offset += len;
> -	}
> -
> -	sg_miter_stop(&miter);
> -}
> -
>   static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>   {
>   	struct meson_host *host = mmc_priv(mmc);
> @@ -830,7 +789,12 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>   		if (data->flags & MMC_DATA_WRITE) {
>   			cmd_cfg |= CMD_CFG_DATA_WR;
>   			WARN_ON(xfer_bytes > host->bounce_buf_size);
> -			meson_mmc_copy_buffer(host, data, xfer_bytes, true);
> +			if (host->dram_access_quirk)
> +				sg_copy_to_io(data->sg, data->sg_len,
> +					      host->bounce_iomem_buf, xfer_bytes);

Maybe you could just use host->regs + SD_EMMC_SRAM_DATA_BUF_OFF directly 
here (and below) and save carrying host->bounce_iomem_buf around?

Robin.

> +			else
> +				sg_copy_to_buffer(data->sg, data->sg_len,
> +						  host->bounce_buf, xfer_bytes);
>   			dma_wmb();
>   		}
>   
> @@ -999,7 +963,10 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>   	if (meson_mmc_bounce_buf_read(data)) {
>   		xfer_bytes = data->blksz * data->blocks;
>   		WARN_ON(xfer_bytes > host->bounce_buf_size);
> -		meson_mmc_copy_buffer(host, data, xfer_bytes, false);
> +		if (host->dram_access_quirk)
> +			sg_copy_from_io(data->sg, data->sg_len, host->bounce_iomem_buf, xfer_bytes);
> +		else
> +			sg_copy_from_buffer(data->sg, data->sg_len, host->bounce_buf, xfer_bytes);
>   	}
>   
>   	next_cmd = meson_mmc_get_next_command(cmd);
> 
