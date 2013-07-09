From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: TMIO: update Device Tree binding documentation
Date: Tue, 9 Jul 2013 11:13:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1307091110540.28812@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

The SDHI mmc-tmio implementation has been updated to cover additional SoC
types. This patch documents the changes.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

Now, that the patch "mmc: SDHI: add DT compatibility strings for further 
SoCs" has been approved, it shall be accompanied by this documentation 
update.

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index df204e1..ec6f5bd 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -13,8 +13,13 @@ Optional properties:
 - toshiba,mmc-wrprotect-disable: write-protect detection is unavailable
 
 When used with Renesas SDHI hardware, the following compatibility strings
-configure various model-specific properties:
+configure properties, specific to the respective SoC model:
 
-"renesas,sh7372-sdhi":	(default) compatible with SH7372
-"renesas,r8a7740-sdhi":	compatible with R8A7740: certain MMC/SD commands have to
-			wait for the interface to become idle.
+"renesas,shmobile-sdhi":	generic SDHI block
+"renesas,sh7372-sdhi":		SDHI block, used on SH7372 (SH-Mobile AP4)
+"renesas,sh73a0-sdhi":		SDHI block, used on SH73A0 (SH-Mobile AG5)
+"renesas,r8a73a4-sdhi":		SDHI block, used on R8A73A4 (R-Mobile APE6)
+"renesas,r8a7740-sdhi":		SDHI block, used on R8A7740 (R-Mobile A1)
+"renesas,r8a7778-sdhi":		SDHI block, used on R8A7778 (R-Car M1A)
+"renesas,r8a7779-sdhi":		SDHI block, used on R8A7779 (R-Car H1)
+"renesas,r8a7790-sdhi":		SDHI block, used on R8A7790 (R-Car H2)
-- 
1.7.2.5

