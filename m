From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 15/15] Documentation: ARM: Add new MMC requirements for DRA7/K2G
Date: Wed, 25 Apr 2018 19:02:03 +0530
Message-ID: <20180425133203.14133-1-kishon@ti.com>
References: <20180425125449.19755-16-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425125449.19755-16-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson=20?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org, kishon@ti.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

>From 4.18 kernel, all the MMC controller instances in DRA7
are programmed using sdhci based driver (sdhci-omap.c). Document
this new requirement here. Both omap2plus_defconfig and
multi_v7_defconfig has CONFIG_MMC_SDHCI_OMAP enabled.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes from v3:
Add K2G also in the dependencies description

 Documentation/arm/OMAP/README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/arm/OMAP/README b/Documentation/arm/OMAP/README
index 75645c45d14a..5bf5ac3b3ed4 100644
--- a/Documentation/arm/OMAP/README
+++ b/Documentation/arm/OMAP/README
@@ -5,3 +5,7 @@ KERNEL		NEW DEPENDENCIES
 v4.3+		Update is needed for custom .config files to make sure
 		CONFIG_REGULATOR_PBIAS is enabled for MMC1 to work
 		properly.
+
+v4.18+		Update is needed for custom .config files to make sure
+		CONFIG_MMC_SDHCI_OMAP is enabled for all MMC instances
+		to work in DRA7 and K2G based boards.
-- 
2.17.0
