From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] mmc: tegra: Disable UHS-I modes for tegra30
Date: Tue, 10 May 2016 18:16:08 +0100
Message-ID: <57321758.5020308@nvidia.com>
References: <1462806903-13860-1-git-send-email-jonathanh@nvidia.com>
 <573208AD.4090506@nvidia.com> <57320DA8.1090809@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13854 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbcEJRQO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 13:16:14 -0400
In-Reply-To: <57320DA8.1090809@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Lucas Stach <dev@lynxeye.de>


On 10/05/16 17:34, Stephen Warren wrote:
> On 05/10/2016 10:13 AM, Jon Hunter wrote:

[snip]

>> Stephen, for your u-boot testing, do you are set the bit in the vendor
>> misc register to enable version 3.0 support for sdhci on tegra30? This
>> is what the above quirk is doing (and has done so for a very long time).
> 
> I don't see anything in the U-Boot driver that is equivalent to the
> kernel's NVQUIRK_ENABLE_SDHCI_SPEC_300. I assume that means the
> controller advertises an early spec version when in U-Boot, which simply
> means U-Boot doesn't know to take advantage of any faster transfer modes
> enabled by later specification versions, but I'm not entirely sure what
> effect the following kernel code has on the HW:
> 
>>     /* Erratum: Enable SDHCI spec v3.00 support */
>>     if (soc_data->nvquirks & NVQUIRK_ENABLE_SDHCI_SPEC_300)
>>         misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300;

Do you see it touch the SDHCI_TEGRA_VENDOR_MISC_CTRL register?

The TRM states ...

"SDMMC_SPARE0[4] : When set, SD3.0 support is advertised in
SDMMC_SLOT_INTERRUPT_STATUS_0_SPECIFICATION_VERSION_NUMBER Otherwise,
only SD2.0 support is advertised"

So I *believe* this means that the sdhci version will now appear as 3.0
and so the host->version == SDHCI_SPEC_300. There are many places in the
sdhci driver where it is checking ...

 if (host->version >= SDHCI_SPEC_300)
	 ...

> Perhaps the kernel driver should pulse the controller's CAR reset signal
> in probe() to ensure that the HW is in a known state?

I will take a look.

Jon
