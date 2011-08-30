From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH v2 1/1] mmc: Support of DUAL BUFFER DESC[ring] mode for dw_mmc
Date: Tue, 30 Aug 2011 19:25:09 +0530
Message-ID: <CANYdXnpYWgChEEG=2pefY76gg49eZXwGBh1w1Mm+wkQh-DZ-NQ@mail.gmail.com>
References: <1314692959-4139-1-git-send-email-shashidharh@vayavyalabs.com>
	<CAH9JG2UjZjiwdWNkk+d1hrgK=7O_WtpDBCT92yja683eAjZ+xA@mail.gmail.com>
	<CANYdXnoZsN-1aGmpuJoDSbgCK4-6ZisKORJtFJfG1zx5L_znMg@mail.gmail.com>
	<4E5CE729.7090307@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:47916 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893Ab1H3NzJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2011 09:55:09 -0400
Received: by yie30 with SMTP id 30so4389390yie.19
        for <linux-mmc@vger.kernel.org>; Tue, 30 Aug 2011 06:55:09 -0700 (PDT)
In-Reply-To: <4E5CE729.7090307@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Kyungmin Park <kmpark@infradead.org>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org

I'm afraid no .The patch has not been tested.As you suggested. I will
test the Patch.
I have sent the modified Patch with version3.But, for some reason,the
patch has appeared in this current  mail thread only.Can you please
review it and suggest changes if any ?

