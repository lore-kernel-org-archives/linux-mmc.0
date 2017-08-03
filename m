From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: of_mmc_spi: fix restricted cast warning of sparse
Date: Thu, 3 Aug 2017 12:51:45 +0200
Message-ID: <CAPDyKFq5Ss+7FmdfwmY_ax49C-5Vr65v73QqyBevcO+svpBmVA@mail.gmail.com>
References: <1501502633-14205-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501502633-14205-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 31 July 2017 at 14:03, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> Sparse reports "warning: cast to restricted __be32".
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/of_mmc_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> index 85bbebfde02e..c9eed8436b6b 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -71,7 +71,7 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
>         struct device *dev = &spi->dev;
>         struct device_node *np = dev->of_node;
>         struct of_mmc_spi *oms;
> -       const u32 *voltage_ranges;
> +       const __be32 *voltage_ranges;
>         int num_ranges;
>         int i;
>
> --
> 2.7.4
>
