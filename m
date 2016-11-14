From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v5 5/5] mmc: dw: Add fifo watermark alignment property
Date: Mon, 14 Nov 2016 16:10:00 +0800
Message-ID: <c5867a19-1268-7beb-4e7c-d1efa7b11837@rock-chips.com>
References: <1478568298-18380-1-git-send-email-jun.nie@linaro.org>
 <1478568298-18380-6-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.136]:45928 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753781AbcKNIKs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2016 03:10:48 -0500
In-Reply-To: <1478568298-18380-6-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>, shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, linux-mmc@vger.kernel.org

On 2016/11/8 9:24, Jun Nie wrote:
> Data done irq is expected if data length is less than
> watermark in PIO mode. But fifo watermark is requested
> to be aligned with data length in some SoC so that TX/RX
> irq can be generated with data done irq. Add the
> watermark alignment to mark this requirement and force
> fifo watermark setting accordingly.
>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c  | 11 +++++++++--
>  include/linux/mmc/dw_mmc.h |  3 +++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 696b5e6..6d85ca6 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1111,11 +1111,15 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
>  		mci_writel(host, CTRL, temp);
>
>  		/*
> -		 * Use the initial fifoth_val for PIO mode.
> +		 * Use the initial fifoth_val for PIO mode. If wm_algined
> +		 * is set, we set watermark same as data size.
>  		 * If next issued data may be transfered by DMA mode,
>  		 * prev_blksz should be invalidated.
>  		 */
> -		mci_writel(host, FIFOTH, host->fifoth_val);
> +		if (host->wm_aligned)
> +			dw_mci_adjust_fifoth(host, data);
> +		else
> +			mci_writel(host, FIFOTH, host->fifoth_val);
>  		host->prev_blksz = 0;
>  	} else {
>  		/*
> @@ -2957,6 +2961,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>
>  	of_property_read_u32(np, "data-addr", &host->data_addr_override);
>
> +	if (of_get_property(np, "fifo-watermark-aligned", NULL))
> +		host->wm_aligned = true;
> +
>  	if (!of_property_read_u32(np, "clock-frequency", &clock_frequency))
>  		pdata->bus_hz = clock_frequency;
>
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 17cb95a..ee4bb30 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -108,6 +108,8 @@ struct dw_mci_dma_slave {
>   * @slot: Slots sharing this MMC controller.
>   * @fifo_depth: depth of FIFO.
>   * @data_addr_override: override fifo reg offset with this value.
> + * @wm_aligned: force fifo watermark equal with data length in PIO mode.
> + *	Set as true if alignment is needed.
>   * @data_shift: log2 of FIFO item size.
>   * @part_buf_start: Start index in part_buf.
>   * @part_buf_count: Bytes of partial data in part_buf.
> @@ -156,6 +158,7 @@ struct dw_mci {
>  	void __iomem		*regs;
>  	void __iomem		*fifo_reg;
>  	u32			data_addr_override;
> +	bool			wm_aligned;
>
>  	struct scatterlist	*sg;
>  	struct sg_mapping_iter	sg_miter;
>


-- 
Best Regards
Shawn Lin

