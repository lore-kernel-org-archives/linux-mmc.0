From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/1] [PATCH v4 1/1] mmc: Support of DUAL BUFFER DESC[ring]
 mode for dw_mmc
Date: Wed, 05 Oct 2011 14:07:23 +0900
Message-ID: <4E8BE60B.7070808@samsung.com>
References: <1317123568-5203-1-git-send-email-shashidharh@vayavyalabs.com>
 <4E8BBD76.9020001@samsung.com>
 <CANYdXnqeB28R_-GSOe-d83XS3=KEfaA94_FV9PepOVEkbQ7c+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:52118 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933787Ab1JEFHh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2011 01:07:37 -0400
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LSK00BSXU8N42L0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 05 Oct 2011 14:07:35 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LSK00H4XU8NIU00@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 05 Oct 2011 14:07:35 +0900 (KST)
In-reply-to: <CANYdXnqeB28R_-GSOe-d83XS3=KEfaA94_FV9PepOVEkbQ7c+A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org

Hi Shashidhar.

Ok..that's dependence with Hardware feature..right? no problem..it's
working fine..

On 10/05/2011 01:54 PM, Shashidhar Hiremath wrote:

> Hi Jaehoon,
>   First of all, thanks a lot for testing the patch.
> I think you are right in saying that the patch does not increase the
> performance considerably.
> The reason I have added the patch is that this dual descriptor mode of
> operation can be validated by this and its a Hardware feature
> supported by the IP.
> 
> And, as far as #fdef scenario is concerned, the default value for
> CHAIN_DESC is always yes .You can find this in the Kconfig file. So I
> think it still makes Chain descriptor as the default mode.

My means how did you think that change the below..

for example,

