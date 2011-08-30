From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH v2 1/1] mmc: Support of DUAL BUFFER DESC[ring] mode for dw_mmc
Date: Tue, 30 Aug 2011 17:35:51 +0900
Message-ID: <CAH9JG2UjZjiwdWNkk+d1hrgK=7O_WtpDBCT92yja683eAjZ+xA@mail.gmail.com>
References: <1314692959-4139-1-git-send-email-shashidharh@vayavyalabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62853 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab1H3Ifw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2011 04:35:52 -0400
Received: by qwk3 with SMTP id 3so3848574qwk.19
        for <linux-mmc@vger.kernel.org>; Tue, 30 Aug 2011 01:35:51 -0700 (PDT)
In-Reply-To: <1314692959-4139-1-git-send-email-shashidharh@vayavyalabs.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org

Hi Shashidhar,

Simple question, what's the performance or latency improvement by this =
patch?
IOW, what's the benefits? can you provide any performance results or
similar things?

Thank you,
Kyungmin Park

On Tue, Aug 30, 2011 at 5:29 PM, Shashidhar Hiremath
<shashidharh@vayavyalabs.com> wrote:
> This Patch adds the support for Dual Buffer Descriptor mode of
> Operation for the dw_mmc driver.The patch also provides the configura=
bility
> Option for choosing DUAL_BUFFER mode or the chained modes through men=
uconfig.
> The Menuconfig option for selecting Dual Buffer mode or chained mode
> is selected only if Internal DMAC is enabled.
>
> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
> ---
> v2:
> * As per suggestions by Will Newton and James Hogan
> -Config symbol Names prefixed with MMC_DW
> -Added more Description for Config parameters added
> -Removed unnecessary config opion IDMAC_DESC_MODE
> -IDMAC_SET_BUFFER_SIZE chenged IDMAC_SET_BUFFER_SIZES
> -fixed typos and indented commments correctly
> -if ((i +1) <=3D sg_len changed to ((i +1) < sg_len
> -duplication "desc->des0 =3D IDMAC_DES0_OWN | IDMAC_DES0_DIC" line re=
moved
> -fixed bug in making DSL value zero
> -removed ANDing the des1 with zero before writing buffer lengths to i=
t
> -Added proper multiline comments
> ---
> =A0drivers/mmc/host/Kconfig =A0| =A0 19 +++++++++++++++++
> =A0drivers/mmc/host/dw_mmc.c | =A0 49 +++++++++++++++++++++++++++++++=
++++---------
> =A0drivers/mmc/host/dw_mmc.h | =A0 =A02 +
> =A03 files changed, 60 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8c87096..1e20dfa 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -534,6 +534,25 @@ config MMC_DW_IDMAC
> =A0 =A0 =A0 =A0 =A0Designware Mobile Storage IP block. This disables =
the external DMA
> =A0 =A0 =A0 =A0 =A0interface.
>
> +choice
> + =A0 =A0 =A0 prompt "select =A0IDMAC Descriptors Mode"
> + =A0 =A0 =A0 depends on MMC_DW_IDMAC
> +
> +config MMC_DW_CHAIN_DESC
> + =A0 =A0 =A0 bool "Chain Descriptor Structure"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Select this option to enable Chained Mode of Operat=
ion and the
> + =A0 =A0 =A0 =A0 Chained Mode operates in a mode where only one Buff=
er will be used
> + =A0 =A0 =A0 =A0 for each descriptor when the transfer is happening =
in DMA mode.
> +
> +config MMC_DW_DUAL_BUFFER_DESC
> + =A0 =A0 =A0 bool "Dual Buffer Descriptor Structure"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Select this option to enable Dual Buffer Desc Mode =
of Operation and
> + =A0 =A0 =A0 =A0 Dual Buffer Descriptor Mode or the Ring Mode indica=
tes that two
> + =A0 =A0 =A0 =A0 buffers can be used for each descriptor during DMA =
mode transfer.
> +endchoice
> +
> =A0config MMC_SH_MMCIF
> =A0 =A0 =A0 =A0tristate "SuperH Internal MMCIF support"
> =A0 =A0 =A0 =A0depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBILE)
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ff0f714..ee02208 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -63,6 +63,9 @@ struct idmac_desc {
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 des1; =A0 /* Buffer sizes =
*/
> =A0#define IDMAC_SET_BUFFER1_SIZE(d, s) \
> =A0 =A0 =A0 =A0((d)->des1 =3D ((d)->des1 & 0x03ffe000) | ((s) & 0x1ff=
f))
> +#define IDMAC_SET_BUFFER_SIZES(d, s1, s2) \
> + =A0 =A0 =A0 ((d)->des1 =3D (((d)->des1) =A0| \
> + =A0 =A0 =A0 (((s1) & 0x1fff) | ((s2) & 0x1fff << 13))))
>
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 des2; =A0 /* buffer 1 phys=
ical address */
>
> @@ -348,17 +351,38 @@ static void dw_mci_translate_sglist(struct dw_m=
ci *host, struct mmc_data *data,
> =A0 =A0 =A0 =A0struct idmac_desc *desc =3D host->sg_cpu;
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < sg_len; i++, desc++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int length =3D sg_dma_len(&dat=
a->sg[i]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 mem_addr =3D sg_dma_address(&data->=
sg[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Length and mem_address of first buff=
er */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int length1 =3D sg_dma_len(&da=
ta->sg[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 mem_addr1 =3D sg_dma_address(&data-=
>sg[i]);
> +#ifdef CONFIG_DUAL_BUFFER_DESC
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int length2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 mem_addr2;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the OWN bit and disable interrup=
ts for this descriptor */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Set the OWN bit and disable interr=
upts
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* for this descriptor
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des0 =3D IDMAC_DES0_OWN | IDMAC_D=
ES0_DIC
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i+1) < sg_len) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 length2 =3D sg_dma_len(=
&data->sg[i+1]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mem_addr2 =3D sg_dma_ad=
dress(&data->sg[i+1]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Buffer length being =
set for Buffer1 and Buffer2 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IDMAC_SET_BUFFER_SIZES(=
desc, length1, length2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des3 =3D mem_addr=
2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Incrementing for the=
 second buffer */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Buffer length being =
set for Buffer1 and Buffer2 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IDMAC_SET_BUFFER_SIZES(=
desc, length1, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +#elif CONFIG_CHAIN_DESC
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set OWN bit and disable interrupts f=
or this descriptor */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0desc->des0 =3D IDMAC_DES0_OWN | IDMAC_=
DES0_DIC | IDMAC_DES0_CH;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Buffer length */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 IDMAC_SET_BUFFER1_SIZE(desc, length);
> -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Buffer length for Buffer1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 IDMAC_SET_BUFFER1_SIZE(desc, length1);
> +#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Physical address to DMA to/from */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des2 =3D mem_addr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des2 =3D mem_addr1;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Set first descriptor */
> @@ -369,6 +393,10 @@ static void dw_mci_translate_sglist(struct dw_mc=
i *host, struct mmc_data *data,
> =A0 =A0 =A0 =A0desc =3D host->sg_cpu + (i - 1) * sizeof(struct idmac_=
desc);
> =A0 =A0 =A0 =A0desc->des0 &=3D ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
> =A0 =A0 =A0 =A0desc->des0 |=3D IDMAC_DES0_LD;
> +#ifdef CONFIG_DUAL_BUFFER_DESC
> + =A0 =A0 =A0 /* Set the End of Ring bit */
> + =A0 =A0 =A0 desc->des0 |=3D IDMAC_DES0_ER;
> +#endif
>
> =A0 =A0 =A0 =A0wmb();
> =A0}
> @@ -388,7 +416,8 @@ static void dw_mci_idmac_start_dma(struct dw_mci =
*host, unsigned int sg_len)
>
> =A0 =A0 =A0 =A0/* Enable the IDMAC */
> =A0 =A0 =A0 =A0temp =3D mci_readl(host, BMOD);
> - =A0 =A0 =A0 temp |=3D SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB;
> + =A0 =A0 =A0 /* The Descriptor Skip length is made zero */
> + =A0 =A0 =A0 temp |=3D SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB | SDMMC_B=
MOD_DSL(0);
> =A0 =A0 =A0 =A0mci_writel(host, BMOD, temp);
>
> =A0 =A0 =A0 =A0/* Start it running */
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 027d377..0520dc8 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -72,6 +72,8 @@
> =A0/* Clock Enable register defines */
> =A0#define SDMMC_CLKEN_LOW_PWR =A0 =A0 =A0 =A0 =A0 =A0BIT(16)
> =A0#define SDMMC_CLKEN_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
> +/* BMOD register defines */
> +#define SDMMC_BMOD_DSL(n) =A0 =A0 =A0 =A0 =A0 =A0 =A0_SBF(2, (n))
> =A0/* time-out register defines */
> =A0#define SDMMC_TMOUT_DATA(n) =A0 =A0 =A0 =A0 =A0 =A0_SBF(8, (n))
> =A0#define SDMMC_TMOUT_DATA_MSK =A0 =A0 =A0 =A0 =A0 0xFFFFFF00
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
