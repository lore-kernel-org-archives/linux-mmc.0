From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v5 0/7] native wl1271 support on ZOOM
Date: Wed, 15 Sep 2010 11:21:19 +0200
Message-ID: <AANLkTikedoL3HjohQfq2qa0TU5yMJR5p1GqyQJtQGrdb@mail.gmail.com>
References: <1283376410-9999-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34867 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701Ab0IOJVn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Sep 2010 05:21:43 -0400
In-Reply-To: <1283376410-9999-1-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "John W. Linville" <linville@tuxdriver.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, Luciano Coelho <luciano.coelho@nokia.com>, akpm@linux-foundation.org, San Mehat <san@google.com>, Roger Quadros <roger.quadros@nokia.com>, Nicolas Pitre <nico@fluxnic.net>, Ido Yariv <ido@wizery.com>, Kalle Valo <kalle.valo@iki.fi>, Russell King <linux@arm.linux.org.uk>, linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, "Wool, Vitaly" <Vitaly.Wool@sonyericsson.com>

On Wed, Sep 1, 2010 at 11:26 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> This patchset adds wl1271 support on ZOOM2/3 boards.

Tony, John, let me please suggest merging this through the wireless tre=
e.

wl1271 is a moving target - it keeps changing in the wireless tree and
merging this patchset there will allow wl1271 developers to have
everything in a single tree (and prevent merge conflicts in
linux-next).

If that's ok with you, I will rebase this on top of wireless-testing
and resubmit.

>
> Only basic support is included; MMC power manipulation part is submit=
ted separately as Runtime PM migration.
>
> Changes since v4:
> - Introduce a simple (yet safe) mechanism to pass platform-specific d=
ata to the driver, as suggested by Russell King. Currently only a singl=
e device is supported; multi-device support will be introduced only whe=
n/if required
>
> Patches are based on 2.6.36-rc3 and tested on ZOOM3.
>
> Thanks,
>
> Ohad Ben-Cohen (7):
> =A0wireless: wl1271: make wl12xx.h common to both spi and sdio
> =A0wireless: wl1271: support return value for the set power func
> =A0wireless: wl12xx: add platform data passing support
> =A0wireless: wl1271: take irq info from private board data
> =A0wireless: wl1271: make ref_clock configurable by board
> =A0omap: zoom: add fixed regulator device for wlan
> =A0omap: zoom: add mmc3/wl1271 device support
>
> =A0arch/arm/mach-omap2/board-zoom-peripherals.c =A0 =A0 =A0 | =A0 54 =
++++++++++++++++++++
> =A0drivers/net/wireless/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +
> =A0drivers/net/wireless/wl12xx/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A05 ++-
> =A0drivers/net/wireless/wl12xx/wl1251_sdio.c =A0 =A0 =A0 =A0 =A0| =A0=
 =A02 +-
> =A0drivers/net/wireless/wl12xx/wl1251_spi.c =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +-
> =A0drivers/net/wireless/wl12xx/wl1271.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A03 +-
> =A0drivers/net/wireless/wl12xx/wl1271_boot.c =A0 =A0 =A0 =A0 =A0| =A0=
 =A09 ++--
> =A0drivers/net/wireless/wl12xx/wl1271_boot.h =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 -
> =A0drivers/net/wireless/wl12xx/wl1271_io.h =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A09 ++-
> =A0drivers/net/wireless/wl12xx/wl1271_main.c =A0 =A0 =A0 =A0 =A0| =A0=
 =A04 +-
> =A0drivers/net/wireless/wl12xx/wl1271_sdio.c =A0 =A0 =A0 =A0 =A0| =A0=
 19 ++++---
> =A0drivers/net/wireless/wl12xx/wl1271_spi.c =A0 =A0 =A0 =A0 =A0 | =A0=
 =A08 ++-
> =A0drivers/net/wireless/wl12xx/wl12xx_platform_data.c | =A0 31 ++++++=
+++++
> =A0include/linux/spi/wl12xx.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 34 ------------
> =A0include/linux/wl12xx.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 38 ++++++++++++++
> =A015 files changed, 164 insertions(+), 57 deletions(-)
> =A0create mode 100644 drivers/net/wireless/wl12xx/wl12xx_platform_dat=
a.c
> =A0delete mode 100644 include/linux/spi/wl12xx.h
> =A0create mode 100644 include/linux/wl12xx.h
>
>
