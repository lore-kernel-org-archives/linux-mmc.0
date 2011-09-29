From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH] leds-class: change back LEDS_CLASS to tristate instead of bool
Date: Thu, 29 Sep 2011 10:00:58 +0800
Message-ID: <CAK5ve-KoanwFGFJcxGQGmAW0yR+MYR1uVGM5q+=8u_ofHrhwOQ__18329.9897857525$1317261711$gmane$org@mail.gmail.com>
References: <1317113432-7299-1-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58958 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074Ab1I2CBS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2011 22:01:18 -0400
In-Reply-To: <1317113432-7299-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, rpurdie@rpsys.net, manuel.lauss@gmail.com, cjb@laptop.org, cbou@mail.ru, dwmw2@infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@li

Hiya,

Any comments and need I do anything to improve this patch?

Thanks,
-Bryan

On Tue, Sep 27, 2011 at 4:50 PM, Bryan Wu <bryan.wu@canonical.com> wrot=
e:
> LEDS_CLASS is required by leds and trigger drivers, but we can build =
it as
> module. =A0So change this option back as tristate and treak the help =
message
> as well.
>
> LEDS_TRIGGERS depends on LEDS_CLASSS, which should be tristate. =A0So=
 set it
> as tristate too and update header files as well.
>
> Change those ifdefs to take care of module configuration.
>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
> =A0arch/arm/mach-omap1/board-ams-delta.c | =A0 =A04 ++--
> =A0drivers/leds/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A09=
 ++++++---
> =A0drivers/leds/led-class.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A08 +++=
+----
> =A0drivers/leds/leds.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02=
 +-
> =A0drivers/mmc/host/au1xmmc.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06 +++--=
-
> =A0drivers/power/power_supply.h =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0include/linux/leds.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07=
 ++++---
