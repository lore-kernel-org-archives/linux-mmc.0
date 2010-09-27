From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v4 1/4] omap4 hsmmc: Adding card detect support for MMC1
Date: Mon, 27 Sep 2010 13:25:01 +0530
Message-ID: <AANLkTi=YvtrfmUTc-YBAUjEXn1v3pPLmhb92J60AhU28@mail.gmail.com>
References: <9408.10.24.255.18.1285348400.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64125 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756320Ab0I0HzD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 03:55:03 -0400
In-Reply-To: <9408.10.24.255.18.1285348400.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: sameo@linux.intel.com
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, akpm@linux-foundation.org, madhu.cr@ti.com, adrian.hunter@nokia.com

Cc: Samuel Ortiz <sameo@linux.intel.com>

On Fri, Sep 24, 2010 at 10:43 PM, kishore kadiyala
<kishore.kadiyala@ti.com> wrote:
> Adding card detect callback function and card detect configuration
> function for MMC1 Controller on OMAP4.
>
> Card detect configuration function does initial configuration of the
> MMC Control & PullUp-PullDown registers of Phoenix.
>
> For MMC1 Controller, card detect interrupt source is
> twl6030 which is non-gpio. The card detect call back function provide=
s
> card present/absent status by reading MMC Control register present
> on twl6030.
>
> Since OMAP4 doesn't use any GPIO line as used in OMAP3 for card detec=
t,
> the suspend/resume initialization which was done in omap_hsmmc_gpio_i=
nit
> previously is moved to the probe thus making it generic for both OMAP=
3 & OMAP4.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
> Cc: Adrian Hunter <adrian.hunter@nokia.com>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> ---
> =A0arch/arm/mach-omap2/board-4430sdp.c | =A0 =A07 +++-
> =A0drivers/mfd/twl6030-irq.c =A0 =A0 =A0 =A0 =A0 | =A0 73 +++++++++++=
++++++++++++++++++++++++
> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 | =A0 =A04 +-
> =A0include/linux/i2c/twl.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 31 +++++++++=
++++++
> =A04 files changed, 112 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap=
2/board-4430sdp.c
> index 9447644..a49f285 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -227,9 +227,14 @@ static int omap4_twl6030_hsmmc_late_init(struct =
device *dev)
> =A0 =A0 =A0 =A0struct omap_mmc_platform_data *pdata =3D dev->platform=
_data;
>
> =A0 =A0 =A0 =A0/* Setting MMC1 Card detect Irq */
> - =A0 =A0 =A0 if (pdev->id =3D=3D 0)
> + =A0 =A0 =A0 if (pdev->id =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl6030_mmc_card_detect_config(=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Failed configur=
ing MMC1 card detect\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->slots[0].card_detect_irq =3D TW=
L6030_IRQ_BASE +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0MMCDETECT_INTR_OFFSET;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->slots[0].card_detect =3D twl6030=
_mmc_card_detect;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
> index 10bf228..2d3bb82 100644
> --- a/drivers/mfd/twl6030-irq.c
> +++ b/drivers/mfd/twl6030-irq.c
> @@ -36,6 +36,7 @@
> =A0#include <linux/irq.h>
> =A0#include <linux/kthread.h>
> =A0#include <linux/i2c/twl.h>
> +#include <linux/platform_device.h>
>
> =A0/*
> =A0* TWL6030 (unlike its predecessors, which had two level interrupt =
handling)
> @@ -223,6 +224,78 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 offse=
t)
> =A0}
> =A0EXPORT_SYMBOL(twl6030_interrupt_mask);
>
> +int twl6030_mmc_card_detect_config(void)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 u8 reg_val =3D 0;
> +
> + =A0 =A0 =A0 /* Unmasking the Card detect Interrupt line for MMC1 fr=
om Phoenix */
> + =A0 =A0 =A0 twl6030_interrupt_unmask(TWL6030_MMCDETECT_INT_MASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 REG_INT_MSK_LINE_B);
> + =A0 =A0 =A0 twl6030_interrupt_unmask(TWL6030_MMCDETECT_INT_MASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 REG_INT_MSK_STS_B);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Intially Configuring MMC_CTRL for receving interru=
pts &
> + =A0 =A0 =A0 =A0* Card status on TWL6030 for MMC1
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val, T=
WL6030_MMCCTRL);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl6030: Failed to read MMCCTRL=
, error %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 reg_val &=3D ~VMMC_AUTO_OFF;
> + =A0 =A0 =A0 reg_val |=3D SW_FC;
> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val, T=
WL6030_MMCCTRL);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl6030: Failed to write MMCCTR=
L, error %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Configuring PullUp-PullDown register */
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 TWL6030_CFG_INPUT_PUPD3);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl6030: Failed to read CFG_INP=
UT_PUPD3, error %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 reg_val &=3D ~(MMC_PU | MMC_PD);
> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 TWL6030_CFG_INPUT_PUPD3);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl6030: Failed to write CFG_IN=
PUT_PUPD3, error %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(twl6030_mmc_card_detect_config);
> +
> +int twl6030_mmc_card_detect(struct device *dev, int slot)
> +{
> + =A0 =A0 =A0 int ret =3D -EIO;
> + =A0 =A0 =A0 u8 read_reg =3D 0;
> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev=
);
> +
> + =A0 =A0 =A0 if (pdev->id) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* TWL6030 provide's Card detect suppor=
t for
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* only MMC1 controller.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Unkown MMC controller %d in %s\=
n", pdev->id, __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* BIT0 of MMC_CTRL on TWL6030 provides card status f=
or MMC1
> + =A0 =A0 =A0 =A0* 0 - Card not present ,1 - Card present
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL6030_MODULE_ID0, &read_reg,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 TWL6030_MMCCTRL);
> + =A0 =A0 =A0 if (ret >=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D read_reg & STS_MMC;
> + =A0 =A0 =A0 return ret;
> +}
> +EXPORT_SYMBOL(twl6030_mmc_card_detect);
> +
> =A0int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_=
end)
> =A0{
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 562dbbb..a51894d 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -466,8 +466,6 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_p=
latform_data *pdata)
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0if (gpio_is_valid(pdata->slots[0].switch_pin)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->suspend =3D omap_hsmmc_suspend_c=
dirq;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->resume =3D omap_hsmmc_resume_cdi=
rq;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pdata->slots[0].cover)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->slots[0].get_co=
ver_state =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0omap_hsmmc_get_cover_state;
> @@ -2211,6 +2209,8 @@ static int __init omap_hsmmc_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Unabl=
e to grab MMC CD IRQ\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_irq_cd;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->suspend =3D omap_hsmmc_suspend_c=
dirq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->resume =3D omap_hsmmc_resume_cdi=
rq;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0omap_hsmmc_disable_irq(host);
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index 6de90bf..e64894c 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -141,6 +141,16 @@
> =A0#define TWL6030_CHARGER_CTRL_INT_MASK =A00x10
> =A0#define TWL6030_CHARGER_FAULT_INT_MASK =A0 =A0 =A0 =A0 0x60
>
> +#define TWL6030_MMCCTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xEE
> +#define VMMC_AUTO_OFF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 << 3)
> +#define SW_FC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x=
1 << 2)
> +#define STS_MMC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1
> +
> +#define TWL6030_CFG_INPUT_PUPD3 =A0 =A0 =A0 =A00xF2
> +#define MMC_PU =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 =
<< 3)
> +#define MMC_PD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 =
<< 2)
> +
> +
>
> =A0#define TWL4030_CLASS_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x4030
> =A0#define TWL6030_CLASS_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x6030
> @@ -173,6 +183,27 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, u=
nsigned num_bytes);
> =A0int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
> =A0int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
>
> +/* Card detect Configuration for MMC1 Controller on OMAP4 */
> +#ifdef CONFIG_TWL4030_CORE
> +int twl6030_mmc_card_detect_config(void);
> +#else
> +static inline int twl6030_mmc_card_detect_config(void)
> +{
> + =A0 =A0 =A0 pr_debug("twl6030_mmc_card_detect_config not supported\=
n");
> + =A0 =A0 =A0 return 0;
> +}
> +#endif
> +
> +/* MMC1 Controller on OMAP4 uses Phoenix irq for Card detect */
> +#ifdef CONFIG_TWL4030_CORE
> +int twl6030_mmc_card_detect(struct device *dev, int slot);
> +#else
> +static inline int twl6030_mmc_card_detect(struct device *dev, int sl=
ot)
> +{
> + =A0 =A0 =A0 pr_debug("Call back twl6030_mmc_card_detect not support=
ed\n");
> + =A0 =A0 =A0 return -EIO;
> +}
> +#endif
> =A0/*----------------------------------------------------------------=
------*/
>
> =A0/*
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
