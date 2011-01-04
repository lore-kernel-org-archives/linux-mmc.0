From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 3/4] mmc: add MMC_QUIRK_DISABLE_CD
Date: Wed, 5 Jan 2011 00:13:27 +0200
Message-ID: <AANLkTikKDkE8eoRct_DN++dRTZ8uEMqUKN2GZdCngRKQ@mail.gmail.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com>
 <1294175416-12358-3-git-send-email-ohad@wizery.com> <4D239AAF.6090202@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.214.194]:38500 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab1ADWNr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 17:13:47 -0500
Received: by iwn42 with SMTP id 42so7497837iwn.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jan 2011 14:13:47 -0800 (PST)
In-Reply-To: <4D239AAF.6090202@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Jan 5, 2011 at 12:09 AM, David Vrabel <david.vrabel@csr.com> wr=
ote:
> How are you intending to use this?

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 9db9203..ae69ba9 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -19,6 +19,7 @@
 #include <linux/regulator/fixed.h>
 #include <linux/wl12xx.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/card.h>

 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -196,6 +197,18 @@ struct wl12xx_platform_data omap_zoom_wlan_data
__initdata =3D {
        .board_ref_clock =3D 1,
 };

+static void zoom_wl1271_init_card(struct mmc_card *card)
+{
+       /*
+        * Tell SDIO core to disconnect the pull-up resistor on CD/DAT[=
3]
+        * (pin 1) of the wl1271 card, which is not required since we
+        * already have OMAP pulling up this line, and we don't need an=
y
+        * card detection functionality. As a result, this may save som=
e
+        * power.
+        */
+       card->quirks |=3D MMC_QUIRK_DISABLE_CD;
+}
+
 static struct omap2_hsmmc_info mmc[] __initdata =3D {
        {
                .name           =3D "external",
@@ -220,6 +233,7 @@ static struct omap2_hsmmc_info mmc[] __initdata =3D=
 {
                .gpio_wp        =3D -EINVAL,
                .gpio_cd        =3D -EINVAL,
                .nonremovable   =3D true,
+               .init_card      =3D zoom_wl1271_init_card,
        },
        {}      /* Terminator */
 };


> Whether this pull up should be
> enabled or disabled is determined by the board (not the card). =A0The
> pull-up should be disabled if the board has a pull-up external to the
> card, otherwise it must remain enabled.

Agree.
