From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/6] mmc: dt: Document binding for eMMC DDR 3.3V I/O voltage support
Date: Wed, 25 Jan 2017 16:12:22 +0100
Message-ID: <1485357143-23280-6-git-send-email-ulf.hansson@linaro.org>
References: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485357143-23280-1-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 8a37782..c7f4a0e 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -40,6 +40,7 @@ Optional properties:
 - cap-mmc-hw-reset: eMMC hardware reset is supported
 - cap-sdio-irq: enable SDIO IRQ signalling on this interface
 - full-pwr-cycle: full power cycle of the card is supported
+- mmc-ddr-3_3v: eMMC high-speed DDR mode(3.3V I/O) is supported
 - mmc-ddr-1_8v: eMMC high-speed DDR mode(1.8V I/O) is supported
 - mmc-ddr-1_2v: eMMC high-speed DDR mode(1.2V I/O) is supported
 - mmc-hs200-1_8v: eMMC HS200 mode(1.8V I/O) is supported
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
