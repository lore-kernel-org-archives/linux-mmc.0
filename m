From: Zhang Haijun <B42677@freescale.com>
Subject: Re: [PATCH 2/4 V2] mmc: esdhc: workaround for dma err in the last
 system transaction
Date: Fri, 23 Aug 2013 14:39:39 +0800
Message-ID: <521703AB.8030702@freescale.com>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com> <99E897753B6F7048BD8CCDB4661D02E13DF52C@039-SN2MPN1-022.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:18511
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754640Ab3HWGh5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 02:37:57 -0400
In-Reply-To: <99E897753B6F7048BD8CCDB4661D02E13DF52C@039-SN2MPN1-022.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhang Haijun-B42677 <B42677@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, Wood Scott-B07421 <B07421@freescale.com>, Xie Xiaobo-R63061 <X.Xie@freescale.com>

Hi, Anton and all

Is there any advice on these two patches ?

[PATCH 2/4 V2] mmc: esdhc: workaround for dma err in the last system 
transaction
[PATCH 3/4 V3] mmc: esdhc: Correct host version of T4240-R1.0-R2.0.


[PATCH 1/4 V4] powerpc/85xx: Add support for 85xx cpu type detection
This patch is Act-by Scott.
Patch 4/4 is split to four patches and Act-by Anton.


Thanks all.



