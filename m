From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v8 1/2] mmc: dw_mmc: move controller reset before driver init
Date: Tue, 8 Aug 2017 12:46:57 +0200
Message-ID: <CAPDyKFp5RJJvss9tiOy6_SMRUSyzS_1SVhK4gMpogxcUsS+iaw@mail.gmail.com>
References: <20170802031742.60363-1-liwei213@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170802031742.60363-1-liwei213@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Li Wei <liwei213@huawei.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Heiner Kallweit <hkallweit1@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guodong Xu <guodong.xu@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 2 August 2017 at 05:17, Li Wei <liwei213@huawei.com> wrote:
> This commit modifies dw_mci_probe(), it moves reset assertion before
> drv_data->init(host)
>
> Some driver needs to access controller registers in its .init() ops. So,
> in order to make such access safe, we should do controller reset before
> .init() being called.
>
> Signed-off-by: Wei Li <liwei213@huawei.com>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> Signed-off-by: Chen Jun <chenjun14@huawei.com>

This looks good to me. However, I need an ack from Jaehoon to pick this up.

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a9dfb26972f2..f2fa928e1a12 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3067,6 +3067,12 @@ int dw_mci_probe(struct dw_mci *host)
>                 goto err_clk_ciu;
>         }
>
> +       if (!IS_ERR(host->pdata->rstc)) {
> +               reset_control_assert(host->pdata->rstc);
> +               usleep_range(10, 50);
> +               reset_control_deassert(host->pdata->rstc);
> +       }
> +
>         if (drv_data && drv_data->init) {
>                 ret = drv_data->init(host);
>                 if (ret) {
> @@ -3076,12 +3082,6 @@ int dw_mci_probe(struct dw_mci *host)
>                 }
>         }
>
> -       if (!IS_ERR(host->pdata->rstc)) {
> -               reset_control_assert(host->pdata->rstc);
> -               usleep_range(10, 50);
> -               reset_control_deassert(host->pdata->rstc);
> -       }
> -
>         setup_timer(&host->cmd11_timer,
>                     dw_mci_cmd11_timer, (unsigned long)host);
>
> --
> 2.11.0
>
