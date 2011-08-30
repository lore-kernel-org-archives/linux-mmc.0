From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH v2 1/1] mmc: Support of DUAL BUFFER DESC[ring] mode for dw_mmc
Date: Tue, 30 Aug 2011 15:20:54 +0530
Message-ID: <CANYdXnqUthTCCT+XW1M5_Eu-Q1xzwVkeMk=S2W0sQF92TZtF=w@mail.gmail.com>
References: <1314692959-4139-1-git-send-email-shashidharh@vayavyalabs.com>
	<4E5CA5A1.1060901@imgtec.com>
	<CANYdXno-9ibC5RJQGOknKX6tEnQHS_z2ruuXxtkyJPfy-9iphg@mail.gmail.com>
	<4E5CB1BE.5060903@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:47731 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab1H3Juz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2011 05:50:55 -0400
Received: by yie30 with SMTP id 30so4233285yie.19
        for <linux-mmc@vger.kernel.org>; Tue, 30 Aug 2011 02:50:55 -0700 (PDT)
In-Reply-To: <4E5CB1BE.5060903@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

OK,got it .Sorry for the confusion.Will make the change.

On Tue, Aug 30, 2011 at 3:17 PM, James Hogan <james.hogan@imgtec.com> w=
rote:
> Hi
>
> On 08/30/2011 10:40 AM, Shashidhar Hiremath wrote:
>> thanks for the reply James.
>> Please find my comments below:
>> On Tue, Aug 30, 2011 at 2:26 PM, James Hogan <james.hogan@imgtec.com=
> wrote:
>>> Hi Shashidhar
>>>
>>> Thanks for the updated patch.
>>>
>>> On 08/30/2011 09:29 AM, Shashidhar Hiremath wrote:
>>>> This Patch adds the support for Dual Buffer Descriptor mode of
>>>> Operation for the dw_mmc driver.The patch also provides the config=
urability
>>>> Option for choosing DUAL_BUFFER mode or the chained modes through =
menuconfig.
>>>> The Menuconfig option for selecting Dual Buffer mode or chained mo=
de
>>>> is selected only if Internal DMAC is enabled.
>>>>
>>>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>>>> ---
>>>> v2:
>>>> * As per suggestions by Will Newton and James Hogan
>>>> -Config symbol Names prefixed with MMC_DW
>>>> -Added more Description for Config parameters added
>>>> -Removed unnecessary config opion IDMAC_DESC_MODE
>>>> -IDMAC_SET_BUFFER_SIZE chenged IDMAC_SET_BUFFER_SIZES
>>>> -fixed typos and indented commments correctly
>>>> -if ((i +1) <=3D sg_len changed to ((i +1) < sg_len
>>>> -duplication "desc->des0 =3D IDMAC_DES0_OWN | IDMAC_DES0_DIC" line=
 removed
>>>> -fixed bug in making DSL value zero
>>>> -removed ANDing the des1 with zero before writing buffer lengths t=
o it
>>>> -Added proper multiline comments
>>>> ---
>>>> =C2=A0drivers/mmc/host/Kconfig =C2=A0| =C2=A0 19 +++++++++++++++++
>>>> =C2=A0drivers/mmc/host/dw_mmc.c | =C2=A0 49 ++++++++++++++++++++++=
+++++++++++++---------
>>>> =C2=A0drivers/mmc/host/dw_mmc.h | =C2=A0 =C2=A02 +
>>>> =C2=A03 files changed, 60 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>>> index 8c87096..1e20dfa 100644
>>>> --- a/drivers/mmc/host/Kconfig
>>>> +++ b/drivers/mmc/host/Kconfig
>>>> @@ -534,6 +534,25 @@ config MMC_DW_IDMAC
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Designware Mobile Storage IP block. Th=
is disables the external DMA
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 interface.
>>>>
>>>> +choice
>>>> + =C2=A0 =C2=A0 prompt "select =C2=A0IDMAC Descriptors Mode"
>>>> + =C2=A0 =C2=A0 depends on MMC_DW_IDMAC
>>>> +
>>>> +config MMC_DW_CHAIN_DESC
>>>> + =C2=A0 =C2=A0 bool "Chain Descriptor Structure"
>>>> + =C2=A0 =C2=A0 help
>>>> + =C2=A0 =C2=A0 =C2=A0 Select this option to enable Chained Mode o=
f Operation and the
>>>> + =C2=A0 =C2=A0 =C2=A0 Chained Mode operates in a mode where only =
one Buffer will be used
>>>> + =C2=A0 =C2=A0 =C2=A0 for each descriptor when the transfer is ha=
ppening in DMA mode.
>>>> +
>>>> +config MMC_DW_DUAL_BUFFER_DESC
>>>> + =C2=A0 =C2=A0 bool "Dual Buffer Descriptor Structure"
>>>> + =C2=A0 =C2=A0 help
>>>> + =C2=A0 =C2=A0 =C2=A0 Select this option to enable Dual Buffer De=
sc Mode of Operation and
>>>> + =C2=A0 =C2=A0 =C2=A0 Dual Buffer Descriptor Mode or the Ring Mod=
e indicates that two
>>>> + =C2=A0 =C2=A0 =C2=A0 buffers can be used for each descriptor dur=
ing DMA mode transfer.
>>>> +endchoice
>>>> +
>>>> =C2=A0config MMC_SH_MMCIF
>>>> =C2=A0 =C2=A0 =C2=A0 tristate "SuperH Internal MMCIF support"
>>>> =C2=A0 =C2=A0 =C2=A0 depends on MMC_BLOCK && (SUPERH || ARCH_SHMOB=
ILE)
>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>> index ff0f714..ee02208 100644
>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>> @@ -63,6 +63,9 @@ struct idmac_desc {
>>>> =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 des1; =C2=A0 /* Buffer sizes */
>>>> =C2=A0#define IDMAC_SET_BUFFER1_SIZE(d, s) \
>>>> =C2=A0 =C2=A0 =C2=A0 ((d)->des1 =3D ((d)->des1 & 0x03ffe000) | ((s=
) & 0x1fff))
>>>> +#define IDMAC_SET_BUFFER_SIZES(d, s1, s2) \
>>>> + =C2=A0 =C2=A0 ((d)->des1 =3D (((d)->des1) =C2=A0| \
>>>> + =C2=A0 =C2=A0 (((s1) & 0x1fff) | ((s2) & 0x1fff << 13))))
>>>
>>> This still doesn't look right. The fields which get OR'd in don't g=
et
>>> cleared first, so if there is already a value you'll get the OR of =
the
>>> old and new value. I think you were correct before in masking with =
0,
>>> but that means you can entirely drop the reference to (d)->des1, si=
nce
>>> the new value doesn't depend on the old value.
>>
>> Ok,So is it Ok if I mask it with zero and then OR the values since
>> there is no other value to be written to des1.
>
> The point I'm trying to make is that the result of masking with zero =
is
> always 0, and if you OR a value onto 0, the result is always that val=
ue
>
> Therefore what you suggest:
> #define IDMAC_SET_BUFFER_SIZES(d, s1, s2) \
> =C2=A0 =C2=A0 ((d)->des1 =3D (((d)->des1 & 0x0) =C2=A0| \
> =C2=A0 =C2=A0 (((s1) & 0x1fff) | ((s2) & 0x1fff << 13))))
>
> is the same as:
> #define IDMAC_SET_BUFFER_SIZES(d, s1, s2) \
> =C2=A0 =C2=A0 ((d)->des1 =3D ((s1) & 0x1fff) | ((s2) & 0x1fff << 13))
>
> but the latter is simpler and more readable.
>
> Thanks
> James
>
>>
>>>
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 des2; =C2=A0 /* buffer 1 physical address */
>>>>
>>>> @@ -348,17 +351,38 @@ static void dw_mci_translate_sglist(struct d=
w_mci *host, struct mmc_data *data,
>>>> =C2=A0 =C2=A0 =C2=A0 struct idmac_desc *desc =3D host->sg_cpu;
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < sg_len; i++, desc++) {
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int length =3D=
 sg_dma_len(&data->sg[i]);
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 mem_addr =3D sg_dm=
a_address(&data->sg[i]);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Length and mem_addr=
ess of first buffer */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int length1 =3D=
 sg_dma_len(&data->sg[i]);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 mem_addr1 =3D sg_d=
ma_address(&data->sg[i]);
>>>> +#ifdef CONFIG_DUAL_BUFFER_DESC
>>>
>>> don't forget to rename the configs here too.
>> Will rename the configs
>>>
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int length2;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 mem_addr2;
>>>>
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set the OWN bit and=
 disable interrupts for this descriptor */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Set the OWN bi=
t and disable interrupts
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* for this descr=
iptor
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->des0 =3D IDMAC_D=
ES0_OWN | IDMAC_DES0_DIC
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((i+1) < sg_len) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 length2 =3D sg_dma_len(&data->sg[i+1]);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mem_addr2 =3D sg_dma_address(&data->sg[i+1]);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Buffer length being set for Buffer1 and Buffer2 */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 IDMAC_SET_BUFFER_SIZES(desc, length1, length2);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 desc->des3 =3D mem_addr2;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Incrementing for the second buffer */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 i++;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Buffer length being set for Buffer1 and Buffer2 */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 IDMAC_SET_BUFFER_SIZES(desc, length1, 0);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>> +#elif CONFIG_CHAIN_DESC
>>>
>>> here too
>>>
>> will rename configs
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set OWN bit and dis=
able interrupts for this descriptor */
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->des0 =3D ID=
MAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
>>>> -
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Buffer length */
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IDMAC_SET_BUFFER1_SIZE=
(desc, length);
>>>> -
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Buffer length for B=
uffer1 */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IDMAC_SET_BUFFER1_SIZE=
(desc, length1);
>>>> +#endif
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Physical addre=
ss to DMA to/from */
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->des2 =3D mem_add=
r;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->des2 =3D mem_add=
r1;
>>>> =C2=A0 =C2=A0 =C2=A0 }
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 /* Set first descriptor */
>>>> @@ -369,6 +393,10 @@ static void dw_mci_translate_sglist(struct dw=
_mci *host, struct mmc_data *data,
>>>> =C2=A0 =C2=A0 =C2=A0 desc =3D host->sg_cpu + (i - 1) * sizeof(stru=
ct idmac_desc);
>>>> =C2=A0 =C2=A0 =C2=A0 desc->des0 &=3D ~(IDMAC_DES0_CH | IDMAC_DES0_=
DIC);
>>>> =C2=A0 =C2=A0 =C2=A0 desc->des0 |=3D IDMAC_DES0_LD;
>>>> +#ifdef CONFIG_DUAL_BUFFER_DESC
>>>
>>> and here
>>>
>>>> + =C2=A0 =C2=A0 /* Set the End of Ring bit */
>>>> + =C2=A0 =C2=A0 desc->des0 |=3D IDMAC_DES0_ER;
>>>> +#endif
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 wmb();
>>>> =C2=A0}
>>>> @@ -388,7 +416,8 @@ static void dw_mci_idmac_start_dma(struct dw_m=
ci *host, unsigned int sg_len)
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 /* Enable the IDMAC */
>>>> =C2=A0 =C2=A0 =C2=A0 temp =3D mci_readl(host, BMOD);
>>>> - =C2=A0 =C2=A0 temp |=3D SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB;
>>>> + =C2=A0 =C2=A0 /* The Descriptor Skip length is made zero */
>>>> + =C2=A0 =C2=A0 temp |=3D SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB | SD=
MMC_BMOD_DSL(0);
>>>
>>> this won't actually set the DSL to zero (you cannot clear bits with=
 a |=3D
>>> operator. You probably want to clear the DSL bits in temp, and then=
 OR
>>> in the new DSL value (or not in the case of setting it to 0).
>> Will clear DSL fields and then OR it as it will make it more generic=
=2E
>>>
>>>> =C2=A0 =C2=A0 =C2=A0 mci_writel(host, BMOD, temp);
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 /* Start it running */
>>>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>>>> index 027d377..0520dc8 100644
>>>> --- a/drivers/mmc/host/dw_mmc.h
>>>> +++ b/drivers/mmc/host/dw_mmc.h
>>>> @@ -72,6 +72,8 @@
>>>> =C2=A0/* Clock Enable register defines */
>>>> =C2=A0#define SDMMC_CLKEN_LOW_PWR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
BIT(16)
>>>> =C2=A0#define SDMMC_CLKEN_ENABLE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 BIT(0)
>>>> +/* BMOD register defines */
>>>> +#define SDMMC_BMOD_DSL(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
_SBF(2, (n))
>>>> =C2=A0/* time-out register defines */
>>>> =C2=A0#define SDMMC_TMOUT_DATA(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
_SBF(8, (n))
>>>> =C2=A0#define SDMMC_TMOUT_DATA_MSK =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xF=
=46FFFF00
>>>
>>> Cheers
>>> James
>>>
>>>
>>
>>
>>
>
>



--=20
regards,
Shashidhar Hiremath
