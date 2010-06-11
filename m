From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 3/3] s5pv210: Aquila: add definitions for sdhci devices
Date: Fri, 11 Jun 2010 15:05:32 +0900
Message-ID: <AANLkTil5a4B4Yk31MnEtCc80-645x09ZvCOCHcyIY-vS@mail.gmail.com>
References: <1276076345-24370-1-git-send-email-m.szyprowski@samsung.com>
	<1276076345-24370-4-git-send-email-m.szyprowski@samsung.com>
	<20100611051825.GW7248@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:47491 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab0FKGFd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jun 2010 02:05:33 -0400
In-Reply-To: <20100611051825.GW7248@trinity.fluff.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kgene.kim@samsung.com

On Fri, Jun 11, 2010 at 2:18 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Wed, Jun 09, 2010 at 11:39:05AM +0200, Marek Szyprowski wrote:
>> This patch add support for SDHCI blocks on Samsung Aquila board. The
>> following host controllers are defined:
>> 1. Internal MoviNAND device (permanently wired to the controller)
>> 2. Internal WiFI SDIO device (card is activated by power regualor)
>> 3. External MMC/SD socket (card detection is provided by external
>> gpio interrupt)
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> =A0arch/arm/mach-s5pv210/Kconfig =A0 =A0 =A0 | =A0 =A04 ++
>> =A0arch/arm/mach-s5pv210/mach-aquila.c | =A0 66 ++++++++++++++++++++=
+++++++++++++++
>> =A02 files changed, 70 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/K=
config
>> index b7a2f38..dcc9d74 100644
>> --- a/arch/arm/mach-s5pv210/Kconfig
>> +++ b/arch/arm/mach-s5pv210/Kconfig
>> @@ -57,7 +57,11 @@ config MACH_AQUILA
>> =A0 =A0 =A0 select CPU_S5PV210
>> =A0 =A0 =A0 select ARCH_SPARSEMEM_ENABLE
>> =A0 =A0 =A0 select S5PV210_SETUP_FB_24BPP
>> + =A0 =A0 select S5PV210_SETUP_SDHCI
>> =A0 =A0 =A0 select S3C_DEV_FB
>> + =A0 =A0 select S3C_DEV_HSMMC
>> + =A0 =A0 select S3C_DEV_HSMMC1
>> + =A0 =A0 select S3C_DEV_HSMMC2
>> =A0 =A0 =A0 select S5PC110_DEV_ONENAND
>> =A0 =A0 =A0 help
>> =A0 =A0 =A0 =A0 Machine support for the Samsung Aquila target based =
on S5PC110 SoC
>> diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5p=
v210/mach-aquila.c
>> index fb9dbb2..1b7fe79 100644
>> --- a/arch/arm/mach-s5pv210/mach-aquila.c
>> +++ b/arch/arm/mach-s5pv210/mach-aquila.c
>> @@ -13,6 +13,7 @@
>> =A0#include <linux/init.h>
>> =A0#include <linux/serial_core.h>
>> =A0#include <linux/fb.h>
>> +#include <linux/gpio.h>
>>
>> =A0#include <asm/mach/arch.h>
>> =A0#include <asm/mach/map.h>
>> @@ -22,12 +23,15 @@
>> =A0#include <mach/map.h>
>> =A0#include <mach/regs-clock.h>
>> =A0#include <mach/regs-fb.h>
>> +#include <mach/regs-gpio.h>
>>
>> =A0#include <plat/regs-serial.h>
>> =A0#include <plat/s5pv210.h>
>> =A0#include <plat/devs.h>
>> =A0#include <plat/cpu.h>
>> =A0#include <plat/fb.h>
>> +#include <plat/gpio-cfg.h>
>> +#include <plat/sdhci.h>
>>
>> =A0/* Following are default values for UCON, ULCON and UFCON UART re=
gisters */
>> =A0#define S5PV210_UCON_DEFAULT (S3C2410_UCON_TXILEVEL | =A0 =A0 =A0=
 =A0\
>> @@ -116,9 +120,66 @@ static struct s3c_fb_platdata aquila_lcd_pdata =
__initdata =3D {
>> =A0 =A0 =A0 .setup_gpio =A0 =A0 =3D s5pv210_fb_gpio_setup_24bpp,
>> =A0};
>>
>> +/* MoviNAND */
>> +static struct s3c_sdhci_platdata aquila_hsmmc0_data __initdata =3D =
{
>> + =A0 =A0 .max_width =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4,
>> + =A0 =A0 .cd_type =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D S3C_SDHCI_CD_P=
ERMANENT,
>> +};
>> +
>> +/* Wireless LAN */
>> +static struct s3c_sdhci_platdata aquila_hsmmc1_data __initdata =3D =
{
>> + =A0 =A0 .max_width =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4,
>> + =A0 =A0 .cd_type =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D S3C_SDHCI_CD_E=
XTERNAL,
>> + =A0 =A0 /* ext_cd_{init,cleanup} callbacks will be added later */
>> +};
>> +
>> +/* External Flash */
>> +#define AQUILA_EXT_FLASH_IRQ IRQ_EINT(28) =A0 =A0/* S5PV210_GPH3(4)=
 */
