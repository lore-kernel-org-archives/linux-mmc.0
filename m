From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/2] regulator: Fix pbias regulator enable
Date: Fri, 4 Sep 2015 17:30:23 +0530
Message-ID: <1441368025-21182-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

vsel_reg and enable_reg of the pbias regulator descriptor should actually
have the offset from syscon.

However after
"ARM: dts: <platform>: add minimal l4 bus layout with control module
support"
vsel_reg and enable_reg started to have the absolute address because
of address translation that happens due to pbias node made as the
child node of syscon. This breaks the pbias regulator enable.

This series adds the 'offset' to be populated in vsel_reg and enable_reg
in the pbias driver itself.

Changes from v2:
*) Squashed all the dt patches into a single patch

Changes from v1:
*) Fixed Tony's review comments on adding a 'comment' for adding offset in
   the driver and adding a warning for using platform_get_resource.
*) Added Tony's Acked-by.

Tested these patches against mmc -next in omap4 panda, omap3 beagle xm,
dra72 and omap5 uevm

Kishon Vijay Abraham I (2):
  regulator: pbias: program pbias register offset in pbias driver
  ARM: dts: <omap2/3/4/5/dra7>: use "ti,pbias-<platform>" compatible
    string for pbias

 .../bindings/regulator/pbias-regulator.txt         |    7 ++-
 arch/arm/boot/dts/dra7.dtsi                        |    2 +-
 arch/arm/boot/dts/omap2430.dtsi                    |    2 +-
 arch/arm/boot/dts/omap3.dtsi                       |    2 +-
 arch/arm/boot/dts/omap4.dtsi                       |    2 +-
 arch/arm/boot/dts/omap5.dtsi                       |    2 +-
 drivers/regulator/pbias-regulator.c                |   56 +++++++++++++++++---
 7 files changed, 61 insertions(+), 12 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
