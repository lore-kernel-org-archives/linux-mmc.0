From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/3] mmc: sdhci-esdhc-imx: get rid of the uses of cpu_is_mx()
Date: Tue, 5 Jul 2011 11:47:30 -0600
Message-ID: <CACxGe6uRTDss+kn5h-VGQhQ45fWpTdGj4wNn=NczAfF_55UU5g@mail.gmail.com>
References: <1309879568-25837-1-git-send-email-shawn.guo@linaro.org> <1309879568-25837-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48297 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab1GERrv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2011 13:47:51 -0400
Received: by ywe9 with SMTP id 9so2360738ywe.19
        for <linux-mmc@vger.kernel.org>; Tue, 05 Jul 2011 10:47:50 -0700 (PDT)
In-Reply-To: <1309879568-25837-2-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Tue, Jul 5, 2011 at 9:26 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> The patch removes all the uses of cpu_is_mx(). =A0Instead, it utilize=
s
> platform_device_id to distinguish the esdhc differences among SoCs.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Chris Ball <cjb@laptop.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/arm/mach-imx/clock-imx25.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A04 +-
> =A0arch/arm/mach-imx/clock-imx35.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A06 +-
> =A0arch/arm/mach-mx5/clock-mx51-mx53.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 16 +++---
> =A0arch/arm/mach-mx5/mx51_efika.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A04 +-
> =A0.../plat-mxc/devices/platform-sdhci-esdhc-imx.c =A0 =A0| =A0 17 ++=
+---
> =A0arch/arm/plat-mxc/include/mach/devices-common.h =A0 =A0| =A0 =A01 =
+
> =A0drivers/mmc/host/sdhci-esdhc-imx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 60 ++++++++++++++++++-
> =A07 files changed, 81 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/cloc=
k-imx25.c
> index a65838f..2955afa 100644
> --- a/arch/arm/mach-imx/clock-imx25.c
> +++ b/arch/arm/mach-imx/clock-imx25.c
> @@ -300,8 +300,8 @@ static struct clk_lookup lookups[] =3D {
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx2-wdt.0", NULL, wdt_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
> - =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
> - =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
> + =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx25.0", NULL, esdhc1_clk=
)
> + =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx25.1", NULL, esdhc2_clk=
)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("mx2-camera.0", NULL, csi_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
> diff --git a/arch/arm/mach-imx/clock-imx35.c b/arch/arm/mach-imx/cloc=
k-imx35.c
> index 5a4cc1e..2f80f14 100644
> --- a/arch/arm/mach-imx/clock-imx35.c
> +++ b/arch/arm/mach-imx/clock-imx35.c
> @@ -458,9 +458,9 @@ static struct clk_lookup lookups[] =3D {
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx-epit.0", NULL, epit1_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx-epit.1", NULL, epit2_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK(NULL, "esai", esai_clk)
> - =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
> - =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
> - =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx.2", NULL, esdhc3_clk)
> + =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx35.0", NULL, esdhc1_clk=
)
> + =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx35.1", NULL, esdhc2_clk=
)
> + =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx35.2", NULL, esdhc3_clk=
)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("fec.0", NULL, fec_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK(NULL, "gpio", gpio1_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK(NULL, "gpio", gpio2_clk)
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/=
clock-mx51-mx53.c
> index 699b0d2..fd60e2c 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1453,10 +1453,10 @@ static struct clk_lookup mx51_lookups[] =3D {
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx51-ecspi.0", NULL, ecspi1_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx51-ecspi.1", NULL, ecspi2_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx51-cspi.0", NULL, cspi_clk)
> - =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
> - =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
> - =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx.2", NULL, esdhc3_clk)
> - =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx.3", NULL, esdhc4_clk)
> + =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx51.0", NULL, esdhc1_clk=
)
> + =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx51.1", NULL, esdhc2_clk=
)
> + =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx51.2", NULL, esdhc3_clk=
)
> + =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx51.3", NULL, esdhc4_clk=
)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK(NULL, "cpu_clk", cpu_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
> @@ -1480,10 +1480,10 @@ static struct clk_lookup mx53_lookups[] =3D {
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx-i2c.2", NULL, i2c3_mx53_clk)
> - =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
> - =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_mx53_=
clk)
> - =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx.2", NULL, esdhc3_mx53_=
clk)
> - =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx.3", NULL, esdhc4_mx53_=
clk)
> + =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx53.0", NULL, esdhc1_clk=
)
> + =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx53.1", NULL, esdhc2_mx5=
3_clk)
> + =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx53.2", NULL, esdhc3_mx5=
3_clk)
> + =A0 =A0 =A0 _REGISTER_CLOCK("sdhci-esdhc-imx53.3", NULL, esdhc4_mx5=
3_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx53-ecspi.0", NULL, ecspi1_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx53-ecspi.1", NULL, ecspi2_clk)
> =A0 =A0 =A0 =A0_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
> diff --git a/arch/arm/mach-mx5/mx51_efika.c b/arch/arm/mach-mx5/mx51_=
efika.c
> index 56739c2..4435e03 100644
> --- a/arch/arm/mach-mx5/mx51_efika.c
> +++ b/arch/arm/mach-mx5/mx51_efika.c
> @@ -260,8 +260,8 @@ static struct regulator_consumer_supply vvideo_co=
nsumers[] =3D {
> =A0};
>
> =A0static struct regulator_consumer_supply vsd_consumers[] =3D {
> - =A0 =A0 =A0 REGULATOR_SUPPLY("vmmc", "sdhci-esdhc-imx.0"),
> - =A0 =A0 =A0 REGULATOR_SUPPLY("vmmc", "sdhci-esdhc-imx.1"),
> + =A0 =A0 =A0 REGULATOR_SUPPLY("vmmc", "sdhci-esdhc-imx51.0"),
> + =A0 =A0 =A0 REGULATOR_SUPPLY("vmmc", "sdhci-esdhc-imx51.1"),
> =A0};
>
> =A0static struct regulator_consumer_supply pwgt1_consumer[] =3D {
> diff --git a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c b/a=
rch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
> index 79d6d71..5955f5d 100644
> --- a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
> +++ b/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
> @@ -10,21 +10,22 @@
> =A0#include <mach/devices-common.h>
> =A0#include <mach/esdhc.h>
>
> -#define imx_sdhci_esdhc_imx_data_entry_single(soc, _id, hwid) \
> +#define imx_sdhci_esdhc_imx_data_entry_single(soc, _devid, _id, hwid=
) \
> =A0 =A0 =A0 =A0{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devid =3D _devid, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.id =3D _id, =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.iobase =3D soc ## _ESDHC ## hwid ## _=
BASE_ADDR, =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.irq =3D soc ## _INT_ESDHC ## hwid, =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0}
>
> -#define imx_sdhci_esdhc_imx_data_entry(soc, id, hwid) =A0\
> - =A0 =A0 =A0 [id] =3D imx_sdhci_esdhc_imx_data_entry_single(soc, id,=
 hwid)
> +#define imx_sdhci_esdhc_imx_data_entry(soc, devid, id, hwid) =A0 \
> + =A0 =A0 =A0 [id] =3D imx_sdhci_esdhc_imx_data_entry_single(soc, dev=
id, id, hwid)
>
> =A0#ifdef CONFIG_SOC_IMX25
> =A0const struct imx_sdhci_esdhc_imx_data
> =A0imx25_sdhci_esdhc_imx_data[] __initconst =3D {
> =A0#define imx25_sdhci_esdhc_imx_data_entry(_id, _hwid) =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 imx_sdhci_esdhc_imx_data_entry(MX25, _id, _hwid)
> + =A0 =A0 =A0 imx_sdhci_esdhc_imx_data_entry(MX25, "sdhci-esdhc-imx25=
", _id, _hwid)
> =A0 =A0 =A0 =A0imx25_sdhci_esdhc_imx_data_entry(0, 1),
> =A0 =A0 =A0 =A0imx25_sdhci_esdhc_imx_data_entry(1, 2),
> =A0};
> @@ -34,7 +35,7 @@ imx25_sdhci_esdhc_imx_data[] __initconst =3D {
> =A0const struct imx_sdhci_esdhc_imx_data
> =A0imx35_sdhci_esdhc_imx_data[] __initconst =3D {
> =A0#define imx35_sdhci_esdhc_imx_data_entry(_id, _hwid) =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 imx_sdhci_esdhc_imx_data_entry(MX35, _id, _hwid)
> + =A0 =A0 =A0 imx_sdhci_esdhc_imx_data_entry(MX35, "sdhci-esdhc-imx35=
", _id, _hwid)
> =A0 =A0 =A0 =A0imx35_sdhci_esdhc_imx_data_entry(0, 1),
> =A0 =A0 =A0 =A0imx35_sdhci_esdhc_imx_data_entry(1, 2),
> =A0 =A0 =A0 =A0imx35_sdhci_esdhc_imx_data_entry(2, 3),
> @@ -45,7 +46,7 @@ imx35_sdhci_esdhc_imx_data[] __initconst =3D {
> =A0const struct imx_sdhci_esdhc_imx_data
> =A0imx51_sdhci_esdhc_imx_data[] __initconst =3D {
> =A0#define imx51_sdhci_esdhc_imx_data_entry(_id, _hwid) =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 imx_sdhci_esdhc_imx_data_entry(MX51, _id, _hwid)
> + =A0 =A0 =A0 imx_sdhci_esdhc_imx_data_entry(MX51, "sdhci-esdhc-imx51=
", _id, _hwid)
> =A0 =A0 =A0 =A0imx51_sdhci_esdhc_imx_data_entry(0, 1),
> =A0 =A0 =A0 =A0imx51_sdhci_esdhc_imx_data_entry(1, 2),
> =A0 =A0 =A0 =A0imx51_sdhci_esdhc_imx_data_entry(2, 3),
> @@ -57,7 +58,7 @@ imx51_sdhci_esdhc_imx_data[] __initconst =3D {
> =A0const struct imx_sdhci_esdhc_imx_data
> =A0imx53_sdhci_esdhc_imx_data[] __initconst =3D {
> =A0#define imx53_sdhci_esdhc_imx_data_entry(_id, _hwid) =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 imx_sdhci_esdhc_imx_data_entry(MX53, _id, _hwid)
> + =A0 =A0 =A0 imx_sdhci_esdhc_imx_data_entry(MX53, "sdhci-esdhc-imx53=
", _id, _hwid)
> =A0 =A0 =A0 =A0imx53_sdhci_esdhc_imx_data_entry(0, 1),
> =A0 =A0 =A0 =A0imx53_sdhci_esdhc_imx_data_entry(1, 2),
> =A0 =A0 =A0 =A0imx53_sdhci_esdhc_imx_data_entry(2, 3),
> @@ -93,6 +94,6 @@ struct platform_device *__init imx_add_sdhci_esdhc_=
imx(
> =A0 =A0 =A0 =A0if (!pdata)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata =3D &default_esdhc_pdata;
>
> - =A0 =A0 =A0 return imx_add_platform_device("sdhci-esdhc-imx", data-=
>id, res,
> + =A0 =A0 =A0 return imx_add_platform_device(data->devid, data->id, r=
es,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(res), pdata=
, sizeof(*pdata));
> =A0}
> diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/a=
rm/plat-mxc/include/mach/devices-common.h
> index bf93820..c9e7b66 100644
> --- a/arch/arm/plat-mxc/include/mach/devices-common.h
> +++ b/arch/arm/plat-mxc/include/mach/devices-common.h
> @@ -276,6 +276,7 @@ struct platform_device *__init imx_add_mxc_w1(
>
> =A0#include <mach/esdhc.h>
> =A0struct imx_sdhci_esdhc_imx_data {
> + =A0 =A0 =A0 const char *devid;
> =A0 =A0 =A0 =A0int id;
> =A0 =A0 =A0 =A0resource_size_t iobase;
> =A0 =A0 =A0 =A0resource_size_t irq;
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sd=
hci-esdhc-imx.c
> index 3cc6f61..1edda29 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -20,7 +20,6 @@
> =A0#include <linux/mmc/host.h>
> =A0#include <linux/mmc/mmc.h>
> =A0#include <linux/mmc/sdio.h>
> -#include <mach/hardware.h>
> =A0#include <mach/esdhc.h>
> =A0#include "sdhci-pltfm.h"
> =A0#include "sdhci-esdhc.h"
> @@ -42,11 +41,57 @@
> =A0*/
> =A0#define ESDHC_FLAG_MULTIBLK_NO_INT =A0 =A0 (1 << 1)
>
> +enum imx_esdhc_type {
> + =A0 =A0 =A0 IMX25_ESDHC,
> + =A0 =A0 =A0 IMX35_ESDHC,
> + =A0 =A0 =A0 IMX51_ESDHC,
> + =A0 =A0 =A0 IMX53_ESDHC,
> +};
> +
> =A0struct pltfm_imx_data {
> =A0 =A0 =A0 =A0int flags;
> =A0 =A0 =A0 =A0u32 scratchpad;
> + =A0 =A0 =A0 enum imx_esdhc_type devtype;
> +};
> +
> +static struct platform_device_id imx_esdhc_devtype[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "sdhci-esdhc-imx25",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =3D IMX25_ESDHC,
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "sdhci-esdhc-imx35",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =3D IMX35_ESDHC,
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "sdhci-esdhc-imx51",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =3D IMX51_ESDHC,
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "sdhci-esdhc-imx53",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =3D IMX53_ESDHC,
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* sentinel */
> + =A0 =A0 =A0 }
> =A0};
>
> +static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
> +{
> + =A0 =A0 =A0 return data->devtype =3D=3D IMX25_ESDHC;
> +}
> +
> +static inline int is_imx35_esdhc(struct pltfm_imx_data *data)
> +{
> + =A0 =A0 =A0 return data->devtype =3D=3D IMX35_ESDHC;
> +}
> +
> +static inline int is_imx51_esdhc(struct pltfm_imx_data *data)
> +{
> + =A0 =A0 =A0 return data->devtype =3D=3D IMX51_ESDHC;
> +}
> +
> +static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
> +{
> + =A0 =A0 =A0 return data->devtype =3D=3D IMX53_ESDHC;
> +}
> +
> =A0static unsigned int esdhc_pltfm_get_max_blk_size(struct sdhci_host=
 *host)
> =A0{
> =A0 =A0 =A0 =A0/* Force 2048 bytes, which is the maximum supported si=
ze in SDHCI. */
> @@ -55,8 +100,12 @@ static unsigned int esdhc_pltfm_get_max_blk_size(=
struct sdhci_host *host)
>
> =A0static unsigned int esdhc_pltfm_get_max_blk_count(struct sdhci_hos=
t *host)
> =A0{
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> + =A0 =A0 =A0 struct pltfm_imx_data *imx_data =3D pltfm_host->priv;
> +
> =A0 =A0 =A0 =A0/* Fix errata ENGcm07207 which is present on i.MX25 an=
d i.MX35 */
> - =A0 =A0 =A0 return (cpu_is_mx25() || cpu_is_mx35()) ? 1 : 65535;
> + =A0 =A0 =A0 return (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_=
data)) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 : 65535;
> =A0}
>
> =A0static inline void esdhc_clrset_le(struct sdhci_host *host, u32 ma=
sk, u32 val, int reg)
> @@ -274,6 +323,8 @@ static int __devinit sdhci_esdhc_imx_probe(struct=
 platform_device *pdev)
> =A0 =A0 =A0 =A0imx_data =3D kzalloc(sizeof(struct pltfm_imx_data), GF=
P_KERNEL);
> =A0 =A0 =A0 =A0if (!imx_data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> +
> + =A0 =A0 =A0 imx_data->devtype =3D pdev->id_entry->driver_data;
> =A0 =A0 =A0 =A0pltfm_host->priv =3D imx_data;
>
> =A0 =A0 =A0 =A0clk =3D clk_get(mmc_dev(host->mmc), NULL);
> @@ -285,10 +336,10 @@ static int __devinit sdhci_esdhc_imx_probe(stru=
ct platform_device *pdev)
> =A0 =A0 =A0 =A0clk_enable(clk);
> =A0 =A0 =A0 =A0pltfm_host->clk =3D clk;
>
> - =A0 =A0 =A0 if (!cpu_is_mx25())
> + =A0 =A0 =A0 if (!is_imx25_esdhc(imx_data))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->quirks |=3D SDHCI_QUIRK_BROKEN_T=
IMEOUT_VAL;
>
> - =A0 =A0 =A0 if (!(cpu_is_mx25() || cpu_is_mx35() || cpu_is_mx51()))
> + =A0 =A0 =A0 if (is_imx53_esdhc(imx_data))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0imx_data->flags |=3D ESDHC_FLAG_MULTIB=
LK_NO_INT;
>
> =A0 =A0 =A0 =A0boarddata =3D host->mmc->parent->platform_data;
> @@ -401,6 +452,7 @@ static struct platform_driver sdhci_esdhc_imx_dri=
ver =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "sdhci-esdhc-imx",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D imx_esdhc_devtype,
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D sdhci_esdhc_imx_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(sdhci_esdhc_im=
x_remove),
> =A0#ifdef CONFIG_PM
> --
> 1.7.4.1
>
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
