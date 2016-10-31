From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 4/5] mmc: dw: Add fifo address property
Date: Mon, 31 Oct 2016 18:35:51 +0900
Message-ID: <db898064-ff2c-fe97-fac5-c6c328af260f@samsung.com>
References: <1477622229-32060-1-git-send-email-jun.nie@linaro.org>
 <CGME20161028023953epcas1p3f5326dbfb7cd501916ebe936316841a3@epcas1p3.samsung.com>
 <1477622229-32060-5-git-send-email-jun.nie@linaro.org>
 <bc49c0a3-5159-03a2-0023-e32f2dbbf956@samsung.com>
 <CABymUCMAW60bvi=OGhgxoBdK8t4cXgycCp_ELUE0bEQOVL0dnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:60451 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763848AbcJaJfy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Oct 2016 05:35:54 -0400
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OFW02E91NZNRUC0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 31 Oct 2016 18:35:52 +0900 (KST)
In-reply-to: <CABymUCMAW60bvi=OGhgxoBdK8t4cXgycCp_ELUE0bEQOVL0dnA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, "xie.baoyou" <xie.baoyou@zte.com.cn>, Ulf Hansson <ulf.hansson@linaro.org>, Jason Liu <jason.liu@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 10/31/2016 05:50 PM, Jun Nie wrote:
> 2016-10-28 13:24 GMT+08:00 Jaehoon Chung <jh80.chung@samsung.com>:
>> On 10/28/2016 11:37 AM, Jun Nie wrote:
>>> The FIFO address may break default address assumption of 0x100
>>> (version < 0x240A) and 0x200(version >= 0x240A) in current driver.
>>> The new property is introduced to override fifo address via DT
>>> node information.
>>>
>>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>>> ---
>>>  drivers/mmc/host/dw_mmc.c  | 5 +++++
>>>  include/linux/mmc/dw_mmc.h | 2 ++
>>>  2 files changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 1c9ee36..24ae05b6 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -2955,6 +2955,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>>>
>>>       of_property_read_u32(np, "card-detect-delay", &pdata->detect_delay_ms);
>>>
>>> +     of_property_read_u32(np, "fifo-addr", &host->fifo_addr_override);
>>> +
>>>       if (!of_property_read_u32(np, "clock-frequency", &clock_frequency))
>>>               pdata->bus_hz = clock_frequency;
>>>
>>> @@ -3163,6 +3165,9 @@ int dw_mci_probe(struct dw_mci *host)
>>>       else
>>>               host->fifo_reg = host->regs + DATA_240A_OFFSET;
>>>
>>> +     if (host->fifo_addr_override)
>>> +             host->fifo_reg = host->regs + host->fifo_addr_override;
>>> +
>>
>> Check condition the sequentially.
>>
>> if (host->fifo_addr_override) {
>> ...
>> } else if (host->verid < DW_MMC_240A) {
>> ..
>> } else {
>> ..
>> }
>>
>> how about?
> 
> Okay, will change to this.
> 
>>
>>>       tasklet_init(&host->tasklet, dw_mci_tasklet_func, (unsigned long)host);
>>>       ret = devm_request_irq(host->dev, host->irq, dw_mci_interrupt,
>>>                              host->irq_flags, "dw-mci", host);
>>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>>> index f5af2bd..4866ef5 100644
>>> --- a/include/linux/mmc/dw_mmc.h
>>> +++ b/include/linux/mmc/dw_mmc.h
>>> @@ -107,6 +107,7 @@ struct dw_mci_dma_slave {
>>>   * @ciu_clk: Pointer to card interface unit clock instance.
>>>   * @slot: Slots sharing this MMC controller.
>>>   * @fifo_depth: depth of FIFO.
>>> + * @fifo_addr_override: override fifo reg offset with this value.
>>
>> DATA addr is more correct. it's related with DATA register.
> 
> You name it, will change to data_addr_override.

Yes, data_addr or data_addr_override? It's more clear than fifo.

Best Regards,
Jaehoon Chung


>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>   * @data_shift: log2 of FIFO item size.
>>>   * @part_buf_start: Start index in part_buf.
>>>   * @part_buf_count: Bytes of partial data in part_buf.
>>> @@ -154,6 +155,7 @@ struct dw_mci {
>>>       spinlock_t              irq_lock;
>>>       void __iomem            *regs;
>>>       void __iomem            *fifo_reg;
>>> +     u32                     fifo_addr_override;
>>>
>>>       struct scatterlist      *sg;
>>>       struct sg_mapping_iter  sg_miter;
>>>
>>
> 
> 
> 