On Tue, Aug 30, 2011 at 7:05 PM, James Hogan <james.hogan@imgtec.com> w=
rote:
> Hi Shashidhar,
>
> Has the patch been tested to check the dual buffer code gets hit (i.e=
=2E
> it doesn't always get given just single buffers) and that it still wo=
rks?
>
> mmc_test might be a good way of doing so if you have a spare sd card
> that you don't mind getting wiped, and I believe it does performance
> measurements too which is a bonus.
>
> Cheers
> James
>
> On 08/30/2011 10:23 AM, Shashidhar Hiremath wrote:
>> Hi Kyungmin ,
>> =C2=A0 I have actually not tested ,though I believe Dual Buffer Mode=
 will
>> improve performance by certain extent.The main reason for adding his
>> patch is since the hardware supports different modes for IDMAC data
>> transfer.I thought it would be better to have the support in the
>> driver.I will surely comeback with statistics on performance
>> improvement soon after testing it.
>>
>> On Tue, Aug 30, 2011 at 2:05 PM, Kyungmin Park <kmpark@infradead.org=
> wrote:
>>> Hi Shashidhar,
>>>
>>> Simple question, what's the performance or latency improvement by t=
his patch?
>>> IOW, what's the benefits? can you provide any performance results o=
r
>>> similar things?
>>>
>>> Thank you,
>>> Kyungmin Park
>>>
>>> On Tue, Aug 30, 2011 at 5:29 PM, Shashidhar Hiremath
>>> <shashidharh@vayavyalabs.com> wrote:
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
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Designware Mobile Storage IP blo=
ck. This disables the external DMA
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interface.
>>>>
>>>> +choice
>>>> + =C2=A0 =C2=A0 =C2=A0 prompt "select =C2=A0IDMAC Descriptors Mode=
"
>>>> + =C2=A0 =C2=A0 =C2=A0 depends on MMC_DW_IDMAC
>>>> +
>>>> +config MMC_DW_CHAIN_DESC
>>>> + =C2=A0 =C2=A0 =C2=A0 bool "Chain Descriptor Structure"
>>>> + =C2=A0 =C2=A0 =C2=A0 help
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Select this option to enable Chained=
 Mode of Operation and the
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Chained Mode operates in a mode wher=
e only one Buffer will be used
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 for each descriptor when the transfe=
r is happening in DMA mode.
>>>> +
>>>> +config MMC_DW_DUAL_BUFFER_DESC
>>>> + =C2=A0 =C2=A0 =C2=A0 bool "Dual Buffer Descriptor Structure"
>>>> + =C2=A0 =C2=A0 =C2=A0 help
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Select this option to enable Dual Bu=
ffer Desc Mode of Operation and
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Dual Buffer Descriptor Mode or the R=
ing Mode indicates that two
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffers can be used for each descrip=
tor during DMA mode transfer.
>>>> +endchoice
>>>> +
>>>> =C2=A0config MMC_SH_MMCIF
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "SuperH Internal MMCIF support=
"
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on MMC_BLOCK && (SUPERH || ARCH=
_SHMOBILE)
>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>> index ff0f714..ee02208 100644
>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>> @@ -63,6 +63,9 @@ struct idmac_desc {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 des1; =C2=A0 /* Buffer sizes */
>>>> =C2=A0#define IDMAC_SET_BUFFER1_SIZE(d, s) \
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0((d)->des1 =3D ((d)->des1 & 0x03ffe000)=
 | ((s) & 0x1fff))
>>>> +#define IDMAC_SET_BUFFER_SIZES(d, s1, s2) \
>>>> + =C2=A0 =C2=A0 =C2=A0 ((d)->des1 =3D (((d)->des1) =C2=A0| \
>>>> + =C2=A0 =C2=A0 =C2=A0 (((s1) & 0x1fff) | ((s2) & 0x1fff << 13))))
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 des2; =C2=A0 /* buffer 1 physical address */
>>>>
>>>> @@ -348,17 +351,38 @@ static void dw_mci_translate_sglist(struct d=
w_mci *host, struct mmc_data *data,
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct idmac_desc *desc =3D host->sg_cp=
u;
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < sg_len; i++, desc++) =
{
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int le=
ngth =3D sg_dma_len(&data->sg[i]);
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 mem_addr =3D=
 sg_dma_address(&data->sg[i]);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Length and m=
em_address of first buffer */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int le=
ngth1 =3D sg_dma_len(&data->sg[i]);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 mem_addr1 =3D=
 sg_dma_address(&data->sg[i]);
>>>> +#ifdef CONFIG_DUAL_BUFFER_DESC
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int le=
ngth2;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 mem_addr2;
>>>>
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set the OWN =
bit and disable interrupts for this descriptor */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Set the=
 OWN bit and disable interrupts
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* for thi=
s descriptor
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->des0 =3D =
IDMAC_DES0_OWN | IDMAC_DES0_DIC
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((i+1) < sg_=
len) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 length2 =3D sg_dma_len(&data->sg[i+1]);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 mem_addr2 =3D sg_dma_address(&data->sg[i+1]);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Buffer length being set for Buffer1 and Buffer2 */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 IDMAC_SET_BUFFER_SIZES(desc, length1, length2);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 desc->des3 =3D mem_addr2;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Incrementing for the second buffer */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 i++;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Buffer length being set for Buffer1 and Buffer2 */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 IDMAC_SET_BUFFER_SIZES(desc, length1, 0);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>> +#elif CONFIG_CHAIN_DESC
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set OWN bit =
and disable interrupts for this descriptor */
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0desc->des0 =
=3D IDMAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
>>>> -
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Buffer lengt=
h */
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IDMAC_SET_BUFFE=
R1_SIZE(desc, length);
>>>> -
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Buffer lengt=
h for Buffer1 */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IDMAC_SET_BUFFE=
R1_SIZE(desc, length1);
>>>> +#endif
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Physical=
 address to DMA to/from */
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->des2 =3D =
mem_addr;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->des2 =3D =
mem_addr1;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Set first descriptor */
>>>> @@ -369,6 +393,10 @@ static void dw_mci_translate_sglist(struct dw=
_mci *host, struct mmc_data *data,
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0desc =3D host->sg_cpu + (i - 1) * sizeo=
f(struct idmac_desc);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0desc->des0 &=3D ~(IDMAC_DES0_CH | IDMAC=
_DES0_DIC);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0desc->des0 |=3D IDMAC_DES0_LD;
>>>> +#ifdef CONFIG_DUAL_BUFFER_DESC
>>>> + =C2=A0 =C2=A0 =C2=A0 /* Set the End of Ring bit */
>>>> + =C2=A0 =C2=A0 =C2=A0 desc->des0 |=3D IDMAC_DES0_ER;
>>>> +#endif
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0wmb();
>>>> =C2=A0}
>>>> @@ -388,7 +416,8 @@ static void dw_mci_idmac_start_dma(struct dw_m=
ci *host, unsigned int sg_len)
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Enable the IDMAC */
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D mci_readl(host, BMOD);
>>>> - =C2=A0 =C2=A0 =C2=A0 temp |=3D SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_=
=46B;
>>>> + =C2=A0 =C2=A0 =C2=A0 /* The Descriptor Skip length is made zero =
*/
>>>> + =C2=A0 =C2=A0 =C2=A0 temp |=3D SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_=
=46B | SDMMC_BMOD_DSL(0);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mci_writel(host, BMOD, temp);
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Start it running */
>>>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>>>> index 027d377..0520dc8 100644
>>>> --- a/drivers/mmc/host/dw_mmc.h
>>>> +++ b/drivers/mmc/host/dw_mmc.h
>>>> @@ -72,6 +72,8 @@
>>>> =C2=A0/* Clock Enable register defines */
>>>> =C2=A0#define SDMMC_CLKEN_LOW_PWR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0BIT(16)
>>>> =C2=A0#define SDMMC_CLKEN_ENABLE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 BIT(0)
>>>> +/* BMOD register defines */
>>>> +#define SDMMC_BMOD_DSL(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0_SBF(2, (n))
>>>> =C2=A0/* time-out register defines */
>>>> =C2=A0#define SDMMC_TMOUT_DATA(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0_SBF(8, (n))
>>>> =C2=A0#define SDMMC_TMOUT_DATA_MSK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0xFFFFFF00
>>>> --
>>>> 1.7.2.3
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>>
>>>
>>
>>
>>
>
>



--=20
regards,
Shashidhar Hiremath
