From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 06/11] mfd: tmio: remove now unneeded tmio_mmc_cd_wakeup()
Date: Fri, 6 Jan 2012 11:53:37 +0900
Message-ID: <CANqRtoTTRWGoBoEOs2BkgKYU_W2gNZPghJj=9KsTTQMbwS3oqQ@mail.gmail.com>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
	<1325686636-23905-7-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1325686636-23905-7-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 4, 2012 at 11:17 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Now, that all users of tmio_mmc_cd_wakeup() have been converted over =
to
> drivers/mmc/core/cd-gpio.c, that function can be removed.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> =A0include/linux/mfd/tmio.h | =A0 11 -----------
> =A01 files changed, 0 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index 4ef9307..08fb7d2 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -4,7 +4,6 @@
> =A0#include <linux/device.h>
> =A0#include <linux/fb.h>
> =A0#include <linux/io.h>
> -#include <linux/jiffies.h>
> =A0#include <linux/platform_device.h>
> =A0#include <linux/pm_runtime.h>
>
> @@ -110,16 +109,6 @@ struct tmio_mmc_data {
> =A0};
>
> =A0/*
> - * This function is deprecated and will be removed soon. Please, con=
vert your
> - * platform to use drivers/mmc/core/cd-gpio.c
> - */
> -static inline void tmio_mmc_cd_wakeup(struct tmio_mmc_data *pdata)
> -{
> - =A0 =A0 =A0 if (pdata)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_detect_change(dev_get_drvdata(dev),=
 msecs_to_jiffies(100));
> -}
> -
> -/*

Ok, I can clearly see the merit of removing unused code. And I do
appreciate that you clean up the code. Thank you!

The only issue is that we do however have tons of users of the SDHI
driver (just grep in arch/arm/mach-shmobile and in arch/sh) and many
of them can use other pins than the SDHI CD function for hotplug
detection. To support such configurations we need to have some way to
notify the driver instance about the hotplug change. This patch is
removing just that.

I do realize that you recently posted some generic MMC GPIO hotplug
patches, and I am happy that you agreed with me that it is better to
put it in the generic MMC core than pushing it in the SDHI or MMCIF
driver. So this development seems like a perfect fit for both the SDHI
driver and the MMCIF driver.

I'd like to see platforms move over to your MMC GPIO hotplug helpers,
but at the same time I want to keep the existing notification method
to make a smooth transition. I personally added GPIO IRQ support
rather recently to SH Mobile ARM, but it is still rather early and we
do not have many users yet. I have seen customer-specific hardware
designs using non-GPIO pins for CD handling too, and to support such
hardware we want to keep flexible notification methods. So with that
in mind I'd like to keep the options open and allow fully developed
platforms to use your MMC GPIO hotplug code, but also allow custom
platforms and boards/SoCs with more limited software support handle
hotplug notification the old way.

So please don't remove this function at this point. Give us time to mov=
e over.

Thanks,

/ magnus
