Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0AD22540A;
	Wed, 26 Feb 2025 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597996; cv=none; b=jwlW74lgWeLilHgOs75vnjVyvSADRaJ9KBGjhTbL5STzQD8Yqgl/04VoVdahPWQhe+giMnCPV+7QhjuV/3BdUTFTfybG/Q5/8WTDHk3kr5eGLbb3NORTEgrK9Gq8fmCBgmnH1NAYO7ad2XhkTj4t3EvmH9nQXmOWpRcdSfZqG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597996; c=relaxed/simple;
	bh=h6RdmGr8OqqidZERSf7wvyOPx+OpsshAqusRKR5DhoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QjbstjhtwYjXG+GRSGrYfcstUNpsdXpWxPVMkjiI7v8KT9uzTCytM4KCi5L2M55IDu7KWisyzGS7Gwp2EmsPpXQK95+IGZ5y/n5UhKsVIO90Se1NwI6EszGko7sOTNVyS//v4ZxWPJPAvI9TBKdZ/Xw0FGP6pHjiYxhN14phW0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=MT5TiMPQ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MT5TiMPQ"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1740597987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aHk9olOfjsR8vzOGK98b4cllDXRPWUHO6CLaRKmRifU=;
	b=MT5TiMPQXu7d9mD8cmV+LaoQS3009Vy8G7mhKxycsFZWP2crYQU1ULGCtpiWvXbWQcxeGo
	0H9M5c7Idh0Zotj/BtdSvQjrysbmBbBc7bxxrot83NBxqRhpbGP62P9hbCCoL3wUVyCzak
	DAv8wP2N29FJGvwHD5X9XcLY5qIQa4Kac4rQJUNEySIhThIVP5DfBbEBtlk1j0vZrbaieM
	huhaQ4yCJe9I0AclF8fObyCI22iVO6v1ryFe+7CJY7oxPcaLrECPnYRPLk6vhUnOkugilu
	M4j+7IOp1nbZWdxSACRRDzyhaNLULFDXfxRX9oNGOyrLtkLv8y4hEmJlDDt6FQ==
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	git@hrdl.eu,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Trim trailing whitespace from card product names
Date: Wed, 26 Feb 2025 20:26:18 +0100
Message-Id: <fb7fcecae737f3e8b279854d7c853000527cba9a.1740597891.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Product names for some eMMC chips can include trailing whitespace, which
seems to be rather uncommon, but makes emitted messages and /sys properties
somewhat unsightly.  Here's such an example from a Pine64 PineNote, in which
"Biwin ", as the eMMC product name, contains trailing whitespace:

  mmc0: new HS200 MMC card at address 0001
  mmcblk0: mmc0:0001 Biwin  115 GiB
  mmcblk0: p1 p2 p3 p4 p5 p6 p7
  mmcblk0boot0: mmc0:0001 Biwin  4.00 MiB
  mmcblk0boot1: mmc0:0001 Biwin  4.00 MiB
  mmcblk0rpmb: mmc0:0001 Biwin  4.00 MiB, chardev (249:0)

Trailing whitespace in /sys properties may even cause some unforeseen issues
with some scripts, so let's have the trailing whitespace trimmed in product
names for eMMC chips.  Although not observed yet by the author of these
changes, the same trailing whitespace may appear in SD card product names,
so let's trim them as well, which can't hurt.

Touch-up one commit as well, by using proper capitalization.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/mmc/core/mmc.c | 6 +++++-
 drivers/mmc/core/sd.c  | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6a23be214543..1522fd2b517d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/string.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
 #include <linux/sysfs.h>
@@ -66,7 +67,7 @@ static int mmc_decode_cid(struct mmc_card *card)
 
 	/*
 	 * The selection of the format here is based upon published
-	 * specs from sandisk and from what people have reported.
+	 * specs from SanDisk and from what people have reported.
 	 */
 	switch (card->csd.mmca_vsn) {
 	case 0: /* MMC v1.0 - v1.2 */
@@ -109,6 +110,9 @@ static int mmc_decode_cid(struct mmc_card *card)
 		return -EINVAL;
 	}
 
+	/* some product names include trailing whitespace */
+	strim(card->cid.prod_name);
+
 	return 0;
 }
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index cc757b850e79..8eba697d3d86 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -11,6 +11,7 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/string.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
 #include <linux/scatterlist.h>
@@ -95,6 +96,9 @@ void mmc_decode_cid(struct mmc_card *card)
 	card->cid.month			= unstuff_bits(resp, 8, 4);
 
 	card->cid.year += 2000; /* SD cards year offset */
+
+	/* some product names may include trailing whitespace */
+	strim(card->cid.prod_name);
 }
 
 /*
