From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: [PATCH v3 11/16] mmc: tmio: deprecate "toshiba,mmc-wrprotect-disable" DT property
Date: Thu, 18 Jan 2018 01:28:11 +0900
Message-ID: <1516206496-16612-12-git-send-email-yamada.masahiro@socionext.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1516206496-16612-1-git-send-email-yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Cc: Ulf Magnusson <ulfalizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This property is equivalent to "disable-wp" defined in
Documentation/devicetree/bindings/mmc/tmio_mmc.txt

The TMIO MMC core calls mmc_of_parse(), and it sets
MMC_CAP2_NO_WRITE_PROTECT if "disable-wp" property is present.

We do not need a vendor-specific property to do the same thing.

Let's remove the description from the dt-binding to prevent new boards
from using it.

I am keeping the driver code for existing DT files, but added
comments that this is deprecated.

Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
---

Changes in v3:
  - newly added

Changes in v2: None

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 1 -
 drivers/mmc/host/tmio_mmc_core.c                   | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index 3c67624..cb7d40e 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -49,7 +49,6 @@ Required properties:
 	  2: R7S72100
 
 Optional properties:
-- toshiba,mmc-wrprotect-disable: write-protect detection is unavailable
 - pinctrl-names: should be "default", "state_uhs"
 - pinctrl-0: should contain default/high speed pin ctrl
 - pinctrl-1: should contain uhs mode pin ctrl
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 7ad3433c..f30ac69 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1134,6 +1134,11 @@ static void tmio_mmc_of_parse(struct platform_device *pdev,
 	if (!np)
 		return;
 
+	/*
+	 * DEPRECATED:
+	 * For new platforms, please use "disable-wp" instead of
+	 * "toshiba,mmc-wrprotect-disable"
+	 */
 	if (of_get_property(np, "toshiba,mmc-wrprotect-disable", NULL))
 		mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
 }
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
