From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v3 0/3] Add driver Support for MMCSD on AM654x
Date: Mon, 17 Dec 2018 13:45:41 +0530
Message-ID: <378ace78-7345-8875-f3e7-7cddcaf5e4bc@ti.com>
References: <20181210183507.9617-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210183507.9617-1-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, michal.simek@xilinx.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On 11/12/18 12:05 AM, Faiz Abbas wrote:
> The following patches add driver support for MMCSD on TI's AM654
> platforms.
> 
> Previously I had added the support to sdhci-of-arasan driver with
> a separate phy driver[1]. Since then it has turned out that tuning
> operation (for HS200, HS400 and SDR104 speed modes) will require
> configuration of phy registers. This completely breaks the model of
> the sdhci-of-arasan driver which relies on a separate driver to
> configure the phy register space.
> 
> Because of this, I am creating a new driver with both the sdhci and
> phy register spaces. This helps me use the phy registers in a future
> patch that adds tuning support.
> 
> DT patches will be posted in a separate series.
> 
> Changes in v3:
>  1. Removed reference to clk_ahb as its not being used.
>  2. Added comment for pm_runtime being used for enabling
>     clocks.
> 
> Changes in v2:
>  1. Reset OTAP delay back to default value in init.
>  2. Improved patch description for patch 2.
>  3. Minor style fixes.
> 
> [1] driver and phy patches posted before
>     https://patchwork.kernel.org/project/linux-mmc/list/?series=26623
> 
> Faiz Abbas (3):
>   dt-bindings: mmc: sdhci-am654: Document bindings for the host
>     controllers on TI's AM654 SOCs
>   dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for am65
>   mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver
> 
>  .../devicetree/bindings/mmc/arasan,sdhci.txt  |   4 +
>  .../devicetree/bindings/mmc/sdhci-am654.txt   |  37 ++
>  drivers/mmc/host/Kconfig                      |  12 +
>  drivers/mmc/host/Makefile                     |   1 +
>  drivers/mmc/host/sdhci-of-arasan.c            |  46 ---
>  drivers/mmc/host/sdhci_am654.c                | 374 ++++++++++++++++++
>  6 files changed, 428 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt
>  create mode 100644 drivers/mmc/host/sdhci_am654.c


Gentle ping.

Thanks,
Faiz
