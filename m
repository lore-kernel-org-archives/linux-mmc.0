From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: [PATCH v4 1/2] MMC: add support for the Marvell Dove SDHCI controller
Date: Mon, 22 Nov 2010 09:42:33 +0200
Message-ID: <AANLkTimhzUe+qODZYCvvrH6Hi06gV1yHVpS1LRHhXu7o@mail.gmail.com>
References: <cover.1288293593.git.mike@compulab.co.il>
	<ea487c43c1aff1d07355e0e0699e739c8617b96f.1288293593.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61921 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab0KVHme convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2010 02:42:34 -0500
Received: by qyk5 with SMTP id 5so470323qyk.19
        for <linux-mmc@vger.kernel.org>; Sun, 21 Nov 2010 23:42:33 -0800 (PST)
In-Reply-To: <ea487c43c1aff1d07355e0e0699e739c8617b96f.1288293593.git.mike@compulab.co.il>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Saeed Bishara <saeed@marvell.com>, linux-arm-kernel@lists.infradead.org

On Thu, Oct 28, 2010 at 9:23 PM, Mike Rapoport <mike@compulab.co.il> wr=
ote:
> Implement an sdhci-pltfm driver for the controller found on Marvell
> Dove SoC
>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> CC: Saeed Bishara <saeed@marvell.com>
Acked-by: Saeed Bishara <saeed@marvell.com>
> ---
> =C2=A0drivers/mmc/host/Kconfig =C2=A0 =C2=A0 =C2=A0 | =C2=A0 13 +++++=
++
> =C2=A0drivers/mmc/host/Makefile =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 =
+
> =C2=A0drivers/mmc/host/sdhci-dove.c =C2=A0| =C2=A0 70 +++++++++++++++=
+++++++++++++++++++++++++
> =C2=A0drivers/mmc/host/sdhci-pltfm.c | =C2=A0 =C2=A03 ++
> =C2=A0drivers/mmc/host/sdhci-pltfm.h | =C2=A0 =C2=A01 +
> =C2=A05 files changed, 88 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 drivers/mmc/host/sdhci-dove.c
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 68d1279..4958839 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -130,6 +130,19 @@ config MMC_SDHCI_CNS3XXX
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If unsure, say N.
>
> +config MMC_SDHCI_DOVE
> + =C2=A0 =C2=A0 =C2=A0 bool "SDHCI support on Marvell's Dove SoC"
> + =C2=A0 =C2=A0 =C2=A0 depends on ARCH_DOVE
> + =C2=A0 =C2=A0 =C2=A0 depends on MMC_SDHCI_PLTFM
> + =C2=A0 =C2=A0 =C2=A0 select MMC_SDHCI_IO_ACCESSORS
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 This selects the Secure Digital Host Co=
ntroller Interface in
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Marvell's Dove SoC.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 If you have a controller with this inte=
rface, say Y or M here.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 If unsure, say N.
> +
> =C2=A0config MMC_SDHCI_S3C
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "SDHCI support on Samsung S3C SoC=
"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on MMC_SDHCI && PLAT_SAMSUNG
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 840bcb5..9e1c418 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_MMC_JZ4740) =C2=A0 =C2=A0 =C2=A0+=3D j=
z4740_mmc.o
> =C2=A0obj-$(CONFIG_MMC_SDHCI_PLTFM) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D sdhci-platform.o
> =C2=A0sdhci-platform-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=3D sdhci-plt=
fm.o
> =C2=A0sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX) =C2=A0 =C2=A0 +=3D s=
dhci-cns3xxx.o
> +sdhci-platform-$(CONFIG_MMC_SDHCI_DOVE) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D sdhci-dove.o
>
> =C2=A0obj-$(CONFIG_MMC_SDHCI_OF) =C2=A0 =C2=A0 +=3D sdhci-of.o
> =C2=A0sdhci-of-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=3D sdhci-of-core.o
> diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-d=
ove.c
> new file mode 100644
> index 0000000..561167c
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-dove.c
> @@ -0,0 +1,70 @@
> +/*
> + * sdhci-dove.c Support for SDHCI on Marvell's Dove SoC
> + *
> + * Author: Saeed Bishara <saeed@marvell.com>
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0Mike Rapoport <mike@compulab.co.il>
> + * Based on =C2=A0sdhci-cns3xxx.c
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See th=
e
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/mmc/host.h>
> +
> +#include "sdhci.h"
> +#include "sdhci-pltfm.h"
> +
> +static u16 sdhci_dove_readw(struct sdhci_host *host, int reg)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u16 ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (reg) {
> + =C2=A0 =C2=A0 =C2=A0 case SDHCI_HOST_VERSION:
> + =C2=A0 =C2=A0 =C2=A0 case SDHCI_SLOT_INT_STATUS:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* those registers=
 don't exist */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D readw(host=
->ioaddr + reg);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static u32 sdhci_dove_readl(struct sdhci_host *host, int reg)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u32 ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (reg) {
> + =C2=A0 =C2=A0 =C2=A0 case SDHCI_CAPABILITIES:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D readl(host=
->ioaddr + reg);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Mask the suppor=
t for 3.0V */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret &=3D ~SDHCI_CA=
N_VDD_300;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D readl(host=
->ioaddr + reg);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static struct sdhci_ops sdhci_dove_ops =3D {
> + =C2=A0 =C2=A0 =C2=A0 .read_w =3D sdhci_dove_readw,
> + =C2=A0 =C2=A0 =C2=A0 .read_l =3D sdhci_dove_readl,
> +};
> +
> +struct sdhci_pltfm_data sdhci_dove_pdata =3D {
> + =C2=A0 =C2=A0 =C2=A0 .ops =C2=A0 =C2=A0=3D &sdhci_dove_ops,
> + =C2=A0 =C2=A0 =C2=A0 .quirks =3D SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWE=
R |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SDHCI_QUIRK=
_NO_BUSY_IRQ |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SDHCI_QUIRK=
_BROKEN_TIMEOUT_VAL |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SDHCI_QUIRK=
_FORCE_DMA,
> +};
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-=
pltfm.c
> index e045e3c..28d818e 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -161,6 +161,9 @@ static const struct platform_device_id sdhci_pltf=
m_ids[] =3D {
> =C2=A0#ifdef CONFIG_MMC_SDHCI_CNS3XXX
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ "sdhci-cns3xxx", (kernel_ulong_t)&sdhci_=
cns3xxx_pdata },
> =C2=A0#endif
> +#ifdef CONFIG_MMC_SDHCI_DOVE
> + =C2=A0 =C2=A0 =C2=A0 { "sdhci-dove", (kernel_ulong_t)&sdhci_dove_pd=
ata },
> +#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ },
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-=
pltfm.h
> index 900f329..718d837 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -14,5 +14,6 @@
> =C2=A0#include <linux/sdhci-pltfm.h>
>
> =C2=A0extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
> +extern struct sdhci_pltfm_data sdhci_dove_pdata;
>
> =C2=A0#endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
> --
> 1.7.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
