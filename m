From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/3] mmc: sdhci: sdhci-pci-o2micro: Correctly set bus
 width when tuning
Date: Tue, 18 Jun 2019 13:40:45 +0200
Message-ID: <CAPDyKFom1q33iOmxHp1pbzcDuE3FxYAoBXWupAe97RwUx0BBXQ@mail.gmail.com>
References: <20190617201014.84503-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190617201014.84503-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "ernest.zhang" <ernest.zhang@bayhubtech.com>, Daniel Kurtz <djkurtz@chromium.org>, Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 17 Jun 2019 at 22:10, Raul E Rangel <rrangel@chromium.org> wrote:
>
> The O2Micro controller only supports tuning at 4-bits. So the host driver
> needs to change the bus width while tuning and then set it back when done.
>
> There was a bug in the original implementation in that mmc->ios.bus_width
> also wasn't updated. Thus setting the incorrect blocksize in
> sdhci_send_tuning which results in a tuning failure.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> Fixes: 0086fc217d5d7 ("mmc: sdhci: Add support for O2 hardware tuning")
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-pci-o2micro.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index b29bf4e7dcb48..dd21315922c87 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -115,6 +115,7 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>          */
>         if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
>                 current_bus_width = mmc->ios.bus_width;
> +               mmc->ios.bus_width = MMC_BUS_WIDTH_4;
>                 sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
>         }
>
> @@ -126,8 +127,10 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>         sdhci_end_tuning(host);
>
> -       if (current_bus_width == MMC_BUS_WIDTH_8)
> +       if (current_bus_width == MMC_BUS_WIDTH_8) {
> +               mmc->ios.bus_width = MMC_BUS_WIDTH_8;
>                 sdhci_set_bus_width(host, current_bus_width);
> +       }
>
>         host->flags &= ~SDHCI_HS400_TUNING;
>         return 0;
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
