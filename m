From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: exynos: remove incorrect __exit_p()
Date: Tue, 27 Jan 2015 14:59:01 +0100
Message-ID: <CAPDyKFpk_SjBpT=+yCfNv8yGVVT64Z5GugjL+qoYubxjduxN3g@mail.gmail.com>
References: <20150124003340.GA16286@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150124003340.GA16286@dtor-ws>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Kukjin Kim <kgene@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 24 January 2015 at 01:33, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> dw_mci_pltfm_remove() is not (nor should it be) marked as __exit,
> so we should not be using __exit_p() wrapper with it.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks! Applied for next.

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-exynos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 12a5eaa..fe32948 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -422,7 +422,7 @@ static const struct dev_pm_ops dw_mci_exynos_pmops = {
>
>  static struct platform_driver dw_mci_exynos_pltfm_driver = {
>         .probe          = dw_mci_exynos_probe,
> -       .remove         = __exit_p(dw_mci_pltfm_remove),
> +       .remove         = dw_mci_pltfm_remove,
>         .driver         = {
>                 .name           = "dwmmc_exynos",
>                 .of_match_table = dw_mci_exynos_match,
> --
> 2.2.0.rc0.207.ga3a616c
>
>
> --
> Dmitry
