From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add sdhci_arasan_set_power
Date: Thu, 30 Nov 2017 14:09:56 +0100
Message-ID: <CAPDyKFqnUE4R=VU9Y9LhahUc3vbx14wE-XuGeTog0vHPrp59rg@mail.gmail.com>
References: <1511827377-2021-1-git-send-email-milan.o.stevanovic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511827377-2021-1-git-send-email-milan.o.stevanovic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milan Stevanovic <milan.o.stevanovic@gmail.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 28 November 2017 at 01:02, Milan Stevanovic
<milan.o.stevanovic@gmail.com> wrote:
> The power register needs to have a valid voltage set
> even when the power supply is managed by  an external regulator.
>
> Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 0720ea7..fb57206 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -262,6 +262,17 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
>         return -EINVAL;
>  }
>
> +static void sdhci_arasan_set_power(struct sdhci_host *host, unsigned char mode,
> +                    unsigned short vdd)
> +{
> +       if (!IS_ERR(host->mmc->supply.vmmc)) {
> +               struct mmc_host *mmc = host->mmc;
> +
> +               mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> +       }
> +       sdhci_set_power_noreg(host, mode, vdd);
> +}
> +
>  static const struct sdhci_ops sdhci_arasan_ops = {
>         .set_clock = sdhci_arasan_set_clock,
>         .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -269,6 +280,7 @@ static const struct sdhci_ops sdhci_arasan_ops = {
>         .set_bus_width = sdhci_set_bus_width,
>         .reset = sdhci_arasan_reset,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
> +       .set_power = sdhci_arasan_set_power,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
> --
> 2.7.4
>
