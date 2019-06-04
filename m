From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v3 1/3] mmc: sdhci_am654: Fix SLOTTYPE write
Date: Tue, 4 Jun 2019 18:31:15 +0530
Message-ID: <00366591-23db-34a3-2299-90ae97c72a9c@ti.com>
References: <20190528095928.26452-2-faiz_abbas@ti.com>
 <20190604125043.C8D40249A2@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190604125043.C8D40249A2@mail.kernel.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Sasha,

On 04/06/19 6:20 PM, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
> 
> The bot has tested the following trees: v5.1.6, v5.0.20, v4.19.47, v4.14.123, v4.9.180, v4.4.180.
> 
> v5.1.6: Build OK!
> v5.0.20: Build OK!

Please apply it only to the above two releases. I guess this script
could detect that the file was not even present before this and not try
to apply to those.

> v4.19.47: Failed to apply! Possible dependencies:
>     06b23ca021c4 ("mmc: sdhci-of-arasan: Add a single data structure to incorporate pdata and soc_ctl_map")
>     41fd4caeb00b ("mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver")
>     f0061fed1f8a ("mmc: sdhci-of-arasan: Add Support for AM654 MMC and PHY")
> 
> v4.14.123: Failed to apply! Possible dependencies:
>     06b23ca021c4 ("mmc: sdhci-of-arasan: Add a single data structure to incorporate pdata and soc_ctl_map")
>     41fd4caeb00b ("mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver")
>     7d326930d352 ("mmc: sdhci-omap: Add OMAP SDHCI driver")
>     84362d79f436 ("mmc: sdhci-of-arasan: Add CQHCI support for arasan,sdhci-5.1")
>     f0061fed1f8a ("mmc: sdhci-of-arasan: Add Support for AM654 MMC and PHY")
> 
> v4.9.180: Failed to apply! Possible dependencies:
>     06b23ca021c4 ("mmc: sdhci-of-arasan: Add a single data structure to incorporate pdata and soc_ctl_map")
>     3a3748dba881 ("mmc: sdhci-xenon: Add Marvell Xenon SDHC core functionality")
>     41fd4caeb00b ("mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver")
>     7d326930d352 ("mmc: sdhci-omap: Add OMAP SDHCI driver")
>     84362d79f436 ("mmc: sdhci-of-arasan: Add CQHCI support for arasan,sdhci-5.1")
>     d38dcad4e7b4 ("mmc: sdhci: Let drivers decide whether to use mmc_retune_needed() with pm")
>     f0061fed1f8a ("mmc: sdhci-of-arasan: Add Support for AM654 MMC and PHY")
> 
> v4.4.180: Failed to apply! Possible dependencies:
>     06b23ca021c4 ("mmc: sdhci-of-arasan: Add a single data structure to incorporate pdata and soc_ctl_map")
>     0c7fe32e847f ("mmc: sdhci-of-arasan: fix clk issue in sdhci_arasan_remove()")
>     278d09624eda ("mmc: sdhci-of-arasan: fix missing sdhci_pltfm_free for err handling")
>     3a3748dba881 ("mmc: sdhci-xenon: Add Marvell Xenon SDHC core functionality")
>     3ea4666e8d42 ("mmc: sdhci-of-arasan: Properly set corecfg_baseclkfreq on rk3399")
>     41fd4caeb00b ("mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver")
>     476bf3d62d5c ("mmc: sdhci-brcmstb: Add driver for Broadcom BRCMSTB SoCs")
>     5d9460d74ce5 ("mmc: sdhci-pic32: Add PIC32 SDHCI host controller driver")
>     7d326930d352 ("mmc: sdhci-omap: Add OMAP SDHCI driver")
>     802ac39a5566 ("mmc: sdhci-of-arasan: fix set_clock when a phy is supported")
>     84362d79f436 ("mmc: sdhci-of-arasan: Add CQHCI support for arasan,sdhci-5.1")
>     89211418cb71 ("mmc: sdhci-of-arasan: use sdhci_pltfm_init for private allocation")
>     91aa366109e8 ("mmc: sdhci-of-arasan: add phy support for sdhci-of-arasan")
>     a05c84651145 ("mmc: sdhci-of-arasan: implement enhanced strobe callback")
>     c390f2110adf ("mmc: sdhci-of-arasan: Add ability to export card clock")
>     ca572f4636aa ("mmc: sdhci-of-arasan: Always power the PHY off/on when clock changes")
>     f0061fed1f8a ("mmc: sdhci-of-arasan: Add Support for AM654 MMC and PHY")
> 
> 
> How should we proceed with this patch?
> 

Thanks,
Faiz
