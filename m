From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 15/22] OMAP: hsmmc: Do not mux the slot if non default muxing is already done
Date: Thu,  5 May 2011 14:51:15 +0300
Message-ID: <1304596282-4095-16-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:62722 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170Ab1EELwT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 May 2011 07:52:19 -0400
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>

From: Jarkko Lavinen <jarkko.lavinen@nokia.com>

Allow the bootloader do all the muxing.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/hsmmc.c |    3 ++-
 arch/arm/mach-omap2/hsmmc.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index b2f30be..6b97fae 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -440,7 +440,8 @@ void __init omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
 		pr_err("%s fails!\n", __func__);
 		goto done;
 	}
-	omap_hsmmc_mux(mmc_data, (ctrl_nr - 1));
+	if (!hsmmcinfo->nomux)
+		omap_hsmmc_mux(mmc_data, (ctrl_nr - 1));
 
 	name = "omap_hsmmc";
 	ohl = omap_hsmmc_latency;
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index f119348..0f2a87e 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -19,6 +19,7 @@ struct omap2_hsmmc_info {
 	bool	power_saving;	/* Try to sleep or power off when possible */
 	bool	no_off;		/* power_saving and power is not to go off */
 	bool	vcc_aux_disable_is_sleep; /* Regulator off remapped to sleep */
+	bool    nomux;          /* No default muxing for this slot */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
 	char	*name;		/* or NULL for default */
-- 
1.7.0.4