#ifdef CONFIG_MMC_DW_DUAL_BUFFER_DESC
     for (i = 0; i < sg_len; i += 2, desc++) {
#else
     for (i = 0; i < sg_len; i++, desc++) {
#endif

Then code is more cleanable..just my opinion..

Regards,
Jaehoon Chung

> 
> On Wed, Oct 5, 2011 at 7:44 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi Shashidhar.
>>
>> I tested dual-buffer descriptor with applied your patch.
>> Actually, i didn't see to improve the performance. Dose it relate with
>> the performance? i didn't sure..
>>
>> And you used #ifdef CHAIN_DESC and #ifdef DUAL_BUFFER_DESC.
>> I think if you use CHAIN_DESC by default, need not #ifdef CHAIN_DESC.
>> Because if you didn't select DUAL_BUFFER_DESC, should be work with
>> CHAIN_DESC. (i think good that using #ifdef..#else..#endif)
>>
>> Regards,
>> Jaehoon Chung
>>
>> On 09/27/2011 08:39 PM, Shashidhar Hiremath wrote:
>>
>>> This Patch adds the support for Dual Buffer Descriptor mode of
>>> Operation for the dw_mmc driver.The patch also provides the configurability
>>> Option for choosing DUAL_BUFFER mode or the chained modes through menuconfig.
>>> The Menuconfig option for selecting Dual Buffer mode or chained mode
>>> is selected only if Internal DMAC is enabled.
>>>
>>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>>> ---
>>> v2:
>>> * As per suggestions by Will Newton and James Hogan
>>> -Config symbol Names prefixed with MMC_DW
>>> -Added more Description for Config parameters added
>>> -Removed unnecessary config opion IDMAC_DESC_MODE
>>> -IDMAC_SET_BUFFER_SIZE chenged IDMAC_SET_BUFFER_SIZES
>>> -fixed typos and indented commments correctly
>>> -if ((i +1) <= sg_len changed to ((i +1) < sg_len
>>> -duplication "desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC" line removed
>>> -fixed bug in making DSL value zero
>>> -removed ANDing the des1 with zero before writing buffer lengths to it
>>> -Added proper multiline comments
>>> v3:
>>> * As per suggestions by James Hogan
>>> -Modified Config Symbol Names in the Driver File
>>> -Fixed Bug in Clearing the DSL field of BMOD register
>>> -Fixed bug in IDMAC_SET_BUFFER_SIZES
>>> v4:
>>> * After Testing the Dual Buffer Support
>>> -Modified the dma_init sequence to support Dual Buffer Mode
>>>
>>>  drivers/mmc/host/Kconfig  |   19 ++++++++++++++
>>>  drivers/mmc/host/dw_mmc.c |   58 ++++++++++++++++++++++++++++++++++++++++----
>>>  drivers/mmc/host/dw_mmc.h |    2 +
>>>  3 files changed, 73 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>> index 8c87096..dd0df83 100644
>>> --- a/drivers/mmc/host/Kconfig
>>> +++ b/drivers/mmc/host/Kconfig
>>> @@ -534,6 +534,25 @@ config MMC_DW_IDMAC
>>>         Designware Mobile Storage IP block. This disables the external DMA
>>>         interface.
>>>
>>> +choice
>>> +     prompt "select  IDMAC Descriptors Mode"
>>> +     depends on MMC_DW_IDMAC
>>> +
>>> +config MMC_DW_CHAIN_DESC
>>> +     bool "Chain Descriptor Structure"
>>> +     help
>>> +       Select this option to enable Chained Mode of Operation and the
>>> +       Chained Mode operates in a mode where only one Buffer will be used
>>> +       for each descriptor when the transfer is happening in DMA mode.
>>> +
>>> +config MMC_DW_DUAL_BUFFER_DESC
>>> +     bool "Dual Buffer Descriptor Structure"
>>> +     help
>>> +       Select this option to enable Dual Buffer Desc Mode of Operation and
>>> +       Dual Buffer Descriptor Mode or the Ring Mode indicates that two
>>> +       buffers can be used for each descriptor during DMA mode transfer.
>>> +endchoice
>>> +
>>>  config MMC_SH_MMCIF
>>>       tristate "SuperH Internal MMCIF support"
>>>       depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBILE)
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index ff0f714..ba54bb8 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -63,6 +63,8 @@ struct idmac_desc {
>>>       u32             des1;   /* Buffer sizes */
>>>  #define IDMAC_SET_BUFFER1_SIZE(d, s) \
>>>       ((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))
>>> +#define IDMAC_SET_BUFFER_SIZES(d, s1, s2) \
>>> +     (d->des1 = (((s1) & 0x1fff) | (((s2) & 0x1fff) << 13)))
>>>
>>>       u32             des2;   /* buffer 1 physical address */
>>>
>>> @@ -347,18 +349,45 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
>>>       int i;
>>>       struct idmac_desc *desc = host->sg_cpu;
>>>
>>> +#ifdef CONFIG_MMC_DW_DUAL_BUFFER_DESC
>>> +     for (i = 0; i < sg_len; i += 2, desc++) {
>>> +#endif
>>> +#ifdef CONFIG_MMC_DW_CHAIN_DESC
>>>       for (i = 0; i < sg_len; i++, desc++) {
>>> -             unsigned int length = sg_dma_len(&data->sg[i]);
>>> -             u32 mem_addr = sg_dma_address(&data->sg[i]);
>>> +#endif
>>> +             unsigned int length1 = sg_dma_len(&data->sg[i]);
>>> +             u32 mem_addr1 = sg_dma_address(&data->sg[i]);
>>> +#ifdef CONFIG_MMC_DW_DUAL_BUFFER_DESC
>>> +             unsigned int length2 = 0;
>>> +             u32 mem_addr2;
>>> +
>>> +             if ((i+1) < sg_len) {
>>> +                     length2 = sg_dma_len(&data->sg[(i+1)]);
>>> +                     mem_addr2 = sg_dma_address(&data->sg[i+1]);
>>> +             }
>>> +
>>> +             /* Set the OWN bit and disable interrupts for this descriptor
>>> +              * and disable the Chained Mode
>>> +              */
>>> +             desc->des0 = (IDMAC_DES0_OWN | IDMAC_DES0_DIC) & (~IDMAC_DES0_CH);
>>> +             /* Buffer length1 and length2 */
>>> +             IDMAC_SET_BUFFER_SIZES(desc, length1, length2);
>>> +#endif
>>> +#ifdef CONFIG_MMC_DW_CHAIN_DESC
>>>
>>>               /* Set the OWN bit and disable interrupts for this descriptor */
>>>               desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
>>>
>>> -             /* Buffer length */
>>> -             IDMAC_SET_BUFFER1_SIZE(desc, length);
>>> +             /* Buffer length1 */
>>> +             IDMAC_SET_BUFFER1_SIZE(desc, length1);
>>> +#endif
>>>
>>>               /* Physical address to DMA to/from */
>>> -             desc->des2 = mem_addr;
>>> +             desc->des2 = mem_addr1;
>>> +#ifdef CONFIG_MMC_DW_DUAL_BUFFER_DESC
>>> +             if ((i+1) < sg_len)
>>> +                     desc->des3 = mem_addr2;
>>> +#endif
>>>       }
>>>
>>>       /* Set first descriptor */
>>> @@ -366,8 +395,14 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
>>>       desc->des0 |= IDMAC_DES0_FD;
>>>
>>>       /* Set last descriptor */
>>> +#ifdef CONFIG_MMC_DW_DUAL_BUFFER_DESC
>>> +     desc = host->sg_cpu + ((i/2) - 1) * sizeof(struct idmac_desc);
>>> +     desc->des0 &= (~IDMAC_DES0_DIC);
>>> +#endif
>>> +#ifdef CONFIG_MMC_DW_CHAIN_DESC
>>>       desc = host->sg_cpu + (i - 1) * sizeof(struct idmac_desc);
>>>       desc->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
>>> +#endif
>>>       desc->des0 |= IDMAC_DES0_LD;
>>>
>>>       wmb();
>>> @@ -388,6 +423,10 @@ static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
>>>
>>>       /* Enable the IDMAC */
>>>       temp = mci_readl(host, BMOD);
>>> +#ifdef CONFIG_MMC_DW_DUAL_BUFFER_DESC
>>> +     /* The Descriptor Skip length is made zero */
>>> +     temp &= ~(SDMMC_BMOD_DSL(0x1f));
>>> +#endif
>>>       temp |= SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB;
>>>       mci_writel(host, BMOD, temp);
>>>
>>> @@ -402,13 +441,20 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>>>
>>>       /* Number of descriptors in the ring buffer */
>>>       host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc);
>>> -
>>> +#ifdef CONFIG_MMC_DW_CHAIN_DESC
>>>       /* Forward link the descriptor list */
>>>       for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++, p++)
>>>               p->des3 = host->sg_dma + (sizeof(struct idmac_desc) * (i + 1));
>>> +#endif
>>> +#ifdef CONFIG_MMC_DW_DUAL_BUFFER_DESC
>>> +     for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++)
>>> +             p++;
>>> +#endif
>>>
>>>       /* Set the last descriptor as the end-of-ring descriptor */
>>> +#ifdef CONFIG_MMC_DW_CHAIN_DESC
>>>       p->des3 = host->sg_dma;
>>> +#endif
>>>       p->des0 = IDMAC_DES0_ER;
>>>
>>>       /* Mask out interrupts - get Tx & Rx complete only */
>>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>>> index 027d377..0520dc8 100644
>>> --- a/drivers/mmc/host/dw_mmc.h
>>> +++ b/drivers/mmc/host/dw_mmc.h
>>> @@ -72,6 +72,8 @@
>>>  /* Clock Enable register defines */
>>>  #define SDMMC_CLKEN_LOW_PWR          BIT(16)
>>>  #define SDMMC_CLKEN_ENABLE           BIT(0)
>>> +/* BMOD register defines */
>>> +#define SDMMC_BMOD_DSL(n)            _SBF(2, (n))
>>>  /* time-out register defines */
>>>  #define SDMMC_TMOUT_DATA(n)          _SBF(8, (n))
>>>  #define SDMMC_TMOUT_DATA_MSK         0xFFFFFF00
>>
>>
>>
> 
> 
> 


