From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tmio: remove unneeded variable in tmio_mmc_start_command()
Date: Mon, 30 Jul 2018 17:06:51 +0200
Message-ID: <CAPDyKFrbyiYhj_Q_hWCoxFG0pdg805ors9CuNm8Hb7Xh+2Wksg@mail.gmail.com>
References: <1532508374-28957-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532508374-28957-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 25 July 2018 at 10:46, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> Pass TMIO_MASK_CMD to tmio_mmc_enable_mmc_irqs() directly,
> and remove the variable, irq_mask.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/tmio_mmc_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 3080299..3cb554c 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -309,7 +309,6 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host,
>  {
>         struct mmc_data *data = host->data;
>         int c = cmd->opcode;
> -       u32 irq_mask = TMIO_MASK_CMD;
>
>         switch (mmc_resp_type(cmd)) {
>         case MMC_RSP_NONE: c |= RESP_NONE; break;
> @@ -349,7 +348,7 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host,
>                         c |= TRANSFER_READ;
>         }
>
> -       tmio_mmc_enable_mmc_irqs(host, irq_mask);
> +       tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_CMD);
>
>         /* Fire off the command */
>         sd_ctrl_write32_as_16_and_16(host, CTL_ARG_REG, cmd->arg);
> --
> 2.7.4
>
