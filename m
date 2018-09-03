From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/8] Tegra SDHCI support HS400 on Tegra210 and Tegra186
Date: Mon, 3 Sep 2018 08:14:16 +0200
Message-ID: <CAPDyKFqBin991q5P2k3jEjz6PxSYEQW9HwMzuC0nYz9u2yT9FQ@mail.gmail.com>
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 10 August 2018 at 20:13, Aapo Vienamo <avienamo@nvidia.com> wrote:
> Hi all,
> This series implements support for HS400 signaling on Tegra210 and
> Tegra186. This includes programming the DQS trimmer values, implementing
> enhanced strobe and HS400 delay line calibration.
>
> This series depends on the "Tegra SDHCI add support for HS200 and UHS
> signaling" series.
>
> Changelog:
> v2:
>         - Document in dt-bindings which controllers support HS400
>         - Use val instead of reg in tegra_sdhci_set_dqs_trim()
>         - Change "dt" to "DT" in "mmc: tegra: Parse and program DQS trim
>           value" commit message
>         - Add spaces around << in tegra_sdhci_set_dqs_trim()
>         - Make the "mmc: tegra: Implement HS400 enhanced strobe" commit
>           message more detailed
>         - Remove a debug print from tegra_sdhci_hs400_enhanced_strobe()
>         - Add blank lines around if-else-block in
>           tegra_sdhci_hs400_enhanced_strobe()
>         - Use val instead of reg in tegra_sdhci_hs400_enhanced_strobe()
>         - Make commit message of "mmc: tegra: Implement HS400 delay line
>           calibration" more detailed
>
> Aapo Vienamo (8):
>   dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
>   mmc: tegra: Parse and program DQS trim value
>   mmc: tegra: Implement HS400 enhanced strobe
>   mmc: tegra: Implement HS400 delay line calibration
>   arm64: dts: tegra186: Add SDMMC4 DQS trim value
>   arm64: dts: tegra210: Add SDMMC4 DQS trim value
>   arm64: dts: tegra186: Enable HS400
>   arm64: dts: tegra210: Enable HS400
>
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  4 ++
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  2 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  2 +
>  drivers/mmc/host/sdhci-tegra.c                     | 84 +++++++++++++++++++++-
>  4 files changed, 89 insertions(+), 3 deletions(-)
>
> --
> 2.7.4
>

Applied patch 1->4 for next, thanks!

Kind regards
Uffe
