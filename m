From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH v7 01/10] mmc: dw_mmc: Add external dma interface
 support
Date: Tue, 15 Sep 2015 16:52:07 +0800
Message-ID: <55F7DC37.70903@rock-chips.com>
References: <1440379479-24308-1-git-send-email-shawn.lin@rock-chips.com>
 <1440379536-24400-1-git-send-email-shawn.lin@rock-chips.com>
 <55F7D214.6020100@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <55F7D214.6020100@samsung.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org
Cc: shawn.lin@rock-chips.com, Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>, Joachim Eastwood <manabian@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Russell King <linux@arm.linux.org.uk>, Zhangfei Gao <zhangfei.gao@linaro.org>, Jun Nie <jun.nie@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, Govindraj Raja <govindraj.raja@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de, dianders@chromium.org, linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, CPGS <cpgs@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 2015/9/15 16:08, Jaehoon Chung wrote:
> Hi, Shawn.
>

[...]

>> -config MMC_DW_IDMAC
>> -	bool "Internal DMAC interface"
>> -	depends on MMC_DW
>> -	help
>> -	  This selects support for the internal DMAC block within the Synopsys
>> -	  Designware Mobile Storage IP block. This disables the external DMA
>> -	  interface.
>> +	  PIO, internal DMA mode and external DMA mode.
>
> In future, i will add the quirk for broken IDMAC.
> This patch is absolutely depended on HCON register, but some IP can be broken it.
> how about?
>

That's fine to add broken IDMAC if some IP can support reading tranfer 
mode from HCON.(I check IP 270a and 240a, they supports)

>>
>>   config MMC_DW_PLTFM
>>   	tristate "Synopsys Designware MCI Support as platform device"

[...]

>> +static void dw_mci_edmac_stop_dma(struct dw_mci *host)
>> +{
>> +	dmaengine_terminate_all(host->dms->ch);
>
> Does it need not to check "return value"?
>

Doesn't need. dmaengine_terminate_all return -ENOSYS if sub-dma drivers 
doesn't implement terminate_all hook. Then nearly all the sub-dma 
drivers always return 0(success) . That's why none of mmc host drivers 
to check the return value here.

>> +}
>> +
>> +static int dw_mci_edmac_start_dma(struct dw_mci *host,
>> +					    unsigned int sg_len)
>> +{
>> +	struct dma_slave_config cfg;
>> +	struct dma_async_tx_descriptor *desc = NULL;
>> +	struct scatterlist *sgl = host->data->sg;
>> +	const u32 mszs[] = {1, 4, 8, 16, 32, 64, 128, 256};
>> +	u32 sg_elems = host->data->sg_len;
>> +	u32 fifoth_val;
>> +	u32 fifo_offset = host->fifo_reg - host->regs;
>> +	int ret = 0;
>> +
>> +	/* Set external dma config: burst size, burst width */
>> +	cfg.dst_addr = (dma_addr_t)(host->phy_regs + fifo_offset);
>> +	cfg.src_addr = cfg.dst_addr;
>> +	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>> +	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>> +
>> +	/* Match burst msize with external dma config */
>> +	fifoth_val = mci_readl(host, FIFOTH);
>> +	cfg.dst_maxburst = mszs[(fifoth_val >> 28) & 0x7];
>> +	cfg.src_maxburst = cfg.dst_maxburst;
>
> The above configuration needs to set it at every time?
>

I think so. We call dw_mci_adjust_fifoth to make
configuraton more reasonable every time. So this setting correlates to
the fifoth calculated by dw_mci_adjust_fifoth.

>> +
>> +	if (host->data->flags & MMC_DATA_WRITE)
>> +		cfg.direction = DMA_MEM_TO_DEV;
>> +	else /* MMC_DATA_READ */
>
> Can be removed the comment.
>

okay.

>> +		cfg.direction = DMA_DEV_TO_MEM;
>> +
>> +	ret = dmaengine_slave_config(host->dms->ch, &cfg);

[...]

>> +			mmc->max_segs = 64;
>> +			mmc->max_blk_size = 65536;
>> +			mmc->max_blk_count = 65535;
>> +			mmc->max_req_size =
>> +					mmc->max_blk_size * mmc->max_blk_count;
>> +			mmc->max_seg_size = mmc->max_req_size;
>
>
> WARNING: suspect code indent for conditional statements (8, 24)
> #349: FILE: drivers/mmc/host/dw_mmc.c:2599:

Sorry, but I can't find it?

./scripts/checkpatch.pl -f drivers/mmc/host/dw_mmc.c
total: 0 errors, 0 warnings, 3310 lines checked

drivers/mmc/host/dw_mmc.c has no obvious style problems and is ready for 
submission.

> +       } else if (host->use_dma == TRANS_MODE_EDMAC) {
> +                       mmc->max_segs = 64;
>
>
>>   	} else {

[...]

>> +	*/
>
> trans_mode can't take HCON value, but trans_mode reassigned to "TRANS_MODE_IDMAC" or "TRANS_MODE_EDMAC"..
> It's reassigned to host->use_dma...why can't use the host->use_dma?
>
> Your code..
>
> 1. trans_mode <- HCON value
> 2. Check trans_mode which interface use.
> 	then trans_mode <- TRANS_MODE_IDMAC/EDMAC/PIO
> 3. host->use_dma <- trans_mode
>
> isn't?
>
> It can be replaced to "host->use_dma" instead of "trans_mode".
>

yep, I intented to introduce a variable to make others clear the
mismatch meaning of databook. If you feel ok, I will remove trans_mode 
in v8. :)

