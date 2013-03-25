From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: FW: [PATCH v2 3/4] mmc: sdhci-pxa: Add SDHCI driver for PXA16x
Date: Mon, 25 Mar 2013 15:58:31 +0800
Message-ID: <CADz5_gJTyxbTHnAN+BH_Q257DVp+KwNCyFOuVt7tGRgrH46+MA@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDEC87120@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:38073 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756603Ab3CYH6c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Mar 2013 03:58:32 -0400
Received: by mail-ob0-f169.google.com with SMTP id oi10so4461787obb.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2013 00:58:31 -0700 (PDT)
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C0BDEC87120@SC-VEXCH1.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Cc: Chris Ball <cjb@laptop.org>, Qiming Wu <wuqm@marvell.com>, Philip Rakity <prakity@nvidia.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.ke=
rnel.org] On Behalf Of Tanmay Upadhyay
> Sent: Monday, March 18, 2013 2:20 AM
> To: Zhangfei Gao; dwang4@marvell.com; njun@marvell.com; Qiming Wu; pr=
akity@marvell.com
> Cc: cjb@laptop.org; linux-mmc@vger.kernel.org; linux-arm-kernel@lists=
=2Einfradead.org; Tanmay Upadhyay
> Subject: [PATCH v2 3/4] mmc: sdhci-pxa: Add SDHCI driver for PXA16x
>
> PXA16x devices uses SDHCI controller v1. As it's not much different
> than v2 controller, v1 driver is merged with sdhci-pxav2 driver
>
> v2 - instead of having separate file sdhci-pxav1, merge code with
>      sdhci-pxav2 driver code as suggested by Chris Ball
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
> ---
>  drivers/mmc/host/Kconfig                |    7 ++++---
>  drivers/mmc/host/sdhci-pxav2.c          |   30 +++++++++++++++++++++=
++++++++-
>  drivers/mmc/host/sdhci.c                |    3 +++
>  drivers/mmc/host/sdhci.h                |    1 +
>  include/linux/platform_data/pxa_sdhci.h |    2 ++
>  5 files changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index e5faed8..875e2475 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -207,14 +207,15 @@ config MMC_SDHCI_PXAV3
>           If unsure, say N.
>
>  config MMC_SDHCI_PXAV2
> -       tristate "Marvell PXA9XX SD Host Controller support (PXAV2)"
> +       tristate "Marvell PXA16X/PXA9XX SD Host Controller support (P=
XAV1/V2)"
>         depends on CLKDEV_LOOKUP
>         select MMC_SDHCI
>         select MMC_SDHCI_PLTFM
>         default y if CPU_PXA910
> +       default y if CPU_PXA168
>         help
> -         This selects the Marvell(R) PXAV2 SD Host Controller.
> -         If you have a PXA9XX platform with SD Host Controller
> +         This selects the Marvell(R) PXAV1/V2 SD Host Controller.
> +         If you have a PXA16X or PXA9XX platform with SD Host Contro=
ller
>           and a card slot, say Y or M here.
>
>           If unsure, say N.
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-=
pxav2.c
> index ac854aa..5af7d46 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -30,6 +30,7 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/delay.h>
>
>  #include "sdhci.h"
>  #include "sdhci-pltfm.h"
> @@ -75,7 +76,13 @@ static void pxav2_set_private_registers(struct sdh=
ci_host *host, u8 mask)
>                         writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZ=
E_SETUP);
>                 }
>
> -               if (pdata && (pdata->flags & PXA_FLAG_ENABLE_CLOCK_GA=
TING)) {
> +               if (pdata && pdata->pxav1_controller) {
> +                       /* no clock gating */
> +                       tmp =3D readw(host->ioaddr + SD_FIFO_PARAM);
> +                       tmp |=3D DIS_PAD_SD_CLK_GATE;
> +                       writew(tmp, host->ioaddr + SD_FIFO_PARAM);

Why above code needed? And why just disable bit DIS_PAD_SD_CLK_GATE?
Below code when PXA_FLAG_ENABLE_CLOCK_GATING is not set can disable
clock gating.

> +               } else if (pdata && (pdata->flags
> +                               & PXA_FLAG_ENABLE_CLOCK_GATING)) {
>                         tmp =3D readw(host->ioaddr + SD_FIFO_PARAM);
>                         tmp &=3D ~CLK_GATE_SETTING_BITS;
>                         writew(tmp, host->ioaddr + SD_FIFO_PARAM);
> @@ -118,6 +125,20 @@ static u32 pxav2_get_max_clock(struct sdhci_host=
 *host)
>         return clk_get_rate(pltfm_host->clk);
>  }
>
> +/*
> + * we cannot talk to controller for 8 bus cycles according to sdio s=
pec
> + * at lowest speed this is 100,000 HZ per cycle or 800,000 cycles
> + * which is quite a LONG TIME on a fast cpu -- so delay if needed
> + */
> +static void platform_specific_completion(struct sdhci_host *host)
> +{
> +       struct platform_device *pdev =3D to_platform_device(mmc_dev(h=
ost->mmc));
> +       struct sdhci_pxa_platdata *pdata =3D pdev->dev.platform_data;
> +
> +       if (host->clock < 3200000 && pdata && pdata->delay_in_ms)
> +               mdelay(pdata->delay_in_ms);
> +}

Do we need this? Can you point out the spec?
And Why 3200000?
And I think it's better to delay according to host->clock.

> +
>  static struct sdhci_ops pxav2_sdhci_ops =3D {
>         .get_max_clock =3D pxav2_get_max_clock,
>         .platform_reset_exit =3D pxav2_set_private_registers,
> @@ -218,6 +239,13 @@ static int sdhci_pxav2_probe(struct platform_dev=
ice *pdev)
>                 if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
>                         host->mmc->caps |=3D MMC_CAP_8_BIT_DATA;
>
> +               if (pdata->pxav1_controller) {
> +                       host->quirks |=3D SDHCI_QUIRK_NO_BUSY_IRQ
> +                                       | SDHCI_QUIRK_32BIT_DMA_SIZE;
> +                       pxav2_sdhci_ops.platform_specific_completion
> +                               =3D platform_specific_completion;
> +               }
> +
>                 if (pdata->quirks)
>                         host->quirks |=3D pdata->quirks;
>                 if (pdata->host_caps)
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6f0bfc0..430eabd 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1001,6 +1001,9 @@ static void sdhci_send_command(struct sdhci_hos=
t *host, struct mmc_command *cmd)
>                 mdelay(1);
>         }
>
> +       if (host->ops->platform_specific_completion)
> +               host->ops->platform_specific_completion(host);
> +
>         mod_timer(&host->timer, jiffies + 10 * HZ);
>
>         host->cmd =3D cmd;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index a6d69b7..ef2efd3 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -282,6 +282,7 @@ struct sdhci_ops {
>         void    (*platform_resume)(struct sdhci_host *host);
>         void    (*adma_workaround)(struct sdhci_host *host, u32 intma=
sk);
>         void    (*platform_init)(struct sdhci_host *host);
> +       void    (*platform_specific_completion)(struct sdhci_host *ho=
st);
>  };
>
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/=
platform_data/pxa_sdhci.h
> index 27d3156..865a578 100644
> --- a/include/linux/platform_data/pxa_sdhci.h
> +++ b/include/linux/platform_data/pxa_sdhci.h
> @@ -54,6 +54,8 @@ struct sdhci_pxa_platdata {
>         unsigned int    quirks;
>         unsigned int    quirks2;
>         unsigned int    pm_caps;
> +       bool            pxav1_controller;  /* set if pxa168 */
> +       unsigned int    delay_in_ms;
>  };
>
>  struct sdhci_pxa {
> --
> 1.7.9.5
>
> *********************************************************************=
***********************************************************************=
*****************
> eInfochips Business Disclaimer : This e-mail message and all attachme=
nts transmitted with it are intended solely for the use of the addresse=
e and may contain legally privileged and confidential information. If t=
he reader of this message is not the intended recipient, or an employee=
 or agent responsible for delivering this message to the intended recip=
ient, you are hereby notified that any dissemination, distribution, cop=
ying, or other use of this message or its attachments is strictly prohi=
bited. If you have received this message in error, please notify the se=
nder immediately by replying to this message and please delete it from =
your computer. Any views expressed in this message are those of the ind=
ividual sender unless otherwise stated. Company has taken enough precau=
tions to prevent the spread of viruses. However the company accepts no =
liability for any damage caused by any virus transmitted by this email.
> *********************************************************************=
***********************************************************************=
*****************
>
>
> ---------------------------------------------------------------------=
------------------------
> Notice:
> This message has been scanned by Trend Micro Mail Security scanner an=
d is believed to be clean
> ---------------------------------------------------------------------=
------------------------ =C3=A8=C2=BA{.n=C3=87+=E2=80=B0=C2=B7=C5=B8=C2=
=AE=E2=80=B0=C2=AD=E2=80=A0+%=C5=A0=C3=8Blzwm=E2=80=A6=C3=A9b =C3=AB=C2=
=A7=C2=B2=C3=A6=C3=ACr=C2=B8=E2=80=BAzX=C2=A7=C2=BB =C2=A6r)=C3=AD=E2=80=
=A6=C3=A6=C3=A8w*jg=C2=AC=C2=B1=C2=A8 =C2=B6=E2=80=B0=C5=A1=C5=BD=C5=A0=
=C3=9D=C2=A2j/ =C3=AA=C3=A4z=C2=B9=C3=9E=E2=80=93=C5=A0=C3=A02=C5=A0=C3=
=9E=E2=84=A2=C2=A8=C3=A8=C2=AD=C3=9A&=C2=A2)=C3=9F=C2=A1=C2=ABa=C2=B6=C3=
=9A =C3=BE=C3=B8 =C2=AEG=C2=AB =C3=A9h=C2=AE =C3=A6j:+v=E2=80=B0=C2=A8=C5=
=A0w=C3=A8=E2=80=A0=C3=99=C2=A5
