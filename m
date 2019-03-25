From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 10/24] mmc: mtk-sd: add support for MT8516
Date: Mon, 25 Mar 2019 14:26:47 +0100
Message-ID: <CAPDyKFrbr+3ddOG3kRi6ux4vHFUQg+GtX8fLq9cqafj3CAAePQ@mail.gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-11-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190323211612.860-11-fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

-- trimmed cc-list

On Sat, 23 Mar 2019 at 22:19, Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
>
> Add the MSDC configuration for the MT8516 SoC.
>
> Signed-off-by: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 573aa127d00b..51139275b1b2 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -507,6 +507,16 @@ static const struct mtk_mmc_compatible mt7622_compat = {
>         .support_64g = false,
>  };
>
> +static const struct mtk_mmc_compatible mt8516_compat = {
> +       .clk_div_bits = 12,
> +       .hs400_tune = false,
> +       .pad_tune_reg = MSDC_PAD_TUNE0,
> +       .async_fifo = true,
> +       .data_tune = true,
> +       .busy_check = true,
> +       .stop_clk_fix = true,
> +};
> +
>  static const struct of_device_id msdc_of_ids[] = {
>         { .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
>         { .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
> @@ -514,6 +524,7 @@ static const struct of_device_id msdc_of_ids[] = {
>         { .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
>         { .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
>         { .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
> +       { .compatible = "mediatek,mt8516-mmc", .data = &mt8516_compat},
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, msdc_of_ids);
> --
> 2.20.1
>
