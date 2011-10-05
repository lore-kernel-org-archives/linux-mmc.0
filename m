From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH 1/1] [PATCH v4 1/1] mmc: Support of DUAL BUFFER DESC[ring]
 mode for dw_mmc
Date: Wed, 5 Oct 2011 10:24:26 +0530
Message-ID: <CANYdXnqeB28R_-GSOe-d83XS3=KEfaA94_FV9PepOVEkbQ7c+A@mail.gmail.com>
References: <1317123568-5203-1-git-send-email-shashidharh@vayavyalabs.com>
	<4E8BBD76.9020001@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59708 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab1JEEy1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2011 00:54:27 -0400
Received: by iakk32 with SMTP id k32so1373494iak.19
        for <linux-mmc@vger.kernel.org>; Tue, 04 Oct 2011 21:54:26 -0700 (PDT)
In-Reply-To: <4E8BBD76.9020001@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org

Hi Jaehoon,
  First of all, thanks a lot for testing the patch.
I think you are right in saying that the patch does not increase the
performance considerably.
The reason I have added the patch is that this dual descriptor mode of
operation can be validated by this and its a Hardware feature
supported by the IP.

And, as far as #fdef scenario is concerned, the default value for
CHAIN_DESC is always yes .You can find this in the Kconfig file. So I
think it still makes Chain descriptor as the default mode.

