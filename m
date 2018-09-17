From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mxcmmc: replace spin_lock_irqsave with spin_lock in ISR
Date: Mon, 17 Sep 2018 20:35:33 +0200
Message-ID: <CAPDyKFqr61j91qPKMv49nSKnwUbiZxPXDCYpbX4CNvN7eVGWGw@mail.gmail.com>
References: <20180911144701.53383-1-hangdianqj@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911144701.53383-1-hangdianqj@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jun qian <hangdianqj@163.com>
Cc: Kees Cook <keescook@chromium.org>, Allen <allen.lkml@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 11 September 2018 at 16:47, jun qian <hangdianqj@163.com> wrote:
> As you are already in ISR, it is unnecessary to call spin_lock_irqsave.
>
> Signed-off-by: jun qian <hangdianqj@163.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mxcmmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index de4e6e5bf304..4d17032d15ee 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -728,7 +728,6 @@ static void mxcmci_cmd_done(struct mxcmci_host *host, unsigned int stat)
>  static irqreturn_t mxcmci_irq(int irq, void *devid)
>  {
>         struct mxcmci_host *host = devid;
> -       unsigned long flags;
>         bool sdio_irq;
>         u32 stat;
>
> @@ -740,9 +739,9 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
>
>         dev_dbg(mmc_dev(host->mmc), "%s: 0x%08x\n", __func__, stat);
>
> -       spin_lock_irqsave(&host->lock, flags);
> +       spin_lock(&host->lock);
>         sdio_irq = (stat & STATUS_SDIO_INT_ACTIVE) && host->use_sdio;
> -       spin_unlock_irqrestore(&host->lock, flags);
> +       spin_unlock(&host->lock);
>
>         if (mxcmci_use_dma(host) && (stat & (STATUS_WRITE_OP_DONE)))
>                 mxcmci_writel(host, STATUS_WRITE_OP_DONE, MMC_REG_STATUS);
> --
> 2.17.1
>
>
>
