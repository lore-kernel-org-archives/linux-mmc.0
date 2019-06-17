From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1] mmc: sdhci-of-esdhc: set the sd clock divisor value
 above 3
Date: Mon, 17 Jun 2019 13:35:20 +0200
Message-ID: <CAPDyKFq-zb3aA7SjFPxx3-xDb+UUwEGG5EK1UW951LyQnBNopA@mail.gmail.com>
References: <20190614082954.39648-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190614082954.39648-1-yinbo.zhu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinbo Zhu <yinbo.zhu@nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Xiaobo Xie <xiaobo.xie@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yangbo Lu <yangbo.lu@nxp.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, 14 Jun 2019 at 10:28, Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
>
> From: Yangbo Lu <yangbo.lu@nxp.com>
>
> This patch is to set the sd clock divisor value above 3 in tuning mode
>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index d4ec0a959a75..c4af026c3fba 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -824,9 +824,17 @@ static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
>         bool hs400_tuning;
> +       unsigned int clk;
>         u32 val;
>         int ret;
>
> +       /* For tuning mode, the sd clock divisor value
> +        * must be larger than 3 according to reference manual.
> +        */
> +       clk = esdhc->peripheral_clock / 3;
> +       if (host->clock > clk)
> +               esdhc_of_set_clock(host, clk);
> +
>         if (esdhc->quirk_limited_clk_division &&
>             host->flags & SDHCI_HS400_TUNING)
>                 esdhc_of_set_clock(host, host->clock);
> --
> 2.17.1
>
