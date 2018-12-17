From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/3] Add driver Support for MMCSD on AM654x
Date: Mon, 17 Dec 2018 09:26:56 +0100
Message-ID: <CAPDyKFpPCmuCVXEK0S5dOauDChKQShGUTenM1RzqSCPF29=3iQ@mail.gmail.com>
References: <20181210183507.9617-1-faiz_abbas@ti.com> <378ace78-7345-8875-f3e7-7cddcaf5e4bc@ti.com>
 <38fe3521-f029-5e1b-78be-f265c5764a3b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <38fe3521-f029-5e1b-78be-f265c5764a3b@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, Kishon <kishon@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 17 Dec 2018 at 09:24, Sekhar Nori <nsekhar@ti.com> wrote:
>
> On 17/12/18 1:45 PM, Faiz Abbas wrote:
> > Hi,
> >
> > On 11/12/18 12:05 AM, Faiz Abbas wrote:
> >> The following patches add driver support for MMCSD on TI's AM654
> >> platforms.
> >>
> >> Previously I had added the support to sdhci-of-arasan driver with
> >> a separate phy driver[1]. Since then it has turned out that tuning
> >> operation (for HS200, HS400 and SDR104 speed modes) will require
> >> configuration of phy registers. This completely breaks the model of
> >> the sdhci-of-arasan driver which relies on a separate driver to
> >> configure the phy register space.
> >>
> >> Because of this, I am creating a new driver with both the sdhci and
> >> phy register spaces. This helps me use the phy registers in a future
> >> patch that adds tuning support.
> >>
> >> DT patches will be posted in a separate series.
> >>
> >> Changes in v3:
> >>  1. Removed reference to clk_ahb as its not being used.
> >>  2. Added comment for pm_runtime being used for enabling
> >>     clocks.
> >>
> >> Changes in v2:
> >>  1. Reset OTAP delay back to default value in init.
> >>  2. Improved patch description for patch 2.
> >>  3. Minor style fixes.
> >>
> >> [1] driver and phy patches posted before
> >>     https://patchwork.kernel.org/project/linux-mmc/list/?series=26623
> >>
> >> Faiz Abbas (3):
> >>   dt-bindings: mmc: sdhci-am654: Document bindings for the host
> >>     controllers on TI's AM654 SOCs
> >>   dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for am65
> >>   mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver
> >>
> >>  .../devicetree/bindings/mmc/arasan,sdhci.txt  |   4 +
> >>  .../devicetree/bindings/mmc/sdhci-am654.txt   |  37 ++
> >>  drivers/mmc/host/Kconfig                      |  12 +
> >>  drivers/mmc/host/Makefile                     |   1 +
> >>  drivers/mmc/host/sdhci-of-arasan.c            |  46 ---
> >>  drivers/mmc/host/sdhci_am654.c                | 374 ++++++++++++++++++
> >>  6 files changed, 428 insertions(+), 46 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt
> >>  create mode 100644 drivers/mmc/host/sdhci_am654.c
> >
> >
> > Gentle ping.
>
> I see these in linux-next.
>
> aff88ff23512 (Faiz Abbas) 6 days ago  mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver
> 7f6e4cc6727d (Faiz Abbas) 6 days ago  dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for AM65
> 351b766ef2c7 (Faiz Abbas) 6 days ago  dt-bindings: mmc: sdhci-am654: Document bindings for the host controllers on TI's AM654 SOCs

Correct!

Apologize for not confirming that I have applied them. I don't know
why I missed that for this series.

Kind regards
Uffe
