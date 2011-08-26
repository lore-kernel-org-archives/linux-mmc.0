From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 1/1] mmc: Support of DUAL BUFFER DESC[ring] mode for dw_mmc
Date: Fri, 26 Aug 2011 21:04:37 +0100
Message-ID: <CAAG0J995gjuMfvZog+gUqNK9tTQDXREqF7fgFBZa=bsR7QH4ag@mail.gmail.com>
References: <CANYdXno+b6ZZ=3upGMwYxxbJMbKSteWKGM=RxtKhSOYr3iov4g@mail.gmail.com>
	<4E57A22A.7050604@imgtec.com>
	<CANYdXnoKJxo+Q8gwfbXbeaADK_HuPNnV2YjfqkVSNsCCFy3x5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44610 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730Ab1HZUEi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Aug 2011 16:04:38 -0400
Received: by vws1 with SMTP id 1so3226266vws.19
        for <linux-mmc@vger.kernel.org>; Fri, 26 Aug 2011 13:04:37 -0700 (PDT)
In-Reply-To: <CANYdXnoKJxo+Q8gwfbXbeaADK_HuPNnV2YjfqkVSNsCCFy3x5A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: James Hogan <james.hogan@imgtec.com>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

Hi

On 26 August 2011 19:06, Shashidhar Hiremath
<shashidharh@vayavyalabs.com> wrote:
> Hi James,
> =A0thanks a lot for the reply.
> =A0I will fix all the indentation issues as well.Please find my
> comments/queries below:
>
> On Fri, Aug 26, 2011 at 7:09 PM, James Hogan <james.hogan@imgtec.com>=
 wrote:
>> Hi,
>>
>> Thanks for sending the patch.
>>
>> On 08/26/2011 11:31 AM, Shashidhar Hiremath wrote:
>>> This Patch adds the support for Dual Buffer Descriptor mode of
>>> Operation for the dw_mmc driver.The patch also provides the configu=
rability
>>> Option for choosing DUAL_BUFFER mode or the chained modes through m=
enuconfig.
>>> The Menuconfig option for selecting Dual Buffer mode or chained mod=
e
>>> is selected only if
>>> Internal DMAC is enabled.
>>>
>>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>>> ---
>>> =A0drivers/mmc/host/Kconfig =A0| =A0 22 ++++++++++++++++++
>>> =A0drivers/mmc/host/dw_mmc.c | =A0 55 +++++++++++++++++++++++++++++=
+++++++--------
>>> =A02 files changed, 67 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>> index 8c87096..e10f585 100644
>>> --- a/drivers/mmc/host/Kconfig
>>> +++ b/drivers/mmc/host/Kconfig
>>> @@ -534,6 +534,28 @@ config MMC_DW_IDMAC
>>> =A0 =A0 =A0 =A0 Designware Mobile Storage IP block. This disables t=
he external DMA
>>> =A0 =A0 =A0 =A0 interface.
>>>
>>> +config IDMAC_DESC_MODE
>>
>> I think this config needs to be more specific, otherwise it could
>> conflict with drivers for other hardware with an internal DMAC, i.e.
>> something like MMC_DW_IDMAC_DESC_MODE.
>>
>>> + =A0 =A0 bool "Internal DMAC Descriptor Operating Mode"
>>> + =A0 =A0 depends on MMC_DW_IDMAC
>>> + =A0 =A0 help
>>> + =A0 =A0 =A0 This selects the Operating mode for the Descriptors.
>>
>> Am I right that there are 3 modes, dual buffer, chain descriptor, an=
d
>> something else?
>> This config option doesn't seem necessary. I would put "optional" in=
 the
>> choice below, or add a choice for whatever the mode is called when
>> neither option is selected.
>> If there are only the two options, don't have the choice depend on
>> IDMAC_DESC_MODE, otherwise if you don't select it, neither of the
>> choices will be set.
>>
> There are only two modes actually,and one of them has to be selected
> is MMC_DW_IDMAC is seleced i'e If Internal DMAC is selected ,only
> then ,the usage of descriptors and its modes used here come into
> picture.
> So, Is it OK if I add the choice options within MMC_DW_IDMAC option
> which reprsents internal DMAC selected ?

