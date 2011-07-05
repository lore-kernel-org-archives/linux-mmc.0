From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH v2] arm: mach-mmp: brownstone.c support multiple sd slots
Date: Tue, 5 Jul 2011 14:52:22 +0800
Message-ID: <CAMPhdO-TTRP-k7J-zrG2_rQJsmNDRhTgpqiiX2yqW+Egf8+t2A@mail.gmail.com>
References: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
 <20110427093328.GU17290@n2100.arm.linux.org.uk> <161C3F6C-0986-4364-B458-DBA4D08456FD@marvell.com>
 <1F336A22-BAC3-41E3-8D4E-5DF27874D1EA@marvell.com> <20110428095127.GX17290@n2100.arm.linux.org.uk>
 <3BFCE791-3BAD-42ED-BC87-A27F40D6C77C@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47686 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775Ab1GEGwo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2011 02:52:44 -0400
Received: by vws1 with SMTP id 1so3989880vws.19
        for <linux-mmc@vger.kernel.org>; Mon, 04 Jul 2011 23:52:43 -0700 (PDT)
In-Reply-To: <3BFCE791-3BAD-42ED-BC87-A27F40D6C77C@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Zhangfei Gao <zgao6@marvell.com>

On Fri, Apr 29, 2011 at 4:45 AM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> Support multiple sd/eMMC interfaces. enable mmc1, 2, and 3.
> mmc2 is used eMMC and slot is marked PERMANENT and 8 bit device.
> mmc1 is used for Wifi and slot is marked PERMANENT
>
> Note: eMMC (mmc2) is set to initialize first to workaround a problem
> where booting in logical order requires mmc create work queue
> to be multi-threaded otherwise boot process hangs. =C2=A0BUG report
> send to linux-mmc and linux-kernel mailing list.
>
> Wifi (mmc1) requires we enable power on the device by toggling
> the gpio lines for power and reset.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>

Applied. Though the email client was fiddling the spaces/CR-LF a bit.

> ---
> =C2=A0arch/arm/mach-mmp/brownstone.c | =C2=A0 52 ++++++++++++++++++++=
+++++++++++++++++++-
> =C2=A01 files changed, 51 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brown=
stone.c
> index 7bb78fd..577e8de 100644
> --- a/arch/arm/mach-mmp/brownstone.c
> +++ b/arch/arm/mach-mmp/brownstone.c
> @@ -19,6 +19,7 @@
> =C2=A0#include <linux/regulator/max8649.h>
> =C2=A0#include <linux/regulator/fixed.h>
> =C2=A0#include <linux/mfd/max8925.h>
> +#include <linux/delay.h>
>
> =C2=A0#include <asm/mach-types.h>
> =C2=A0#include <asm/mach/arch.h>
> @@ -177,9 +178,56 @@ static struct i2c_board_info brownstone_twsi1_in=
fo[] =3D {
> =C2=A0};
>
> =C2=A0static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 =3D {
> - =C2=A0 =C2=A0 =C2=A0 .max_speed =C2=A0 =C2=A0 =C2=A0=3D 25000000,
> + =C2=A0 =C2=A0 =C2=A0 .adjust_clocks =C2=A0=3D 1,
> + =C2=A0 =C2=A0 =C2=A0 .clk_select =C2=A0 =C2=A0 =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 .clk_delay =C2=A0 =C2=A0 =C2=A0=3D 31,
> =C2=A0};
>
> +static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 =3D {
> + =C2=A0 =C2=A0 =C2=A0 .adjust_clocks =C2=A0=3D 1,
> + =C2=A0 =C2=A0 =C2=A0 .clk_select =C2=A0 =C2=A0 =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 .clk_delay =C2=A0 =C2=A0 =C2=A0=3D 15,
> + =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D P=
XA_FLAG_CARD_PERMANENT,
> +};
> +
> +static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 =3D {
> + =C2=A0 =C2=A0 =C2=A0 .adjust_clocks =C2=A0=3D 1,
> + =C2=A0 =C2=A0 =C2=A0 .clk_select =C2=A0 =C2=A0 =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 .clk_delay =C2=A0 =C2=A0 =C2=A0=3D 31,
> + =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D P=
XA_FLAG_CARD_PERMANENT |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PXA_FLAG_SD_8_BIT_CAPABLE_SLOT,
> +};
> +
> +static void __init mmc_sdio_wifi(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int poweron;
> + =C2=A0 =C2=A0 =C2=A0 int reset;
> +
> + =C2=A0 =C2=A0 =C2=A0 poweron =3D mfp_to_gpio(GPIO57_GPIO);
> + =C2=A0 =C2=A0 =C2=A0 reset =3D mfp_to_gpio(GPIO58_GPIO);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (gpio_request(reset, "sd8xxx reset")) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_INFO "=
gpio %d request failed\n", reset);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (gpio_request(poweron, "sd8xxx PDn")) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_free(reset);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_INFO "=
gpio %d request failed\n", poweron);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 gpio_direction_output(poweron, 1);
> + =C2=A0 =C2=A0 =C2=A0 msleep(1);
> + =C2=A0 =C2=A0 =C2=A0 gpio_direction_output(reset, 0);
> + =C2=A0 =C2=A0 =C2=A0 msleep(1);
> + =C2=A0 =C2=A0 =C2=A0 gpio_direction_output(reset, 1);
> + =C2=A0 =C2=A0 =C2=A0 gpio_free(reset);
> + =C2=A0 =C2=A0 =C2=A0 gpio_free(poweron);
> +
> + =C2=A0 =C2=A0 =C2=A0 mmp2_add_sdhost(1, &mmp2_sdh_platdata_mmc1); /=
* Wifi */
> +}
> +
> =C2=A0static void __init brownstone_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mfp_config(ARRAY_AND_SIZE(brownstone_pin_c=
onfig));
> @@ -188,7 +236,9 @@ static void __init brownstone_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmp2_add_uart(1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmp2_add_uart(3);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brow=
nstone_twsi1_info));
> + =C2=A0 =C2=A0 =C2=A0 mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /=
* eMMC */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0=
); /* SD/MMC */
> + =C2=A0 =C2=A0 =C2=A0 mmc_sdio_wifi();
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* enable 5v regulator */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_device_register(&brownstone_v_5vp=
_device);
> --
> 1.7.0.4
>
>
>
