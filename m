From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 2/4] mmc: dw_mmc: avoid race condition of cpu and IDMAC
Date: Tue, 20 Sep 2016 18:49:22 +0900
Message-ID: <d3cd8993-7c5e-bdd4-5182-aec5fd0b040c@samsung.com>
References: <1472789679-15121-1-git-send-email-shawn.lin@rock-chips.com>
 <1472789679-15121-2-git-send-email-shawn.lin@rock-chips.com>
 <CGME20160920094723epcas1p15f490cb1f112f70f774e3117ae7acebb@epcas1p1.samsung.com>
 <35afa945-1b94-f870-d52e-6ab7b1da4a67@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <35afa945-1b94-f870-d52e-6ab7b1da4a67@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

On 09/20/2016 06:47 PM, Shawn Lin wrote:
> Hi Jaehoon,
> 
> Friendly ping... :)

Thanks for reminding! :) I forgot your patch-set..sorry!

Best Regards,
Jaehoon Chung
> 
> On 2016/9/2 12:14, Shawn Lin wrote:
>> We could see an obvious race condition by test that
>> the former write operation by IDMAC aiming to clear
>> OWN bit reach right after the later configuration of
>> the same desc, which makes the IDMAC be in SUSPEND
>> state as the OWN bit was cleared by the asynchronous
>> write operation of IDMAC. The bug can be very easy
>> reproduced on RK3288 or similar when we reduce the
>> running rate of system buses and keep the CPU running
>> faster. So as two separate masters, IDMAC and cpu
>> write the same descriptor stored on the same address,
>> and this should be protected by adding check of OWN
>> bit before preparing new descriptors.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v2:
>> - fallback to PIO mode if failing to wait for OWN bit
>> - cleanup polluted desc chain as the own bit error could
>>   occur on any place of the chain, so we need to clr the desc
>>   configured before that one. Use the exist function to reinit
>>   the desc chain. As this issue is really rare, so after applied,
>>   the fio/iozone stress test didn't show up performance regression.
>>
>>  drivers/mmc/host/dw_mmc.c | 208 ++++++++++++++++++++++++++++------------------
>>  1 file changed, 129 insertions(+), 79 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 782b303..daa1c52 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -467,12 +467,87 @@ static void dw_mci_dmac_complete_dma(void *arg)
>>      }
>>  }
>>
>> -static inline void dw_mci_prepare_desc64(struct dw_mci *host,
>> +static int dw_mci_idmac_init(struct dw_mci *host)
>> +{
>> +    int i;
>> +
>> +    if (host->dma_64bit_address == 1) {
>> +        struct idmac_desc_64addr *p;
>> +        /* Number of descriptors in the ring buffer */
>> +        host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc_64addr);
>> +
>> +        /* Forward link the descriptor list */
>> +        for (i = 0, p = host->sg_cpu; i < host->ring_size - 1;
>> +                                i++, p++) {
>> +            p->des6 = (host->sg_dma +
>> +                    (sizeof(struct idmac_desc_64addr) *
>> +                            (i + 1))) & 0xffffffff;
>> +
>> +            p->des7 = (u64)(host->sg_dma +
>> +                    (sizeof(struct idmac_desc_64addr) *
>> +                            (i + 1))) >> 32;
>> +            /* Initialize reserved and buffer size fields to "0" */
>> +            p->des1 = 0;
>> +            p->des2 = 0;
>> +            p->des3 = 0;
>> +        }
>> +
>> +        /* Set the last descriptor as the end-of-ring descriptor */
>> +        p->des6 = host->sg_dma & 0xffffffff;
>> +        p->des7 = (u64)host->sg_dma >> 32;
>> +        p->des0 = IDMAC_DES0_ER;
>> +
>> +    } else {
>> +        struct idmac_desc *p;
>> +        /* Number of descriptors in the ring buffer */
>> +        host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc);
>> +
>> +        /* Forward link the descriptor list */
>> +        for (i = 0, p = host->sg_cpu;
>> +             i < host->ring_size - 1;
>> +             i++, p++) {
>> +            p->des3 = cpu_to_le32(host->sg_dma +
>> +                    (sizeof(struct idmac_desc) * (i + 1)));
>> +            p->des1 = 0;
>> +        }
>> +
>> +        /* Set the last descriptor as the end-of-ring descriptor */
>> +        p->des3 = cpu_to_le32(host->sg_dma);
>> +        p->des0 = cpu_to_le32(IDMAC_DES0_ER);
>> +    }
>> +
>> +    dw_mci_idmac_reset(host);
>> +
>> +    if (host->dma_64bit_address == 1) {
>> +        /* Mask out interrupts - get Tx & Rx complete only */
>> +        mci_writel(host, IDSTS64, IDMAC_INT_CLR);
>> +        mci_writel(host, IDINTEN64, SDMMC_IDMAC_INT_NI |
>> +                SDMMC_IDMAC_INT_RI | SDMMC_IDMAC_INT_TI);
>> +
>> +        /* Set the descriptor base address */
>> +        mci_writel(host, DBADDRL, host->sg_dma & 0xffffffff);
>> +        mci_writel(host, DBADDRU, (u64)host->sg_dma >> 32);
>> +
>> +    } else {
>> +        /* Mask out interrupts - get Tx & Rx complete only */
>> +        mci_writel(host, IDSTS, IDMAC_INT_CLR);
>> +        mci_writel(host, IDINTEN, SDMMC_IDMAC_INT_NI |
>> +                SDMMC_IDMAC_INT_RI | SDMMC_IDMAC_INT_TI);
>> +
>> +        /* Set the descriptor base address */
>> +        mci_writel(host, DBADDR, host->sg_dma);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static inline int dw_mci_prepare_desc64(struct dw_mci *host,
>>                       struct mmc_data *data,
>>                       unsigned int sg_len)
>>  {
>>      unsigned int desc_len;
>>      struct idmac_desc_64addr *desc_first, *desc_last, *desc;
>> +    unsigned long timeout;
>>      int i;
>>
>>      desc_first = desc_last = desc = host->sg_cpu;
>> @@ -489,6 +564,19 @@ static inline void dw_mci_prepare_desc64(struct dw_mci *host,
>>              length -= desc_len;
>>
>>              /*
>> +             * Wait for the former clear OWN bit operation
>> +             * of IDMAC to make sure that this descriptor
>> +             * isn't still owned by IDMAC as IDMAC's write
>> +             * ops and CPU's read ops are asynchronous.
>> +             */
>> +            timeout = jiffies + msecs_to_jiffies(100);
>> +            while (readl(&desc->des0) & IDMAC_DES0_OWN) {
>> +                if (time_after(jiffies, timeout))
>> +                    goto err_own_bit;
>> +                udelay(10);
>> +            }
>> +
>> +            /*
>>               * Set the OWN bit and disable interrupts
>>               * for this descriptor
>>               */
>> @@ -516,15 +604,24 @@ static inline void dw_mci_prepare_desc64(struct dw_mci *host,
>>      /* Set last descriptor */
>>      desc_last->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
>>      desc_last->des0 |= IDMAC_DES0_LD;
>> +
>> +    return 0;
>> +err_own_bit:
>> +    /* restore the descriptor chain as it's polluted */
>> +    dev_dbg(host->dev, "desciptor is still owned by IDMAC.\n");
>> +    memset(host->sg_cpu, 0, PAGE_SIZE);
>> +    dw_mci_idmac_init(host);
>> +    return -EINVAL;
>>  }
>>
>>
>> -static inline void dw_mci_prepare_desc32(struct dw_mci *host,
>> +static inline int dw_mci_prepare_desc32(struct dw_mci *host,
>>                       struct mmc_data *data,
>>                       unsigned int sg_len)
>>  {
>>      unsigned int desc_len;
>>      struct idmac_desc *desc_first, *desc_last, *desc;
>> +    unsigned long timeout;
>>      int i;
>>
>>      desc_first = desc_last = desc = host->sg_cpu;
>> @@ -541,6 +638,20 @@ static inline void dw_mci_prepare_desc32(struct dw_mci *host,
>>              length -= desc_len;
>>
>>              /*
>> +             * Wait for the former clear OWN bit operation
>> +             * of IDMAC to make sure that this descriptor
>> +             * isn't still owned by IDMAC as IDMAC's write
>> +             * ops and CPU's read ops are asynchronous.
>> +             */
>> +            timeout = jiffies + msecs_to_jiffies(100);
>> +            while (readl(&desc->des0) &
>> +                   cpu_to_le32(IDMAC_DES0_OWN)) {
>> +                if (time_after(jiffies, timeout))
>> +                    goto err_own_bit;
>> +                udelay(10);
>> +            }
>> +
>> +            /*
>>               * Set the OWN bit and disable interrupts
>>               * for this descriptor
>>               */
>> @@ -569,16 +680,28 @@ static inline void dw_mci_prepare_desc32(struct dw_mci *host,
>>      desc_last->des0 &= cpu_to_le32(~(IDMAC_DES0_CH |
>>                         IDMAC_DES0_DIC));
>>      desc_last->des0 |= cpu_to_le32(IDMAC_DES0_LD);
>> +
>> +    return 0;
>> +err_own_bit:
>> +    /* restore the descriptor chain as it's polluted */
>> +    dev_dbg(host->dev, "desciptor is still owned by IDMAC.\n");
>> +    memset(host->sg_cpu, 0, PAGE_SIZE);
>> +    dw_mci_idmac_init(host);
>> +    return -EINVAL;
>>  }
>>
>>  static int dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
>>  {
>>      u32 temp;
>> +    int ret;
>>
>>      if (host->dma_64bit_address == 1)
>> -        dw_mci_prepare_desc64(host, host->data, sg_len);
>> +        ret = dw_mci_prepare_desc64(host, host->data, sg_len);
>>      else
>> -        dw_mci_prepare_desc32(host, host->data, sg_len);
>> +        ret = dw_mci_prepare_desc32(host, host->data, sg_len);
>> +
>> +    if (ret)
>> +        goto out;
>>
>>      /* drain writebuffer */
>>      wmb();
>> @@ -603,81 +726,8 @@ static int dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
>>      /* Start it running */
>>      mci_writel(host, PLDMND, 1);
>>
>> -    return 0;
>> -}
>> -
>> -static int dw_mci_idmac_init(struct dw_mci *host)
>> -{
>> -    int i;
>> -
>> -    if (host->dma_64bit_address == 1) {
>> -        struct idmac_desc_64addr *p;
>> -        /* Number of descriptors in the ring buffer */
>> -        host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc_64addr);
>> -
>> -        /* Forward link the descriptor list */
>> -        for (i = 0, p = host->sg_cpu; i < host->ring_size - 1;
>> -                                i++, p++) {
>> -            p->des6 = (host->sg_dma +
>> -                    (sizeof(struct idmac_desc_64addr) *
>> -                            (i + 1))) & 0xffffffff;
>> -
>> -            p->des7 = (u64)(host->sg_dma +
>> -                    (sizeof(struct idmac_desc_64addr) *
>> -                            (i + 1))) >> 32;
>> -            /* Initialize reserved and buffer size fields to "0" */
>> -            p->des1 = 0;
>> -            p->des2 = 0;
>> -            p->des3 = 0;
>> -        }
>> -
>> -        /* Set the last descriptor as the end-of-ring descriptor */
>> -        p->des6 = host->sg_dma & 0xffffffff;
>> -        p->des7 = (u64)host->sg_dma >> 32;
>> -        p->des0 = IDMAC_DES0_ER;
>> -
>> -    } else {
>> -        struct idmac_desc *p;
>> -        /* Number of descriptors in the ring buffer */
>> -        host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc);
>> -
>> -        /* Forward link the descriptor list */
>> -        for (i = 0, p = host->sg_cpu;
>> -             i < host->ring_size - 1;
>> -             i++, p++) {
>> -            p->des3 = cpu_to_le32(host->sg_dma +
>> -                    (sizeof(struct idmac_desc) * (i + 1)));
>> -            p->des1 = 0;
>> -        }
>> -
>> -        /* Set the last descriptor as the end-of-ring descriptor */
>> -        p->des3 = cpu_to_le32(host->sg_dma);
>> -        p->des0 = cpu_to_le32(IDMAC_DES0_ER);
>> -    }
>> -
>> -    dw_mci_idmac_reset(host);
>> -
>> -    if (host->dma_64bit_address == 1) {
>> -        /* Mask out interrupts - get Tx & Rx complete only */
>> -        mci_writel(host, IDSTS64, IDMAC_INT_CLR);
>> -        mci_writel(host, IDINTEN64, SDMMC_IDMAC_INT_NI |
>> -                SDMMC_IDMAC_INT_RI | SDMMC_IDMAC_INT_TI);
>> -
>> -        /* Set the descriptor base address */
>> -        mci_writel(host, DBADDRL, host->sg_dma & 0xffffffff);
>> -        mci_writel(host, DBADDRU, (u64)host->sg_dma >> 32);
>> -
>> -    } else {
>> -        /* Mask out interrupts - get Tx & Rx complete only */
>> -        mci_writel(host, IDSTS, IDMAC_INT_CLR);
>> -        mci_writel(host, IDINTEN, SDMMC_IDMAC_INT_NI |
>> -                SDMMC_IDMAC_INT_RI | SDMMC_IDMAC_INT_TI);
>> -
>> -        /* Set the descriptor base address */
>> -        mci_writel(host, DBADDR, host->sg_dma);
>> -    }
>> -
>> -    return 0;
>> +out:
>> +    return ret;
>>  }
>>
>>  static const struct dw_mci_dma_ops dw_mci_idmac_ops = {
>>
> 
> 
