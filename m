From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH v2 08/16] ARM: omap: add hsmmc am33xx specific init
Date: Thu, 11 Oct 2012 15:04:33 -0400
Message-ID: <1349982281-10785-9-git-send-email-mporter@ti.com>
References: <1349982281-10785-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1349982281-10785-1-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

AM33xx requires special handling in hsmmc initialization
platform glue.

Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/hsmmc.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 4d3a632..42ce988 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -365,7 +365,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	else
 		mmc->slots[0].ocr_mask = c->ocr_mask;
 
-	if (!soc_is_am35xx())
+	if (!soc_is_am35xx() && !soc_is_am33xx())
 		mmc->slots[0].features |= HSMMC_HAS_PBIAS;
 
 	if (cpu_is_omap44xx() && (omap_rev() > OMAP4430_REV_ES1_0))
@@ -388,7 +388,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 			}
 		}
 
-		if (soc_is_am35xx())
+		if (soc_is_am35xx() || soc_is_am33xx())
 			mmc->slots[0].set_power = nop_mmc_set_power;
 
 		/* OMAP3630 HSMMC1 supports only 4-bit */
@@ -489,7 +489,8 @@ static void __init omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
 	if (res < 0)
 		goto free_mmc;
 
-	omap_hsmmc_mux(mmc_data, (ctrl_nr - 1));
+	if (!soc_is_am33xx())
+		omap_hsmmc_mux(mmc_data, (ctrl_nr - 1));
 
 	name = "omap_hsmmc";
 	res = snprintf(oh_name, MAX_OMAP_MMC_HWMOD_NAME_LEN,
-- 
1.7.9.5


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
