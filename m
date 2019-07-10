From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 00/11] Arasan SDHCI enhancements and ZynqMP Tap Delays
 Handling
Date: Wed, 10 Jul 2019 14:33:54 +0300
Message-ID: <d4a733c4-9760-a790-5752-be3f14c53bec@intel.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Manish Narani <manish.narani@xilinx.com>, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de, michal.simek@xilinx.com, christoph.muellner@theobroma-systems.com, philipp.tomsich@theobroma-systems.com, viresh.kumar@linaro.org, scott.branden@broadcom.com, ayaka@soulik.info, kernel@esmil.dk, tony.xie@rock-chips.com, rajan.vaja@xilinx.com, jolly.shah@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org, olof@lixom.net
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 1/07/19 8:29 AM, Manish Narani wrote:
> This patch series does the following:
>  - Reorganize the Clock Handling in Arasan SD driver
>  - Adds new sampling clock in Arasan SD driver
>  - Adds support to set Clock Delays in SD Arasan Driver
>  - Add SDIO Tap Delay handling in ZynqMP firmware driver
>  - Add support for ZynqMP Tap Delays setting in Arasan SD driver
> 
> Changes in v2:
> 	- Replaced the deprecated calls to clock framework APIs
> 	- Added support for dev_clk_get() call to work for SD card clock
> 	- Separated the clock data struct
> 	- Fragmented the patch series in smaller patches to make it more
> 	  readable
> 
> This patch series contains a DT patch, which I think should be there to
> maintain the order of commits.
> 
> Manish Narani (11):
>   dt-bindings: mmc: arasan: Update documentation for SD Card Clock
>   arm64: dts: rockchip: Add optional clock property indicating sdcard
>     clock
>   mmc: sdhci-of-arasan: Replace deprecated clk API calls
>   mmc: sdhci-of-arasan: Separate out clk related data to another
>     structure
>   dt-bindings: mmc: arasan: Update Documentation for the input clock
>   mmc: sdhci-of-arasan: Add sampling clock for a phy to use
>   dt-bindings: mmc: arasan: Add optional properties for Arasan SDHCI
>   mmc: sdhci-of-arasan: Add support to set clock phase delays for SD
>   firmware: xilinx: Add SDIO Tap Delay APIs
>   dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
>   mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup
> 
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  49 ++-
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   4 +-
>  drivers/firmware/xilinx/zynqmp.c                   |  48 +++
>  drivers/mmc/host/sdhci-of-arasan.c                 | 453 ++++++++++++++++++++-
>  include/linux/firmware/xlnx-zynqmp.h               |  15 +-
>  5 files changed, 540 insertions(+), 29 deletions(-)
> 

For SDHCI:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
