From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] mmc: tegra: Disable UHS-I modes for tegra30
Date: Tue, 10 May 2016 11:49:41 -0600
Message-ID: <57321F35.704@wwwdotorg.org>
References: <1462806903-13860-1-git-send-email-jonathanh@nvidia.com>
 <573208AD.4090506@nvidia.com> <57320DA8.1090809@wwwdotorg.org>
 <57321758.5020308@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57321758.5020308@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Lucas Stach <dev@lynxeye.de>
List-Id: linux-mmc@vger.kernel.org

On 05/10/2016 11:16 AM, Jon Hunter wrote:
>
> On 10/05/16 17:34, Stephen Warren wrote:
>> On 05/10/2016 10:13 AM, Jon Hunter wrote:
>
> [snip]
>
>>> Stephen, for your u-boot testing, do you are set the bit in the vendor
>>> misc register to enable version 3.0 support for sdhci on tegra30? This
>>> is what the above quirk is doing (and has done so for a very long time).
>>
>> I don't see anything in the U-Boot driver that is equivalent to the
>> kernel's NVQUIRK_ENABLE_SDHCI_SPEC_300. I assume that means the
>> controller advertises an early spec version when in U-Boot, which simply
>> means U-Boot doesn't know to take advantage of any faster transfer modes
>> enabled by later specification versions, but I'm not entirely sure what
>> effect the following kernel code has on the HW:
>>
>>>      /* Erratum: Enable SDHCI spec v3.00 support */
>>>      if (soc_data->nvquirks & NVQUIRK_ENABLE_SDHCI_SPEC_300)
>>>          misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300;
>
> Do you see it touch the SDHCI_TEGRA_VENDOR_MISC_CTRL register?

Not at all. For reference, the register is defined in 
arch/arm/include/asm/arch-tegra/tegra_mmc.h as venmiscctl, and that 
symbol isn't referenced anywhere.
