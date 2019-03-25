From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/24] dt-bindings: mmc: mtk-sd: add mtk-sd support for
 MT8516
Date: Mon, 25 Mar 2019 14:26:40 +0100
Message-ID: <CAPDyKFrAxmBv+1i3qJpD=M1Wq33U2PMfQv_99xDm9MLhLxSWYg@mail.gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-9-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190323211612.860-9-fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
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
Cc: DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

- trimmed cc list

On Sat, 23 Mar 2019 at 22:17, Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
>
> Add binding documentation of mtk-sd for MT8516 SoCs.
>
> Signed-off-by: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index f5bcda3980cc..91a2ec59e497 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -11,6 +11,7 @@ Required properties:
>         "mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
>         "mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
>         "mediatek,mt8183-mmc": for mmc host ip compatible with mt8183
> +       "mediatek,mt8516-mmc": for mmc host ip compatible with mt8516
>         "mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
>         "mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
>         "mediatek,mt7622-mmc": for MT7622 SoC
> --
> 2.20.1
>
