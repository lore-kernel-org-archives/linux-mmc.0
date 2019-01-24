From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 0/7] Port am335 and am437 devices to sdhci-omap
Date: Thu, 24 Jan 2019 15:14:08 +0530
Message-ID: <f26aa2cc-fe14-f0e8-171f-bd81ea6a216b@ti.com>
References: <20190111110851.6805-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190111110851.6805-1-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: zhang.chunyan@linaro.org, kishon@ti.com, adrian.hunter@intel.com, mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 11/01/19 4:38 PM, Faiz Abbas wrote:
> The following add driver patches for porting TI's am335x and am437x
> devices to the sdhci-omap driver.
> 
> This involves adding external DMA support to sdhci (first 3 patches from
> Chunyan) plus some miscellaneous patches to take care of deviations of
> the controllers from the sdhci model.
> 
> DT changes will be posted in a separate series.
> 
> Untested versions of Chunyan's patches were posted before[1].
> 
> Tested on: am335x-evm, am335x-boneblack, am335x-sk, am437x-gpevm,
> am43xx-gpevm, am437x-idk, dra7xx-evm, dra72x-evm
> 
> [1] https://patchwork.kernel.org/project/linux-mmc/list/?series=54897
> 
> Chunyan Zhang (3):
>   mmc: sdhci: add support for using external DMA devices
>   mmc: sdhci-omap: Add using external dma
>   dt-bindings: sdhci-omap: Add example for using external dma
> 
> Faiz Abbas (4):
>   mmc: sdhci: Add quirk for disabling DTO during erase command
>   mmc: sdhci_omap: Add DISABLE_DTO_FOR_ERASE Quirk
>   dt-bindings: sdhci-omap: Add am335x and am437x specific bindings
>   mmc: sdhci-omap: Add am335x and am437x specific compatibles
> 
>  .../devicetree/bindings/mmc/sdhci-omap.txt    |   9 +
>  drivers/mmc/host/Kconfig                      |   4 +
>  drivers/mmc/host/sdhci-omap.c                 |  27 +-
>  drivers/mmc/host/sdhci.c                      | 274 +++++++++++++++++-
>  drivers/mmc/host/sdhci.h                      |  10 +
>  5 files changed, 319 insertions(+), 5 deletions(-)
> 

Gentle ping.

Thanks,
Faiz
