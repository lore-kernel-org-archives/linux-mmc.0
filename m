From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Annotate implicit fall through in jz_mmc_irq_worker
Date: Tue, 22 Jan 2019 08:47:59 +0100
Message-ID: <CAPDyKFq2k=DqJmkRv_5Awwsc0Wken7tST11iAg3YefY-_y4y=w@mail.gmail.com>
References: <20190116195219.2897-1-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116195219.2897-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Malaterre <malat@debian.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 16 Jan 2019 at 20:52, Mathieu Malaterre <malat@debian.org> wrote:
>
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> these places in the code produced warnings (W=1).
>
> This commit removes the following warnings:
>
>   drivers/mmc/host/jz4740_mmc.c:745:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   drivers/mmc/host/jz4740_mmc.c:779:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 33215d66afa2..a1df8bc0b964 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -743,6 +743,7 @@ static irqreturn_t jz_mmc_irq_worker(int irq, void *devid)
>                         break;
>
>                 jz_mmc_prepare_data_transfer(host);
> +               /* fall through */
>
>         case JZ4740_MMC_STATE_TRANSFER_DATA:
>                 if (host->use_dma) {
> @@ -777,6 +778,7 @@ static irqreturn_t jz_mmc_irq_worker(int irq, void *devid)
>                         break;
>                 }
>                 jz4740_mmc_write_irq_reg(host, JZ_MMC_IRQ_DATA_TRAN_DONE);
> +               /* fall through */
>
>         case JZ4740_MMC_STATE_SEND_STOP:
>                 if (!req->stop)
> --
> 2.19.2
>
