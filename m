From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2 v2] mmc: enable mmc host device to suspend/resume asynchronously
Date: Fri, 22 Jan 2016 15:51:37 +0100
Message-ID: <CAPDyKFrKmTfA2GjQDmFnh0hRzeP8kcKGL6oMSzrZihyGL4pQUA@mail.gmail.com>
References: <56A1A2C2.1030106@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56A1A2C2.1030106@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: Venu Byravarasu <vbyravarasu@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 22 January 2016 at 04:32, Fu, Zhonghui <zhonghui.fu@linux.intel.com> wrote:
> This patch enables mmc hosts to suspend/resume asynchronously.
> This will improve system suspend/resume speed. After applying
> this patch and enabling all mmc hosts' child devices to
> suspend/resume asynchronously on ASUS T100TA, the system
> suspend-to-idle time is reduced from 1645ms to 1107ms, and the
> system resume time is reduced from 940ms to 914ms.

Do you really reduce time at all with this patch by its own? I think not.

Moreover, I thought the biggest improvement came from the patch which
enabled async suspend/resume for the MMC/SD/SDIO device?
ec076cd226c3 ("mmc: enable MMC/SD/SDIO device to suspend/resume asynchronously")

Similar comment applies to patch2/2, but I would expect it together
with the $subject patch gives an improvement.

Please update the change-logs one more round.

Kind regards
Uffe

>
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> Acked-by: Venu Byravarasu <vbyravarasu@nvidia.com>
> ---
> Changes in v2:
> - Update commit message
>
>  drivers/mmc/core/host.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 0aecd5c..1d94607 100644
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
