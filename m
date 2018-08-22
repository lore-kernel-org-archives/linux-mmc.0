From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/1] mmc: dw_mmc: hi3798cv200: add MMC_CAP_CMD23 cap
Date: Wed, 22 Aug 2018 11:48:38 +0200
Message-ID: <CAPDyKFpQfOgdzpqM9VytADxE9ZHOAw=6VzTgP=WD=iM93eRRnQ@mail.gmail.com>
References: <1534770297-5242-1-git-send-email-igor.opaniuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534770297-5242-1-git-send-email-igor.opaniuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Igor Opaniuk <igor.opaniuk@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, tianshuliang <tianshuliang@hisilicon.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 20 August 2018 at 15:04, Igor Opaniuk <igor.opaniuk@linaro.org> wrote:
> Enable access to the RPMB on the on-board eMMC of the
> Poplar board.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>

Thanks, queued for v.4.20!

Kind regards
Uffe

> ---
>
> v2:
> - as there are three dwmmc blocks integrated on Hi3798CV200 SoC with
> identical CMD23 support, provide MMC_CAP_CMD23 capability instead of 0 for
> the third block also.
>
>  drivers/mmc/host/dw_mmc-hi3798cv200.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> index f9b333f..bc51cef 100644
> --- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
> +++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> @@ -23,6 +23,12 @@ struct hi3798cv200_priv {
>         struct clk *drive_clk;
>  };
>
> +static unsigned long dw_mci_hi3798cv200_caps[] = {
> +       MMC_CAP_CMD23,
> +       MMC_CAP_CMD23,
> +       MMC_CAP_CMD23
> +};
> +
>  static void dw_mci_hi3798cv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  {
>         struct hi3798cv200_priv *priv = host->priv;
> @@ -160,6 +166,8 @@ static int dw_mci_hi3798cv200_init(struct dw_mci *host)
>  }
>
>  static const struct dw_mci_drv_data hi3798cv200_data = {
> +       .caps = dw_mci_hi3798cv200_caps,
> +       .num_caps = ARRAY_SIZE(dw_mci_hi3798cv200_caps),
>         .init = dw_mci_hi3798cv200_init,
>         .set_ios = dw_mci_hi3798cv200_set_ios,
>         .execute_tuning = dw_mci_hi3798cv200_execute_tuning,
> --
> 2.7.4
>
