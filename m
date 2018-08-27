From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/8] Tegra SDHCI support HS400 on Tegra210 and Tegra186
Date: Mon, 27 Aug 2018 11:50:52 +0200
Message-ID: <CAPDyKFrXQwjvNQeAbWfNeoc+wSfb+EeD-XrudHjeKGxsYS2-9A@mail.gmail.com>
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com> <20180824091103.GA9100@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824091103.GA9100@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Aapo Vienamo <avienamo@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 24 August 2018 at 11:11, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Fri, Aug 10, 2018 at 09:13:57PM +0300, Aapo Vienamo wrote:
>> Hi all,
>> This series implements support for HS400 signaling on Tegra210 and
>> Tegra186. This includes programming the DQS trimmer values, implementing
>> enhanced strobe and HS400 delay line calibration.
>>
>> This series depends on the "Tegra SDHCI add support for HS200 and UHS
>> signaling" series.
>>
>> Changelog:
>> v2:
>>       - Document in dt-bindings which controllers support HS400
>>       - Use val instead of reg in tegra_sdhci_set_dqs_trim()
>>       - Change "dt" to "DT" in "mmc: tegra: Parse and program DQS trim
>>         value" commit message
>>       - Add spaces around << in tegra_sdhci_set_dqs_trim()
>>       - Make the "mmc: tegra: Implement HS400 enhanced strobe" commit
>>         message more detailed
>>       - Remove a debug print from tegra_sdhci_hs400_enhanced_strobe()
>>       - Add blank lines around if-else-block in
>>         tegra_sdhci_hs400_enhanced_strobe()
>>       - Use val instead of reg in tegra_sdhci_hs400_enhanced_strobe()
>>       - Make commit message of "mmc: tegra: Implement HS400 delay line
>>         calibration" more detailed
>>
>> Aapo Vienamo (8):
>>   dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
>>   mmc: tegra: Parse and program DQS trim value
>>   mmc: tegra: Implement HS400 enhanced strobe
>>   mmc: tegra: Implement HS400 delay line calibration
>>   arm64: dts: tegra186: Add SDMMC4 DQS trim value
>>   arm64: dts: tegra210: Add SDMMC4 DQS trim value
>>   arm64: dts: tegra186: Enable HS400
>>   arm64: dts: tegra210: Enable HS400
>>
>>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  4 ++
>>  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  2 +
>>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  2 +
>>  drivers/mmc/host/sdhci-tegra.c                     | 84 +++++++++++++++++++++-
>>  4 files changed, 89 insertions(+), 3 deletions(-)
>
> Ulf, Adrian,
>
> Aapo just reminded me of this small series that also has a dependency on
> the UHS signalling series posted earlier. I think it's easiest if I just
> stash this on top of the existing branch that I have and send this along
> with the rest as part of a pull request early after v4.19-rc1.

Yep, that would be convenient for me.

Although, we first need some input from Adrian.

Kind regards
Uffe
