From: Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH v2 00/11] Arasan SDHCI enhancements and ZynqMP Tap Delays
 Handling
Date: Mon, 22 Jul 2019 04:56:38 +0000
Message-ID: <MN2PR02MB60291FE74900566F4C5D359DC1C40@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
 <MN2PR02MB602959626A4F6E462A321F35C1CF0@MN2PR02MB6029.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MN2PR02MB602959626A4F6E462A321F35C1CF0@MN2PR02MB6029.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "heiko@sntech.de" <heiko@sntech.de>, Michal Simek <michals@xilinx.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "christoph.muellner@theobroma-systems.com" <christoph.muellner@theobroma-systems.com>, "philipp.tomsich@theobroma-systems.com" <philipp.tomsich@theobroma-systems.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "scott.branden@broadcom.com" <scott.branden@broadcom.com>, "ayaka@soulik.info" <ayaka@soulik.info>, "kernel@esmil.dk" <kernel@esmil.dk>, "tony.xie@rock-chips.com" <tony.xie@rock-chips.com>, "mdf@kernel.org" <mdf@kernel.org>, "olof@lixom.net" <olof@lixom.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Gentle Ping!

> -----Original Message-----
> From: Manish Narani
> Sent: Monday, July 15, 2019 12:46 PM
> To: Manish Narani <MNARANI@xilinx.com>; ulf.hansson@linaro.org;
> robh+dt@kernel.org; mark.rutland@arm.com; heiko@sntech.de; Michal Simek
> <michals@xilinx.com>; adrian.hunter@intel.com;
> christoph.muellner@theobroma-systems.com; philipp.tomsich@theobroma-
> systems.com; viresh.kumar@linaro.org; scott.branden@broadcom.com;
> ayaka@soulik.info; kernel@esmil.dk; tony.xie@rock-chips.com;
> mdf@kernel.org; olof@lixom.net
> Cc: linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> rockchip@lists.infradead.org
> Subject: RE: [PATCH v2 00/11] Arasan SDHCI enhancements and ZynqMP Tap
> Delays Handling
>=20
> Ping!
>=20
> > -----Original Message-----
> > From: Manish Narani <manish.narani@xilinx.com>
> > Sent: Monday, July 1, 2019 11:00 AM
> > To: ulf.hansson@linaro.org; robh+dt@kernel.org; mark.rutland@arm.com;
> > heiko@sntech.de; Michal Simek <michals@xilinx.com>;
> > adrian.hunter@intel.com; christoph.muellner@theobroma-systems.com;
> > philipp.tomsich@theobroma-systems.com; viresh.kumar@linaro.org;
> > scott.branden@broadcom.com; ayaka@soulik.info; kernel@esmil.dk;
> > tony.xie@rock-chips.com; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> > <JOLLYS@xilinx.com>; Nava kishore Manne <navam@xilinx.com>;
> > mdf@kernel.org; Manish Narani <MNARANI@xilinx.com>; olof@lixom.net
> > Cc: linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > rockchip@lists.infradead.org
> > Subject: [PATCH v2 00/11] Arasan SDHCI enhancements and ZynqMP Tap
> > Delays Handling
> >
> > This patch series does the following:
> >  - Reorganize the Clock Handling in Arasan SD driver
> >  - Adds new sampling clock in Arasan SD driver
> >  - Adds support to set Clock Delays in SD Arasan Driver
> >  - Add SDIO Tap Delay handling in ZynqMP firmware driver
> >  - Add support for ZynqMP Tap Delays setting in Arasan SD driver
> >
> > Changes in v2:
> > 	- Replaced the deprecated calls to clock framework APIs
> > 	- Added support for dev_clk_get() call to work for SD card clock
> > 	- Separated the clock data struct
> > 	- Fragmented the patch series in smaller patches to make it more
> > 	  readable
> >
> > This patch series contains a DT patch, which I think should be there to
> > maintain the order of commits.
> >
> > Manish Narani (11):
> >   dt-bindings: mmc: arasan: Update documentation for SD Card Clock
> >   arm64: dts: rockchip: Add optional clock property indicating sdcard
> >     clock
> >   mmc: sdhci-of-arasan: Replace deprecated clk API calls
> >   mmc: sdhci-of-arasan: Separate out clk related data to another
> >     structure
> >   dt-bindings: mmc: arasan: Update Documentation for the input clock
> >   mmc: sdhci-of-arasan: Add sampling clock for a phy to use
> >   dt-bindings: mmc: arasan: Add optional properties for Arasan SDHCI
> >   mmc: sdhci-of-arasan: Add support to set clock phase delays for SD
> >   firmware: xilinx: Add SDIO Tap Delay APIs
> >   dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
> >   mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setu=
p
> >
> >  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  49 ++-
> >  arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   4 +-
> >  drivers/firmware/xilinx/zynqmp.c                   |  48 +++
> >  drivers/mmc/host/sdhci-of-arasan.c                 | 453
> ++++++++++++++++++++-
> >  include/linux/firmware/xlnx-zynqmp.h               |  15 +-
> >  5 files changed, 540 insertions(+), 29 deletions(-)
> >
> > --
> > 2.1.1
