From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH] mmc/sdhci-acpi: enable sdhci-acpi device to suspend/resume
 asynchronously
Date: Mon, 17 Aug 2015 11:38:00 +0800
Message-ID: <55D15718.9080107@linux.intel.com>
References: <55BF6843.4050502@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2789 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbbHQDiD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 16 Aug 2015 23:38:03 -0400
In-Reply-To: <55BF6843.4050502@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, yunpeng.gao@intel.com, andriy.shevchenko@linux.intel.com, peter.griffin@linaro.org
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Hi,

Any comments are welcome.


Thanks,
Zhonghui

On 2015/8/3 21:10, Fu, Zhonghui wrote:
> Enable sdhci-acpi device to suspend/resume asynchronously.
> This can improve system suspend/resume speed.
>
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> ---
>  drivers/mmc/host/sdhci-acpi.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 22d929f..67e6263 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -379,6 +379,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
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

