From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: uniphier-sd: avoid using broken DMA RX channel
Date: Mon, 15 Oct 2018 15:15:47 +0200
Message-ID: <CAPDyKFpYggUu2WDsR1CENKJDyCpZ1Nh+DrO3=oT1euGLNurxBg@mail.gmail.com>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com> <1539356258-12374-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539356258-12374-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 12 October 2018 at 16:57, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> host->chan_rx is NULL when UNIPHIER_SD_CAP_BROKEN_DMA_RX quirk flag
> is set. In this case, it should not set up DMA.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/uniphier-sd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
> index 10d49aa..1ee9fd0 100644
> --- a/drivers/mmc/host/uniphier-sd.c
> +++ b/drivers/mmc/host/uniphier-sd.c
> @@ -251,6 +251,9 @@ static void uniphier_sd_internal_dma_start(struct tmio_mmc_host *host,
>         u32 dma_mode;
>         int sg_len;
>
> +       if ((data->flags & MMC_DATA_READ) && !host->chan_rx)
> +               goto force_pio;
> +
>         if (WARN_ON(host->sg_len != 1))
>                 goto force_pio;
>
> --
> 2.7.4
>
