From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pci: remove outdated declaration
Date: Fri, 22 Sep 2017 11:45:38 +0200
Message-ID: <CAPDyKFq9bXTiohOZ9O6aysjDLgYPRnXUt2fL3yp=f5XUrcXVbw@mail.gmail.com>
References: <20170915181328.31510-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170915181328.31510-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 15 September 2017 at 20:13, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> The function was removed half a year ago, so this declaration can go,
> too.
>
> Fixes: 51ced59cc02e0d ("mmc: sdhci-pci: Use ACPI DSM to get driver strength for some Intel devices")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  include/linux/mmc/sdhci-pci-data.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/include/linux/mmc/sdhci-pci-data.h b/include/linux/mmc/sdhci-pci-data.h
> index fda15b6d4135d3..618f90d6e1ba1a 100644
> --- a/include/linux/mmc/sdhci-pci-data.h
> +++ b/include/linux/mmc/sdhci-pci-data.h
> @@ -14,7 +14,4 @@ struct sdhci_pci_data {
>
>  extern struct sdhci_pci_data *(*sdhci_pci_get_data)(struct pci_dev *pdev,
>                                 int slotno);
> -
> -extern int sdhci_pci_spt_drive_strength;
> -
>  #endif
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
