From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 03/11] ARM: U300: set f_max to 24 MHz for MMCI
Date: Thu,  8 Apr 2010 01:12:33 +0200
Message-ID: <1270681953-5244-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Grant Likely <grant.likely@secretlab.ca>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>
List-Id: linux-mmc@vger.kernel.org

This employs the frequency setting mechanism introduced to the
MMCI to specify that this system can actually be clocked at 24 MHz.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/mmc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-u300/mmc.c b/arch/arm/mach-u300/mmc.c
index c2549b8..88506d0 100644
--- a/arch/arm/mach-u300/mmc.c
+++ b/arch/arm/mach-u300/mmc.c
@@ -102,6 +102,7 @@ int __devinit mmc_init(struct amba_device *adev)
 	 * we have a regulator we can control instead.
 	 */
 	/* Nominally 2.85V on our platform */
+	mmci_card->mmc0_plat_data.f_max = 24000000;
 	mmci_card->mmc0_plat_data.status = mmc_status;
 	mmci_card->mmc0_plat_data.gpio_wp = -1;
 	mmci_card->mmc0_plat_data.gpio_cd = -1;
-- 
1.6.3.3