>> +	trans_mode = SDMMC_GET_TRANS_MODE(mci_readl(host, HCON));
>> +	if (trans_mode == DMA_INTERFACE_IDMA) {

[...]

>>
>>   	if (!host->dma_ops)
>>   		goto no_dma;
>
> This checking seems unnecessary, after applied your code.
>

Ahh... that's right, thanks for pointing it out.

> Best Regards,
> Jaehoon Chung
>
>> @@ -2562,12 +2733,12 @@ static void dw_mci_init_dma(struct dw_mci *host)
>>   		goto no_dma;
>>   	}
>>
>> -	host->use_dma = 1;
>> +	host->use_dma = trans_mode;
>>   	return;
>>
>>   no_dma:
>>   	dev_info(host->dev, "Using PIO mode.\n");
>> -	host->use_dma = 0;
>> +	host->use_dma = trans_mode;
>>   }
>>
>>   static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
>> @@ -2650,10 +2821,9 @@ static bool dw_mci_reset(struct dw_mci *host)
>>   		}
>>   	}
>>
>> -#if IS_ENABLED(CONFIG_MMC_DW_IDMAC)
>> -	/* It is also recommended that we reset and reprogram idmac */
>> -	dw_mci_idmac_reset(host);
>> -#endif
>> +	if (host->use_dma == TRANS_MODE_IDMAC)
>> +		/* It is also recommended that we reset and reprogram idmac */
>> +		dw_mci_idmac_reset(host);
>>
>>   	ret = true;
>>
>> @@ -3067,6 +3237,9 @@ EXPORT_SYMBOL(dw_mci_remove);
>>    */
>>   int dw_mci_suspend(struct dw_mci *host)
>>   {
>> +	if (host->use_dma && host->dma_ops->exit)
>> +		host->dma_ops->exit(host);
>> +
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL(dw_mci_suspend);
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index 8ce4674..811d467 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -148,6 +148,12 @@
>>   #define SDMMC_SET_FIFOTH(m, r, t)	(((m) & 0x7) << 28 | \
>>   					 ((r) & 0xFFF) << 16 | \
>>   					 ((t) & 0xFFF))
>> +/* HCON register defines */
>> +#define DMA_INTERFACE_IDMA		(0x0)
>> +#define DMA_INTERFACE_DWDMA		(0x1)
>> +#define DMA_INTERFACE_GDMA		(0x2)
>> +#define DMA_INTERFACE_NODMA		(0x3)
>> +#define SDMMC_GET_TRANS_MODE(x)		(((x)>>16) & 0x3)
>>   /* Internal DMAC interrupt defines */
>>   #define SDMMC_IDMAC_INT_AI		BIT(9)
>>   #define SDMMC_IDMAC_INT_NI		BIT(8)
>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>> index 134c574..f67b2ec 100644
>> --- a/include/linux/mmc/dw_mmc.h
>> +++ b/include/linux/mmc/dw_mmc.h
>> @@ -16,6 +16,7 @@
>>
>>   #include <linux/scatterlist.h>
>>   #include <linux/mmc/core.h>
>> +#include <linux/dmaengine.h>
>>
>>   #define MAX_MCI_SLOTS	2
>>
>> @@ -40,6 +41,17 @@ enum {
>>
>>   struct mmc_data;
>>
>> +enum {
>> +	TRANS_MODE_PIO = 0,
>> +	TRANS_MODE_IDMAC,
>> +	TRANS_MODE_EDMAC
>> +};
>> +
>> +struct dw_mci_dma_slave {
>> +	struct dma_chan *ch;
>> +	enum dma_transfer_direction direction;
>> +};
>> +
>>   /**
>>    * struct dw_mci - MMC controller state shared between all slots
>>    * @lock: Spinlock protecting the queue and associated data.
>> @@ -154,7 +166,14 @@ struct dw_mci {
>>   	dma_addr_t		sg_dma;
>>   	void			*sg_cpu;
>>   	const struct dw_mci_dma_ops	*dma_ops;
>> +	/* For idmac */
>>   	unsigned int		ring_size;
>> +
>> +	/* For edmac */
>> +	struct dw_mci_dma_slave *dms;
>> +	/* Registers's physical base address */
>> +	void                    *phy_regs;
>> +
>>   	u32			cmd_status;
>>   	u32			data_status;
>>   	u32			stop_cmdr;
>> @@ -208,8 +227,8 @@ struct dw_mci {
>>   struct dw_mci_dma_ops {
>>   	/* DMA Ops */
>>   	int (*init)(struct dw_mci *host);
>> -	void (*start)(struct dw_mci *host, unsigned int sg_len);
>> -	void (*complete)(struct dw_mci *host);
>> +	int (*start)(struct dw_mci *host, unsigned int sg_len);
>> +	void (*complete)(void *host);
>>   	void (*stop)(struct dw_mci *host);
>>   	void (*cleanup)(struct dw_mci *host);
>>   	void (*exit)(struct dw_mci *host);
>>
>
>
>
>


-- 
Best Regards
Shawn Lin
