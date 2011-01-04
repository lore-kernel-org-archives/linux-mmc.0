From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 4/4] mmc: add MMC_QUIRK_NONSTD_FUNC_IF
Date: Wed, 5 Jan 2011 01:16:15 +0200
Message-ID: <AANLkTi=HyXUAMALQD4MMZrw=Por8bTkJ6HxSC10UrDt4@mail.gmail.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com>
 <1294175416-12358-4-git-send-email-ohad@wizery.com> <AANLkTimg7DU=1bYv-k2-WwiSurHmsrjN_+zb_=irZv9n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.214.194]:36030 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab1ADXQg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 18:16:36 -0500
Received: by iwn42 with SMTP id 42so7513909iwn.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jan 2011 15:16:36 -0800 (PST)
In-Reply-To: <AANLkTimg7DU=1bYv-k2-WwiSurHmsrjN_+zb_=irZv9n@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, "DE CESCO, Jonathan" <jonathanc@ti.com>

Hi Pierre,

On Wed, Jan 5, 2011 at 12:48 AM, Pierre Tardy <tardyp@gmail.com> wrote:
> This sounds good, and may solve this problem we have with wl1271.
> Then, how do you tell the mmc stack the wl1271 has the quirk
> MMC_QUIRK_NONSTD_FUNC_IF?

Something like this:

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/
index 5a8311f..f9f9c8a 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -19,6 +19,7 @@
 #include <linux/regulator/fixed.h>
 #include <linux/wl12xx.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/card.h>

 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -196,6 +197,17 @@ struct wl12xx_platform_data omap_zoom_wlan_data __initdata
        .board_ref_clock = 1,
 };

+static void zoom_wl1271_init_card(struct mmc_card *card)
+{
+       /*
+        * Tell SDIO core to ignore the standard SDIO function interface
+        * codes indicated by the wl1271. This is required because the
+        * wl1271 erronouesly indicates its first function as a standard
+        * Bluetooth SDIO interface.
+        */
+       card->quirks |= MMC_QUIRK_NONSTD_FUNC_IF;
+}
+
 static struct omap2_hsmmc_info mmc[] __initdata = {
        {
                .name           = "external",
@@ -221,6 +233,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
                .gpio_wp        = -EINVAL,
                .gpio_cd        = -EINVAL,
                .nonremovable   = true,
+               .init_card      = zoom_wl1271_init_card,
        },
        {}      /* Terminator */
 };

This applies on the ZOOM board. in your case it would be a bit
different, but the core principle should stay the same.

Thanks,
Ohad.
