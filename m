From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 4/10] MAINTAINERS: add entry for Marvell Xenon MMC Host Controller drivers
Date: Fri,  7 Oct 2016 17:22:50 +0200
Message-ID: <86b237c01d9767d4e0edf6d41194ab959838e5c0.1475853198.git-series.gregory.clement@free-electrons.com>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
In-Reply-To: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Ziji Hu <huziji@marvell.com>, "Jack(SH) Zhu" <jmzhu@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Xueping Liu <xpliu@marvell.com>, Hilbert Zhang <zzhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

From: Ziji Hu <huziji@marvell.com>

Add maintainer entry for Marvell Xenon eMMC/SD/SDIO Host
Controller drivers.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 207eaefd3b97..89adcd57aa25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7578,6 +7578,11 @@ M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Odd Fixes
 F:	drivers/mmc/host/mvsdio.*
 
+MARVELL XENON MMC/SD/SDIO HOST CONTROLLER DRIVER
+M:	Ziji Hu <huziji@marvell.com>
+L:	linux-mmc@vger.kernel.org
+S:	Supported
+
 MATROX FRAMEBUFFER DRIVER
 L:	linux-fbdev@vger.kernel.org
 S:	Orphan
-- 
git-series 0.8.10
