From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v6] mmc: dw_mmc: Add IDMAC 64-bit address mode support
Date: Thu, 16 Oct 2014 15:49:55 +0900
Message-ID: <543F6A93.1070008@samsung.com>
References: <705D14B1C7978B40A723277C067CEDE21B3336B2@IN01WEMBXB.internal.synopsys.com>
 <CAGOxZ51fzvoqUQ7=8312iLyu4jwgmskkaysgXQHju-E5EM5gNQ@mail.gmail.com>
 <CAFp+6iFQ=MU-R-mYLeL0=H5fVWkxVu5s4ineh3RcSExCUNAjCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48011 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbaJPGt7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Oct 2014 02:49:59 -0400
In-reply-to: <CAFp+6iFQ=MU-R-mYLeL0=H5fVWkxVu5s4ineh3RcSExCUNAjCA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vivek Gautam <gautam.vivek@samsung.com>, Alim Akhtar <alim.akhtar@gmail.com>
Cc: Prabu Thangamuthu <Prabu.T@synopsys.com>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>

Hi, Prabu.

On 10/15/2014 09:05 PM, Vivek Gautam wrote:
> Hi Prabu,
>=20
>=20
> On Tue, Oct 14, 2014 at 5:41 PM, Alim Akhtar <alim.akhtar@gmail.com> =
wrote:
>> Hi Prahu,
>> Thanks for a quick re-spin o the patch.
>> One last comment, this is more of a information seek.
>> On Thu, Oct 9, 2014 at 1:09 PM, Prabu Thangamuthu <Prabu.T@synopsys.=
com> wrote:
>>> Synopsys DW_MMC IP core supports Internal DMA Controller with 64-bi=
t address mode from IP version 2.70a onwards.
>>> Updated the driver to support IDMAC 64-bit addressing mode.
>>>
>>> Tested the features in DW_MMC core v2.70a and v2.40a with HAPS-51 s=
etup and driver is working fine.
>>>
>>> Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
>>> ---
>>> Change log v6:
>>>         - Updated with review comment.
>>>
>>> Change log v5:
>>>         - Recreated the patch against linux-next as this patch is r=
equired for another patch http://www.spinics.net/lists/arm-kernel/msg35=
7985.html
>>>
>>> Change log v4:
>>>         - Add the dynamic support for 32-bit and 64-bit address mod=
e based on hw configuration.
>>>         - Removed the CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS macro.
>>>
>>>  drivers/mmc/host/dw_mmc.c  |  195 ++++++++++++++++++++++++++++++++=
+++---------
>>>  drivers/mmc/host/dw_mmc.h  |   11 +++
>>>  include/linux/mmc/dw_mmc.h |    2 +
>>>  3 files changed, 170 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 69f0cc6..c3b75a5 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -62,6 +62,24 @@
>>>                                  SDMMC_IDMAC_INT_FBE | SDMMC_IDMAC_=
INT_RI | \
>>>                                  SDMMC_IDMAC_INT_TI)
>>>
>>> +struct idmac_desc_64addr {
>>> +       u32             des0;   /* Control Descriptor */
>>> +
>>> +       u32             des1;   /* Reserved */
>> What is the default value of these _Reserved_ descriptors? As these
>> are pointers, do you thing initializing then to zero make sense?
>=20
> I think the default reset value of these descriptors will depend on
> how dwmmc is integrated in h/w and how these descriptors are then
> configured.
>=20
> So it makes sense to initialize these descriptors to zero before use.
> We have seen on our exynos7 system, that we need to initialize the
> descriptors des1 and des2 to zero before we use them further.

I agreed with Vivek and Alim's comment.

And I think you can fix the below compile warning.

drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_idmac_init=E2=80=
=99:
drivers/mmc/host/dw_mmc.c:542:21: warning: right shift count >=3D width=
 of type [enabled by default]
drivers/mmc/host/dw_mmc.c:547:3: warning: right shift count >=3D width =
of type [enabled by default]
drivers/mmc/host/dw_mmc.c:575:3: warning: right shift count >=3D width =
of type [enabled by default]

I will check this patch with 2.70a and other version.

Best Regards,
Jaehoon Chung

>=20
>>> +
>>> +       u32             des2;   /*Buffer sizes */
>>> +#define IDMAC_64ADDR_SET_BUFFER1_SIZE(d, s) \
>>> +       ((d)->des2 =3D ((d)->des2 & 0x03ffe000) | ((s) & 0x1fff))
>>> +
>>> +       u32             des3;   /* Reserved */
>>> +
>>> +       u32             des4;   /* Lower 32-bits of Buffer Address =
Pointer 1*/
>>> +       u32             des5;   /* Upper 32-bits of Buffer Address =
Pointer 1*/
>>> +
>>> +       u32             des6;   /* Lower 32-bits of Next Descriptor=
 Address */
>>> +       u32             des7;   /* Upper 32-bits of Next Descriptor=
 Address */
>>> +};
>>> +
>>>  struct idmac_desc {
>>>         u32             des0;   /* Control Descriptor */
>>>  #define IDMAC_DES0_DIC BIT(1)
>>> @@ -414,30 +432,66 @@ static void dw_mci_translate_sglist(struct dw=
_mci *host, struct mmc_data *data,
>>>                                     unsigned int sg_len)
>>>  {
>>>         int i;
>>> -       struct idmac_desc *desc =3D host->sg_cpu;
>>> +       if (host->dma_64bit_address =3D=3D 1) {
>>> +               struct idmac_desc_64addr *desc =3D host->sg_cpu;
>>>
>>> -       for (i =3D 0; i < sg_len; i++, desc++) {
>>> -               unsigned int length =3D sg_dma_len(&data->sg[i]);
>>> -               u32 mem_addr =3D sg_dma_address(&data->sg[i]);
>>> +               for (i =3D 0; i < sg_len; i++, desc++) {
>>> +                       unsigned int length =3D sg_dma_len(&data->s=
g[i]);
>>> +                       u64 mem_addr =3D sg_dma_address(&data->sg[i=
]);
>>>
>>> -               /* Set the OWN bit and disable interrupts for this =
descriptor */
>>> -               desc->des0 =3D IDMAC_DES0_OWN | IDMAC_DES0_DIC | ID=
MAC_DES0_CH;
>>> +                       /*
>>> +                        * Set the OWN bit and disable interrupts f=
or this
>>> +                        * descriptor
>>> +                        */
>>> +                       desc->des0 =3D IDMAC_DES0_OWN | IDMAC_DES0_=
DIC |
>>> +                                               IDMAC_DES0_CH;
>>> +                       /* Buffer length */
>>> +                       IDMAC_64ADDR_SET_BUFFER1_SIZE(desc, length)=
;
>>> +
>>> +                       /* Physical address to DMA to/from */
>>> +                       desc->des4 =3D mem_addr & 0xffffffff;
>>> +                       desc->des5 =3D mem_addr >> 32;
>>> +               }
>>>
>>> -               /* Buffer length */
>>> -               IDMAC_SET_BUFFER1_SIZE(desc, length);
>>> +               /* Set first descriptor */
>>> +               desc =3D host->sg_cpu;
>>> +               desc->des0 |=3D IDMAC_DES0_FD;
>>>
>>> -               /* Physical address to DMA to/from */
>>> -               desc->des2 =3D mem_addr;
>>> -       }
>>> +               /* Set last descriptor */
>>> +               desc =3D host->sg_cpu + (i - 1) *
>>> +                               sizeof(struct idmac_desc_64addr);
>>> +               desc->des0 &=3D ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
>>> +               desc->des0 |=3D IDMAC_DES0_LD;
>>> +
>>> +       } else {
>>> +               struct idmac_desc *desc =3D host->sg_cpu;
>>> +
>>> +               for (i =3D 0; i < sg_len; i++, desc++) {
>>> +                       unsigned int length =3D sg_dma_len(&data->s=
g[i]);
>>> +                       u32 mem_addr =3D sg_dma_address(&data->sg[i=
]);
>>> +
>>> +                       /*
>>> +                        * Set the OWN bit and disable interrupts f=
or this
>>> +                        * descriptor
>>> +                        */
>>> +                       desc->des0 =3D IDMAC_DES0_OWN | IDMAC_DES0_=
DIC |
>>> +                                               IDMAC_DES0_CH;
>>> +                       /* Buffer length */
>>> +                       IDMAC_SET_BUFFER1_SIZE(desc, length);
>>> +
>>> +                       /* Physical address to DMA to/from */
>>> +                       desc->des2 =3D mem_addr;
>>> +               }
>>>
>>> -       /* Set first descriptor */
>>> -       desc =3D host->sg_cpu;
>>> -       desc->des0 |=3D IDMAC_DES0_FD;
>>> +               /* Set first descriptor */
>>> +               desc =3D host->sg_cpu;
>>> +               desc->des0 |=3D IDMAC_DES0_FD;
>>>
>>> -       /* Set last descriptor */
>>> -       desc =3D host->sg_cpu + (i - 1) * sizeof(struct idmac_desc)=
;
>>> -       desc->des0 &=3D ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
>>> -       desc->des0 |=3D IDMAC_DES0_LD;
>>> +               /* Set last descriptor */
>>> +               desc =3D host->sg_cpu + (i - 1) * sizeof(struct idm=
ac_desc);
>>> +               desc->des0 &=3D ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
>>> +               desc->des0 |=3D IDMAC_DES0_LD;
>>> +       }
>>>
>>>         wmb();
>>>  }
>>> @@ -466,29 +520,67 @@ static void dw_mci_idmac_start_dma(struct dw_=
mci *host, unsigned int sg_len)
>>>
>>>  static int dw_mci_idmac_init(struct dw_mci *host)
>>>  {
>>> -       struct idmac_desc *p;
>>>         int i;
>>>
>>> -       /* Number of descriptors in the ring buffer */
>>> -       host->ring_size =3D PAGE_SIZE / sizeof(struct idmac_desc);
>>> +       if (host->dma_64bit_address =3D=3D 1) {
>>> +               struct idmac_desc_64addr *p;
>>> +               /* Number of descriptors in the ring buffer */
>>> +               host->ring_size =3D PAGE_SIZE / sizeof(struct idmac=
_desc_64addr);
>>> +
>>> +               /* Forward link the descriptor list */
>>> +               for (i =3D 0, p =3D host->sg_cpu; i < host->ring_si=
ze - 1;
>>> +                                                               i++=
, p++) {
>>> +                       p->des6 =3D (host->sg_dma +
>>> +                                       (sizeof(struct idmac_desc_6=
4addr) *
>>> +                                                       (i + 1))) &=
 0xffffffff;
>>> +
>>> +                       p->des7 =3D (host->sg_dma +
>>> +                                       (sizeof(struct idmac_desc_6=
4addr) *
>>> +                                                       (i + 1))) >=
> 32;
>>> +               }
>>> +
>>> +               /* Set the last descriptor as the end-of-ring descr=
iptor */
>>> +               p->des6 =3D host->sg_dma & 0xffffffff;
>>> +               p->des7 =3D host->sg_dma >> 32;
>>> +               p->des0 =3D IDMAC_DES0_ER;
>>> +
>>> +       } else {
>>> +               struct idmac_desc *p;
>>> +               /* Number of descriptors in the ring buffer */
>>> +               host->ring_size =3D PAGE_SIZE / sizeof(struct idmac=
_desc);
>>>
>>> -       /* Forward link the descriptor list */
>>> -       for (i =3D 0, p =3D host->sg_cpu; i < host->ring_size - 1; =
i++, p++)
>>> -               p->des3 =3D host->sg_dma + (sizeof(struct idmac_des=
c) * (i + 1));
>>> +               /* Forward link the descriptor list */
>>> +               for (i =3D 0, p =3D host->sg_cpu; i < host->ring_si=
ze - 1; i++, p++)
>>> +                       p->des3 =3D host->sg_dma + (sizeof(struct i=
dmac_desc) *
>>> +                                                               (i =
+ 1));
>>>
>>> -       /* Set the last descriptor as the end-of-ring descriptor */
>>> -       p->des3 =3D host->sg_dma;
>>> -       p->des0 =3D IDMAC_DES0_ER;
>>> +               /* Set the last descriptor as the end-of-ring descr=
iptor */
>>> +               p->des3 =3D host->sg_dma;
>>> +               p->des0 =3D IDMAC_DES0_ER;
>>> +       }
>>>
>>>         dw_mci_idmac_reset(host);
>>>
>>> -       /* Mask out interrupts - get Tx & Rx complete only */
>>> -       mci_writel(host, IDSTS, IDMAC_INT_CLR);
>>> -       mci_writel(host, IDINTEN, SDMMC_IDMAC_INT_NI | SDMMC_IDMAC_=
INT_RI |
>>> -                  SDMMC_IDMAC_INT_TI);
>>> +       if (host->dma_64bit_address =3D=3D 1) {
>>> +               /* Mask out interrupts - get Tx & Rx complete only =
*/
>>> +               mci_writel(host, IDSTS64, IDMAC_INT_CLR);
>>> +               mci_writel(host, IDINTEN64, SDMMC_IDMAC_INT_NI |
>>> +                               SDMMC_IDMAC_INT_RI | SDMMC_IDMAC_IN=
T_TI);
>>> +
>>> +               /* Set the descriptor base address */
>>> +               mci_writel(host, DBADDRL, host->sg_dma & 0xffffffff=
);
>>> +               mci_writel(host, DBADDRU, host->sg_dma >> 32);
>>> +
>>> +       } else {
>>> +               /* Mask out interrupts - get Tx & Rx complete only =
*/
>>> +               mci_writel(host, IDSTS, IDMAC_INT_CLR);
>>> +               mci_writel(host, IDINTEN, SDMMC_IDMAC_INT_NI |
>>> +                               SDMMC_IDMAC_INT_RI | SDMMC_IDMAC_IN=
T_TI);
>>> +
>>> +               /* Set the descriptor base address */
>>> +               mci_writel(host, DBADDR, host->sg_dma);
>>> +       }
>>>
>>> -       /* Set the descriptor base address */
>>> -       mci_writel(host, DBADDR, host->sg_dma);
>>>         return 0;
>>>  }
>>>
>>> @@ -2045,11 +2137,22 @@ static irqreturn_t dw_mci_interrupt(int irq=
, void *dev_id)
>>>
>>>  #ifdef CONFIG_MMC_DW_IDMAC
>>>         /* Handle DMA interrupts */
>>> -       pending =3D mci_readl(host, IDSTS);
>>> -       if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
>>> -               mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI | SDMMC_=
IDMAC_INT_RI);
>>> -               mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
>>> -               host->dma_ops->complete(host);
>>> +       if (host->dma_64bit_address =3D=3D 1) {
>>> +               pending =3D mci_readl(host, IDSTS64);
>>> +               if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT=
_RI)) {
>>> +                       mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_T=
I |
>>> +                                                       SDMMC_IDMAC=
_INT_RI);
>>> +                       mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_N=
I);
>>> +                       host->dma_ops->complete(host);
>>> +               }
>>> +       } else {
>>> +               pending =3D mci_readl(host, IDSTS);
>>> +               if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT=
_RI)) {
>>> +                       mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI =
|
>>> +                                                       SDMMC_IDMAC=
_INT_RI);
>>> +                       mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI)=
;
>>> +                       host->dma_ops->complete(host);
>>> +               }
>>>         }
>>>  #endif
>>>
>>> @@ -2309,6 +2412,22 @@ static void dw_mci_cleanup_slot(struct dw_mc=
i_slot *slot, unsigned int id)
>>>
>>>  static void dw_mci_init_dma(struct dw_mci *host)
>>>  {
>>> +       int addr_config;
>>> +       /* Check ADDR_CONFIG bit in HCON to find IDMAC address bus =
width */
>>> +       addr_config =3D (mci_readl(host, HCON) >> 27) & 0x01;
>>> +
>>> +       if (addr_config =3D=3D 1) {
>>> +               /* host supports IDMAC in 64-bit address mode */
>>> +               host->dma_64bit_address =3D 1;
>>> +               dev_info(host->dev, "IDMAC supports 64-bit address =
mode.\n");
>>> +               if (!dma_set_mask(host->dev, DMA_BIT_MASK(64)))
>>> +                       dma_set_coherent_mask(host->dev, DMA_BIT_MA=
SK(64));
>>> +       } else {
>>> +               /* host supports IDMAC in 32-bit address mode */
>>> +               host->dma_64bit_address =3D 0;
>>> +               dev_info(host->dev, "IDMAC supports 32-bit address =
mode.\n");
>>> +       }
>>> +
>>>         /* Alloc memory for sg translation */
>>>         host->sg_cpu =3D dmam_alloc_coherent(host->dev, PAGE_SIZE,
>>>                                           &host->sg_dma, GFP_KERNEL=
);
>>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>>> index 01b99e8..64b04aa 100644
>>> --- a/drivers/mmc/host/dw_mmc.h
>>> +++ b/drivers/mmc/host/dw_mmc.h
>>> @@ -55,6 +55,17 @@
>>>  #define SDMMC_BUFADDR          0x098
>>>  #define SDMMC_CDTHRCTL         0x100
>>>  #define SDMMC_DATA(x)          (x)
>>> +/*
>>> +* Registers to support idmac 64-bit address mode
>>> +*/
>>> +#define SDMMC_DBADDRL          0x088
>>> +#define SDMMC_DBADDRU          0x08c
>>> +#define SDMMC_IDSTS64          0x090
>>> +#define SDMMC_IDINTEN64                0x094
>>> +#define SDMMC_DSCADDRL         0x098
>>> +#define SDMMC_DSCADDRU         0x09c
>>> +#define SDMMC_BUFADDRL         0x0A0
>>> +#define SDMMC_BUFADDRU         0x0A4
>>>
>>>  /*
>>>   * Data offset is difference according to Version
>>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.=
h
>>> index 0013669..9e6eabb 100644
>>> --- a/include/linux/mmc/dw_mmc.h
>>> +++ b/include/linux/mmc/dw_mmc.h
>>> @@ -54,6 +54,7 @@ struct mmc_data;
>>>   *     transfer is in progress.
>>>   * @use_dma: Whether DMA channel is initialized or not.
>>>   * @using_dma: Whether DMA is in use for the current transfer.
>>> + * @dma_64bit_address: Whether DMA supports 64-bit address mode or=
 not.
>>>   * @sg_dma: Bus address of DMA buffer.
>>>   * @sg_cpu: Virtual address of DMA buffer.
>>>   * @dma_ops: Pointer to platform-specific DMA callbacks.
>>> @@ -140,6 +141,7 @@ struct dw_mci {
>>>         /* DMA interface members*/
>>>         int                     use_dma;
>>>         int                     using_dma;
>>> +       int                     dma_64bit_address;
>>>
>>>         dma_addr_t              sg_dma;
>>>         void                    *sg_cpu;
>>> --
>>> 1.7.6.5
>>>
>>
>>
>>
>> --
>> Regards,
>> Alim
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>=20
>=20
>=20

