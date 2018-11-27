From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: dw_mmc: IDMAC Invalidate cache after read
Date: Tue, 27 Nov 2018 08:43:11 +0800
Message-ID: <d20a3c39-dea7-e324-e677-ec416c16559c@rock-chips.com>
References: <1542786115.18775.83.camel@atviedlbe741.rss.d3s.at.thales>
 <a45eca28-fd89-e595-5b34-689bc3a09b9c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a45eca28-fd89-e595-5b34-689bc3a09b9c@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, JABLONSKY Jan <Jan.JABLONSKY@thalesgroup.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2018/11/23 23:29, Robin Murphy wrote:
> Hi Jan,
> 
> [repeating some of the discussion from your other thread for the benefit 
> of the MMC audience]
> 
> On 21/11/2018 07:42, JABLONSKY Jan wrote:
>> CPU may not see most up-to-date and correct copy of DMA buffer, when
>> internal DMA controller is in use.
>> Problem appears on The Altera SoC FPGA (uses integrated DMA controller),
>> during higher CPU and system memory load
>>
>> Signed-off-by: Jan Jablonsky <jan.jablonsky@thalesgroup.com>
>> ---
>>   drivers/mmc/host/dw_mmc.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 80dc2fd..63873d9 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -499,8 +499,7 @@ static void dw_mci_dmac_complete_dma(void *arg)
>>       dev_vdbg(host->dev, "DMA complete\n");
>> -    if ((host->use_dma == TRANS_MODE_EDMAC) &&
>> -        data && (data->flags & MMC_DATA_READ))
>> +    if (data && (data->flags & MMC_DATA_READ))
>>           /* Invalidate cache after read */
>>           dma_sync_sg_for_cpu(mmc_dev(host->slot->mmc),
>>                       data->sg,
> 
> It looks very dubious whether this is actually the right thing to do. 
> Just considering this driver, edma has an complementary sync_sg call in 
> its .start method, so if idma needed this one, logically shouldn't it 
> also need the other one as well?
> 
> However, from a DMA API point of view, these syncs make no sense either 
> way - the very next thing we do here is call host->dma_ops->cleanup(), 
> which calls dma_unmap_sg(), which will perform the appropriate cache 
> maintenance anyway. Thus I can't see why this code is even here to begin 
> with. Similarly on the request path - the sg list really shouldn't have 
> been touched since being mapped in dw_mci_pre_dma_transfer(), so that 
> sync should also be an effective no-op unless it's papering over some 
> race condition elsewhere.
> 
> Shawn - do you remember why these syncs were added in 3fc7eaef44dbc? 
> Were you seeing actual coherency issues on RK31xx SoCs, or was it 
> perhaps just some leftover or misunderstanding which missed getting 
> cleaned up?

I  can't remember too much details but looking at the dma-mapping code 
again, it seems the complemetary sync-op here is useless.

> 
> Robin.
> 
> 
> 
