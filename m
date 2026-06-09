Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56F233E377;
	Tue,  9 Jun 2026 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015219; cv=none; b=DLkX8zGGINlSSMXrA+zdmvm5I6SDqRCpRx9vWGCSXmNeevpWbMFgVpTmcTJf3PQAUtE0YY42cQ4c5hC352TMxLM6VmVWPsuO61Gewq+4b3Q9nZn+bqrBJJGM3o5zN2MA3ToISRBCHJQ2onu4/EKtLeCdUelBKD4Y7OGgv2ES2D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015219; c=relaxed/simple;
	bh=7hp/UOb4cP9+2Ta+q1UxShiAHGLDd0VAZhe5AMhowmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUxqY4P+fxgQYBRZQfhJbwIxS+RwfkBDzXktpJktOv6jeTPsHrAy/A8YKID/nu8rvWxhz0/QAM414Bg6OTukZWPhKkr67EwE4JYe6jSue9vTzF93KNda0Z9i4k5CSpZ2RrHAYnl5U9AInNjjDuNnUSD/JXzgMLijfwrIzOWgpy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0121F00893;
	Tue,  9 Jun 2026 14:26:54 +0000 (UTC)
From: Greg Ungerer <gerg@linux-m68k.org>
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	arnd@kernel.org,
	wei.fang@nxp.com,
	frank.li@nxp.com,
	shenwei.wang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	nico@fluxnic.net,
	adureghello@baylibre.com,
	ulfh@kernel.org,
	linux-mmc@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-spi@vger.kernel.org,
	olteanv@gmail.com,
	Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCHv2 2/4] net: smc91x: do not use readw()/writew() on ColdFire platforms
Date: Wed, 10 Jun 2026 00:12:59 +1000
Message-ID: <20260609142139.1563360-4-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609142139.1563360-1-gerg@linux-m68k.org>
References: <20260609142139.1563360-1-gerg@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the access macros and functions used to access the smsc hardware
registers when used on ColdFire SoC platforms so they do not use readw()
or writew(), or derived functions like ioread16be() and iowrite16be().

The current set of readX()/writeX() access methods for ColdFire have
historically been non-standard, in that they mostly access memory
big-endian instead of the expected little-endian. Before fixing the
ColdFire readX() and writeX() supporting code to properly work with
little-endian data existing driver uses need to be fixed. Convert the
smsc driver ColdFire uses of these to use the raw access macros - which
are well defined to be (native) big-endian on ColdFire. This change
requires some byte swapping at time of access to retain existing correct
behavior.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
v2: changed from RFC to PATCH

 drivers/net/ethernet/smsc/smc91x.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 38aa4374e813..1290335629c1 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -142,22 +142,26 @@ static inline void _SMC_outw_align4(u16 val, void __iomem *ioaddr, int reg,
 #define SMC_CAN_USE_32BIT	0
 #define SMC_NOWAIT		1
 
+/*
+ * Access SMSC device registers using raw IO access primitives. Byte
+ * swap as required for device registers, but not data.
+ */
 static inline void mcf_insw(void __iomem *a, unsigned char *p, int l)
 {
 	u16 *wp = (u16 *) p;
 	while (l-- > 0)
-		*wp++ = readw(a);
+		*wp++ = __raw_readw(a);
 }
 
 static inline void mcf_outsw(void __iomem *a, unsigned char *p, int l)
 {
 	u16 *wp = (u16 *) p;
 	while (l-- > 0)
-		writew(*wp++, a);
+		__raw_writew(*wp++, a);
 }
 
-#define SMC_inw(a, r)		ioread16be((a) + (r))
-#define SMC_outw(lp, v, a, r)	iowrite16be(v, (a) + (r))
+#define SMC_inw(a, r)		swab16(__raw_readw((a) + (r)))
+#define SMC_outw(lp, v, a, r)	__raw_writew(swab16(v), (a) + (r))
 #define SMC_insw(a, r, p, l)	mcf_insw(a + r, p, l)
 #define SMC_outsw(a, r, p, l)	mcf_outsw(a + r, p, l)
 
-- 
2.54.0

