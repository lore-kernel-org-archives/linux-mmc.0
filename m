From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix some coding style
Date: Thu, 05 Jan 2017 10:19:10 +0900
Message-ID: <dca78b88-425e-363a-aaca-9e3c3a43971e@samsung.com>
References: <CGME20170104125752epcas4p2a801fce6fd376d02d7440ad4bfe1716b@epcas4p2.samsung.com>
 <1483534376-6521-1-git-send-email-xzy.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1483534376-6521-1-git-send-email-xzy.xu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ziyuan Xu <xzy.xu@rock-chips.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 01/04/2017 09:52 PM, Ziyuan Xu wrote:
> Let's fix the warnings from checkpatch.pl:
> 
> - line over 80 characters;
> - block comments should align the * on each Lines;
> - statements not starting on a tabstop.

If there is no critical problem, 
I think that current codes are keeping better than changing.
When someone contribute the patches relevant to these, it can be also changed,
(It's more meaningful.)

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
> ---
> 
>  drivers/mmc/host/dw_mmc.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ed63237..a8efe3f 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -94,7 +94,8 @@ struct idmac_desc {
>  
>  	__le32		des1;	/* Buffer sizes */
>  #define IDMAC_SET_BUFFER1_SIZE(d, s) \
> -	((d)->des1 = ((d)->des1 & cpu_to_le32(0x03ffe000)) | (cpu_to_le32((s) & 0x1fff)))
> +	((d)->des1 = ((d)->des1 & cpu_to_le32(0x03ffe000)) | \
> +	 (cpu_to_le32((s) & 0x1fff)))
>  
>  	__le32		des2;	/* buffer 1 physical address */
>  
> @@ -2733,16 +2734,16 @@ static void dw_mci_init_dma(struct dw_mci *host)
>  	struct device_node *np = dev->of_node;
>  
>  	/*
> -	* Check tansfer mode from HCON[17:16]
> -	* Clear the ambiguous description of dw_mmc databook:
> -	* 2b'00: No DMA Interface -> Actually means using Internal DMA block
> -	* 2b'01: DesignWare DMA Interface -> Synopsys DW-DMA block
> -	* 2b'10: Generic DMA Interface -> non-Synopsys generic DMA block
> -	* 2b'11: Non DW DMA Interface -> pio only
> -	* Compared to DesignWare DMA Interface, Generic DMA Interface has a
> -	* simpler request/acknowledge handshake mechanism and both of them
> -	* are regarded as external dma master for dw_mmc.
> -	*/
> +	 * Check tansfer mode from HCON[17:16]
> +	 * Clear the ambiguous description of dw_mmc databook:
> +	 * 2b'00: No DMA Interface -> Actually means using Internal DMA block
> +	 * 2b'01: DesignWare DMA Interface -> Synopsys DW-DMA block
> +	 * 2b'10: Generic DMA Interface -> non-Synopsys generic DMA block
> +	 * 2b'11: Non DW DMA Interface -> pio only
> +	 * Compared to DesignWare DMA Interface, Generic DMA Interface has a
> +	 * simpler request/acknowledge handshake mechanism and both of them
> +	 * are regarded as external dma master for dw_mmc.
> +	 */
>  	host->use_dma = SDMMC_GET_TRANS_MODE(mci_readl(host, HCON));
>  	if (host->use_dma == DMA_INTERFACE_IDMA) {
>  		host->use_dma = TRANS_MODE_IDMAC;
> @@ -2756,9 +2757,9 @@ static void dw_mci_init_dma(struct dw_mci *host)
>  	/* Determine which DMA interface to use */
>  	if (host->use_dma == TRANS_MODE_IDMAC) {
>  		/*
> -		* Check ADDR_CONFIG bit in HCON to find
> -		* IDMAC address bus width
> -		*/
> +		 * Check ADDR_CONFIG bit in HCON to find
> +		 * IDMAC address bus width
> +		 */
>  		addr_config = SDMMC_GET_ADDR_CONFIG(mci_readl(host, HCON));
>  
>  		if (addr_config == 1) {
> @@ -3337,8 +3338,8 @@ int dw_mci_runtime_resume(struct device *dev)
>  	 * Restore the initial value at FIFOTH register
>  	 * And Invalidate the prev_blksz with zero
>  	 */
> -	 mci_writel(host, FIFOTH, host->fifoth_val);
> -	 host->prev_blksz = 0;
> +	mci_writel(host, FIFOTH, host->fifoth_val);
> +	host->prev_blksz = 0;
>  
>  	/* Put in max timeout */
>  	mci_writel(host, TMOUT, 0xFFFFFFFF);
> 
