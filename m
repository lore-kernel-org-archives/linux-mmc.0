From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v4 02/13] mmc: detailed definition of CD and WP MMC line polarities in DT
Date: Fri, 15 Feb 2013 16:13:51 +0100
Message-ID: <1360941242-18153-3-git-send-email-g.liakhovetski@gmx.de>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

Clarify ways to specify write-protect and card-detect MMC lines in FDT.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v4: remove Linux-specific references.

 Documentation/devicetree/bindings/mmc/mmc.txt |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 34f28ed..24c8552 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -18,12 +18,31 @@ Only one of the properties in this section should be supplied:
 
 Optional properties:
 - wp-gpios: Specify GPIOs for write protection, see gpio binding
-- cd-inverted: when present, polarity on the cd gpio line is inverted
-- wp-inverted: when present, polarity on the wp gpio line is inverted
+- cd-inverted: when present, polarity on the CD line is inverted. See the note
+  below for the case, when a GPIO is used for the CD line
+- wp-inverted: when present, polarity on the WP line is inverted. See the note
+  below for the case, when a GPIO is used for the WP line
 - max-frequency: maximum operating clock frequency
 - no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
   this system, even if the controller claims it is.
 
+*NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
+polarity properties, we have to fix the meaning of the "normal" and "inverted"
+line levels. We choose to follow the SDHCI standard, which specifies both those
+lines as "active low." Therefore, using the "cd-inverted" property means, that
+the CD line is active high, i.e. it is high, when a card is inserted. Similar
+logic applies to the "wp-inverted" property.
+
+CD and WP lines can be implemented on the hardware in one of two ways: as GPIOs,
+specified in cd-gpios and wp-gpios properties, or as dedicated pins. Polarity of
+dedicated pins can be specified, using *-inverted properties. GPIO polarity can
+also be specified using the OF_GPIO_ACTIVE_LOW flag. This creates an ambiguity
+in the latter case. We choose to use the XOR logic for GPIO CD and WP lines.
+This means, the two properties are "superimposed," for example leaving the
+OF_GPIO_ACTIVE_LOW flag clear and specifying the respective *-inverted
+property results in a double-inversion and actually means the "normal" line
+polarity is in effect.
+
 Optional SDIO properties:
 - keep-power-in-suspend: Preserves card power during a suspend/resume cycle
 - enable-sdio-wakeup: Enables wake up of host system on SDIO IRQ assertion
-- 
1.7.2.5

