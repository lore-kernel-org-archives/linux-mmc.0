From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: rtsx: usb backend needs LED support
Date: Tue, 29 Apr 2014 13:05:15 +0200
Message-ID: <CAPDyKFpJrrviaZo_L8MkLF=v7DqGEVj9=uSNsNtU-FXNwu-MmQ@mail.gmail.com>
References: <cover.1398735435.git.micky_ching@realsil.com.cn>
 <7208467.nZIXMIfPji@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <7208467.nZIXMIfPji@wuerfel>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei WANG <wei_wang@realsil.com.cn>, Roger <rogerable@realtek.com>, devel@linuxdriverproject.org, Lee Jones <lee.jones@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

On 29 April 2014 11:45, Arnd Bergmann <arnd@arndb.de> wrote:
> [hijacking the thread since it has the right Cc list already, sorry]
>
> I stumbled over this doing randconfig builds on linux-next
>
> 8<----------
>
> From c11f54f1e5ea0557e076867ca31c90bcb20e3e0c Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Tue, 29 Apr 2014 11:41:40 +0200
> Subject: [PATCH] mmc: rtsx: usb backend needs LED support
>
> Building the rtsx USB driver requires the LED classdev base
> support, otherwise we get this build error:
>
> drivers/built-in.o: In function `rtsx_usb_sdmmc_drv_remove':
> :(.text+0x806480): undefined reference to `led_classdev_unregister'
> drivers/built-in.o: In function `rtsx_usb_sdmmc_drv_probe':
> :(.text+0x806708): undefined reference to `led_classdev_register'
>
> This adds an explicit dependency in Kconfig

I think the proper solution is to fix the dependency in the driver code instead.

There are already some ifdefs hackery for making it optional to use
leds, apparently that's not working properly.

Kind regards
Ulf Hansson

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 92d91fe..66aedf3 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -696,6 +696,7 @@ config MMC_REALTEK_PCI
>  config MMC_REALTEK_USB
>         tristate "Realtek USB SD/MMC Card Interface Driver"
>         depends on MFD_RTSX_USB
> +       depends on LEDS_CLASS
>         help
>           Say Y here to include driver code to support SD/MMC card interface
>           of Realtek RTS5129/39 series card reader
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
