From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: enable MMC/SD/SDIO device to suspend/resume asynchronously
Date: Fri, 4 Dec 2015 15:56:38 +0100
Message-ID: <CAPDyKFpX88Xd6Lo-FaLe9a+xLR_tV_PzWnckETHym6vn3tSrHg@mail.gmail.com>
References: <56618FB4.3020100@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56618FB4.3020100@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Hans de Goede <hdegoede@redhat.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 4 December 2015 at 14:05, Fu, Zhonghui <zhonghui.fu@linux.intel.com> wrote:
> Now, PM core supports asynchronous suspend/resume mode for devices
> during system suspend/resume, and the power state transition of one
> device may be completed in separate kernel thread. PM core ensures
> all power state transition dependency between devices. This patch
> enables MMC/SD/SDIO card and SDIO function devices to suspend/resume
> asynchronously. This will take advantage of multicore and improve
> system suspend/resume speed. After applying this patch and enabling
> all SDIO function's child devices to suspend/resume asynchronously
> on ASUS T100TA, the system suspend-to-idle time is reduced from
> 1645ms to 1108ms, and the system resume time is reduced from 940ms
> to 918ms.
>
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/bus.c      |    2 ++
>  drivers/mmc/core/sdio_bus.c |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 972ff84..4bc48f1 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -349,6 +349,8 @@ int mmc_add_card(struct mmc_card *card)
>
>         card->dev.of_node = mmc_of_find_child_device(card->host, 0);
>
> +       device_enable_async_suspend(&card->dev);
> +
>         ret = device_add(&card->dev);
>         if (ret)
>                 return ret;
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 7e327a6..86f5b32 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -322,6 +322,7 @@ int sdio_add_func(struct sdio_func *func)
>
>         sdio_set_of_node(func);
>         sdio_acpi_set_handle(func);
> +       device_enable_async_suspend(&func->dev);
>         ret = device_add(&func->dev);
>         if (ret == 0)
>                 sdio_func_set_present(func);
> -- 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
