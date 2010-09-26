From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 3/4] esdhc-3 esdhc: fsl esdhc driver based on sdhci driver
Date: Sun, 26 Sep 2010 04:56:16 -0400
Message-ID: <AANLkTimLX-+Jyc-_Csqz09yPH1SKCwArV=NC0rEEqtrf@mail.gmail.com>
References: <1285299788-32209-1-git-send-email-r65037@freescale.com>
	<1285299788-32209-2-git-send-email-r65037@freescale.com>
	<1285299788-32209-3-git-send-email-r65037@freescale.com>
	<1285299788-32209-4-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38570 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab0IZI4R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 04:56:17 -0400
Received: by iwn5 with SMTP id 5so3755657iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 01:56:16 -0700 (PDT)
In-Reply-To: <1285299788-32209-4-git-send-email-r65037@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <r65037@freescale.com>
Cc: w.sang@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Sep 23, 2010 at 11:43 PM, Richard Zhu <r65037@freescale.com> wr=
ote:
> Based on SDHCI API, esdhc driver supports PIO and simple internal
> DMA modes.
>
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
> =A0drivers/mmc/host/Kconfig =A0 =A0 | =A0 13 ++
> =A0drivers/mmc/host/Makefile =A0 =A0| =A0 =A01 +
> =A0drivers/mmc/host/sdhci-imx.c | =A0395 ++++++++++++++++++++++++++++=
++++++++++++++
> =A03 files changed, 409 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/mmc/host/sdhci-imx.c
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 283190b..ce2840c 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -130,6 +130,19 @@ config MMC_SDHCI_CNS3XXX
>
> =A0 =A0 =A0 =A0 =A0If unsure, say N.
>
> +config MMC_SDHCI_IMX
> + =A0 =A0 =A0 tristate "Freescale i.MX platform eSDHCI support"
> + =A0 =A0 =A0 depends on ARCH_MX5 && MMC_SDHCI
> + =A0 =A0 =A0 depends on MMC_SDHCI_PLTFM
> + =A0 =A0 =A0 select MMC_SDHCI_IO_ACCESSORS
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This selects the Freescale i.MX Enhanced Secure Car=
d Host
> + =A0 =A0 =A0 =A0 Controller Interface.
> + =A0 =A0 =A0 =A0 If you have a i.MX platform with a Multimedia Card =
slot,
> + =A0 =A0 =A0 =A0 say Y or M here.
> +
> + =A0 =A0 =A0 =A0 If unsure, say N.
> +
> =A0config MMC_SDHCI_S3C
> =A0 =A0 =A0 =A0tristate "SDHCI support on Samsung S3C SoC"
> =A0 =A0 =A0 =A0depends on MMC_SDHCI && (PLAT_S3C24XX || PLAT_S3C64XX)
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 840bcb5..ae7c3e7 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_MMC_JZ4740) =A0 =A0 =A0+=3D jz4740_mmc=
=2Eo
> =A0obj-$(CONFIG_MMC_SDHCI_PLTFM) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=
=3D sdhci-platform.o
> =A0sdhci-platform-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 :=3D sdhci-pltfm.o
> =A0sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX) =A0 =A0 +=3D sdhci-cns3=
xxx.o
> +sdhci-platform-$(CONFIG_MMC_SDHCI_IMX) =A0 =A0 =A0 =A0 +=3D sdhci-im=
x.o
>
> =A0obj-$(CONFIG_MMC_SDHCI_OF) =A0 =A0 +=3D sdhci-of.o
> =A0sdhci-of-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 :=3D sdhci-of-core.o
> diff --git a/drivers/mmc/host/sdhci-imx.c b/drivers/mmc/host/sdhci-im=
x.c
> new file mode 100644
> index 0000000..6e34bcd
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-imx.c
> @@ -0,0 +1,395 @@
> +/*
> + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reser=
ved.
> + */
> +
> +/*
> + * sdhci-imx.c Support for SDHCI platform devices
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +/* Supports:
> + * SDHCI imx devices
> + *
> + * Inspired by sdhci-pci.c, by Pierre Ossman
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/highmem.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/gpio.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/mmc/host.h>
> +#include <linux/sdhci-pltfm.h>
> +
> +#include <mach/mmc.h>
> +
> +#include "sdhci.h"
> +#include "sdhci-pltfm.h"
> +
> +/* Vendor specified registors */
> +#define =A0 =A0 =A0 =A0FSL_SDHCI_WML =A0 =A0 =A0 =A0 =A0 0x44
> +#define =A0 =A0 =A0 =A0FSL_SDHCI_WML_16_WORDS =A00x08100810
> +#define =A0 =A0 =A0 =A0FSL_SDHCI_WML_32_WORDS =A00x08200820
> +#define =A0 =A0 =A0 =A0FSL_SDHCI_WML_64_WORDS =A00x08400840
> +#define =A0 =A0 =A0 =A0FSL_SDHCI_WML_128_WORDS 0x08800880
> +
> +/* Non-standard clock control registor */
> +#define ESDHC_SYSTEM_CONTROL =A0 0x2C
> +#define ESDHC_CLOCK_MASK =A0 =A0 =A0 0x0000FFF0
> +#define ESDHC_PREDIV_SHIFT =A0 =A0 8
> +#define ESDHC_DIVIDER_SHIFT =A0 =A04
> +#define ESDHC_CLOCK_PEREN =A0 =A0 =A00x00000004
> +#define ESDHC_CLOCK_HCKEN =A0 =A0 =A00x00000002
> +#define ESDHC_CLOCK_IPGEN =A0 =A0 =A00x00000001
> +
> +/* Non-standard host control registor */
> +#define =A0 =A0 =A0 =A0ESDHC_SDHCI_CTRL_8BITBUS =A0 =A0 =A0 =A00x000=
00004
> +#define =A0 =A0 =A0 =A0FSL_ESDHC_HOST_CONTROL_RES =A0 =A0 =A00x33E
> +#define ESDHC_HOST_CONTROL_LE =A0 =A0 =A0 =A0 =A00x20
> +
> +/*******************************************************************=
**********\
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 *
> + * SDHCI core callbacks =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 *
> +\*******************************************************************=
**********/
> +
> +static u32 sdhci_imx_readl(struct sdhci_host *host, int reg)
> +{
> + =A0 =A0 =A0 return readl(host->ioaddr + reg);
> +}
> +
> +static u16 sdhci_imx_readw(struct sdhci_host *host, int reg)
> +{
> + =A0 =A0 =A0 u32 val;
> + =A0 =A0 =A0 u16 rc;
> +
> + =A0 =A0 =A0 if (reg % 4 =3D=3D 3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Invalid reg address!\n=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 val =3D readl(host->ioaddr + (reg / 4) * 4);
> + =A0 =A0 =A0 rc =3D (val >> (reg % 4) * 8) & 0xFFFF;
> +
> + =A0 =A0 =A0 return rc;
> +}
> +
> +static u8 sdhci_imx_readb(struct sdhci_host *host, int reg)
> +{
> + =A0 =A0 =A0 u32 val;
> + =A0 =A0 =A0 u8 rc;
> +
> + =A0 =A0 =A0 val =3D readl(host->ioaddr + (reg / 4) * 4);
> + =A0 =A0 =A0 rc =3D (val >> (reg % 4) * 8) & 0xFF;
> + =A0 =A0 =A0 if (reg =3D=3D SDHCI_HOST_CONTROL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Bus width */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val & ESDHC_SDHCI_CTRL_8BITBUS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc |=3D SDHCI_CTRL_8BIT=
BUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc &=3D ~SDHCI_CTRL_4BI=
TBUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (val & SDHCI_CTRL_4BITBUS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc &=3D ~SDHCI_CTRL_8BI=
TBUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc |=3D SDHCI_CTRL_4BIT=
BUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc &=3D ~SDHCI_CTRL_8BI=
TBUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc &=3D ~SDHCI_CTRL_4BI=
TBUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DMA */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val & (SDHCI_CTRL_DMA_MASK << 5))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc |=3D ((val >> 5) & S=
DHCI_CTRL_DMA_MASK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME D3CD */
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return rc;
> +}
> +
> +static void sdhci_imx_writel(struct sdhci_host *host, u32 val, int r=
eg)
> +{
> + =A0 =A0 =A0 writel(val, host->ioaddr + reg);
> +}
> +
> +static void sdhci_imx_writew(struct sdhci_host *host, u16 val, int r=
eg)
> +{
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> +
> + =A0 =A0 =A0 u32 io_val;
> +
> + =A0 =A0 =A0 if (reg % 4 =3D=3D 3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Invalid reg address!\n=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (reg =3D=3D SDHCI_BLOCK_SIZE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Two last DMA bits are reserved, an=
d first one is used for
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* non-standard blksz of 4096 bytes t=
hat we don't support
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* yet. So clear the DMA boundary bit=
s.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~SDHCI_MAKE_BLKSZ(0x7, 0);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 io_val =3D readl(host->ioaddr + (reg / 4) * 4);
> + =A0 =A0 =A0 io_val &=3D ~(0xFFFF << ((reg % 4) * 8));
> + =A0 =A0 =A0 io_val |=3D val << ((reg % 4) * 8);
> +
> + =A0 =A0 =A0 switch (reg) {
> + =A0 =A0 =A0 case SDHCI_TRANSFER_MODE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Postpone this write, we must do it=
 together with a
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* command write that is down below.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pltfm_host->scratchpad =3D val;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 case SDHCI_COMMAND:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(io_val | pltfm_host->scratchpad,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 host->ioaddr + =A0SDHCI_TRANSFER_MODE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Make a double check that the warte=
 mark level register is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* configured properly. default value=
 is FSL_SDHCI_WML_16_WORDS
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (readl(host->ioaddr + FSL_SDHCI_WML)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D =
=46SL_SDHCI_WML_16_WORDS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->flags & SDHCI=
_REQ_USE_DMA)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(=
=46SL_SDHCI_WML_64_WORDS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 host->ioaddr + FSL_SDHCI_WML);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(=
=46SL_SDHCI_WML_128_WORDS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 host->ioaddr + FSL_SDHCI_WML);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 writel(io_val, host->ioaddr + (reg / 4) * 4);
> +}
> +
> +static void sdhci_imx_set_power(struct sdhci_host *host, u8 power)
> +{
> + =A0 =A0 =A0 int voltage =3D 0;
> +
> + =A0 =A0 =A0 /* There is no sdhci standard PWR CTL REG in imx sdhci =
*/
> + =A0 =A0 =A0 if (host->pwr =3D=3D power)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (host->vmmc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (power =3D=3D (unsigned short)-1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_disable(host-=
>vmmc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(mmc_dev(host->m=
mc), "mmc power off\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (power =3D=3D 7)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltage=
 =3D 1800000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (power >=3D 8)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltage=
 =3D 2000000 + (power - 8) * 100000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_set_voltage(h=
ost->vmmc, voltage, voltage);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (regulator_enable(ho=
st->vmmc) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg=
(mmc_dev(host->mmc), "mmc power on\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(=
1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 host->pwr =3D power;
> +}
> +
> +static void sdhci_imx_writeb(struct sdhci_host *host, u8 val, int re=
g)
> +{
> + =A0 =A0 =A0 u32 io_val;
> +
> + =A0 =A0 =A0 /* Since there is no power register in FSL eSDHC, handl=
e it in SW */
> + =A0 =A0 =A0 if (reg =3D=3D SDHCI_POWER_CONTROL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_imx_set_power(host, val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (reg =3D=3D SDHCI_HOST_CONTROL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 io_val =3D readl(host->ioaddr + SDHCI_H=
OST_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Bit7~6, andi bit0 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 io_val |=3D (val & ~FSL_ESDHC_HOST_CONT=
ROL_RES);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ensure the LE mode */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 io_val |=3D ESDHC_HOST_CONTROL_LE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Configure the bus_width 8bits, 4bits=
, or 1bit*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val & SDHCI_CTRL_8BITBUS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 io_val |=3D ESDHC_SDHCI=
_CTRL_8BITBUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 io_val &=3D ~SDHCI_CTRL=
_4BITBUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (val & SDHCI_CTRL_4BITBUS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 io_val &=3D ~ESDHC_SDHC=
I_CTRL_8BITBUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 io_val |=3D SDHCI_CTRL_=
4BITBUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 io_val &=3D ~ESDHC_SDHC=
I_CTRL_8BITBUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 io_val &=3D ~SDHCI_CTRL=
_4BITBUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Configure the DMA */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val & SDHCI_CTRL_DMA_MASK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 io_val |=3D (val & SDHC=
I_CTRL_DMA_MASK) << 5;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(io_val, host->ioaddr + SDHCI_HOS=
T_CONTROL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 io_val =3D readl(host->ioaddr + (reg / 4) * 4);
> + =A0 =A0 =A0 io_val &=3D ~(0xFF << ((reg % 4) * 8));
> + =A0 =A0 =A0 io_val |=3D val << ((reg % 4) * 8);
> +
> + =A0 =A0 =A0 writel(io_val, host->ioaddr + (reg / 4) * 4);
> +}
> +
> +static unsigned int sdhci_imx_get_max_clock(struct sdhci_host *host)
> +{
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> +
> + =A0 =A0 =A0 return clk_get_rate(pltfm_host->clk);
> +}
> +
> +static unsigned int sdhci_imx_get_min_clock(struct sdhci_host *host)
> +{
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> +
> + =A0 =A0 =A0 return clk_get_rate(pltfm_host->clk) / 256 / 16;
> +}
> +
> +static unsigned int sdhci_imx_get_timeout_clock(struct sdhci_host *h=
ost)
> +{
> + =A0 =A0 =A0 return sdhci_imx_get_max_clock(host) / 1000000;
> +}
> +
> +static unsigned int sdhci_imx_get_ro(struct sdhci_host *host)
> +{
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> +
> + =A0 =A0 =A0 return gpio_get_value(pltfm_host->wp_gpio);
> +}
> +
> +static void sdhci_imx_set_clock(struct sdhci_host *host, unsigned in=
t clock)
> +{
> + =A0 =A0 =A0 int pre_div =3D 2;
> + =A0 =A0 =A0 int div =3D 1;
> + =A0 =A0 =A0 u32 temp;
> +
> + =A0 =A0 =A0 temp =3D sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> + =A0 =A0 =A0 temp &=3D ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESD=
HC_CLOCK_PEREN
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | ESDHC_CLOCK_MASK);
> + =A0 =A0 =A0 sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> +
> + =A0 =A0 =A0 if (clock =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 while (host->max_clk / pre_div / 16 > clock && pre_div =
< 256)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pre_div *=3D 2;
> +
> + =A0 =A0 =A0 while (host->max_clk / pre_div / div > clock && div < 1=
6)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 div++;
> +
> + =A0 =A0 =A0 dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actu=
al: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock, host->max_clk / pre_div / div);
> +
> + =A0 =A0 =A0 pre_div >>=3D 1;
> + =A0 =A0 =A0 div--;
> +
> + =A0 =A0 =A0 temp =3D sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> + =A0 =A0 =A0 temp |=3D (ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDH=
C_CLOCK_PEREN
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (div << ESDHC_DIVIDER=
_SHIFT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (pre_div << ESDHC_PRE=
DIV_SHIFT));
> + =A0 =A0 =A0 sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> + =A0 =A0 =A0 mdelay(10);
> +out:
> + =A0 =A0 =A0 host->clock =3D clock;
> +}
> +
> +static int sdhci_imx_enable_dma(struct sdhci_host *host)
> +{
> + =A0 =A0 =A0 u32 ctrl;
> +
> + =A0 =A0 =A0 ctrl =3D readl(host->ioaddr + SDHCI_HOST_CONTROL);
> + =A0 =A0 =A0 ctrl &=3D ~(SDHCI_CTRL_DMA_MASK << 5);
> + =A0 =A0 =A0 if ((host->flags & SDHCI_REQ_USE_DMA) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->flags & SDHCI_USE_ADMA))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D (SDHCI_CTRL_ADMA32 << 8);
> + =A0 =A0 =A0 else if (host->flags & SDHCI_REQ_USE_DMA)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D (SDHCI_CTRL_SDMA << 8);
> +
> + =A0 =A0 =A0 writel(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
> +
> + =A0 =A0 =A0 if (host->flags & SDHCI_REQ_USE_DMA)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(FSL_SDHCI_WML_64_WORDS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->i=
oaddr + FSL_SDHCI_WML);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(FSL_SDHCI_WML_128_WORDS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->i=
oaddr + FSL_SDHCI_WML);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int __match_sdhci_imx(struct device *dev, void *data)
> +{
> + =A0 =A0 =A0 return !strncmp(dev_name(dev), "imx-sdhci", 9);
> +}
> +static int sdhci_imx_init(struct sdhci_host *host)
> +{
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> + =A0 =A0 =A0 struct clk *clk;
> + =A0 =A0 =A0 struct device *dev;
> +

Not sure how many device is served, what driver get here is only
imx-sdhci.0, but  imx-sdhci.1,  imx-sdhci.2 will never come up.
So this method only right for one device.

> + =A0 =A0 =A0 dev =3D device_find_child(mmc_dev(host->mmc), NULL, __m=
atch_sdhci_imx);
> + =A0 =A0 =A0 clk =3D clk_get(dev, "imx_sdhc_clk");
> + =A0 =A0 =A0 if (IS_ERR(clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mmc_dev(host->mmc), "clk err\n"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 clk_enable(clk);
> + =A0 =A0 =A0 pltfm_host->clk =3D clk;
> + =A0 =A0 =A0 dev_dbg(dev, "SDHC clock:%lu\n", clk_get_rate(clk));
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void sdhci_imx_exit(struct sdhci_host *host)
> +{
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> +
> + =A0 =A0 =A0 clk_disable(pltfm_host->clk);
> + =A0 =A0 =A0 clk_put(pltfm_host->clk);
> +}
> +
> +
> +static struct sdhci_ops sdhci_imx_ops =3D {
> + =A0 =A0 =A0 .read_l =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D sdhci_imx_r=
eadl,
> + =A0 =A0 =A0 .read_w =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D sdhci_imx_r=
eadw,
> + =A0 =A0 =A0 .read_b =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D sdhci_imx_r=
eadb,
> + =A0 =A0 =A0 .write_l =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D sdhci_imx_w=
ritel,
> + =A0 =A0 =A0 .write_w =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D sdhci_imx_w=
ritew,
> + =A0 =A0 =A0 .write_b =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D sdhci_imx_w=
riteb,
> + =A0 =A0 =A0 .set_clock =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D sdhci_imx_set=
_clock,
> + =A0 =A0 =A0 .enable_dma =A0 =A0 =A0 =A0 =A0 =A0 =3D sdhci_imx_enabl=
e_dma,
> + =A0 =A0 =A0 .get_max_clock =A0 =A0 =A0 =A0 =A0=3D sdhci_imx_get_max=
_clock,
> + =A0 =A0 =A0 .get_min_clock =A0 =A0 =A0 =A0 =A0=3D sdhci_imx_get_min=
_clock,
> + =A0 =A0 =A0 .get_timeout_clock =A0 =A0 =A0=3D sdhci_imx_get_timeout=
_clock,
> + =A0 =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D sdhci_imx_g=
et_ro,
> +};
> +
> +struct sdhci_pltfm_data sdhci_imx_pdata =3D {
> + =A0 =A0 =A0 .ops =3D &sdhci_imx_ops,
> + =A0 =A0 =A0 .quirks =3D SDHCI_QUIRK_BROKEN_ADMA
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_32BIT_DMA_ADDR
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_32BIT_ADMA_SIZE
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_NO_BUSY_IRQ
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_BROKEN_CARD_DETECTION
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_NONSTANDARD_CLOCK
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET,
> + =A0 =A0 =A0 .init =3D sdhci_imx_init,
> + =A0 =A0 =A0 .exit =3D sdhci_imx_exit,
> +};
> --
> 1.7.0
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
