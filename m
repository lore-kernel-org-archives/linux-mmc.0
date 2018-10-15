From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: uniphier-sd: fix DMA disabling
Date: Mon, 15 Oct 2018 15:15:43 +0200
Message-ID: <CAPDyKFqa__C+34=tFRnysEz0R2Xy-ZAZSHp1JEv=pOEsfK2VWQ@mail.gmail.com>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com> <1539356258-12374-2-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539356258-12374-2-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 12 October 2018 at 16:57, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Once DMA is enabled, it is not possible to disable it because
> uniphier_sd_dma_endisable() always sets the DMA_ENABLE_DMASDRW bit
> regardless of the argument 'enable'. It should disable DMA when
> 'enable' is false.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/uniphier-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
> index 10e7b30..10d49aa 100644
> --- a/drivers/mmc/host/uniphier-sd.c
> +++ b/drivers/mmc/host/uniphier-sd.c
> @@ -78,7 +78,7 @@ static void *uniphier_sd_priv(struct tmio_mmc_host *host)
>
>  static void uniphier_sd_dma_endisable(struct tmio_mmc_host *host, int enable)
>  {
> -       sd_ctrl_write16(host, CTL_DMA_ENABLE, DMA_ENABLE_DMASDRW);
> +       sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? DMA_ENABLE_DMASDRW : 0);
>  }
>
>  /* external DMA engine */
> --
> 2.7.4
>
