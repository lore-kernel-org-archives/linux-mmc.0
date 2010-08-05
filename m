From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch 1/1]sdhci: sdhc spec 3.0 add some modification
Date: Thu, 5 Aug 2010 15:09:14 +0800
Message-ID: <AANLkTinn+Af7kE34kjLEf3XLe2YTbpkJ4MtePFK0vMS8@mail.gmail.com>
References: <AANLkTin=8qej=hh3sJQkyjHcp17Wh4j8wngqyuRz=+1C@mail.gmail.com>
	<AANLkTimx_-+wvrnoe22ZDtrhfc0Ds873KSzW04zuppBH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38006 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758832Ab0HEHJQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Aug 2010 03:09:16 -0400
Received: by yxg6 with SMTP id 6so2382711yxg.19
        for <linux-mmc@vger.kernel.org>; Thu, 05 Aug 2010 00:09:15 -0700 (PDT)
In-Reply-To: <AANLkTimx_-+wvrnoe22ZDtrhfc0Ds873KSzW04zuppBH@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>

>>
>> =A0 =A0 =A0 =A01. support 8 bit data transfer width
> 8 bit buswidth patch is already merged to mm tree.
>
> http://marc.info/?l=3Dlinux-mmc&m=3D127783663526810&w=3D3
>
> Thank you,
> Kyungmin Park
>

Thanks Kyungmin, updated without 8 bit support.

=46rom 2b717444443acdac90c5f31522a1515a2000749a Mon Sep 17 00:00:00 200=
1
=46rom: Zhangfei Gao <zgao6@marvell.com>
Date: Fri, 6 Aug 2010 07:10:01 +0800
Subject: [PATCH] sdhc: support 10-bit divided clock Mode


Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
---
 drivers/mmc/host/sdhci.c |    5 +++--
 drivers/mmc/host/sdhci.h |    4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c6d1bd8..212dc9e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1002,7 +1002,8 @@ static void sdhci_set_clock(struct sdhci_host
*host, unsigned int clock)
 	}
 	div >>=3D 1;

-	clk =3D div << SDHCI_DIVIDER_SHIFT;
+	clk =3D (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
+	clk |=3D ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIVIDER_SHIFT) <<
SDHCI_DIVIDER_SHIFT_HI;
 	clk |=3D SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);

@@ -1681,7 +1682,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	host->version =3D sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version =3D (host->version & SDHCI_SPEC_VER_MASK)
 				>> SDHCI_SPEC_VER_SHIFT;
-	if (host->version > SDHCI_SPEC_200) {
+	if (host->version > SDHCI_SPEC_300) {
 		printk(KERN_ERR "%s: Unknown controller version (%d). "
 			"You may experience problems.\n", mmc_hostname(mmc),
 			host->version);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c846813..7c09b4f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -85,6 +85,9 @@

 #define SDHCI_CLOCK_CONTROL	0x2C
 #define  SDHCI_DIVIDER_SHIFT	8
+#define  SDHCI_DIVIDER_SHIFT_HI	6
+#define  SDHCI_DIV_MASK	0xFF
+#define  SDHCI_DIV_HI_MASK	0x300
 #define  SDHCI_CLOCK_CARD_EN	0x0004
 #define  SDHCI_CLOCK_INT_STABLE	0x0002
 #define  SDHCI_CLOCK_INT_EN	0x0001
@@ -177,6 +180,7 @@
 #define  SDHCI_SPEC_VER_SHIFT	0
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
+#define   SDHCI_SPEC_300	2

 struct sdhci_ops;

--=20
1.6.0.4
