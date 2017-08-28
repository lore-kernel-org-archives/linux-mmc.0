From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: Re: [PATCH 5/5] defconfig: msm: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS
Date: Mon, 28 Aug 2017 18:05:20 +0530
Message-ID: <cf8dd048-83fc-7be7-3ae0-9e0f52f4379d@codeaurora.org>
References: <1503033582-48703-1-git-send-email-vviswana@codeaurora.org>
 <1503033582-48703-6-git-send-email-vviswana@codeaurora.org>
 <CAPDyKFo7CC-mdjf3UzyJgiygtOdSic_WkKYGnv4FuwE58dTQ6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFo7CC-mdjf3UzyJgiygtOdSic_WkKYGnv4FuwE58dTQ6w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Asutosh Das <asutoshd@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org



On 8/22/2017 3:08 PM, Ulf Hansson wrote:
> On 18 August 2017 at 07:19, Vijay Viswanath <vviswana@codeaurora.org> wrote:
>> Enable CONFIG_MMC_SDHCI_IO_ACCESSORS so that SDHC controller specific
>> register read and write APIs, if registered, can be used.
>>
>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>> ---
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 65cdd87..a3c93ed 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -398,6 +398,7 @@ CONFIG_MMC_SDHCI_CADENCE=y
>>   CONFIG_MMC_SDHCI_TEGRA=y
>>   CONFIG_MMC_MESON_GX=y
>>   CONFIG_MMC_SDHCI_MSM=y
>> +CONFIG_MMC_SDHCI_IO_ACCESSORS=y
>>   CONFIG_MMC_SPI=y
>>   CONFIG_MMC_SDHI=y
>>   CONFIG_MMC_DW=y
> 
> CONFIG_MMC_SDHCI_IO_ACCESSORS is intended to be selected by those
> SDHCI variants that needs it.
> 
> May therefore suggest you add a "select line" for MMC_SDHCI_MSM in
> drivers/mmc/host/Kconfig:
> select CONFIG_MMC_SDHCI_IO_ACCESSORS if ARM64
> 

Will do this way. Thanks!

> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
