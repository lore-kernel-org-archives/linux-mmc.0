From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 00/40] Tegra SDHCI add support for HS200 and UHS signaling
Date: Thu, 23 Aug 2018 12:42:14 +0200
Message-ID: <CAPDyKFq=Ox+BfU+-D-T6pd81x+_WG_P_VztNRTJ97sAEe8sNDQ@mail.gmail.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com> <20180823084704.GA28696@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180823084704.GA28696@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Aapo Vienamo <avienamo@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 23 August 2018 at 10:47, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Fri, Aug 10, 2018 at 09:08:02PM +0300, Aapo Vienamo wrote:
>> Hi all,
>>
>> This series implements support for faster signaling modes on Tegra
>> SDHCI controllers. This series consist of several parts: changes
>> requried for 1.8 V signaling and pad control, pad calibration, and
>> tuning. Following earlies patch sets have been merged into this
>> larger set: "Tegra PMC pinctrl pad configuration", "Tegra SDHCI enable
>> 1.8 V signaling on Tegar210 and Tegra186", "Tegra SDHCI update the
>> padautocal procedure". Also the patches for enabling SDHCI tuning
>> are added.
>>
>> Changelog:
>> v2:
>>       - Fix grammar in PMC device tree bindings docs
>>       - Remove a stray line from tegra sdhci bindings
>>       - Cosmetic changes to PMC pinctrl driver
>>       - Fix a typo in "soc/tegra: pmc: Implement
>>         tegra_io_pad_is_powered()" commit message
>>       - Declare mask and value on the same line in
>>         tegra_io_pad_is_powered()
>>       - Move the call to tegra_sdhci_is_pad_and_regulator_valid() to
>>         inside the if condition in tegra_sdhci_reset()
>>       - Use usleep_range() in tegra_sdhci_configure_cal_pad()
>>       - Move sdhci_writel() out of the enable if-else body in
>>         tegra_sdhci_configure_cal_pad()
>>       - Add a delay before starting polling in
>>         tegra_sdhci_pad_autocalib()
>>       - Use usleep_range() in tegra_sdhci_set_tap()
>>       - Rename orig_enabled to status in
>>         tegra_sdhci_configure_card_clk()
>>       - Fix if condition wrapping alignment in tegra_sdhci_set_tap()
>>
>> v1:
>>       - Probe the regulator voltage capabilities to determine whether pinctrl
>>         is needed in tegra_sdhci_r eset
>>       - Don't remove tegra_sdhci_voltage_switch()
>>       - Use dev_warn() in tegra_sdhci_init_pinctrl_info()
>>       - Don't change start_signal_voltage_switch callback if pinctrl info
>>         invalid
>>       - Only call udelay(1) on enable in tegra_sdhci_configure_cal_pad()
>>       - Add nvidia, prefix to pad autocal offset dt props in the example
>>
>> See the original patch sets for earlier changelogs.
>>
>> Aapo Vienamo (40):
>>   dt-bindings: Add Tegra PMC pad configuration bindings
>>   dt-bindings: mmc: tegra: Add pad voltage control properties
>>   dt-bindings: Add Tegra SDHCI pad pdpu offset bindings
>>   dt-bindings: mmc: Add Tegra SDHCI sampling trimmer values
>>   soc/tegra: pmc: Fix pad voltage configuration for Tegra186
>>   soc/tegra: pmc: Factor out DPD register bit calculation
>>   soc/tegra: pmc: Implement tegra_io_pad_is_powered()
>>   soc/tegra: pmc: Use X macro to generate IO pad tables
>>   soc/tegra: pmc: Remove public pad voltage APIs
>>   soc/tegra: pmc: Implement pad configuration via pinctrl
>>   mmc: sdhci: Add a quirk to skip clearing the transfer mode register on
>>     tuning
>>   mmc: tegra: Reconfigure pad voltages during voltage switching
>>   mmc: tegra: Poll for calibration completion
>>   mmc: tegra: Set calibration pad voltage reference
>>   mmc: tegra: Power on the calibration pad
>>   mmc: tegra: Disable card clock during pad calibration
>>   mmc: tegra: Program pad autocal offsets from dt
>>   mmc: tegra: Perform pad calibration after voltage switch
>>   mmc: tegra: Enable pad calibration on Tegra210 and Tegra186
>>   mmc: tegra: Add a workaround for tap value change glitch
>>   mmc: tegra: Parse default trim and tap from dt
>>   mmc: tegra: Configure default tap values
>>   mmc: tegra: Configure default trim value on reset
>>   mmc: tegra: Use standard SDHCI tuning on Tegra210 and Tegra186
>>   mmc: sdhci: Add a quirk to disable card clock during tuning
>>   mmc: tegra: Enable workaround for tuning transfer mode bug
>>   mmc: tegra: Set SDHCI_QUIRK2_TUNE_DIS_CARD_CLK on Tegra210
>>   mmc: tegra: Enable UHS and HS200 modes for Tegra210
>>   mmc: tegra: Enable UHS and HS200 modes for Tegra186
>>   arm64: dts: Add Tegra210 sdmmc pinctrl voltage states
>>   arm64: dts: Add Tegra186 sdmmc pinctrl voltage states
>>   arm64: dts: tegra210-p2180: Allow ldo2 to go down to 1.8 V
>>   arm64: dts: tegra210-p2180: Correct sdmmc4 vqmmc-supply
>>   arm64: dts: tegra210-p2597: Remove no-1-8-v from sdmmc1
>>   arm64: dts: tegra186: Add sdmmc pad auto calibration offsets
>>   arm64: dts: tegra210: Add sdmmc pad auto calibration offsets
>>   arm64: dts: tegra210: Add SDHCI tap and trim values
>>   arm64: dts: tegra186: Add SDHCI tap and trim values
>>   arm64: dts: tegra186: Assign clocks for sdmmc1 and sdmmc4
>>   arm64: dts: tegra210: Assign clocks for sdmmc1 and sdmmc4
>>
>>  .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  93 ++++
>>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 103 ++++
>>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  68 +++
>>  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  74 +++
>>  arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |  12 +-
>>  arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   1 -
>>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  55 ++
>>  drivers/mmc/host/sdhci-tegra.c                     | 556 +++++++++++++++++++--
>>  drivers/mmc/host/sdhci.c                           |  21 +
>>  drivers/mmc/host/sdhci.h                           |   4 +
>>  drivers/soc/tegra/pmc.c                            | 511 ++++++++++++++-----
>>  include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h |  18 +
>>  include/soc/tegra/pmc.h                            |  20 +-
>>  13 files changed, 1324 insertions(+), 212 deletions(-)
>>  create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
>
> Hi Ulf, Adrian,
>
> I've been running some tests on this on various Tegra boards and this
> all seems to work fine. I'm also pretty happy with how this turned out,
> so the whole series is:
>
> Acked-by: Thierry Reding <treding@nvidia.com>
>
> In order to get this merged, I think it'd be best for you guys to pick
> up the MMC patches, since they are all independent of the rest. There is
> a runtime dependency on the PMC bits for the faster modes, but things
> will fallback to the status quo if those bits are not enabled. The only
> dependency here is between the PMC and DTS changes, which I usually pick
> up into the Tegra tree anyway, so I can sort that out there.

Great, thanks for clarifying the dependency.

>
> Since I've already gone through the process of splitting up the series,
> I can offer to rebase the MMC patches on top of v4.19-rc1 when it's out
> and send a pull request for the MMC patches.

That sounds convenient for me. Please also include the corresponding
dt doc changes for mmc, as I am normally queuing these via my mmc
tree.

Although, I think it's better to wait until Adrian has given his ack
for the series.

> Alternatively I can further
> split that branch up into two parts, one with the two patches that touch
> the core and another with the remainder, if that's what you prefer. Or
> you can of course feel free to apply all of the MMC patches yourselves
> with my above Acked-by if you want to.
>
> Any thought on the above?

Let's see how it goes, if there are any struggles, I don't have a
problem to cherry-pick the mmc parts of the series.

Kind regards
Uffe