On 07/19/2013 10:21 AM, Zhang Haijun-B42677 wrote:
> Hi, all
>
> Expect your advice and any comments.
>
>
> Thanks.
>
> Regards
> Haijun.
>
>
>> -----Original Message-----
>> From: Zhang Haijun-B42677
>> Sent: Wednesday, July 17, 2013 6:11 PM
>> To: linux-mmc@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
>> Cc: cbouatmailru@gmail.com; cjb@laptop.org; Wood Scott-B07421; Fleming
>> Andy-AFLEMING; Zhang Haijun-B42677; Zhang Haijun-B42677
>> Subject: [PATCH 2/4 V2] mmc: esdhc: workaround for dma err in the last
>> system transaction
>>
>> A-004388: eSDHC DMA might not stop if error occurs on system transaction
>>
>> eSDHC DMA(SDMA/ADMA) might not stop if an error occurs in the last system
>> transaction. It may continue initiating additional transactions until
>> software reset for data/all is issued during error recovery. There is not
>> any data corruption to the SD data. The IRQSTAT[DMAE] is set when the
>> erratum occurs.
>> The only conditions under which issues occur are the following:
>> 1. SDMA - For SD Write , the error occurs in the last system transaction.
>> No issue for SD read
>> 2. ADMA
>> a. Block count is enabled: For SD write, the error occurs in the last
>> system transaction. There is no issue for SD read when block count is
>> enabled.
>> b. Block count is disabled: Block count is designated by the ADMA
>> descriptor table, and the error occurs in the last system transaction
>> when ADMA is executing last descriptor line of table.
>>
>> eSDHC may initiate additional system transactions. There is no data
>> integrity issue for case 1 and 2a described below. For case 2b, system
>> data might be corrupted.
>>
>> Workaround: Set eSDHC_SYSCTL[RSTD] when IRQSTAT[DMAE] is set. For cases
>> 2a and 2b above, add an extra descriptor line with zero data next to the
>> last descriptor line.
>>
>> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>> ---
>> changes for V2:
>> 	- Update the svr version list
>>
>>   drivers/mmc/host/sdhci-of-esdhc.c | 112
>> ++++++++++++++++++++++++++++++++++----
>>   1 file changed, 102 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-
>> of-esdhc.c
>> index 15039e2..adfaadd 100644
>> --- a/drivers/mmc/host/sdhci-of-esdhc.c
>> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
>> @@ -21,9 +21,13 @@
>>   #include <linux/mmc/host.h>
>>   #include "sdhci-pltfm.h"
>>   #include "sdhci-esdhc.h"
>> +#include <asm/mpc85xx.h>
>>
>>   #define VENDOR_V_22	0x12
>>   #define VENDOR_V_23	0x13
>> +
>> +static u32 svr;
>> +
>>   static u32 esdhc_readl(struct sdhci_host *host, int reg)  {
>>   	u32 ret;
>> @@ -142,6 +146,26 @@ static void esdhc_writeb(struct sdhci_host *host, u8
>> val, int reg)
>>   	sdhci_be32bs_writeb(host, val, reg);
>>   }
>>
>> +static void esdhc_reset(struct sdhci_host *host, u8 mask) {
>> +	u32 ier;
>> +	u32 uninitialized_var(isav);
>> +
>> +	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
>> +		isav = esdhc_readl(host, SDHCI_INT_ENABLE);
>> +
>> +	esdhc_writeb(host, mask, SDHCI_SOFTWARE_RESET);
>> +	mdelay(100);
>> +
>> +	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET) {
>> +		ier = esdhc_readl(host, SDHCI_INT_ENABLE);
>> +		ier &= ~SDHCI_INT_ALL_MASK;
>> +		ier |= isav;
>> +		esdhc_writel(host, ier, SDHCI_INT_ENABLE);
>> +		esdhc_writel(host, ier, SDHCI_SIGNAL_ENABLE);
>> +	}
>> +}
>> +
>>   /*
>>    * For Abort or Suspend after Stop at Block Gap, ignore the ADMA
>>    * error(IRQSTAT[ADMAE]) if both Transfer Complete(IRQSTAT[TC]) @@ -
>> 156,25 +180,92 @@ static void esdhci_of_adma_workaround(struct sdhci_host
>> *host, u32 intmask)
>>   	dma_addr_t dmastart;
>>   	dma_addr_t dmanow;
>>
>> -	tmp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
>> +	tmp = esdhc_readl(host, SDHCI_SLOT_INT_STATUS);
>>   	tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
>>
>>   	applicable = (intmask & SDHCI_INT_DATA_END) &&
>>   		(intmask & SDHCI_INT_BLK_GAP) &&
>>   		(tmp == VENDOR_V_23);
>> -	if (!applicable)
>> +	if (applicable) {
>> +
>> +		esdhc_reset(host, SDHCI_RESET_DATA);
>> +		host->data->error = 0;
>> +		dmastart = sg_dma_address(host->data->sg);
>> +		dmanow = dmastart + host->data->bytes_xfered;
>> +
>> +		/* Force update to the next DMA block boundary. */
>> +		dmanow = (dmanow & ~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
>> +			SDHCI_DEFAULT_BOUNDARY_SIZE;
>> +		host->data->bytes_xfered = dmanow - dmastart;
>> +		esdhc_writel(host, dmanow, SDHCI_DMA_ADDRESS);
>> +
>>   		return;
>> +	}
>>
>> -	host->data->error = 0;
>> -	dmastart = sg_dma_address(host->data->sg);
>> -	dmanow = dmastart + host->data->bytes_xfered;
>>   	/*
>> -	 * Force update to the next DMA block boundary.
>> +	 * Check for A-004388: eSDHC DMA might not stop if error
>> +	 * occurs on system transaction
>> +	 * Impact list:
>> +	 * T4240-R1.0 B4860-R1.0 P1010-R1.0
>> +	 * P3041-R1.0-R2.0-R1.1 P2041-R1.0-R1.1-R2.0
>> +	 * P5040-R2.0
>>   	 */
>> -	dmanow = (dmanow & ~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
>> -		SDHCI_DEFAULT_BOUNDARY_SIZE;
>> -	host->data->bytes_xfered = dmanow - dmastart;
>> -	sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
>> +	if (!(((SVR_SOC_VER(svr) == SVR_T4240) && (SVR_REV(svr) == 0x10))
>> ||
>> +		((SVR_SOC_VER(svr) == SVR_B4860) && (SVR_REV(svr) == 0x10))
>> ||
>> +		((SVR_SOC_VER(svr) == SVR_P1010) && (SVR_REV(svr) == 0x10))
>> ||
>> +		((SVR_SOC_VER(svr) == SVR_P3041) && (SVR_REV(svr) <= 0x20))
>> ||
>> +		((SVR_SOC_VER(svr) == SVR_P2041) && (SVR_REV(svr) <= 0x20))
>> ||
>> +		((SVR_SOC_VER(svr) == SVR_P5040) && SVR_REV(svr) == 0x20)))
>> +		return;
>> +
>> +	esdhc_reset(host, SDHCI_RESET_DATA);
>> +
>> +	if (host->flags & SDHCI_USE_ADMA) {
>> +		u32 mod, i, offset;
>> +		u8 *desc;
>> +		dma_addr_t addr;
>> +		struct scatterlist *sg;
>> +		__le32 *dataddr;
>> +		__le32 *cmdlen;
>> +
>> +		/*
>> +		 * If block count was enabled, in case read transfer there
>> +		 * is no data was corrupted
>> +		 */
>> +		mod = esdhc_readl(host, SDHCI_TRANSFER_MODE);
>> +		if ((mod & SDHCI_TRNS_BLK_CNT_EN) &&
>> +			(host->data->flags & MMC_DATA_READ))
>> +			host->data->error = 0;
>> +
>> +		BUG_ON(!host->data);
>> +		desc = host->adma_desc;
>> +		for_each_sg(host->data->sg, sg, host->sg_count, i) {
>> +			addr = sg_dma_address(sg);
>> +			offset = (4 - (addr & 0x3)) & 0x3;
>> +			if (offset)
>> +				desc += 8;
>> +			desc += 8;
>> +		}
>> +
>> +		/*
>> +		 * Add an extra zero descriptor next to the
>> +		 * terminating descriptor.
>> +		 */
>> +		desc += 8;
>> +		WARN_ON((desc - host->adma_desc) > (128 * 2 + 1) * 4);
>> +
>> +		dataddr = (__le32 __force *)(desc + 4);
>> +		cmdlen = (__le32 __force *)desc;
>> +
>> +		cmdlen[0] = cpu_to_le32(0);
>> +		dataddr[0] = cpu_to_le32(0);
>> +	}
>> +
>> +	if ((host->flags & SDHCI_USE_SDMA) &&
>> +		(host->data->flags & MMC_DATA_READ))
>> +		host->data->error = 0;
>> +
>> +	return;
>>   }
>>
>>   static int esdhc_of_enable_dma(struct sdhci_host *host) @@ -299,6 +390,7
>> @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>>   	struct device_node *np;
>>   	int ret;
>>
>> +	svr = mfspr(SPRN_SVR);
>>   	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
>>   	if (IS_ERR(host))
>>   		return PTR_ERR(host);
>> --
>> 1.8.0


-- 
Thanks & Regards

Haijun


