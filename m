From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH v2 1/1] mmc: Support of DUAL BUFFER DESC[ring] mode for dw_mmc
Date: Tue, 30 Aug 2011 14:53:58 +0530
Message-ID: <CANYdXnoZsN-1aGmpuJoDSbgCK4-6ZisKORJtFJfG1zx5L_znMg@mail.gmail.com>
References: <1314692959-4139-1-git-send-email-shashidharh@vayavyalabs.com>
	<CAH9JG2UjZjiwdWNkk+d1hrgK=7O_WtpDBCT92yja683eAjZ+xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42484 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab1H3JX7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2011 05:23:59 -0400
Received: by iabu26 with SMTP id u26so1379942iab.19
        for <linux-mmc@vger.kernel.org>; Tue, 30 Aug 2011 02:23:58 -0700 (PDT)
In-Reply-To: <CAH9JG2UjZjiwdWNkk+d1hrgK=7O_WtpDBCT92yja683eAjZ+xA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org

Hi Kyungmin ,
  I have actually not tested ,though I believe Dual Buffer Mode will
improve performance by certain extent.The main reason for adding his
patch is since the hardware supports different modes for IDMAC data
transfer.I thought it would be better to have the support in the
driver.I will surely comeback with statistics on performance
improvement soon after testing it.

On Tue, Aug 30, 2011 at 2:05 PM, Kyungmin Park <kmpark@infradead.org> w=
rote:
> Hi Shashidhar,
>
> Simple question, what's the performance or latency improvement by thi=
s patch?
> IOW, what's the benefits? can you provide any performance results or
> similar things?
>
> Thank you,
> Kyungmin Park
>
> On Tue, Aug 30, 2011 at 5:29 PM, Shashidhar Hiremath
> <shashidharh@vayavyalabs.com> wrote:
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
>> ---
>> =C2=A0drivers/mmc/host/Kconfig =C2=A0| =C2=A0 19 +++++++++++++++++
>> =C2=A0drivers/mmc/host/dw_mmc.c | =C2=A0 49 ++++++++++++++++++++++++=
+++++++++++---------
>> =C2=A0drivers/mmc/host/dw_mmc.h | =C2=A0 =C2=A02 +
>> =C2=A03 files changed, 60 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 8c87096..1e20dfa 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -534,6 +534,25 @@ config MMC_DW_IDMAC
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Designware Mobile Storage IP block=
=2E This disables the external DMA
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interface.
>>
>> +choice
>> + =C2=A0 =C2=A0 =C2=A0 prompt "select =C2=A0IDMAC Descriptors Mode"
>> + =C2=A0 =C2=A0 =C2=A0 depends on MMC_DW_IDMAC
>> +
>> +config MMC_DW_CHAIN_DESC
>> + =C2=A0 =C2=A0 =C2=A0 bool "Chain Descriptor Structure"
>> + =C2=A0 =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Select this option to enable Chained M=
ode of Operation and the
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Chained Mode operates in a mode where =
only one Buffer will be used
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 for each descriptor when the transfer =
is happening in DMA mode.
>> +
>> +config MMC_DW_DUAL_BUFFER_DESC
>> + =C2=A0 =C2=A0 =C2=A0 bool "Dual Buffer Descriptor Structure"
>> + =C2=A0 =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Select this option to enable Dual Buff=
er Desc Mode of Operation and
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Dual Buffer Descriptor Mode or the Rin=
g Mode indicates that two
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffers can be used for each descripto=
r during DMA mode transfer.
>> +endchoice
>> +
>> =C2=A0config MMC_SH_MMCIF
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "SuperH Internal MMCIF support"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on MMC_BLOCK && (SUPERH || ARCH_S=
HMOBILE)
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index ff0f714..ee02208 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -63,6 +63,9 @@ struct idmac_desc {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 des1; =C2=A0 /* Buffer sizes */
>> =C2=A0#define IDMAC_SET_BUFFER1_SIZE(d, s) \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0((d)->des1 =3D ((d)->des1 & 0x03ffe000) |=
 ((s) & 0x1fff))
