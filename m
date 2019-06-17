From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 1/2] mmc: mediatek: fix SDIO IRQ interrupt handle flow
Date: Mon, 17 Jun 2019 13:35:10 +0200
Message-ID: <CAPDyKFo5zpoRFMG6U_Y2uMk0qCyypW-Ui1Kha5t9_Rher4CDkw@mail.gmail.com>
References: <1560769448-23070-1-git-send-email-jjian.zhou@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560769448-23070-1-git-send-email-jjian.zhou@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jjian Zhou <jjian.zhou@mediatek.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yong Mao <yong.mao@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 17 Jun 2019 at 13:04, Jjian Zhou <jjian.zhou@mediatek.com> wrote:
>
> From: jjian zhou <jjian.zhou@mediatek.com>
>
> SDIO IRQ is triggered by low level. It need disable SDIO IRQ
> detected function. Otherwise the interrupt register can't be cleared.
> It will process the interrupt more.
>
> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>

Applied for fixes and by adding a fixes/stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index c518cc2..fa7d420 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1383,24 +1383,25 @@ static void msdc_request_timeout(struct work_struct *work)
>         }
>  }
>
> -static void __msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> +static void __msdc_enable_sdio_irq(struct msdc_host *host, int enb)
>  {
> -       unsigned long flags;
> -       struct msdc_host *host = mmc_priv(mmc);
> -
> -       spin_lock_irqsave(&host->lock, flags);
> -       if (enb)
> +       if (enb) {
>                 sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> -       else
> +               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +       } else {
>                 sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> -       spin_unlock_irqrestore(&host->lock, flags);
> +               sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +       }
>  }
>
>  static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
>  {
> +       unsigned long flags;
>         struct msdc_host *host = mmc_priv(mmc);
>
> -       __msdc_enable_sdio_irq(mmc, enb);
> +       spin_lock_irqsave(&host->lock, flags);
> +       __msdc_enable_sdio_irq(host, enb);
> +       spin_unlock_irqrestore(&host->lock, flags);
>
>         if (enb)
>                 pm_runtime_get_noresume(host->dev);
> @@ -1422,6 +1423,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>                 spin_lock_irqsave(&host->lock, flags);
>                 events = readl(host->base + MSDC_INT);
>                 event_mask = readl(host->base + MSDC_INTEN);
> +               if ((events & event_mask) & MSDC_INT_SDIOIRQ)
> +                       __msdc_enable_sdio_irq(host, 0);
>                 /* clear interrupts */
>                 writel(events & event_mask, host->base + MSDC_INT);
>
> @@ -1430,10 +1433,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>                 data = host->data;
>                 spin_unlock_irqrestore(&host->lock, flags);
>
> -               if ((events & event_mask) & MSDC_INT_SDIOIRQ) {
> -                       __msdc_enable_sdio_irq(host->mmc, 0);
> +               if ((events & event_mask) & MSDC_INT_SDIOIRQ)
>                         sdio_signal_irq(host->mmc);
> -               }
>
>                 if ((events & event_mask) & MSDC_INT_CDSC) {
>                         if (host->internal_cd)
> @@ -1572,10 +1573,7 @@ static void msdc_init_hw(struct msdc_host *host)
>         sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
>
>         /* Config SDIO device detect interrupt function */
> -       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> -               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> -       else
> -               sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +       sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
>
>         /* Configure to default data timeout */
>         sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
> @@ -2103,7 +2101,12 @@ static void msdc_hw_reset(struct mmc_host *mmc)
>
>  static void msdc_ack_sdio_irq(struct mmc_host *mmc)
>  {
> -       __msdc_enable_sdio_irq(mmc, 1);
> +       unsigned long flags;
> +       struct msdc_host *host = mmc_priv(mmc);
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       __msdc_enable_sdio_irq(host, 1);
> +       spin_unlock_irqrestore(&host->lock, flags);
>  }
>
>  static int msdc_get_cd(struct mmc_host *mmc)
> --
> 1.9.1
>