yes, that sounds good.

>>> +
>>> +choice
>>> + =A0 =A0 prompt "select configuration"
>>> + =A0 =A0 depends on IDMAC_DESC_MODE
>>> +
>>> +config CHAIN_DESC
>>
>> same here (config name)
>>
>>> + =A0 =A0 bool "Chain Descriptor Structure"
>>> + =A0 =A0 help
>>> + =A0 =A0 =A0 Select this option to enable Chained Mode of Operatio=
n.
>>> +
>>> +config DUAL_BUFFER_DESC
>>
>> same here (config name)
>>
>>> + =A0 =A0 bool "Dual Buffer Descriptor Structure"
>>> + =A0 =A0 help
>>> + =A0 =A0 =A0 Select this option to enable Dual Buffer Desc Mode of=
 Operation.
>>> +endchoice
>>> +
>>> +
>>
>> probably no need for the extra newline
>>
>>> =A0config MMC_SH_MMCIF
>>> =A0 =A0 =A0 tristate "SuperH Internal MMCIF support"
>>> =A0 =A0 =A0 depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBILE)
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index ff0f714..a590856 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -63,6 +63,9 @@ struct idmac_desc {
>>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 des1; =A0 /* Buffer sizes *=
/
>>> =A0#define IDMAC_SET_BUFFER1_SIZE(d, s) \
>>> =A0 =A0 =A0 ((d)->des1 =3D ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff=
))
>>> +#define IDMAC_SET_BUFFER_SIZE(d, s1, s2) \
>>> + =A0 =A0 ((d)->des1 =3D ((d)->des1 & 0x0) | \
>>
>> Do you mean to & with 0 there?
> Yes, I have made the desc1 '0' first and then I have ORed the length'=
s
> of Buffer1 and Buffer2 appropriately as below.The reason I have ANDed
> with zero is to remove any junk value present in descriptors.

But (((d)->des1 & 0x0) | X) =3D=3D (0x0 | X) =3D=3D X , so you don't ne=
ed it.

>
>>
>>> + =A0 =A0 (((s1) & 0x1fff) | ((s2) & 0x1fff << 13)))
>>>
>>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 des2; =A0 /* buffer 1 physi=
cal address */
>>>
>>> @@ -348,17 +351,44 @@ static void dw_mci_translate_sglist(struct
>>> dw_mci *host, struct mmc_data *data,
>>> =A0 =A0 =A0 struct idmac_desc *desc =3D host->sg_cpu;
>>>
>>> =A0 =A0 =A0 for (i =3D 0; i < sg_len; i++, desc++) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 unsigned int length =3D sg_dma_len(&data-=
>sg[i]);
>>> - =A0 =A0 =A0 =A0 =A0 =A0 u32 mem_addr =3D sg_dma_address(&data->sg=
[i]);
>>> -
>>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Set the OWN bit and disable interrupts=
 for this descriptor */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 /*length and mem_aadress of first buffer*=
/
>>
>> it'd be nice to have a space after /* and before */ to be consistent=
=2E
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int length1 =3D sg_dma_len(&data=
->sg[i]);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 mem_addr1 =3D sg_dma_address(&data->s=
g[i]);
>>> +#ifdef CONFIG_DUAL_BUFFER_DESC
>>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int length2;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 mem_addr2;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((i+1) <=3D sg_len) {
>>
>> should that be "< sg_len", it never hit sg[sg_len] before, but it wi=
ll
>> below?
> Yes, You are right, I will make the change.
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 length2 =3D sg_dma_len(&d=
ata->sg[i+1]);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mem_addr2 =3D sg_dma_addr=
ess(&data->sg[i+1]);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the OWN bit and di=
sable interrupts
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* for this descriptor
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>
>> the coding style says to have multiline comments with nothing on the
>> first line, i.e.
>> /*
>> =A0* Set the OWN ....
>> =A0* ....
>> =A0*/
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des0 =3D IDMAC_DES0=
_OWN | IDMAC_DES0_DIC
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des0 &=3D (~IDMAC_D=
ES0_CH);
>>
>> is this line necessary, since you only just set it without that bit.
> Yes, agreed.I will make the change.
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Buffer length being se=
t for Buffer1
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and Buffer2 being se=
t
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>
>> same here (multiline comment)
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IDMAC_SET_BUFFER_SIZE(des=
c, length1, length2);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des3 =3D mem_addr2;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Incrementing for the s=
econd buffer */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des0 =3D IDMAC_DES0=
_OWN | IDMAC_DES0_DIC
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des0 &=3D (~IDMAC_D=
ES0_CH);
>>
>> same here (necessary?)
> Agreed,not necessary.I will make the change.
>>
>> Also, should this be the same as the non-dual case (also have
>> IDMAC_DES0_CH), since there is only one sg buffer left?
> Please correct me If I am wrong here.I feel since we select the mode
> for one complee transfer.I have reset it and made the second buffer
> length zero,If dynamic switching to chained mode is possible,I can
> probably make it same as for non dual case.

I don't know off the top of my head. I'd have to check the TRM.

>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Buffer length being se=
t for Buffer1
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and Buffer2 being se=
t
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>
>> same here (multiline comment)
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IDMAC_SET_BUFFER_SIZE(des=
c, length1, 0);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> +#elif CONFIG_CHAIN_DESC
>>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Set OWN bit and disable interrupts for=
 this descriptor */
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des0 =3D IDMAC_DES0_OWN | IDMAC_D=
ES0_DIC | IDMAC_DES0_CH;
>>> -
>>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Buffer length */
>>> - =A0 =A0 =A0 =A0 =A0 =A0 IDMAC_SET_BUFFER1_SIZE(desc, length);
>>> -
>>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Buffer length for Buffer1*/
>>
>> same here (comment spacing)
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 IDMAC_SET_BUFFER1_SIZE(desc, length1);
>>> +#endif
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Physical address to DMA to/from */
>>> - =A0 =A0 =A0 =A0 =A0 =A0 desc->des2 =3D mem_addr;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 desc->des2 =3D mem_addr1;
>>> =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 /* Set first descriptor */
>>> @@ -369,6 +399,10 @@ static void dw_mci_translate_sglist(struct dw_=
mci
>>> *host, struct mmc_data *data,
>>> =A0 =A0 =A0 desc =3D host->sg_cpu + (i - 1) * sizeof(struct idmac_d=
esc);
>>> =A0 =A0 =A0 desc->des0 &=3D ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
>>> =A0 =A0 =A0 desc->des0 |=3D IDMAC_DES0_LD;
>>> +#ifdef CONFIG_DUAL_BUFFER_DESC
>>> + =A0 =A0 /*Set the End of Ring bit */
>>
>> same here (comment spacing)
>>
>>> + =A0 =A0 desc->des0 |=3D IDMAC_DES0_ER;
>>> +#endif
>>>
>>> =A0 =A0 =A0 wmb();
>>> =A0}
>>> @@ -388,7 +422,8 @@ static void dw_mci_idmac_start_dma(struct dw_mc=
i
>>> *host, unsigned int sg_len)
>>>
>>> =A0 =A0 =A0 /* Enable the IDMAC */
>>> =A0 =A0 =A0 temp =3D mci_readl(host, BMOD);
>>> - =A0 =A0 temp |=3D SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB;
>>> + =A0 =A0 /* The Descriptor Skip length is made zero */
>>> + =A0 =A0 temp |=3D SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB & SDMMC_BMO=
D_DSL(0);
>>
>> should that be a | instead of &?
> Yes, will make this change.
>>
>> Also, where is SDMMC_BMOD_DSL defined?

I couldn't find this definition in LXR, has the header file with it
been missed from the patch?

Chees
James

>>
>>> =A0 =A0 =A0 mci_writel(host, BMOD, temp);
>>>
>>> =A0 =A0 =A0 /* Start it running */
