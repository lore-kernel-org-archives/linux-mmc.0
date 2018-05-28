From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 16/33] mmc: sdhci-xenon: use match_string() helper
Date: Mon, 28 May 2018 13:27:14 +0200
Message-ID: <CAPDyKFoSb1sBaNPtfrZKaa++VA3rKKvcXb6cpue8pzjca7wbPg@mail.gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-17-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526903890-35761-17-git-send-email-xieyisheng1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Hu Ziji <huziji@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 21 May 2018 at 13:57, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Hu Ziji <huziji@marvell.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index ec87943..a35804b 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -814,15 +814,10 @@ static int xenon_add_phy(struct device_node *np, struct sdhci_host *host,
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -       int i, ret;
> +       int ret;
>
> -       for (i = 0; i < NR_PHY_TYPES; i++) {
> -               if (!strcmp(phy_name, phy_types[i])) {
> -                       priv->phy_type = i;
> -                       break;
> -               }
> -       }
> -       if (i == NR_PHY_TYPES) {
> +       priv->phy_type = match_string(phy_types, NR_PHY_TYPES, phy_name);
> +       if (priv->phy_type < 0) {
>                 dev_err(mmc_dev(host->mmc),
>                         "Unable to determine PHY name %s. Use default eMMC 5.1 PHY\n",
>                         phy_name);
> --
> 1.7.12.4
>
