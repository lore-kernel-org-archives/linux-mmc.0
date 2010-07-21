From: "Gabay, Benzy" <benzyg-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 19/20] omap: zoom: keep the MMC3 wl1271 device
 powered off
Date: Wed, 21 Jul 2010 13:55:16 -0500
Message-ID: <676FD6AA0F002F49B89E70F0C5EFD22C1311192A47@dlee04.ent.ti.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
 <1279733634-21974-20-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1279733634-21974-20-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TbrhsbdSgBK9A@public.gmane.org
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Ohad,


-----Original Message-----
From: Ohad Ben-Cohen [mailto:ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org] 
Sent: Wednesday, July 21, 2010 12:34 PM
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org; Chikkature Rajashekar, Madhusudhan; Luciano Coelho; akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org; San Mehat; Roger Quadros; Tony Lindgren; Nicolas Pitre; Pandita, Vikram; Kalle Valo; Ohad Ben-Cohen
Subject: [PATCH v2 19/20] omap: zoom: keep the MMC3 wl1271 device powered off

Keep the MMC3 wl1271 WLAN device powered off until its
SDIO function driver requests otherwise.

Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    1 +
 arch/arm/mach-omap2/hsmmc.c                  |    3 +++
 arch/arm/mach-omap2/hsmmc.h                  |    1 +
 arch/arm/plat-omap/include/plat/mmc.h        |    3 +++
 drivers/mmc/host/omap_hsmmc.c                |    3 +++
 5 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 3230801..3ab9125 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -217,6 +217,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.gpio_wp	= -EINVAL,
 		.gpio_cd	= -EINVAL,
 		.ocr_mask	= MMC_VDD_165_195,
+		.dont_power_card = true,
 		.priv_data	= &omap_zoom_wlan_data,
 	},
 	{}      /* Terminator */
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index f06ddd2..24c4144 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -284,6 +284,9 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		if (c->vcc_aux_disable_is_sleep)
 			mmc->slots[0].vcc_aux_disable_is_sleep = 1;
 
+		if (c->dont_power_card)
+			mmc->slots[0].dont_power_card = 1;
+
 		mmc->slots[0].priv_data = c->priv_data;
 
 		/* NOTE:  MMC slots should have a Vcc regulator set up.
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 434a3ed..e200786 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -23,6 +23,7 @@ struct omap2_hsmmc_info {
 	int	ocr_mask;	/* temporary HACK */
 	/* Remux (pad configuation) when powering on/off */
 	void (*remux)(struct device *dev, int slot, int power_on);
+	bool	dont_power_card;/* keep card power off at boot (default is n)*/
 	void	*priv_data;	/* private data to SDIO function driver */
 };
 
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 9db1617..d042494 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -140,6 +140,9 @@ struct omap_mmc_platform_data {
 
 		unsigned int ban_openended:1;
 
+		/* keep this card powered off at boot (default is n) */
+		unsigned int dont_power_card:1;
+
 		/* card private data that should be used by function driver */
 		void *priv_data;
 	} slots[OMAP_MMC_MAX_SLOTS];
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4ac548e..4fb6634 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2157,6 +2157,9 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	if (mmc_slot(host).nonremovable)
 		mmc->caps |= MMC_CAP_NONREMOVABLE;
 
+	if (mmc_slot(host).dont_power_card)
+		mmc->caps |= MMC_CAP_DONT_POWER_CARD;
+
 	mmc_set_embedded_data(mmc, mmc_slot(host).priv_data);
 
 	omap_hsmmc_conf_bus_power(host);
-- 
1.7.0.4

[Benzy Gabay] small comment: Please make sure that all 127x related changes are not bounded only to MMC3. 
On OMAP4 WLAN is used on MMC5.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