>> +#define AQUILA_EXT_FLASH_EN =A0S5PV210_MP05(4)
>> +#define AQUILA_EXT_FLASH_CD =A0S5PV210_GPH3(4)
>> +
>> +static irqreturn_t aquila_ext_flash_card_detect_isr(int irq, void *=
dev_id)
>> +{
>> + =A0 =A0 void (*notify_func)(struct platform_device *, int state) =3D=
 dev_id;
>> + =A0 =A0 notify_func(&s3c_device_hsmmc2, !gpio_get_value(AQUILA_EXT=
_FLASH_CD));
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>
> hmm, not very nice this.
>
> I'd much prefer to see a gpio-based handler in either the sdhci core =
or
> at-least in the driver's directory since I'm sure that his is (a) som=
ething
> Thomas Abrahama has already published patches for (which do need work=
) and

Maybe you see the samsung internal codes. but I think the baseline is
mailing list, others are implement the same functionality with
different place. can you tell me which mail has these one?

Thank you,
Kyungmin Park

> (b) probably going to be needed by other boards and/or other architec=
tures.


>
>> +static int aquila_ext_flash_card_detect_init(
>> + =A0 =A0 =A0 =A0 =A0 =A0 void (*notify_func)(struct platform_device=
 *, int state))
>> +{
>> + =A0 =A0 gpio_request(AQUILA_EXT_FLASH_EN, "FLASH_EN");
>> + =A0 =A0 gpio_direction_output(AQUILA_EXT_FLASH_EN, 1);
>> +
>> + =A0 =A0 if (request_irq(AQUILA_EXT_FLASH_IRQ, aquila_ext_flash_car=
d_detect_isr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_TRIGG=
ER_RISING | IRQF_TRIGGER_FALLING,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "SDHCI car=
d detect", notify_func))
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Error: cannot request irq=
 for External Flash\n");
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int aquila_ext_flash_card_detect_cleanup(
>> + =A0 =A0 =A0 =A0 =A0 =A0 void (*notify_func)(struct platform_device=
 *, int state))
>> +{
>> + =A0 =A0 free_irq(AQUILA_EXT_FLASH_IRQ, notify_func);
>> + =A0 =A0 gpio_direction_output(AQUILA_EXT_FLASH_EN, 0);
>> + =A0 =A0 gpio_free(AQUILA_EXT_FLASH_EN);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct s3c_sdhci_platdata aquila_hsmmc2_data __initdata =3D =
{
>> + =A0 =A0 .max_width =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4,
>> + =A0 =A0 .cd_type =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D S3C_SDHCI_CD_E=
XTERNAL,
>> + =A0 =A0 .ext_cd_init =A0 =A0 =A0 =A0 =A0 =A0=3D aquila_ext_flash_c=
ard_detect_init,
>> + =A0 =A0 .ext_cd_cleanup =A0 =A0 =A0 =A0 =3D aquila_ext_flash_card_=
detect_cleanup,
>> +};
>> +
>> =A0static struct platform_device *aquila_devices[] __initdata =3D {
>> =A0 =A0 =A0 &s3c_device_fb,
>> =A0 =A0 =A0 &s5pc110_device_onenand,
>> + =A0 =A0 &s3c_device_hsmmc0,
>> + =A0 =A0 &s3c_device_hsmmc1,
>> + =A0 =A0 &s3c_device_hsmmc2,
>> =A0};
>>
>> =A0static void __init aquila_map_io(void)
>> @@ -130,6 +191,11 @@ static void __init aquila_map_io(void)
>>
>> =A0static void __init aquila_machine_init(void)
>> =A0{
>> + =A0 =A0 /* SDHCI */
>> + =A0 =A0 s3c_sdhci0_set_platdata(&aquila_hsmmc0_data);
>> + =A0 =A0 s3c_sdhci1_set_platdata(&aquila_hsmmc1_data);
>> + =A0 =A0 s3c_sdhci2_set_platdata(&aquila_hsmmc2_data);
>> +
>> =A0 =A0 =A0 /* FB */
>> =A0 =A0 =A0 s3c_fb_set_platdata(&aquila_lcd_pdata);
>>
>> --
>> 1.7.1.240.g225c
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> --
> Ben
>
> Q: =A0 =A0 =A0What's a light-year?
> A: =A0 =A0 =A0One-third less calories than a regular year.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