On Wed, Oct 5, 2011 at 7:44 AM, Jaehoon Chung <jh80.chung@samsung.com> =
wrote:
> Hi Shashidhar.
>
> I tested dual-buffer descriptor with applied your patch.
> Actually, i didn't see to improve the performance. Dose it relate wit=
h
> the performance? i didn't sure..
>
> And you used #ifdef CHAIN_DESC and #ifdef DUAL_BUFFER_DESC.
> I think if you use CHAIN_DESC by default, need not #ifdef CHAIN_DESC.
> Because if you didn't select DUAL_BUFFER_DESC, should be work with
> CHAIN_DESC. (i think good that using #ifdef..#else..#endif)
>
> Regards,
> Jaehoon Chung
>
> On 09/27/2011 08:39 PM, Shashidhar Hiremath wrote:
>
>> This Patch adds the support for Dual Buffer Descriptor mode of
>> Operation for the dw_mmc driver.The patch also provides the configur=
ability
>> Option for choosing DUAL_BUFFER mode or the chained modes through me=
nuconfig.
>> The Menuconfig option for selecting Dual Buffer mode or chained mode
>> is selected only if Internal DMAC is enabled.
>>
>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>> ---
>> v2:
>> * As per suggestions by Will Newton and James Hogan
>> -Config symbol Names prefixed with MMC_DW
>> -Added more Description for Config parameters added
>> -Removed unnecessary config opion IDMAC_DESC_MODE
>> -IDMAC_SET_BUFFER_SIZE chenged IDMAC_SET_BUFFER_SIZES
>> -fixed typos and indented commments correctly
>> -if ((i +1) <=3D sg_len changed to ((i +1) < sg_len
>> -duplication "desc->des0 =3D IDMAC_DES0_OWN | IDMAC_DES0_DIC" line r=
emoved
>> -fixed bug in making DSL value zero
>> -removed ANDing the des1 with zero before writing buffer lengths to =
it
>> -Added proper multiline comments
>> v3:
>> * As per suggestions by James Hogan
>> -Modified Config Symbol Names in the Driver File
>> -Fixed Bug in Clearing the DSL field of BMOD register
>> -Fixed bug in IDMAC_SET_BUFFER_SIZES
>> v4:
>> * After Testing the Dual Buffer Support
>> -Modified the dma_init sequence to support Dual Buffer Mode
>>
>> =C2=A0drivers/mmc/host/Kconfig =C2=A0| =C2=A0 19 ++++++++++++++
>> =C2=A0drivers/mmc/host/dw_mmc.c | =C2=A0 58 ++++++++++++++++++++++++=
++++++++++++++++----
>> =C2=A0drivers/mmc/host/dw_mmc.h | =C2=A0 =C2=A02 +
>> =C2=A03 files changed, 73 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 8c87096..dd0df83 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -534,6 +534,25 @@ config MMC_DW_IDMAC
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Designware Mobile Storage IP block. This=
 disables the external DMA
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 interface.
>>
>> +choice
>> + =C2=A0 =C2=A0 prompt "select =C2=A0IDMAC Descriptors Mode"
>> + =C2=A0 =C2=A0 depends on MMC_DW_IDMAC
>> +
>> +config MMC_DW_CHAIN_DESC
>> + =C2=A0 =C2=A0 bool "Chain Descriptor Structure"
>> + =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 Select this option to enable Chained Mode of =
Operation and the
>> + =C2=A0 =C2=A0 =C2=A0 Chained Mode operates in a mode where only on=
e Buffer will be used
>> + =C2=A0 =C2=A0 =C2=A0 for each descriptor when the transfer is happ=
ening in DMA mode.
>> +
>> +config MMC_DW_DUAL_BUFFER_DESC
>> + =C2=A0 =C2=A0 bool "Dual Buffer Descriptor Structure"
>> + =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 Select this option to enable Dual Buffer Desc=
 Mode of Operation and
>> + =C2=A0 =C2=A0 =C2=A0 Dual Buffer Descriptor Mode or the Ring Mode =
indicates that two
>> + =C2=A0 =C2=A0 =C2=A0 buffers can be used for each descriptor durin=
g DMA mode transfer.
>> +endchoice
>> +
>> =C2=A0config MMC_SH_MMCIF
>> =C2=A0 =C2=A0 =C2=A0 tristate "SuperH Internal MMCIF support"
>> =C2=A0 =C2=A0 =C2=A0 depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBIL=
E)
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index ff0f714..ba54bb8 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -63,6 +63,8 @@ struct idmac_desc {
>> =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d=
es1; =C2=A0 /* Buffer sizes */
>> =C2=A0#define IDMAC_SET_BUFFER1_SIZE(d, s) \
>> =C2=A0 =C2=A0 =C2=A0 ((d)->des1 =3D ((d)->des1 & 0x03ffe000) | ((s) =
& 0x1fff))
>> +#define IDMAC_SET_BUFFER_SIZES(d, s1, s2) \
>> + =C2=A0 =C2=A0 (d->des1 =3D (((s1) & 0x1fff) | (((s2) & 0x1fff) << =
13)))
>>
>> =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d=
es2; =C2=A0 /* buffer 1 physical address */
>>
>> @@ -347,18 +349,45 @@ static void dw_mci_translate_sglist(struct dw_=
mci *host, struct mmc_data *data,
>> =C2=A0 =C2=A0 =C2=A0 int i;
>> =C2=A0 =C2=A0 =C2=A0 struct idmac_desc *desc =3D host->sg_cpu;
>>
>> +#ifdef CONFIG_MMC_DW_DUAL_BUFFER_DESC
>> + =C2=A0 =C2=A0 for (i =3D 0; i < sg_len; i +=3D 2, desc++) {
>> +#endif
>> +#ifdef CONFIG_MMC_DW_CHAIN_DESC
>> =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < sg_len; i++, desc++) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int length =3D =
sg_dma_len(&data->sg[i]);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 mem_addr =3D sg_dma_=
address(&data->sg[i]);
>> +#endif
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int length1 =3D=
 sg_dma_len(&data->sg[i]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 mem_addr1 =3D sg_dma=
_address(&data->sg[i]);
>> +#ifdef CONFIG_MMC_DW_DUAL_BUFFER_DESC
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int length2 =3D=
 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 mem_addr2;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((i+1) < sg_len) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 length2 =3D sg_dma_len(&data->sg[(i+1)]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mem_addr2 =3D sg_dma_address(&data->sg[i+1]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set the OWN bit and d=
isable interrupts for this descriptor
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* and disable the =
Chained Mode
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->des0 =3D (IDMAC_DE=
S0_OWN | IDMAC_DES0_DIC) & (~IDMAC_DES0_CH);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Buffer length1 and le=
ngth2 */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IDMAC_SET_BUFFER_SIZES(d=
esc, length1, length2);
>> +#endif
>> +#ifdef CONFIG_MMC_DW_CHAIN_DESC
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set the OWN bit =
and disable interrupts for this descriptor */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->des0 =3D IDMA=
C_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
>>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Buffer length */
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IDMAC_SET_BUFFER1_SIZE(d=
esc, length);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Buffer length1 */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IDMAC_SET_BUFFER1_SIZE(d=
esc, length1);
>> +#endif
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Physical address=
 to DMA to/from */
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->des2 =3D mem_addr;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->des2 =3D mem_addr1=
;
>> +#ifdef CONFIG_MMC_DW_DUAL_BUFFER_DESC
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((i+1) < sg_len)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 desc->des3 =3D mem_addr2;
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 /* Set first descriptor */
>> @@ -366,8 +395,14 @@ static void dw_mci_translate_sglist(struct dw_m=
ci *host, struct mmc_data *data,
>> =C2=A0 =C2=A0 =C2=A0 desc->des0 |=3D IDMAC_DES0_FD;
>>
>> =C2=A0 =C2=A0 =C2=A0 /* Set last descriptor */
>> +#ifdef CONFIG_MMC_DW_DUAL_BUFFER_DESC
>> + =C2=A0 =C2=A0 desc =3D host->sg_cpu + ((i/2) - 1) * sizeof(struct =
idmac_desc);
>> + =C2=A0 =C2=A0 desc->des0 &=3D (~IDMAC_DES0_DIC);
>> +#endif
>> +#ifdef CONFIG_MMC_DW_CHAIN_DESC
>> =C2=A0 =C2=A0 =C2=A0 desc =3D host->sg_cpu + (i - 1) * sizeof(struct=
 idmac_desc);
>> =C2=A0 =C2=A0 =C2=A0 desc->des0 &=3D ~(IDMAC_DES0_CH | IDMAC_DES0_DI=
C);
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 desc->des0 |=3D IDMAC_DES0_LD;
>>
>> =C2=A0 =C2=A0 =C2=A0 wmb();
>> @@ -388,6 +423,10 @@ static void dw_mci_idmac_start_dma(struct dw_mc=
i *host, unsigned int sg_len)
>>
>> =C2=A0 =C2=A0 =C2=A0 /* Enable the IDMAC */
>> =C2=A0 =C2=A0 =C2=A0 temp =3D mci_readl(host, BMOD);
>> +#ifdef CONFIG_MMC_DW_DUAL_BUFFER_DESC
>> + =C2=A0 =C2=A0 /* The Descriptor Skip length is made zero */
>> + =C2=A0 =C2=A0 temp &=3D ~(SDMMC_BMOD_DSL(0x1f));
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 temp |=3D SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB;
>> =C2=A0 =C2=A0 =C2=A0 mci_writel(host, BMOD, temp);
>>
>> @@ -402,13 +441,20 @@ static int dw_mci_idmac_init(struct dw_mci *ho=
st)
>>
>> =C2=A0 =C2=A0 =C2=A0 /* Number of descriptors in the ring buffer */
>> =C2=A0 =C2=A0 =C2=A0 host->ring_size =3D PAGE_SIZE / sizeof(struct i=
dmac_desc);
>> -
>> +#ifdef CONFIG_MMC_DW_CHAIN_DESC
>> =C2=A0 =C2=A0 =C2=A0 /* Forward link the descriptor list */
>> =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, p =3D host->sg_cpu; i < host->rin=
g_size - 1; i++, p++)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p->des3 =3D host->s=
g_dma + (sizeof(struct idmac_desc) * (i + 1));
>> +#endif
>> +#ifdef CONFIG_MMC_DW_DUAL_BUFFER_DESC
>> + =C2=A0 =C2=A0 for (i =3D 0, p =3D host->sg_cpu; i < host->ring_siz=
e - 1; i++)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p++;
>> +#endif
>>
>> =C2=A0 =C2=A0 =C2=A0 /* Set the last descriptor as the end-of-ring d=
escriptor */
>> +#ifdef CONFIG_MMC_DW_CHAIN_DESC
>> =C2=A0 =C2=A0 =C2=A0 p->des3 =3D host->sg_dma;
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 p->des0 =3D IDMAC_DES0_ER;
>>
>> =C2=A0 =C2=A0 =C2=A0 /* Mask out interrupts - get Tx & Rx complete o=
nly */
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index 027d377..0520dc8 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -72,6 +72,8 @@
>> =C2=A0/* Clock Enable register defines */
>> =C2=A0#define SDMMC_CLKEN_LOW_PWR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
BIT(16)
>> =C2=A0#define SDMMC_CLKEN_ENABLE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
BIT(0)
>> +/* BMOD register defines */
>> +#define SDMMC_BMOD_DSL(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
_SBF(2, (n))
>> =C2=A0/* time-out register defines */
>> =C2=A0#define SDMMC_TMOUT_DATA(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
_SBF(8, (n))
>> =C2=A0#define SDMMC_TMOUT_DATA_MSK =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xFFF=
=46FF00
>
>
>



--=20
regards,
Shashidhar Hiremath
