From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pxav3: fix device wakeup initialization
Date: Thu, 4 Jun 2015 10:34:24 +0200
Message-ID: <CAPDyKFrEkzTso9KciqoufFknMeHDxWS6s8FPVuzk6Kq66PzjPA@mail.gmail.com>
References: <1433241515-2093-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433241515-2093-1-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 2 June 2015 at 12:38, Jisheng Zhang <jszhang@marvell.com> wrote:
> MMC_PM_KEEP_POWER doesn't imply MMC_PM_WAKE_SDIO_IRQ, we should only
> enable device wake up when MMC_PM_WAKE_SDIO_IRQ is set. And "pm_flags"
> is the requested pm features, we should not set it in the host driver.
>
> At the same time, device wakeup is disabled by default, so there's no
> need to disable device wakeup explicitly.
>
> This patch fixes the warning as following:
>
> [   64.616651] ------------[ cut here ]------------
> [   64.616665] WARNING: CPU: 0 PID: 79 at linux/kernel/irq/manage.c:603 irq_set_irq_wake+0xf0/0x11c()
> [   64.616667] Unbalanced IRQ 87 wake disable
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Thanks, applied.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pxav3.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 01cb2d3..9cd5fc6 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -457,12 +457,8 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, host);
>
> -       if (host->mmc->pm_caps & MMC_PM_KEEP_POWER) {
> +       if (host->mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ)
>                 device_init_wakeup(&pdev->dev, 1);
> -               host->mmc->pm_flags |= MMC_PM_WAKE_SDIO_IRQ;
> -       } else {
> -               device_init_wakeup(&pdev->dev, 0);
> -       }
>
>         pm_runtime_put_autosuspend(&pdev->dev);
>
> --
> 2.1.4
>
