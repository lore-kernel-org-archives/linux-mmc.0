From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: rtsx: usb backend needs LED support
Date: Wed, 30 Apr 2014 09:00:33 +0200
Message-ID: <5378270.XmQGrvIcFE@wuerfel>
References: <cover.1398735435.git.micky_ching@realsil.com.cn>
 <201404300228.s3U2S7WA026782@rtits1.realtek.com>
 <53606F49.1000401@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <53606F49.1000401@realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Roger <rogerable@realtek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei WANG <wei_wang@realsil.com.cn>, devel@linuxdriverproject.org, Lee Jones <lee.jones@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

On Wednesday 30 April 2014 11:34:33 Roger wrote:
> I think Ulf's idea is to fix the bug by modifying the .c files.
> I really found the problem of my ifdef hackery and it should do 
> something similar in sdhci.c as:
> 
> From: Roger Tseng <rogerable@realtek.com>
> Date: Wed, 30 Apr 2014 11:11:25 +0800
> Subject: [PATCH] mmc: rtsx: fix possible linking error if built-in
> 
> rtsx_usb_sdmmc module uses the LED classdev if available, but the code 
> failed
> to consider the situation that it is built-in and the LED classdev is a 
> module,
> leading to following linking error:
> 
>    LD      init/built-in.o
> drivers/built-in.o: In function `rtsx_usb_sdmmc_drv_remove':
> rtsx_usb_sdmmc.c:(.text+0x2a018e): undefined reference to 
> `led_classdev_unregister'
> drivers/built-in.o: In function `rtsx_usb_sdmmc_drv_probe':
> rtsx_usb_sdmmc.c:(.text+0x2a197e): undefined reference to 
> `led_classdev_register'
> 
> Fix by excluding such condition when defining macro RTSX_USB_USE_LEDS_CLASS.
> 
> Signed-off-by: Roger Tseng <rogerable@realtek.com>

Yes, that should work, too.

Acked-by: Arnd Bergmann <arnd@arndb.de>


> ---
>   drivers/mmc/host/rtsx_usb_sdmmc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c 
> b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index e11fafa..38bdda5 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -34,7 +34,8 @@
>   #include <linux/mfd/rtsx_usb.h>
>   #include <asm/unaligned.h>
> 
> -#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
> +#if defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
> +       defined(CONFIG_MMC_REALTEK_USB_MODULE))
>   #include <linux/leds.h>
>   #include <linux/workqueue.h>
>   #define RTSX_USB_USE_LEDS_CLASS
> 
