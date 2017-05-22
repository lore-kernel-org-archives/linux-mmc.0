From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 00/41] omap_hsmmc: Add ADMA support and UHS/HS200/DDR
 support
Date: Mon, 22 May 2017 17:50:44 +0530
Message-ID: <d5bdc61e-abb0-7833-ea2f-a3cca4c4033e@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
 <20170519221344.GI10472@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:30931 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbdEVMVk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2017 08:21:40 -0400
In-Reply-To: <20170519221344.GI10472@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com

Hi,

On Saturday 20 May 2017 03:43 AM, Tony Lindgren wrote:
> Hi,
> 
> * Kishon Vijay Abraham I <kishon@ti.com> [170519 01:19]:
>> This series adds UHS, HS200, DDR mode and ADMA support to
>> omap_hsmmc driver used to improve the throughput of MMC/SD in dra7
>> SoCs.
> 
> Certainly seems way less intrusive than earlier before the
> dmaengine changes :)
> 
>> *) tuning ratio of MMC in dra7 is different from sdhci
> 
> Hmm what's the tuning ratio?

For high speed modes like UHS SDR104 and HS200, sampling clock has to adjusted
according to the position of the data window and it varies depending on the
host and the card.
For this we configure the controller with phase delay from 0 to 0x7c (in steps
of 4) and send the tuning command (CMD19 or CMD21) for which the card responds
with a known pattern. We keep track of the phase delay's for which we received
the known patterns (without errors) and select one of the phase delays (3/4th
ratio from largest consecutive successful phase delay window).

sdhci driver makes use of the HW feature for tuning (no manual setting of phase
delays etc). Sdhci has an ops for platform specific tuning but that again has
to be implemented in omap_hsmmc driver.
> 
>> This series has been tested on beagleboard, pandaboard, beaglebone-black,
>> beaglebone, am335x-evm, am437x-evm, dra7xx-evm, dra72x-evm, am571x-idk
>> and am572x-idk.
> 
> I gave this a quick try after manally applying next-20170519
> after reverting 67d0687224a9 ("mm: drop HASH_ADAPT"). Looks like
> something is missing as I got:
> 
> arch/arm/mach-omap2/pdata-quirks.c:445:23: error:
> 'struct omap_hsmmc_platform_data' has no member named 'version'
> ...
> 
> It's possible I messed up something while manually applying.

[PATCH 13/41] mmc: host: omap_hsmmc: Add support to set IODELAY values adds
version member to 'struct omap_hsmmc_platform_data'.
> 
>> I can split the series to go into Ulf Hansson's tree and Tony's tree 
>> separately if that is required.
> 
> Yes please. Maybe send the dts parts first that are ready to
> get merged, like the fixes and all the iodelay configuration.
> 
> Then the mmc driver changes as a separate set.
> 
> Then third set to follow-up and enable things once the mmc
> driver changes are merged.

Sure.

Thanks
Kishon
