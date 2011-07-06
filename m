From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v3] arm: mach-mmp: brownstone.c support multiple sd slots
Date: Wed, 6 Jul 2011 15:19:34 +0800
Message-ID: <CAMj5BkjQNQtnU1s+KqGjX0i9j+oQkbcY9cOonp1fNu=DEy-YyA@mail.gmail.com>
References: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
	<20110427093328.GU17290@n2100.arm.linux.org.uk>
	<161C3F6C-0986-4364-B458-DBA4D08456FD@marvell.com>
	<1F336A22-BAC3-41E3-8D4E-5DF27874D1EA@marvell.com>
	<20110428095127.GX17290@n2100.arm.linux.org.uk>
	<3BFCE791-3BAD-42ED-BC87-A27F40D6C77C@marvell.com>
	<CAMPhdO-TTRP-k7J-zrG2_rQJsmNDRhTgpqiiX2yqW+Egf8+t2A@mail.gmail.com>
	<CAMj5BkiK17RMY-vEENDqQiDOmfG0Esnp7QDooKWVrhkQL4g6Ow@mail.gmail.com>
	<CAMPhdO-b_dpC2ueexEFujr6p_NRb2JwDc0-UEx3cfOSVcZ-d6w@mail.gmail.com>
	<67F311C7-B489-41E6-BC85-C06DACC7263A@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56737 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129Ab1GFHTf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2011 03:19:35 -0400
Received: by qwk3 with SMTP id 3so3211507qwk.19
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jul 2011 00:19:34 -0700 (PDT)
In-Reply-To: <67F311C7-B489-41E6-BC85-C06DACC7263A@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Zhangfei Gao <zgao6@marvell.com>

On Wed, Jul 6, 2011 at 4:20 AM, Philip Rakity <prakity@marvell.com> wro=
te:
> Subject: [PATCH V3] arm: mach-mmp: brownstone.c support multiple sd s=
lots
>
> V3
> =3D=3D
> Change since V2 -- delete mmc3 since it was committed
> to linux next.
>
> enable mmc1 used for wifi (8688) and marked PERMANENT.
> Wifi requires enabling of power on the device by
> toggling the gpio lines for power and reset. =A0Enable eMMC first to =
work
> around problem in booting order due to workqueue bug.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
> =A0arch/arm/mach-mmp/brownstone.c | =A0 41 ++++++++++++++++++++++++++=
+++++++++++++-
> =A01 files changed, 40 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brown=
stone.c
> index c79162a..940982c 100644
> --- a/arch/arm/mach-mmp/brownstone.c
> +++ b/arch/arm/mach-mmp/brownstone.c
> @@ -19,6 +19,7 @@
> =A0#include <linux/regulator/max8649.h>
> =A0#include <linux/regulator/fixed.h>
> =A0#include <linux/mfd/max8925.h>
> +#include <linux/delay.h>
>
> =A0#include <asm/mach-types.h>
> =A0#include <asm/mach/arch.h>
> @@ -180,6 +181,11 @@ static struct sdhci_pxa_platdata mmp2_sdh_platda=
ta_mmc0 =3D {
> =A0 =A0 =A0 =A0.clk_delay_cycles =3D 0x1f,
> =A0};
>
> +static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 =3D {
> + =A0 =A0 =A0 .clk_delay_cycles =3D 0x1f,
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D PXA_FLAG_CARD_PERMANENT,
> +};
> +
> =A0static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 =3D {
> =A0 =A0 =A0 =A0.clk_delay_cycles =3D 0x1f,
> =A0 =A0 =A0 =A0.flags =3D PXA_FLAG_CARD_PERMANENT
> @@ -187,6 +193,38 @@ static struct sdhci_pxa_platdata mmp2_sdh_platda=
ta_mmc2 =3D {
> =A0};
>
>
> +static void __init mmc_sdio_wifi(void)
> +{
> + =A0 =A0 =A0 int poweron;
> + =A0 =A0 =A0 int reset;
> +
> + =A0 =A0 =A0 poweron =3D mfp_to_gpio(GPIO57_GPIO);
> + =A0 =A0 =A0 reset =3D mfp_to_gpio(GPIO58_GPIO);
> +
> + =A0 =A0 =A0 if (gpio_request(reset, "sd8xxx reset")) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "gpio %d request faile=
d\n", reset);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (gpio_request(poweron, "sd8xxx PDn")) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(reset);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "gpio %d request faile=
d\n", poweron);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 gpio_direction_output(poweron, 0);
> + =A0 =A0 =A0 msleep(1);
> + =A0 =A0 =A0 gpio_direction_output(poweron, 1);
> + =A0 =A0 =A0 msleep(1);
> + =A0 =A0 =A0 gpio_direction_output(reset, 0);
> + =A0 =A0 =A0 msleep(1);
> + =A0 =A0 =A0 gpio_direction_output(reset, 1);
> + =A0 =A0 =A0 gpio_free(reset);
> + =A0 =A0 =A0 gpio_free(poweron);
> +
> + =A0 =A0 =A0 mmp2_add_sdhost(1, &mmp2_sdh_platdata_mmc1); /* Wifi */
> +}
> +

The method keeps power on wifi chip, without dynamically
enable/disable wifi power, which is not final solution.
How about pushing later with dynamically control power, which is in
debugging here.

> =A0static void __init brownstone_init(void)
> =A0{
> =A0 =A0 =A0 =A0mfp_config(ARRAY_AND_SIZE(brownstone_pin_config));
> @@ -195,8 +233,9 @@ static void __init brownstone_init(void)
> =A0 =A0 =A0 =A0mmp2_add_uart(1);
> =A0 =A0 =A0 =A0mmp2_add_uart(3);
> =A0 =A0 =A0 =A0mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1=
_info));
> - =A0 =A0 =A0 mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC =
*/
> =A0 =A0 =A0 =A0mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /* eMMC *=
/
> + =A0 =A0 =A0 mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC =
*/
> + =A0 =A0 =A0 mmc_sdio_wifi();
>
> =A0 =A0 =A0 =A0/* enable 5v regulator */
> =A0 =A0 =A0 =A0platform_device_register(&brownstone_v_5vp_device);
> --
> 1.7.0.4
