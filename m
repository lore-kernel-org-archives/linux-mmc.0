From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/3] s3c64xx: Fix build without SDHCI controllers
Date: Wed, 09 Jun 2010 11:39:03 +0200
Message-ID: <1276076345-24370-2-git-send-email-m.szyprowski@samsung.com>
References: <1276076345-24370-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:34311 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757175Ab0FIJjN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jun 2010 05:39:13 -0400
In-reply-to: <1276076345-24370-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: m.szyprowski@samsung.com, kyungmin.park@samsung.com, ben-linux@fluff.org, kgene.kim@samsung.com

This patch fixes the following compilation problem if only NCP machine
is selected:

arch/arm/mach-s3c64xx/s3c6410.c: In function =E2=80=98s3c6410_map_io=E2=
=80=99:
arch/arm/mach-s3c64xx/s3c6410.c:51: error: implicit declaration of func=
tion =E2=80=98s3c6410_default_sdhci2=E2=80=99

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/sdhci.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat=
-samsung/include/plat/sdhci.h
index 13f9fb2..c2044e5 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -166,6 +166,7 @@ static inline void s3c6410_default_sdhci2(void) { }
 #else
 static inline void s3c6410_default_sdhci0(void) { }
 static inline void s3c6410_default_sdhci1(void) { }
+static inline void s3c6410_default_sdhci2(void) { }
 static inline void s3c6400_default_sdhci0(void) { }
 static inline void s3c6400_default_sdhci1(void) { }
=20
--=20
1.7.1.240.g225c

