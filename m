From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: dt: Add card-detection properties to core binding.
Date: Wed, 22 Aug 2012 14:05:35 -0400
Message-ID: <874nnu245s.fsf_-_@octavius.laptop.org>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
	<CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
	<87k3ws5uhs.fsf@octavius.laptop.org>
	<201208211208.49987.arnd@arndb.de>
	<87393g5mic.fsf@octavius.laptop.org> <5033A34E.7040201@gmail.com>
	<87pq6k46jg.fsf@octavius.laptop.org> <5033B0F0.7050506@gmail.com>
	<CAJuYYwR+oCQUcgoy6ZuHp0XAa+EAj9d-FvLtwsQcP3muFMrKLA@mail.gmail.com>
	<20120822055151.GT24242@S2101-09.ap.freescale.net>
	<877gsr5iz1.fsf@octavius.laptop.org>
	<CAJuYYwQz00ZzB5MxRG66XEPZApAtS6bwJAafmw3b=7DD7u+Crg@mail.gmail.com>
	<87y5l7421h.fsf@octavius.laptop.org>
	<CAJuYYwQLUs5qb8NqtPf3=ytNHJ_VdnN8Z4yWwyk2+OTftdWFXw@mail.gmail.com>
	<87393f3rkj.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <87393f3rkj.fsf@octavius.laptop.org> (Chris Ball's message of
	"Wed, 22 Aug 2012 10:54:36 -0400")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robherring2@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, patches@linaro.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 8a6811f..8e2e0ba 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -9,12 +9,17 @@ Interpreted by the OF core:
 Required properties:
 - bus-width: Number of data lines, can be <1>, <4>, or <8>
 
+Card detection:
+If no property below is supplied, standard SDHCI card detect is used.
+Only one of the properties in this section should be supplied:
+  - broken-cd: There is no card detection available; polling must be used.
+  - cd-gpios: Specify GPIOs for card detection, see gpio binding
+  - non-removable: non-removable slot (like eMMC); assume always present.
+
 Optional properties:
-- cd-gpios: Specify GPIOs for card detection, see gpio binding
 - wp-gpios: Specify GPIOs for write protection, see gpio binding
 - cd-inverted: when present, polarity on the cd gpio line is inverted
 - wp-inverted: when present, polarity on the wp gpio line is inverted
-- non-removable: non-removable slot (like eMMC)
 - max-frequency: maximum operating clock frequency
 
 Example:
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
