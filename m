From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] MMC/SDIO: enable SDIO device to suspend/resume asynchronously
Date: Tue, 6 Oct 2015 10:21:29 +0200
Message-ID: <CAPDyKFrys_LxOVqPQsXQ=_x3LWyywzLEM1h4tAAOgV6aaNyRTA@mail.gmail.com>
References: <55FF87F1.1000209@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55FF87F1.1000209@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Neil Brown <neilb@suse.de>, Jaehoon Chung <jh80.chung@samsung.com>, Andreas Fenkart <afenkart@gmail.com>, Joe Perches <joe@perches.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 21 September 2015 at 06:30, Fu, Zhonghui <zhonghui.fu@linux.intel.com> wrote:
> Now, PM core supports asynchronous suspend/resume mode for devices
> during system suspend/resume, and the power state transition of one
> device may be completed in separate kernel thread. PM core ensures
> all power state transition timing dependency between devices. This
> patch enables SDIO card and function devices to suspend/resume
> asynchronously. This will take advantage of multicore and improve
> system suspend/resume speed.
>
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> ---
> Changes in v2:
> - Amend commit message.
>
>  drivers/mmc/core/sdio.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index b91abed..6719b77 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1106,6 +1106,8 @@ int mmc_attach_sdio(struct mmc_host *host)
>                 pm_runtime_enable(&card->dev);
>         }
>
> +       device_enable_async_suspend(&card->dev);
> +
>         /*
>          * The number of functions on the card is encoded inside
>          * the ocr.
> @@ -1126,6 +1128,8 @@ int mmc_attach_sdio(struct mmc_host *host)
>                  */
>                 if (host->caps & MMC_CAP_POWER_OFF_CARD)
>                         pm_runtime_enable(&card->sdio_func[i]->dev);
> +
> +               device_enable_async_suspend(&card->sdio_func[i]->dev);
>         }
>
>         /*
> -- 1.7.1

I wonder how you guarantee that the mmc host device will be suspended
*after* the SDIO card device and the SDIO func device? Currently that
is controlled via device registration/probe order, without any device
hierarchy configured.

Kind regards
Uffe
