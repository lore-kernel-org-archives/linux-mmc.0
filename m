From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 01/10] mmc: tegra: fix ddr signaling for non-ddr modes
Date: Thu, 21 Mar 2019 11:32:34 +0100
Message-ID: <CAPDyKFp30v1H0KfPFeOc5Ut1dW5tec7cT7NFk6j0VT+DWkAODw@mail.gmail.com>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Harjani Ritesh <riteshh@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, anrao@nvidia.com, linux-tegra <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 13 Mar 2019 at 22:45, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> ddr_signaling is set to true for DDR50 and DDR52 modes but is
> not set back to false for other modes. This programs incorrect
> host clock when mode change happens from DDR52/DDR50 to other
> SDR or HS modes like incase of mmc_retune where it switches
> from HS400 to HS DDR and then from HS DDR to HS mode and then
> to HS200.
>
> This patch fixes the ddr_signaling to set properly for non DDR
> modes.
>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Is this a fix and/or shall I tag it for stable?

The series looks good to me, however I am awaiting two more acks from
Adrian on patch 2 and patch3.

Kind regards
Uffe



> ---
>  drivers/mmc/host/sdhci-tegra.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 32e62904c0d3..46086dd43bfb 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -779,6 +779,7 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
>         bool set_dqs_trim = false;
>         bool do_hs400_dll_cal = false;
>
> +       tegra_host->ddr_signaling = false;
>         switch (timing) {
>         case MMC_TIMING_UHS_SDR50:
>         case MMC_TIMING_UHS_SDR104:
> --
> 2.7.4
>
