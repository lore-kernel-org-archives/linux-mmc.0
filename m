From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 0/8] Tegra SDHCI support HS400 on Tegra210 and Tegra186
Date: Mon, 27 Aug 2018 13:26:05 +0300
Message-ID: <095142c4-2697-d9e1-4930-a39e27b7ef40@intel.com>
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
 <20180827100826.GA18542@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180827100826.GA18542@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Aapo Vienamo <avienamo@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 27/08/18 13:08, Thierry Reding wrote:
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
>> 	- Document in dt-bindings which controllers support HS400
>> 	- Use val instead of reg in tegra_sdhci_set_dqs_trim()
>> 	- Change "dt" to "DT" in "mmc: tegra: Parse and program DQS trim
>> 	  value" commit message
>> 	- Add spaces around << in tegra_sdhci_set_dqs_trim()
>> 	- Make the "mmc: tegra: Implement HS400 enhanced strobe" commit
>> 	  message more detailed
>> 	- Remove a debug print from tegra_sdhci_hs400_enhanced_strobe()
>> 	- Add blank lines around if-else-block in
>> 	  tegra_sdhci_hs400_enhanced_strobe()
>> 	- Use val instead of reg in tegra_sdhci_hs400_enhanced_strobe()
>> 	- Make commit message of "mmc: tegra: Implement HS400 delay line
>> 	  calibration" more detailed
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
> Adrian,
> 
> any chance you could take a brief look at these? They are a prerequisite
> for the 2-patch series ("[PATCH 0/2] Tegra SDHCI rerun pad calibration
> periodically") that you already acked.

Sure, I'll try and have a look today.
