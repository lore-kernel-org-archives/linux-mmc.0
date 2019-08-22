From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: jz4740: Code cleanup
Date: Thu, 22 Aug 2019 14:13:11 +0200
Message-ID: <CAPDyKFowvV=O_3Xg8j9nH7szb91Dd1heUt7nK0acRanZL68zsQ@mail.gmail.com>
References: <20190810121608.24145-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190810121608.24145-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, od@zcrc.me
List-Id: linux-mmc@vger.kernel.org

On Sat, 10 Aug 2019 at 14:16, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Fix wrong code indentation which made the code hard to read, and fix
> return with value in void function.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index ffdbfaadd3f2..59f81e8afcce 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -186,9 +186,9 @@ static void jz4740_mmc_write_irq_reg(struct jz4740_mmc_host *host,
>                                      uint32_t val)
>  {
>         if (host->version >= JZ_MMC_JZ4780)
> -               return writel(val, host->base + JZ_REG_MMC_IREG);
> +               writel(val, host->base + JZ_REG_MMC_IREG);
>         else
> -               return writew(val, host->base + JZ_REG_MMC_IREG);
> +               writew(val, host->base + JZ_REG_MMC_IREG);
>  }
>
>  static uint32_t jz4740_mmc_read_irq_reg(struct jz4740_mmc_host *host)
> @@ -820,14 +820,14 @@ static irqreturn_t jz_mmc_irq(int irq, void *devid)
>                         del_timer(&host->timeout_timer);
>
>                         if (status & JZ_MMC_STATUS_TIMEOUT_RES) {
> -                                       cmd->error = -ETIMEDOUT;
> +                               cmd->error = -ETIMEDOUT;
>                         } else if (status & JZ_MMC_STATUS_CRC_RES_ERR) {
> -                                       cmd->error = -EIO;
> +                               cmd->error = -EIO;
>                         } else if (status & (JZ_MMC_STATUS_CRC_READ_ERROR |
>                                     JZ_MMC_STATUS_CRC_WRITE_ERROR)) {
> -                                       if (cmd->data)
> -                                                       cmd->data->error = -EIO;
> -                                       cmd->error = -EIO;
> +                               if (cmd->data)
> +                                       cmd->data->error = -EIO;
> +                               cmd->error = -EIO;
>                         }
>
>                         jz4740_mmc_set_irq_enabled(host, irq_reg, false);
> --
> 2.21.0.593.g511ec345e18
>
