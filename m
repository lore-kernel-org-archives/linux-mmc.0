From: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: [PATCH] mmc: sdhci-st: correct name of sd-uhs-sdr50 property
Date: Tue, 10 May 2016 09:14:24 +0900
Message-ID: <1462839264-13300-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Correct what appears to be a typo in the name of the sd-uhs-sdr50.

Also fix mixed tab/space indentation.

Signed-off-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-st.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-st.txt b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
index 18d950df2749..88faa91125bf 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-st.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
@@ -38,7 +38,7 @@ Optional properties:
 - bus-width:		Number of data lines.
 			See:  Documentation/devicetree/bindings/mmc/mmc.txt.
 
-- max-frequency: 	Can be 200MHz, 100Mz or 50MHz (default) and used for
+- max-frequency:	Can be 200MHz, 100Mz or 50MHz (default) and used for
 			configuring the CCONFIG3 in the mmcss.
 			See:  Documentation/devicetree/bindings/mmc/mmc.txt.
 
@@ -48,7 +48,7 @@ Optional properties:
 - vqmmc-supply:		Phandle to the regulator dt node, mentioned as the vcc/vdd
 			supply in eMMC/SD specs.
 
-- sd-uhs--sdr50:	To enable the SDR50 in the mmcss.
+- sd-uhs-sdr50:	To enable the SDR50 in the mmcss.
 			See:  Documentation/devicetree/bindings/mmc/mmc.txt.
 
 - sd-uhs-sdr104:	To enable the SDR104 in the mmcss.
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
