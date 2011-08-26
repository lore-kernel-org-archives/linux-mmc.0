From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 1/1] mmc: Support of DUAL BUFFER DESC[ring] mode for dw_mmc
Date: Fri, 26 Aug 2011 12:06:26 +0100
Message-ID: <CAFbHwiR25Nrwbvd1SXr=HVWwroQz3smumpVkj27ij4w+DfCnZQ@mail.gmail.com>
References: <CANYdXno+b6ZZ=3upGMwYxxbJMbKSteWKGM=RxtKhSOYr3iov4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:42597 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab1HZLGa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Aug 2011 07:06:30 -0400
Received: by pzk37 with SMTP id 37so4090140pzk.1
        for <linux-mmc@vger.kernel.org>; Fri, 26 Aug 2011 04:06:29 -0700 (PDT)
In-Reply-To: <CANYdXno+b6ZZ=3upGMwYxxbJMbKSteWKGM=RxtKhSOYr3iov4g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, James Hogan <james.hogan@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

On Fri, Aug 26, 2011 at 11:31 AM, Shashidhar Hiremath
<shashidharh@vayavyalabs.com> wrote:

Hi Shashidhar,

Thanks for the patch! A few comments below:

> This Patch adds the support for Dual Buffer Descriptor mode of
> Operation for the dw_mmc driver.The patch also provides the configura=
bility
> Option for choosing DUAL_BUFFER mode or the chained modes through men=
uconfig.
> The Menuconfig option for selecting Dual Buffer mode or chained mode
> is selected only if
> Internal DMAC is enabled.
>
> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
> ---
> =A0drivers/mmc/host/Kconfig =A0| =A0 22 ++++++++++++++++++
> =A0drivers/mmc/host/dw_mmc.c | =A0 55 +++++++++++++++++++++++++++++++=
+++++--------
> =A02 files changed, 67 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8c87096..e10f585 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -534,6 +534,28 @@ config MMC_DW_IDMAC
> =A0 =A0 =A0 =A0 =A0Designware Mobile Storage IP block. This disables =
the external DMA
> =A0 =A0 =A0 =A0 =A0interface.
>
> +config IDMAC_DESC_MODE
> + =A0 =A0 =A0 bool "Internal DMAC Descriptor Operating Mode"
> + =A0 =A0 =A0 depends on MMC_DW_IDMAC
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This selects the Operating mode for the Descriptors=
=2E
> +
> +choice
> + =A0 =A0 =A0 prompt "select configuration"
> + =A0 =A0 =A0 depends on IDMAC_DESC_MODE
> +
> +config CHAIN_DESC
> + =A0 =A0 =A0 bool "Chain Descriptor Structure"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Select this option to enable Chained Mode of Operat=
ion.
> +
> +config DUAL_BUFFER_DESC
> + =A0 =A0 =A0 bool "Dual Buffer Descriptor Structure"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Select this option to enable Dual Buffer Desc Mode =
of Operation.
> +endchoice

These config symbols go in the global config namespace so you should
probably prefix them with "MMC_DW" to prevent pollution of the
namespace. Also it would be good to add some more description text so
the user can understand which choice to make.