>> +#define IDMAC_SET_BUFFER_SIZES(d, s1, s2) \
>> + =C2=A0 =C2=A0 =C2=A0 ((d)->des1 =3D (((d)->des1) =C2=A0| \
>> + =C2=A0 =C2=A0 =C2=A0 (((s1) & 0x1fff) | ((s2) & 0x1fff << 13))))
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 des2; =C2=A0 /* buffer 1 physical address */
>>
>> @@ -348,17 +351,38 @@ static void dw_mci_translate_sglist(struct dw_=
mci *host, struct mmc_data *data,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct idmac_desc *desc =3D host->sg_cpu;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < sg_len; i++, desc++) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int leng=
th =3D sg_dma_len(&data->sg[i]);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 mem_addr =3D =
sg_dma_address(&data->sg[i]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Length and mem=
_address of first buffer */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int leng=
th1 =3D sg_dma_len(&data->sg[i]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 mem_addr1 =3D=
 sg_dma_address(&data->sg[i]);
>> +#ifdef CONFIG_DUAL_BUFFER_DESC
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int leng=
th2;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 mem_addr2;
>>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set the OWN bi=
t and disable interrupts for this descriptor */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Set the O=
WN bit and disable interrupts
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* for this =
descriptor
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->des0 =3D ID=
MAC_DES0_OWN | IDMAC_DES0_DIC
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((i+1) < sg_le=
n) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 length2 =3D sg_dma_len(&data->sg[i+1]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 mem_addr2 =3D sg_dma_address(&data->sg[i+1]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Buffer length being set for Buffer1 and Buffer2 */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 IDMAC_SET_BUFFER_SIZES(desc, length1, length2);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 desc->des3 =3D mem_addr2;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Incrementing for the second buffer */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 i++;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Buffer length being set for Buffer1 and Buffer2 */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 IDMAC_SET_BUFFER_SIZES(desc, length1, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +#elif CONFIG_CHAIN_DESC
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set OWN bit an=
d disable interrupts for this descriptor */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0desc->des0 =3D=
 IDMAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
>> -
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Buffer length =
*/
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IDMAC_SET_BUFFER1=
_SIZE(desc, length);
>> -
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Buffer length =
for Buffer1 */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IDMAC_SET_BUFFER1=
_SIZE(desc, length1);
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Physical a=
ddress to DMA to/from */
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->des2 =3D me=
m_addr;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->des2 =3D me=
m_addr1;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Set first descriptor */
>> @@ -369,6 +393,10 @@ static void dw_mci_translate_sglist(struct dw_m=
ci *host, struct mmc_data *data,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0desc =3D host->sg_cpu + (i - 1) * sizeof(=
struct idmac_desc);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0desc->des0 &=3D ~(IDMAC_DES0_CH | IDMAC_D=
ES0_DIC);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0desc->des0 |=3D IDMAC_DES0_LD;
>> +#ifdef CONFIG_DUAL_BUFFER_DESC
>> + =C2=A0 =C2=A0 =C2=A0 /* Set the End of Ring bit */
>> + =C2=A0 =C2=A0 =C2=A0 desc->des0 |=3D IDMAC_DES0_ER;
>> +#endif
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0wmb();
>> =C2=A0}
>> @@ -388,7 +416,8 @@ static void dw_mci_idmac_start_dma(struct dw_mci=
 *host, unsigned int sg_len)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Enable the IDMAC */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D mci_readl(host, BMOD);
>> - =C2=A0 =C2=A0 =C2=A0 temp |=3D SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB=
;
>> + =C2=A0 =C2=A0 =C2=A0 /* The Descriptor Skip length is made zero */
>> + =C2=A0 =C2=A0 =C2=A0 temp |=3D SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB=
 | SDMMC_BMOD_DSL(0);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mci_writel(host, BMOD, temp);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Start it running */
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index 027d377..0520dc8 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -72,6 +72,8 @@
>> =C2=A0/* Clock Enable register defines */
>> =C2=A0#define SDMMC_CLKEN_LOW_PWR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0BIT(16)
>> =C2=A0#define SDMMC_CLKEN_ENABLE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 BIT(0)
>> +/* BMOD register defines */
>> +#define SDMMC_BMOD_DSL(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0_SBF(2, (n))
>> =C2=A0/* time-out register defines */
>> =C2=A0#define SDMMC_TMOUT_DATA(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0_SBF(8, (n))
>> =C2=A0#define SDMMC_TMOUT_DATA_MSK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0xFFFFFF00
>> --
>> 1.7.2.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>



--=20
regards,
Shashidhar Hiremath
