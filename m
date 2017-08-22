From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 04/16] mmc: meson-gx: use _irqsave variant of spinlock
Date: Tue, 22 Aug 2017 13:08:46 +0200
Message-ID: <CAPDyKFpoOc+1WMqLMOwhGkifP-Zp3GS7wTSkHmBUk4Pf0Dh+DQ@mail.gmail.com>
References: <20170821160301.21899-1-jbrunet@baylibre.com> <20170821160301.21899-5-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36974 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932350AbdHVLIr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 07:08:47 -0400
Received: by mail-qk0-f173.google.com with SMTP id z18so95203773qka.4
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 04:08:47 -0700 (PDT)
In-Reply-To: <20170821160301.21899-5-jbrunet@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 21 August 2017 at 18:02, Jerome Brunet <jbrunet@baylibre.com> wrote:
> spinlock used in interrupt handler should use the _irqsave variant

Exactly why is that needed?

>
> Fixes: 51c5d8447bd7 ("MMC: meson: initial support for GX platforms")
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 8a74a048db88..a399fbd415f4 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -727,6 +727,7 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>         struct mmc_command *cmd;
>         struct mmc_data *data;
>         u32 irq_en, status, raw_status;
> +       unsigned long flag;
>         irqreturn_t ret = IRQ_HANDLED;
>
>         if (WARN_ON(!host))
> @@ -739,7 +740,7 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>
>         data = cmd->data;
>
> -       spin_lock(&host->lock);
> +       spin_lock_irqsave(&host->lock, flag);
>         irq_en = readl(host->regs + SD_EMMC_IRQ_EN);
>         raw_status = readl(host->regs + SD_EMMC_STATUS);
>         status = raw_status & irq_en;
> @@ -806,7 +807,7 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>         if (ret == IRQ_HANDLED)
>                 meson_mmc_request_done(host->mmc, cmd->mrq);
>
> -       spin_unlock(&host->lock);
> +       spin_unlock_irqrestore(&host->lock, flag);
>         return ret;
>  }
>
> --
> 2.9.5
>

Kind regards
Uffe