> =A0include/linux/mmc/host.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0include/linux/power_supply.h =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A09 files changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-om=
ap1/board-ams-delta.c
> index b2572f7..fd28696 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -241,7 +241,7 @@ static struct i2c_board_info ams_delta_camera_boa=
rd_info[] =3D {
> =A0 =A0 =A0 =A0},
> =A0};
>
> -#ifdef CONFIG_LEDS_TRIGGERS
> +#if defined(CONFIG_LEDS_TRIGGERS) || defined(CONFIG_LEDS_TRIGGERS_MO=
DULE)
> =A0DEFINE_LED_TRIGGER(ams_delta_camera_led_trigger);
>
> =A0static int ams_delta_camera_power(struct device *dev, int power)
> @@ -320,7 +320,7 @@ static void __init ams_delta_init(void)
>
> =A0 =A0 =A0 =A0omap1_usb_init(&ams_delta_usb_config);
> =A0 =A0 =A0 =A0omap1_set_camera_info(&ams_delta_camera_platform_data)=
;
> -#ifdef CONFIG_LEDS_TRIGGERS
> +#if defined(CONFIG_LEDS_TRIGGERS) || defined(CONFIG_LEDS_TRIGGERS_MO=
DULE)
> =A0 =A0 =A0 =A0led_trigger_register_simple("ams_delta_camera",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&ams_delta_camera_led_=
trigger);
> =A0#endif
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index ff203a4..c30233e 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -17,10 +17,13 @@ menuconfig NEW_LEDS
> =A0if NEW_LEDS
>
> =A0config LEDS_CLASS
> - =A0 =A0 =A0 bool "LED Class Support"
> + =A0 =A0 =A0 tristate "LED Class Support"
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This option enables the led sysfs class in /sys/cl=
ass/leds. =A0You'll
> - =A0 =A0 =A0 =A0 need this to do anything useful with LEDs. =A0If un=
sure, say N.
> + =A0 =A0 =A0 =A0 need this to do anything useful with LEDs. =A0If un=
sure, say M.
> +
> + =A0 =A0 =A0 =A0 Note: don't disable it as N, because plenty of led =
and trigger drivers
> + =A0 =A0 =A0 =A0 are using this option.
>
> =A0comment "LED drivers"
>
> @@ -388,7 +391,7 @@ config LEDS_RENESAS_TPU
> =A0 =A0 =A0 =A0 =A0Brightness control is supported but hardware blink=
ing is not.
>
> =A0config LEDS_TRIGGERS
> - =A0 =A0 =A0 bool "LED Trigger support"
> + =A0 =A0 =A0 tristate "LED Trigger support"
> =A0 =A0 =A0 =A0depends on LEDS_CLASS
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This option enables trigger support for the leds c=
lass.
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index dc3d3d8..1f54cb0 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -75,7 +75,7 @@ static ssize_t led_max_brightness_show(struct devic=
e *dev,
> =A0static struct device_attribute led_class_attrs[] =3D {
> =A0 =A0 =A0 =A0__ATTR(brightness, 0644, led_brightness_show, led_brig=
htness_store),
> =A0 =A0 =A0 =A0__ATTR(max_brightness, 0444, led_max_brightness_show, =
NULL),
> -#ifdef CONFIG_LEDS_TRIGGERS
> +#if defined(CONFIG_LEDS_TRIGGERS) || defined(CONFIG_LEDS_TRIGGERS_MO=
DULE)
> =A0 =A0 =A0 =A0__ATTR(trigger, 0644, led_trigger_show, led_trigger_st=
ore),
> =A0#endif
> =A0 =A0 =A0 =A0__ATTR_NULL,
> @@ -209,7 +209,7 @@ int led_classdev_register(struct device *parent, =
struct led_classdev *led_cdev)
> =A0 =A0 =A0 =A0if (IS_ERR(led_cdev->dev))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PTR_ERR(led_cdev->dev);
>
> -#ifdef CONFIG_LEDS_TRIGGERS
> +#if defined(CONFIG_LEDS_TRIGGERS) || defined(CONFIG_LEDS_TRIGGERS_MO=
DULE)
> =A0 =A0 =A0 =A0init_rwsem(&led_cdev->trigger_lock);
> =A0#endif
> =A0 =A0 =A0 =A0/* add to the list of leds */
> @@ -226,7 +226,7 @@ int led_classdev_register(struct device *parent, =
struct led_classdev *led_cdev)
> =A0 =A0 =A0 =A0led_cdev->blink_timer.function =3D led_timer_function;
> =A0 =A0 =A0 =A0led_cdev->blink_timer.data =3D (unsigned long)led_cdev=
;
>
> -#ifdef CONFIG_LEDS_TRIGGERS
> +#if defined(CONFIG_LEDS_TRIGGERS) || defined(CONFIG_LEDS_TRIGGERS_MO=
DULE)
> =A0 =A0 =A0 =A0led_trigger_set_default(led_cdev);
> =A0#endif
>
> @@ -245,7 +245,7 @@ EXPORT_SYMBOL_GPL(led_classdev_register);
> =A0*/
> =A0void led_classdev_unregister(struct led_classdev *led_cdev)
> =A0{
> -#ifdef CONFIG_LEDS_TRIGGERS
> +#if defined(CONFIG_LEDS_TRIGGERS) || defined(CONFIG_LEDS_TRIGGERS_MO=
DULE)
> =A0 =A0 =A0 =A0down_write(&led_cdev->trigger_lock);
> =A0 =A0 =A0 =A0if (led_cdev->trigger)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0led_trigger_set(led_cdev, NULL);
> diff --git a/drivers/leds/leds.h b/drivers/leds/leds.h
> index e77c7f8..53b59b7 100644
> --- a/drivers/leds/leds.h
> +++ b/drivers/leds/leds.h
> @@ -35,7 +35,7 @@ static inline int led_get_brightness(struct led_cla=
ssdev *led_cdev)
> =A0extern struct rw_semaphore leds_list_lock;
> =A0extern struct list_head leds_list;
>
> -#ifdef CONFIG_LEDS_TRIGGERS
> +#if defined(CONFIG_LEDS_TRIGGERS) || defined(CONFIG_LEDS_TRIGGERS_MO=
DULE)
> =A0void led_trigger_set_default(struct led_classdev *led_cdev);
> =A0void led_trigger_set(struct led_classdev *led_cdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct led_trigger *tr=
igger);
> diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
> index 56e7834..83f4913 100644
> --- a/drivers/mmc/host/au1xmmc.c
> +++ b/drivers/mmc/host/au1xmmc.c
> @@ -1043,7 +1043,7 @@ static int __devinit au1xmmc_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "using PIO\n");
> =A0 =A0 =A0 =A0}
>
> -#ifdef CONFIG_LEDS_CLASS
> +#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
> =A0 =A0 =A0 =A0if (host->platdata && host->platdata->led) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct led_classdev *led =3D host->pla=
tdata->led;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0led->name =3D mmc_hostname(mmc);
> @@ -1072,7 +1072,7 @@ static int __devinit au1xmmc_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0return 0; =A0 =A0 =A0 /* all ok */
>
> =A0out6:
> -#ifdef CONFIG_LEDS_CLASS
> +#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
> =A0 =A0 =A0 =A0if (host->platdata && host->platdata->led)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0led_classdev_unregister(host->platdata=
->led);
> =A0out5:
> @@ -1111,7 +1111,7 @@ static int __devexit au1xmmc_remove(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0if (host) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_remove_host(host->mmc);
>
> -#ifdef CONFIG_LEDS_CLASS
> +#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->platdata && host->platdata->=
led)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0led_classdev_unregiste=
r(host->platdata->led);
> =A0#endif
> diff --git a/drivers/power/power_supply.h b/drivers/power/power_suppl=
y.h
> index 018de2b..efa9544 100644
> --- a/drivers/power/power_supply.h
> +++ b/drivers/power/power_supply.h
> @@ -22,7 +22,7 @@ static inline void power_supply_init_attrs(struct d=
evice_type *dev_type) {}
>
> =A0#endif /* CONFIG_SYSFS */
>
> -#ifdef CONFIG_LEDS_TRIGGERS
> +#if defined(CONFIG_LEDS_TRIGGERS) || defined(CONFIG_LEDS_TRIGGERS_MO=
DULE)
>
> =A0extern void power_supply_update_leds(struct power_supply *psy);
> =A0extern int power_supply_create_triggers(struct power_supply *psy);
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 5884def..051bc7e 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -66,7 +66,7 @@ struct led_classdev {
> =A0 =A0 =A0 =A0struct timer_list =A0 =A0 =A0 =A0blink_timer;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0blink_b=
rightness;
>
> -#ifdef CONFIG_LEDS_TRIGGERS
> +#if defined(CONFIG_LEDS_TRIGGERS) || defined(CONFIG_LEDS_TRIGGERS_MO=
DULE)
> =A0 =A0 =A0 =A0/* Protects the trigger data below */
> =A0 =A0 =A0 =A0struct rw_semaphore =A0 =A0 =A0trigger_lock;
>
> @@ -115,7 +115,7 @@ extern void led_brightness_set(struct led_classde=
v *led_cdev,
> =A0/*
> =A0* LED Triggers
> =A0*/
> -#ifdef CONFIG_LEDS_TRIGGERS
> +#if defined(CONFIG_LEDS_TRIGGERS) || defined(CONFIG_LEDS_TRIGGERS_MO=
DULE)
>
> =A0#define TRIG_NAME_MAX 50
>
> @@ -161,7 +161,8 @@ extern void led_trigger_blink(struct led_trigger =
*trigger,
> =A0#endif
>
> =A0/* Trigger specific functions */
> -#ifdef CONFIG_LEDS_TRIGGER_IDE_DISK
> +#if defined(CONFIG_LEDS_TRIGGER_IDE_DISK) || \
> + =A0 =A0 =A0 defined(CONFIG_LEDS_TRIGGER_IDE_DISK_MODULE)
> =A0extern void ledtrig_ide_activity(void);
> =A0#else
> =A0#define ledtrig_ide_activity() do {} while(0)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index aed5bc7..adac344 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -300,7 +300,7 @@ struct mmc_host {
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_flags; =A0 =A0 =A0=
 /* requested pm features */
>
> -#ifdef CONFIG_LEDS_TRIGGERS
> +#if defined(CONFIG_LEDS_TRIGGERS) || defined(CONFIG_LEDS_TRIGGERS_MO=
DULE)
> =A0 =A0 =A0 =A0struct led_trigger =A0 =A0 =A0*led; =A0 =A0 =A0 =A0 =A0=
 /* activity led */
> =A0#endif
>
> diff --git a/include/linux/power_supply.h b/include/linux/power_suppl=
y.h
> index 204c18d..cb09fa0 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -164,7 +164,7 @@ struct power_supply {
> =A0 =A0 =A0 =A0struct device *dev;
> =A0 =A0 =A0 =A0struct work_struct changed_work;
>
> -#ifdef CONFIG_LEDS_TRIGGERS
> +#if defined(CONFIG_LEDS_TRIGGERS) || defined(CONFIG_LEDS_TRIGGERS_MO=
DULE)
> =A0 =A0 =A0 =A0struct led_trigger *charging_full_trig;
> =A0 =A0 =A0 =A0char *charging_full_trig_name;
> =A0 =A0 =A0 =A0struct led_trigger *charging_trig;
> --
> 1.7.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
