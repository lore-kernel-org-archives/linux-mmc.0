From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 7/7] MAINTAINERS: Add TI OMAP SDHCI Maintainer
Date: Mon, 7 Aug 2017 21:31:42 +0530
Message-ID: <20170807160142.12134-8-kishon@ti.com>
References: <20170807160142.12134-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170807160142.12134-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: kishon@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Add Maintainer for the TI OMAP SDHCI driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f66488dfdbc9..10c9dde27c0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11769,6 +11769,12 @@ L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-spear.c
 
+SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) TI OMAP DRIVER
+M:	Kishon Vijay Abraham I <kishon@ti.com>
+L:	linux-mmc@vger.kernel.org
+S:	Maintained
+F:	drivers/mmc/host/sdhci-omap.c
+
 SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
 M:	Scott Bauer <scott.bauer@intel.com>
 M:	Jonathan Derrick <jonathan.derrick@intel.com>
-- 
2.11.0
