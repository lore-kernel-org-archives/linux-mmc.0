From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC PATCH v7 02/10] mmc: dw_mmc: use macro for HCON register
 operations
Date: Tue, 15 Sep 2015 17:10:41 +0900
Message-ID: <55F7D281.6080103@samsung.com>
References: <1440379479-24308-1-git-send-email-shawn.lin@rock-chips.com>
 <1440379554-24444-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1440379554-24444-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, ulf.hansson@linaro.org
Cc: Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>, Joachim Eastwood <manabian@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Russell King <linux@arm.linux.org.uk>, Zhangfei Gao <zhangfei.gao@linaro.org>, Jun Nie <jun.nie@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, Govindraj Raja <govindraj.raja@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de, dianders@chromium.org, linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, CPGS <cpgs@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi, Shawn.

Looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 08/24/2015 10:25 AM, Shawn Lin wrote:
> This patch add some macros for HCON register operations
> to make code more readable.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mmc/host/dw_mmc.c | 6 +++---
>  drivers/mmc/host/dw_mmc.h | 3 +++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 9c91983..0a3c63c 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2678,7 +2678,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
>  		* Check ADDR_CONFIG bit in HCON to find
>  		* IDMAC address bus width
>  		*/
> -		addr_config = (mci_readl(host, HCON) >> 27) & 0x01;
> +		addr_config = SDMMC_GET_ADDR_CONFIG(mci_readl(host, HCON));
>  
>  		if (addr_config == 1) {
>  			/* host supports IDMAC in 64-bit address mode */
> @@ -3060,7 +3060,7 @@ int dw_mci_probe(struct dw_mci *host)
>  	 * Get the host data width - this assumes that HCON has been set with
>  	 * the correct values.
>  	 */
> -	i = (mci_readl(host, HCON) >> 7) & 0x7;
> +	i = SDMMC_GET_HDATA_WIDTH(mci_readl(host, HCON));
>  	if (!i) {
>  		host->push_data = dw_mci_push_data16;
>  		host->pull_data = dw_mci_pull_data16;
> @@ -3142,7 +3142,7 @@ int dw_mci_probe(struct dw_mci *host)
>  	if (host->pdata->num_slots)
>  		host->num_slots = host->pdata->num_slots;
>  	else
> -		host->num_slots = ((mci_readl(host, HCON) >> 1) & 0x1F) + 1;
> +		host->num_slots = SDMMC_GET_SLOT_NUM(mci_readl(host, HCON));
>  
>  	/*
>  	 * Enable interrupts for command done, data over, data empty,
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 811d467..f2a88d4 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -154,6 +154,9 @@
>  #define DMA_INTERFACE_GDMA		(0x2)
>  #define DMA_INTERFACE_NODMA		(0x3)
>  #define SDMMC_GET_TRANS_MODE(x)		(((x)>>16) & 0x3)
> +#define SDMMC_GET_SLOT_NUM(x)		((((x)>>1) & 0x1F) + 1)
> +#define SDMMC_GET_HDATA_WIDTH(x)	(((x)>>7) & 0x7)
> +#define SDMMC_GET_ADDR_CONFIG(x)	(((x)>>27) & 0x1)
>  /* Internal DMAC interrupt defines */
>  #define SDMMC_IDMAC_INT_AI		BIT(9)
>  #define SDMMC_IDMAC_INT_NI		BIT(8)
> 
