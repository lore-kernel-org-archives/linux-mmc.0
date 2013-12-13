From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/4] rename ARCH_BCM to ARCH_BCM_MOBILE (clocksource)
Date: Fri, 13 Dec 2013 09:48:33 +0100
Message-ID: <52AAC9E1.6070405@linaro.org>
References: <1379956836-5866-1-git-send-email-bcm@fixthebug.org> <1379956836-5866-3-git-send-email-bcm@fixthebug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379956836-5866-3-git-send-email-bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Alex Elder <alex.elder-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Daudt <csd-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Domenico Andreoli <cavokz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 09/23/2013 07:20 PM, Christian Daudt wrote:
> Currently ARCH_BCM has been used for Broadcom
> Mobile V7 based SoCs. In order to allow other Broadcom
> SoCs to also use mach-bcm directory and files, this patch
> renames the original ARCH_BCM to ARCH_BCM_MOBILE, and
> uses ARCH_BCM to define any Broadcom chip residing
> in mach-bcm directory.
>
> Signed-off-by: Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>
> Acked-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>

Acked-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>


> Changes from v1:
>   - fix alpha ordering in dts/Makefile
>   - break into 4 patches for separate subsys
>
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makef=
ile
> index 704d6d3..4207ab4 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -25,7 +25,7 @@ obj-$(CONFIG_SUN4I_TIMER)	+=3D sun4i_timer.o
>   obj-$(CONFIG_ARCH_TEGRA)	+=3D tegra20_timer.o
>   obj-$(CONFIG_VT8500_TIMER)	+=3D vt8500_timer.o
>   obj-$(CONFIG_ARCH_NSPIRE)	+=3D zevio-timer.o
> -obj-$(CONFIG_ARCH_BCM)		+=3D bcm_kona_timer.o
> +obj-$(CONFIG_ARCH_BCM_MOBILE)	+=3D bcm_kona_timer.o
>   obj-$(CONFIG_CADENCE_TTC_TIMER)	+=3D cadence_ttc_timer.o
>   obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+=3D exynos_mct.o
>   obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)	+=3D samsung_pwm_timer.o
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
