From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: enable mmc host device to suspend/resume asynchronously
Date: Thu, 27 Aug 2015 15:05:58 +0200
Message-ID: <CAPDyKFpRpGyCCoOU44CwiUxsJW1fMs8FxShvVga+uFHKvy7BBQ@mail.gmail.com>
References: <55BF60F5.8040602@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55BF60F5.8040602@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Markus Niebel <Markus.Niebel@tq-group.com>, Lars-Peter Clausen <lars@metafoo.de>, Sascha Hauer <s.hauer@pengutronix.de>, =?UTF-8?Q?Kristina_Mart=C5=A1enko?= <kristina.martsenko@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 3 August 2015 at 14:39, Fu, Zhonghui <zhonghui.fu@linux.intel.com> wrote:
> Enable mmc host device to suspend/resume asynchronously.
> This can improve system suspend/resume speed.

Can or will?

It would be nice to see some statistics of this to justify the change.
Can you share that?

Moreover we already have the runtime PM support, which enables the
reinitialization sequence of the mmc/sd card to be postponed from the
system PM resume path. Instead that's done when the next
pm_runtime_get_sync() for the card's device gets called. You my tried
that feature by enabling MMC_CAP_RUNTIME_RESUME for the mmc hosts.

Kind regards
Uffe

>
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> ---
>  drivers/mmc/core/host.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 99a9c90..85f2bbb 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -577,6 +577,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         host->class_dev.parent = dev;
>         host->class_dev.class = &mmc_host_class;
>         device_initialize(&host->class_dev);
> +       device_enable_async_suspend(&host->class_dev);
>
>         if (mmc_gpio_alloc(host)) {
>                 put_device(&host->class_dev);
> -- 1.7.1
>
