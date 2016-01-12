From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: enable mmc host device to suspend/resume asynchronously
Date: Tue, 12 Jan 2016 15:42:25 +0100
Message-ID: <CAPDyKFpt=uOiFkH1M6QvTkQAb09S3_mqV2x9o1KUqXsH=ggjEw@mail.gmail.com>
References: <568157A7.8030607@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <568157A7.8030607@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Venu Byravarasu <vbyravarasu@nvidia.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 28 December 2015 at 16:39, Fu, Zhonghui <zhonghui.fu@linux.intel.com> wrote:
> Now, PM core supports asynchronous suspend/resume mode for devices
> during system suspend/resume, and the power state transition of one
> device may be completed in separate kernel thread. PM core ensures
> all power state transition dependency between devices. This patch
> enables mmc hosts to suspend/resume asynchronously. This will take
> advantage of multicore and improve system suspend/resume speed.
> After applying this patch and enabling all mmc hosts' child devices
> to suspend/resume asynchronously on ASUS T100TA, the system
> suspend-to-idle time is reduced from 1645ms to 1107ms, and the
> system resume time is reduced from 940ms to 914ms.

Please update the  change log as I don't think the above is really correct.

I think you can simplify the change log quite a bit and just mention
what and why we want this change.

>
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> ---
>  drivers/mmc/core/host.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index da950c4..7222fd7 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -339,6 +339,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         host->class_dev.parent = dev;
>         host->class_dev.class = &mmc_host_class;
>         device_initialize(&host->class_dev);
> +       device_enable_async_suspend(&host->class_dev);
>
>         if (mmc_gpio_alloc(host)) {
>                 put_device(&host->class_dev);
> -- 1.7.1
>

Otherwise I think this looks good!

Kind regards
Uffe
