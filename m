From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 0/2] omap_hsmmc: Supports slot-name also in DT
Date: Fri, 15 May 2015 23:14:47 +0200
Message-ID: <1431724489-32359-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This patch series fix regression when migrating from legacy board code =
to
DT on Nokia N900. It exports slot-name property to /sys structure from =
DT.
Legacy board code is doing it but DT code without this patch not.

Nokia N900 has two mmc slots, one internal (eMMC) and one external
(uSD card). Userspace on Nokia N900 is using slot-name for detecting if
mmc device is eMMC or uSD.

Pali Roh=C3=A1r (2):
  mmc: omap_hsmmc: Add support for slot-name property in DT
  omap3-n900.dts: Add slot-name properties for mmc devices

 arch/arm/boot/dts/omap3-n900.dts |    2 ++
 drivers/mmc/host/omap_hsmmc.c    |    2 ++
 2 files changed, 4 insertions(+)

--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
