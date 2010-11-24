From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [RFC] sdhc-pxa : mmp2 : Send 74 clocks when device powers up
Date: Wed, 24 Nov 2010 17:07:58 +0800
Message-ID: <AANLkTimARspcdkX802zdZVvubu5c0x054wNeOw5Xrzjn@mail.gmail.com>
References: <1AA1F483-D811-46C1-9637-4B63710BF4F0@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43921 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab0KXJIA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Nov 2010 04:08:00 -0500
Received: by fxm13 with SMTP id 13so4758722fxm.19
        for <linux-mmc@vger.kernel.org>; Wed, 24 Nov 2010 01:07:58 -0800 (PST)
In-Reply-To: <1AA1F483-D811-46C1-9637-4B63710BF4F0@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <markb@marvell.com>

On Wed, Nov 24, 2010 at 9:02 AM, Philip Rakity <prakity@marvell.com> wr=
ote:
> Resent -- now plain text
>
> MMC spec calls for the host to send 74 clocks to the card
> during initialization, right after voltage stabilization.
> the mmp2 controller does not start the clock when the clock
> is enabled but does provide a way to generate the clocks by
> programming the hardware.
>
> Turning ON the clock does NOT do ensure this happens on MMP2 - Aspen =
(pxa168) - Tavor.
> Turning on the clock only ensure that when the first cmd is sent that=
 the clock will
> be turned on.
>
>
> Submitted as a RFC as I do not have a way to test this code using mmc=
-next.
> Code tested in marvell mmp2 linux environment.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
>
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-px=
a.c
> index 5a61208..bc83075 100644
> --- a/drivers/mmc/host/sdhci-pxa.c
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -25,13 +25,21 @@
> #include <linux/io.h>
> #include <linux/err.h>
> #include <plat/sdhci.h>
> +#include <mach/cputype.h>
> #include "sdhci.h"
>
> #define DRIVER_NAME =A0 =A0 "sdhci-pxa"
>
> +#define SD_CFG_FIFO_PARAM =A0 =A0 =A00x100
> +#define =A0SDCFG_GEN_PAD_CLK_ON =A0(1<<6)
> +
> #define SD_FIFO_PARAM =A0 =A0 =A0 =A0 =A0 0x104
> #define DIS_PAD_SD_CLK_GATE =A0 =A0 0x400
>
> +#define SD_CE_ATA_2 =A0 =A0 =A0 =A0 =A0 =A00x10E
> +#define =A0SDCE_MISC_INT_EN =A0 =A0 =A0(1<<1)
> +#define =A0SDCE_MISC_INT =A0 =A0 =A0 =A0 (1<<2)
> +
> struct sdhci_pxa {
> =A0 =A0 =A0 =A0struct sdhci_host =A0 =A0 =A0 =A0 =A0 =A0 =A0 *host;
> =A0 =A0 =A0 =A0struct sdhci_pxa_platdata =A0 =A0 =A0 *pdata;
> @@ -39,6 +47,11 @@ struct sdhci_pxa {
> =A0 =A0 =A0 =A0struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *res;
>
> =A0 =A0 =A0 =A0u8 clk_enable;
> + =A0 =A0 =A0 u8 power_mode;
> +};
> +
> +static struct sdhci_ops sdhci_mmc_ops =3D {
> + =A0 =A0 =A0 .platform_send_init_74_clocks =3D NULL,
> };
>
> /********************************************************************=
*********\
> @@ -73,6 +86,60 @@ static struct sdhci_ops sdhci_pxa_ops =3D {
> =A0 =A0 =A0 =A0.set_clock =3D set_clock,
> };
>
> +/*
> + * MMC spec calls for the host to send 74 clocks to the card
> + * during initialization, right after voltage stabilization.
> + * the mmp2 controller does not start the clock when the clock
> + * is enabled but does provide a way to generate the clocks by
> + * programming the hardware.
> + */
> +static void generate_init_clocks_mmp2(struct sdhci_host *host, u8 po=
wer_mode)
> +{
> + =A0 =A0 =A0 struct sdhci_pxa *pxa =3D sdhci_priv(host);
> + =A0 =A0 =A0 u16 tmp;
> + =A0 =A0 =A0 int count;
> +
> + =A0 =A0 =A0 if (pxa->power_mode =3D=3D MMC_POWER_UP
> + =A0 =A0 =A0 && power_mode =3D=3D MMC_POWER_ON) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* set we want notice of when 74 cloc=
ks are sent
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* (NOT an interrupt -- just a h/w fl=
ag that flips)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr + SD_CE_ATA_=
2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D SDCE_MISC_INT_EN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr + SD_CE_ATA_2)=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* start sending the 74 clocks */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr + SD_CFG_FIF=
O_PARAM);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D SDCFG_GEN_PAD_CLK_ON;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr + SD_CFG_FIFO_=
PARAM);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* slowest speed is about 100KHz or 10u=
sec per clock */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay (740);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D 0;
> +#define MAX_WAIT_COUNT 5
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (count++ < MAX_WAIT_COUNT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check if hardware ha=
s indicated clocks sent */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((readw(host->ioaddr=
 + SD_CE_ATA_2) & SDCE_MISC_INT) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* keep going if error -- could be okay=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count =3D=3D MAX_WAIT_COUNT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk (KERN_WARNING "%=
s: %s: 74 clock interrupt not"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "cleare=
d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func_=
_,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hos=
tname(host->mmc));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* clear the interrupt bit if posted */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr + SD_CE_ATA_=
2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D SDCE_MISC_INT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr + SD_CE_ATA_2)=
;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 pxa->power_mode =3D power_mode;
> +}
> /********************************************************************=
*********\
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
> =A0* Device probing/removal =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> @@ -145,6 +212,10 @@ static int __devinit sdhci_pxa_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mmc->caps |=3D MMC_CAP_8_BIT_DAT=
A;
>
> + =A0 =A0 =A0 if (cpu_is_mmp2())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_mmc_ops.platform_send_init_74_clo=
cks =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 generate_init_clocks_mm=
p2;
> +
> =A0 =A0 =A0 =A0ret =3D sdhci_add_host(host);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "failed to add hos=
t\n");--
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Thanks for the patch, will verify here.
Since the register are different among platforms, how about only leave
interface here, and implement real code under platfrom, for example
mmp2 the implement code is in arch/arm/mach-mmp/mmp2.c