> +
> +
> =A0config MMC_SH_MMCIF
> =A0 =A0 =A0 =A0tristate "SuperH Internal MMCIF support"
> =A0 =A0 =A0 =A0depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBILE)
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ff0f714..a590856 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -63,6 +63,9 @@ struct idmac_desc {
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 des1; =A0 /* Buffer sizes =
*/
> =A0#define IDMAC_SET_BUFFER1_SIZE(d, s) \
> =A0 =A0 =A0 =A0((d)->des1 =3D ((d)->des1 & 0x03ffe000) | ((s) & 0x1ff=
f))
> +#define IDMAC_SET_BUFFER_SIZE(d, s1, s2) \
> + =A0 =A0 =A0 ((d)->des1 =3D ((d)->des1 & 0x0) | \
> + =A0 =A0 =A0 (((s1) & 0x1fff) | ((s2) & 0x1fff << 13)))

IDMAC_SET_BUFFER_SIZES might be a more descriptive name for this macro.

> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 des2; =A0 /* buffer 1 phys=
ical address */
>
> @@ -348,17 +351,44 @@ static void dw_mci_translate_sglist(struct
> dw_mci *host, struct mmc_data *data,
> =A0 =A0 =A0 =A0struct idmac_desc *desc =3D host->sg_cpu;
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < sg_len; i++, desc++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int length =3D sg_dma_len(&dat=
a->sg[i]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 mem_addr =3D sg_dma_address(&data->=
sg[i]);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the OWN bit and disable interrup=
ts for this descriptor */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*length and mem_aadress of first buffe=
r*/

There's typo in this comment.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int length1 =3D sg_dma_len(&da=
ta->sg[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 mem_addr1 =3D sg_dma_address(&data-=
>sg[i]);
> +#ifdef CONFIG_DUAL_BUFFER_DESC
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int length2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 mem_addr2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i+1) <=3D sg_len) {

Won't this always be true as i < sg_len? Should it be if ((i +1) < sg_l=
en)?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 length2 =3D sg_dma_len(=
&data->sg[i+1]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mem_addr2 =3D sg_dma_ad=
dress(&data->sg[i+1]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the OWN bit and =
disable interrupts
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* for this descripto=
r
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des0 =3D IDMAC_DE=
S0_OWN | IDMAC_DES0_DIC
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des0 &=3D (~IDMAC=
_DES0_CH);

These two lines are identical in both branches of the if statement so
could be moved above it.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Buffer length being =
set for Buffer1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and Buffer2 being =
set
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IDMAC_SET_BUFFER_SIZE(d=
esc, length1, length2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des3 =3D mem_addr=
2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Incrementing for the=
 second buffer */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des0 =3D IDMAC_DE=
S0_OWN | IDMAC_DES0_DIC
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des0 &=3D (~IDMAC=
_DES0_CH);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Buffer length being =
set for Buffer1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and Buffer2 being =
set
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IDMAC_SET_BUFFER_SIZE(d=
esc, length1, 0);
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Buffer length for Buffer1*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 IDMAC_SET_BUFFER1_SIZE(desc, length1);
> +#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Physical address to DMA to/from */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des2 =3D mem_addr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->des2 =3D mem_addr1;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Set first descriptor */
> @@ -369,6 +399,10 @@ static void dw_mci_translate_sglist(struct dw_mc=
i
> *host, struct mmc_data *data,
> =A0 =A0 =A0 =A0desc =3D host->sg_cpu + (i - 1) * sizeof(struct idmac_=
desc);
> =A0 =A0 =A0 =A0desc->des0 &=3D ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
> =A0 =A0 =A0 =A0desc->des0 |=3D IDMAC_DES0_LD;
> +#ifdef CONFIG_DUAL_BUFFER_DESC
> + =A0 =A0 =A0 /*Set the End of Ring bit */
> + =A0 =A0 =A0 desc->des0 |=3D IDMAC_DES0_ER;
> +#endif
>
> =A0 =A0 =A0 =A0wmb();
> =A0}
> @@ -388,7 +422,8 @@ static void dw_mci_idmac_start_dma(struct dw_mci
> *host, unsigned int sg_len)
>
> =A0 =A0 =A0 =A0/* Enable the IDMAC */
> =A0 =A0 =A0 =A0temp =3D mci_readl(host, BMOD);
> - =A0 =A0 =A0 temp |=3D SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB;
> + =A0 =A0 =A0 /* The Descriptor Skip length is made zero */
> + =A0 =A0 =A0 temp |=3D SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB & SDMMC_B=
MOD_DSL(0);

I'm not sure what this is trying to do exactly, but it looks like it
won't work. Setting DSL 0 just means having 0 in bits 6:2 of BMOD,
which would be "& ~SDMMC_BMOD_DSL(0)" I would have thought?

> =A0 =A0 =A0 =A0mci_writel(host, BMOD, temp);
>
> =A0 =A0 =A0 =A0/* Start it running */
> --
> 1.7.2.3
>
>
> --
> regards,
> Shashidhar Hiremath
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
