From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: rockchip: remove incorrect __exit_p()
Date: Tue, 27 Jan 2015 14:59:15 +0100
Message-ID: <CAPDyKFobsHLRVS_T5H1o2R1c6orFeKFgAsQA_akknvPur0UfzA@mail.gmail.com>
References: <20150124003009.GA14891@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150124003009.GA14891@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chris Ball <chris@printf.net>, Doug Anderson <dianders@chromium.org>, Addy Ke <addy.ke@rock-chips.com>, linux-mmc <linux-mmc@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 24 January 2015 at 01:30, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> dw_mci_pltfm_remove() is not (nor should it be) marked as __exit,
> so we should not be using __exit_p() wrapper with it.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks! Applied for next.

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 5650ac4..e2a726a 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -133,7 +133,7 @@ static SIMPLE_DEV_PM_OPS(dw_mci_rockchip_pmops,
>
>  static struct platform_driver dw_mci_rockchip_pltfm_driver = {
>         .probe          = dw_mci_rockchip_probe,
> -       .remove         = __exit_p(dw_mci_pltfm_remove),
> +       .remove         = dw_mci_pltfm_remove,
>         .driver         = {
>                 .name           = "dwmmc_rockchip",
>                 .of_match_table = dw_mci_rockchip_match,
> --
> 2.2.0.rc0.207.ga3a616c
>
>
> --
> Dmitry
