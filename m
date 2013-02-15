From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v4 06/13] mmc: tmio-mmc: define device-tree bindings
Date: Fri, 15 Feb 2013 16:13:55 +0100
Message-ID: <1360941242-18153-7-git-send-email-g.liakhovetski@gmx.de>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

Define device-tree bindings for the tmio-mmc driver to be able to specify
parameters, currently provided in platform data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v4: remove the "toshiba,mmc-blksz-2bytes" property, it can be set directly 
by the sh_mobile_sdhi driver, use compatible string parsing instead of
the "toshiba,mmc-has-idle-wait" property.

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/tmio_mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
new file mode 100644
index 0000000..df204e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -0,0 +1,20 @@
+* Toshiba Mobile IO SD/MMC controller
+
+The tmio-mmc driver doesn't probe its devices actively, instead its binding to
+devices is managed by either MFD drivers or by the sh_mobile_sdhi platform
+driver. Those drivers supply the tmio-mmc driver with platform data, that either
+describe hardware capabilities, known to them, or are obtained by them from
+their own platform data or from their DT information. In the latter case all
+compulsory and any optional properties, common to all SD/MMC drivers, as
+described in mmc.txt, can be used. Additionally the following tmio_mmc-specific
+optional bindings can be used.
+
+Optional properties:
+- toshiba,mmc-wrprotect-disable: write-protect detection is unavailable
+
+When used with Renesas SDHI hardware, the following compatibility strings
+configure various model-specific properties:
+
+"renesas,sh7372-sdhi":	(default) compatible with SH7372
+"renesas,r8a7740-sdhi":	compatible with R8A7740: certain MMC/SD commands have to
+			wait for the interface to become idle.
-- 
1.7.2.5

