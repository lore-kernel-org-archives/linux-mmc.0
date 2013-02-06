From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v3 02/13] mmc: detailed definition of CD and WP MMC line polarities in DT
Date: Wed,  6 Feb 2013 20:46:49 +0100
Message-ID: <1360180020-18555-3-git-send-email-g.liakhovetski@gmx.de>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:62415 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758030Ab3BFTrP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Feb 2013 14:47:15 -0500
In-Reply-To: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Arnd Bergmann <arnd@arndb.de>

Clarify ways to specify write-protect and card-detect MMC lines in FDT.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3: {wp,cd}-inverted properties can now be used together with GPIO
    binding flags. A detailed explanation added.

 Documentation/devicetree/bindings/mmc/mmc.txt |   43 +++++++++++++++++++++++-
 1 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 34f28ed..51dd64f 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -18,12 +18,51 @@ Only one of the properties in this section should be supplied:
 
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
 
+*NOTE* on CD and WP polarity. As of 3.8, SD/MMC drivers parse their DT nodes
+each in its own way, including calculation of CD and WP polarities. Our goal is
+to implement a common MMC DT parser and convert all drivers to using it. For
+this we also have to fix the meaning of the "normal" and "inverted" line levels.
+We choose to follow the SDHCI standard, which specifies both those lines as
+"active low." To deliver line polarity to drivers the parser will set
+MMC_CAP2_CD_ACTIVE_HIGH and / or MMC_CAP2_RO_ACTIVE_HIGH capabilities.
+
+CD and WP lines can be implemented on the hardware in one of two ways: as GPIOs,
+specified in cd-gpios and wp-gpios properties, or as dedicated pins. Polarity of
+dedicated pins can be specified, using *-inverted properties. GPIO polarity can
+also be specified using the OF_GPIO_ACTIVE_LOW flag. This creates an ambiguity
+in the latter case. So far there are no drivers, that evaluate both these
+possibilities. Also, all .dts files only use one of them. Boards with mmc
+devices, whose drivers use *-inverted properties, leave the OF_GPIO_ACTIVE_LOW
+flag clear (which is actually usually wrong, since it means "active high," i.e.
+inverted.) OTOH, boards with mmc devices, whose drivers use the
+OF_GPIO_ACTIVE_LOW flag, never specify *-inverted properties. This means, that
+the safest way to implement a common MMC DT parser is by using the XOR logic, as
+in
+
+	explicit_inv_cd = !!of_find_property(np, "cd-inverted", &len);
+
+	cd_gpio = of_get_named_gpio_flags(np, "cd-gpios", 0, &flags);
+	if (gpio_is_valid(cd_gpio) && !(flags & OF_GPIO_ACTIVE_LOW))
+		gpio_inv_cd = 1;
+	else
+		gpio_inv_cd = 0;
+
+	if (gpio_inv_cd ^ explicit_inv_cd)
+		host->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+
+Similarly for WP. This way drivers, currently only interpreting *-inverted
+properties with .dts files always having cd-gpios' OF_GPIO_ACTIVE_LOW flag
+clear, will have to invert the MMC_CAP2_CD_ACTIVE_HIGH capability, but at least
+this capability will not miss any toggles.
+
 Optional SDIO properties:
 - keep-power-in-suspend: Preserves card power during a suspend/resume cycle
 - enable-sdio-wakeup: Enables wake up of host system on SDIO IRQ assertion
-- 
1.7.2.5

