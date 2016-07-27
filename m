From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: rtsx: Remove deprecated create_singlethread_workqueue
Date: Wed, 27 Jul 2016 14:47:19 +0200
Message-ID: <CAPDyKFpfNmcuTj+0Y7WE=9bsk=QJy0tZLcuzgor4dJPFRHxOUg@mail.gmail.com>
References: <20160726170106.GA10120@Karyakshetra>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160726170106.GA10120@Karyakshetra>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 26 July 2016 at 19:01, Bhaktipriya Shridhar <bhaktipriya96@gmail.com> wrote:
> The workqueue "workq" provides support for sd/mmc async request, which
> makes next request do dma_map_sg() while previous request transferring
> data.
>
> The workqueue has a single workitem(&host->work) and hence doesn't require
> ordering. Also, it is not being used on a memory reclaim path. Hence,
> the singlethreaded workqueue has been replaced with the use of system_wq.
>
> System workqueues have been able to handle high level of concurrency
> for a long time now and hence it's not required to have a singlethreaded
> workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
> created with create_singlethread_workqueue(), system_wq allows multiple
> work items to overlap executions even on the same CPU; however, a
> per-cpu workqueue doesn't have any CPU locality or global ordering
> guarantee unless the target CPU is explicitly specified and thus the
> increase of local concurrency shouldn't make any difference.
>
> Work item has been flushed in rtsx_pci_sdmmc_drv_remove() to ensure that
> there are no pending tasks while disconnecting the driver.
>
> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 9313748..49516dc 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -38,7 +38,6 @@ struct realtek_pci_sdmmc {
>         struct rtsx_pcr         *pcr;
>         struct mmc_host         *mmc;
>         struct mmc_request      *mrq;
> -       struct workqueue_struct *workq;
>  #define SDMMC_WORKQ_NAME       "rtsx_pci_sdmmc_workq"
>
>         struct work_struct      work;
> @@ -885,7 +884,7 @@ static void sdmmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         if (sd_rw_cmd(mrq->cmd) || sdio_extblock_cmd(mrq->cmd, data))
>                 host->using_cookie = sd_pre_dma_transfer(host, data, false);
>
> -       queue_work(host->workq, &host->work);
> +       schedule_work(&host->work);
>  }
>
>  static int sd_set_bus_width(struct realtek_pci_sdmmc *host,
> @@ -1404,11 +1403,6 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         host = mmc_priv(mmc);
> -       host->workq = create_singlethread_workqueue(SDMMC_WORKQ_NAME);
> -       if (!host->workq) {
> -               mmc_free_host(mmc);
> -               return -ENOMEM;
> -       }
>         host->pcr = pcr;
>         host->mmc = mmc;
>         host->pdev = pdev;
> @@ -1462,9 +1456,7 @@ static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
>         mmc_remove_host(mmc);
>         host->eject = true;
>
> -       flush_workqueue(host->workq);
> -       destroy_workqueue(host->workq);
> -       host->workq = NULL;
> +       flush_work(&host->work);
>
>         mmc_free_host(mmc);
>
> --
> 2.1.4
>
