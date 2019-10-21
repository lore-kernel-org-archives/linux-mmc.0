From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/8] Arasan SDHCI enhancements and ZynqMP Tap Delays Handling
Date: Mon, 21 Oct 2019 16:14:20 +0200
Message-ID: <CAPDyKFo-8=crHZd9X7JpGJHdEwFs4Pz8rzEtVg6e7QZqE8N8nw@mail.gmail.com>
References: <1571293310-92563-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1571293310-92563-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Manish Narani <manish.narani@xilinx.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, jolly.shah@xilinx.com, rajan.vaja@xilinx.com, nava.manne@xilinx.com, Moritz Fischer <mdf@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, git@xilinx.com
List-Id: linux-mmc@vger.kernel.org

On Thu, 17 Oct 2019 at 08:22, Manish Narani <manish.narani@xilinx.com> wrote:
>
> This patch series does the following:
>  - Reorganize the Clock Handling in Arasan SD driver
>  - Adds new sampling clock in Arasan SD driver
>  - Adds support to set Clock Delays in SD Arasan Driver
>  - Add SDIO Tap Delay handling in ZynqMP firmware driver
>  - Add support for ZynqMP Tap Delays setting in Arasan SD driver
>
> Changes in v2:
>         - Replaced the deprecated calls to clock framework APIs
>         - Added support for dev_clk_get() call to work for SD card clock
>         - Separated the clock data struct
>         - Fragmented the patch series in smaller patches to make it more
>           readable
>
> Changes in v3:
>         - Reverted "Replaced the deprecated calls to clock framework APIs"
>         - Removed devm_clk_get() call which was added in v2
>
> Manish Narani (8):
>   mmc: sdhci-of-arasan: Separate out clk related data to another
>     structure
>   dt-bindings: mmc: arasan: Update Documentation for the input clock
>   mmc: sdhci-of-arasan: Add sampling clock for a phy to use
>   dt-bindings: mmc: arasan: Add optional properties for Arasan SDHCI
>   mmc: sdhci-of-arasan: Add support to set clock phase delays for SD
>   firmware: xilinx: Add SDIO Tap Delay nodes
>   dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
>   mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup
>
>  .../devicetree/bindings/mmc/arasan,sdhci.txt  |  40 +-
>  drivers/mmc/host/sdhci-of-arasan.c            | 477 +++++++++++++++++-
>  include/linux/firmware/xlnx-zynqmp.h          |  13 +-
>  3 files changed, 498 insertions(+), 32 deletions(-)
>
> --
> 2.17.1
>

Manish, the series looks good to me. However, I expect you to post a
re-spin, to move some of the new DT bindings into common mmc DT
bindings, as Rob suggested.

So waiting for another version, before I apply it.

Kind regards
Uffe
