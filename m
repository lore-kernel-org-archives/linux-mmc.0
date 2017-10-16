From: Liming Sun <lsun@mellanox.com>
Subject: RE: [PATCH 0/9] Enable dw-mmc multi-card support
Date: Mon, 16 Oct 2017 14:35:48 +0000
Message-ID: <AM2PR05MB0753A4A6B8227F6CD1D7E24DA14F0@AM2PR05MB0753.eurprd05.prod.outlook.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Liming Sun <lsun@mellanox.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

So far I saw one comment (an ACK) on PATCH 1/9. There seems no comments on =
other patches yet.=20
Ulf, (or other maintainers), any comments or suggestions how to move forwar=
d for this patch series?

Thanks,
Liming

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.ke=
rnel.org] On Behalf Of Liming Sun
Sent: Friday, October 6, 2017 3:21 PM
To: Ulf Hansson <ulf.hansson@linaro.org>; Rob Herring <robh+dt@kernel.org>;=
 Mark Rutland <mark.rutland@arm.com>; Jaehoon Chung <jh80.chung@samsung.com=
>; Kukjin Kim <kgene@kernel.org>; Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liming Sun <lsun@mellanox.com>; linux-mmc@vger.kernel.org; devicetree@v=
ger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infrad=
ead.org; linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/9] Enable dw-mmc multi-card support

This series of commits enables the multi-card support for the dw-mmc contro=
ller. It includes two parts as below.

The first part (patches 1-7) reverts the series of recent commits that remo=
ved the multi-card support with comments saying there was no such use case =
in the real world. Actually this feature is being used in Mellanox Bluefiel=
d SoC and has been requested by customers.

The second part (patches 8-9) fixes the DesignWare multi-card support accor=
ding to the dw-mmc databook (synnopsys: DesignWare Cores Mobile Storage Hos=
t Databook, 2.70a). It has changes to set the card number into the CMD regi=
ster to multiplex requests to different cards when working in SD_MMC_CEATA =
mode, set the CTYPE / CLKENA / CDTHRCTL registers properly according to the=
 spec, and parse the per-card configuration to match the Linux Documentatio=
n (bindings/mmc/synopsys-dw-mshc.txt).

Liming Sun (9):
  Revert "Documentation: dw-mshc: deprecate num-slots"
  Revert "mmc: dw_mmc: remove the unnecessary slot variable"
  Revert "mmc: dw_mmc: use the 'slot' instead of 'cur_slot'"
  Revert "mmc: dw_mmc: remove the 'id' arguments about functions
    relevant to slot"
  Revert "mmc: dw_mmc: change the array of slots"
  Revert "mmc: dw_mmc: remove the loop about finding slots"
  Revert "mmc: dw_mmc: deprecated the "num-slots" property"
  mmc: dw_mmc: Support two SD_MMC_CE-ATA cards
  mmc: dw_mmc: Parse slot-specific configuration

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  16 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |   4 +-
 drivers/mmc/host/dw_mmc.c                          | 277 ++++++++++++++++-=
----
 drivers/mmc/host/dw_mmc.h                          |  17 +-
 4 files changed, 236 insertions(+), 78 deletions(-)

--
1.8.3.1
