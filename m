From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC 06/11] mmc: tmio-mmc: define device-tree bindings
Date: Wed, 16 Jan 2013 17:54:41 +0100
Message-ID: <1358355286-26029-7-git-send-email-g.liakhovetski@gmx.de>
References: <1358355286-26029-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1358355286-26029-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Define device-tree bindings for the tmio-mmc driver to be able to specify
parameters, currently provided in platform data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Please, comment on this one, since it is defining an ABI to be kept forever;-)

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/tmio_mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
new file mode 100644
index 0000000..dd8decd
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -0,0 +1,19 @@
+* Toshiba Mobile IO SD/MMC controller
+
+The tmio-mmc driver doesn't probe its devices actively, instead its binding to
+devices is managed by either MFD drivers or by the sh_mobile_sdhi platform
+driver. Those drivers supply the tmio-mmc driver with platform data, that either
+describe hardware capabilities, known to them, or are obtained by them from
+their own platform data or from their DT information. In the latter case all
+compulsory and any optional properties, common to all SD/MMC drivers, as
+described in mmc.txt, should or can be used. Additionally the following optional
+bindings can be used. They set either respective TMIO_MMC_* flags or MMC_CAP_*
+capabilities.
+
+Optional properties:
+- toshiba,mmc-wrprotect-disable	: set TMIO_MMC_WRPROTECT_DISABLE flag
+- toshiba,mmc-blksz-2bytes	: set TMIO_MMC_BLKSZ_2BYTES
+- toshiba,mmc-cap-sdio-irq	: SDIO IRQ signalling should be used, if
+	supported by the hardware, i.e. set MMC_CAP_SDIO_IRQ if
+	TMIO_MMC_SDIO_IRQ is also set
+- toshiba,mmc-has-idle-wait	: set TMIO_MMC_HAS_IDLE_WAIT
-- 
1.7.2.5

