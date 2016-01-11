From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH 2/2] mmc/sdhci-acpi: enable sdhci-acpi device to
 suspend/resume asynchronously
Date: Mon, 11 Jan 2016 13:29:56 +0800
Message-ID: <56933DD4.5020607@linux.intel.com>
References: <56815841.80901@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:53865 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758132AbcAKFaA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Jan 2016 00:30:00 -0500
In-Reply-To: <56815841.80901@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, michele.curti@gmail.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Hi Ulf,

What do you think about this patch?


Thanks,
Zhonghui

On 12/28/2015 11:41 PM, Fu, Zhonghui wrote:
> Now, PM core supports asynchronous suspend/resume mode for devices
> during system suspend/resume, and the power state transition of one
> device may be completed in separate kernel thread. PM core ensures
> all power state transition dependency between devices. This patch
> enables sdhci-acpi devices to suspend/resume asynchronously. This
> will take advantage of multicore and improve system suspend/resume
> speed. After enabling the sdhci-acpi devices and all their child
> devices to suspend/resume asynchronously on ASUS T100TA, the system
> suspend-to-idle time is reduced from 1645ms to 1089ms, and the
> system resume time is reduced from 940ms to 908ms.
>
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> ---
>  drivers/mmc/host/sdhci-acpi.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index f6047fc..3d27f2d 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -388,6 +388,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
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

