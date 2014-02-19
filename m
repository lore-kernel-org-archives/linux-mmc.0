From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/17] amba: Let runtime PM callbacks be available for CONFIG_PM
Date: Wed, 19 Feb 2014 12:40:39 +0100
Message-ID: <CAPDyKFqaS1H0vT8KJgmhm35X4dB9dUHsqMXee9Eg3V3t6Dn+uQ@mail.gmail.com>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
	<1391529538-21685-2-git-send-email-ulf.hansson@linaro.org>
	<20140219094037.GQ21483@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140219094037.GQ21483-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 19 February 2014 10:40, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Tue, Feb 04, 2014 at 04:58:42PM +0100, Ulf Hansson wrote:
>> Convert to the SET_PM_RUNTIME_PM macro while defining the runtime PM
>> callbacks. This means the callbacks becomes available for both
>> CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME, which is needed by drivers and
>> power domains.
>
> This patch is wrong, because it causes build errors:
>
> drivers/amba/bus.c:126:18: error: 'pm_generic_suspend_late' undeclared here (not in a function)
> drivers/amba/bus.c:127:18: error: 'pm_generic_resume_early' undeclared here (not in a function)
> drivers/amba/bus.c:128:17: error: 'pm_generic_freeze_late' undeclared here (not in a function)
> drivers/amba/bus.c:129:16: error: 'pm_generic_thaw_early' undeclared here (not in a function)
> drivers/amba/bus.c:130:19: error: 'pm_generic_poweroff_late' undeclared here (not in a function)
> drivers/amba/bus.c:131:19: error: 'pm_generic_restore_early' undeclared here (not in a function)
>
> The failing configuration is:
>
> # CONFIG_SUSPEND is not set
> CONFIG_PM_RUNTIME=y
> CONFIG_PM=y
>

Thanks for spotting this! I thought I had tested all the various
combinations, but obvisouly not.

Anyway to add some more clarify; it is not this patch that causes the
issue. It's patch 2, which introduces the late/early callbacks.

Though the problem need to be fixed in the PM core,
pm_generic_suspend_late etc is not set to NULL for !CONFIG_PM_SLEEP,
they should. I guess we should put patch 2 on hold until, right?

Kind regards
Ulf Hansson

> --
> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> Estimate before purchase was "up to 13.2Mbit".
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
