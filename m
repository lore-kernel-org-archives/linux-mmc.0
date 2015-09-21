From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] mmc/sdhci-acpi: enable sdhci-acpi device to
 suspend/resume asynchronously
Date: Mon, 21 Sep 2015 12:32:09 +0300
Message-ID: <1442827929.8361.119.camel@linux.intel.com>
References: <55FFA8DD.5020109@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55FFA8DD.5020109@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, yunpeng.gao@intel.com, peter.griffin@linaro.org
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 2015-09-21 at 14:51 +0800, Fu, Zhonghui wrote:
> Now, PM core supports asynchronous suspend/resume mode for devices
> during system suspend/resume, and the power state transition of one
> device may be completed in separate kernel thread. PM core ensures
> all power state transition timing dependency between devices. This
> patch enables sdhci-acpi device to suspend/resume asynchronously.
> This will take advantage of multicore and improve system
> suspend/resume speed.
> 

It would be nice I think to put here statistics you collected as well.


> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> ---
> Changes in v2:
> - Amend commit message.
> 
>  drivers/mmc/host/sdhci-acpi.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci
> -acpi.c
> index 22d929f..67e6263 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -379,6 +379,8 @@ static int sdhci_acpi_probe(struct 
> platform_device *pdev)
>  		pm_runtime_enable(dev);
>  	}
>  
> +	device_enable_async_suspend(dev);
> +
>  	return 0;
>  
>  err_free:
> -- 1.7.1
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
