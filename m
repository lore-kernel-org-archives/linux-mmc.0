From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2] s3c64xx: Fix build without SDHCI controllers
Date: Fri, 11 Jun 2010 07:59:01 +0200
Message-ID: <1276235941-12114-1-git-send-email-m.szyprowski@samsung.com>
References: <000801cb0900$f64bbdc0$e2e33940$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:20394 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672Ab0FKF7Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jun 2010 01:59:16 -0400
In-reply-to: <000801cb0900$f64bbdc0$e2e33940$%kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: m.szyprowski@samsung.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org

This patch fixes the following compilation problem if only NCP machine
is selected:

arch/arm/mach-s3c64xx/s3c6410.c: In function =E2=80=98s3c6410_map_io=E2=
=80=99:
arch/arm/mach-s3c64xx/s3c6410.c:51: error: implicit declaration of func=
tion =E2=80=98s3c6410_default_sdhci2=E2=80=99

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/sdhci.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat=
-samsung/include/plat/sdhci.h
index 13f9fb2..2e263a8 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -166,8 +166,10 @@ static inline void s3c6410_default_sdhci2(void) { =
}
 #else
 static inline void s3c6410_default_sdhci0(void) { }
 static inline void s3c6410_default_sdhci1(void) { }
+static inline void s3c6410_default_sdhci2(void) { }
 static inline void s3c6400_default_sdhci0(void) { }
 static inline void s3c6400_default_sdhci1(void) { }
+static inline void s3c6400_default_sdhci2(void) { }
=20
 #endif /* CONFIG_S3C64XX_SETUP_SDHCI */
=20
--=20
1.7.1.240.g225c

