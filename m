Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6192C18C;
	Tue, 20 Aug 2024 23:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724195811; cv=none; b=QJdny/+7XBZvoMwKGn96zAJkKtBbOjWQ28M0OE7wi++a2gXmZjuzMatzMHKkcgXHJahjTFG7z6fXEK65jNP8pGrUtIFZeP/f+OUuDSm1W3w22AXiq50BTzHhIWILF9NY5Qps+Ix6ELmm0AVw4W0gG6JAa8aBUTfbg39AObT6PSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724195811; c=relaxed/simple;
	bh=zeU4HrFafNLYsq2SivKsBE9YqKJ+AS//oehwW6doPHU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oakSwpCvnTIIbHr2KbJz/VS3a7DDMqkoVSLXGGqsh8RR1rNA43yWHd7dGnYRS9mp5JSUF1CztNjOvrPG7n4Mg188uFQhry+am9htI/CC2A0kyMqbQl/IJEDHmcuCUkSRy7T1FcFBlz79AcTRhcMMBZ0osoA+LgRSa5CMGmkvPlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Nmzpv2e+; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Nmzpv2e+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1724195809; x=1755731809;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L3lUyrPnTOOQ769Uhh4sneNYG63qlS/SqSYwEuVsHA8=;
  b=Nmzpv2e+PQXCxQVcsBEwwdGBXbm6rhkHxs+UtGAVafRCS5jkHzuoBsSH
   zTjJZFXmRwcxFu7CSqcG0KN/Z5XPTU4ZHIfWOm5VWFus91Bx3J6ybOdQH
   Af6FpkeslJV72qFH0YEeKV+kglRuInuqga5mECv9UOvegAk+SHdej4U5m
   MeQYddCxb8a3jmCSVXtIam3Lx3V86kTAeOGO0vdk64911cpXEwbvTD0JW
   fZlnBtgoTvjcvTCzbn+zmhj6cqJSwwiv6SCUfzV060fVeY8k+pa16DwR0
   EJWezgDan4T4erqFy0kN1NfbMj8S5a6sbVzNT75cEpuFMlGfkbno+mqn7
   Q==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:06:39 +0900
X-IronPort-AV: E=Sophos;i="6.10,163,1719846000"; 
   d="scan'208";a="448857791"
Received: from unknown (HELO LXJ00013846) ([IPv6:2001:cf8:1:1611:9e7b:efff:fe46:27de])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 21 Aug 2024 08:06:39 +0900
Date: Wed, 21 Aug 2024 08:06:31 +0900
From: Keita Aihara <keita.aihara@sony.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jonathan Bell <jonathan@raspberrypi.com>, Tim.Bird@sony.com,
	Shingo.Takeuchi@sony.com, Masaya.Takahashi@sony.com,
	keita.aihara@sony.com, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: core: apply SD quirks earlier during probe
Message-ID: <20240820230631.GA436523@sony.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Jonathan Bell <jonathan@raspberrypi.com>

Applying MMC_QUIRK_BROKEN_SD_CACHE is broken, as the card's SD quirks
are referenced in sd_parse_ext_reg_perf() prior to the quirks being
initialized in mmc_blk_probe().

Split this out into a SD-specific list of quirks and apply in
mmc_sd_init_card() instead.

Fixes: c467c8f08185 ("mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go Plus from 11/2019")
Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
Co-developed-by: Keita Aihara <keita.aihara@sony.com>
Signed-off-by: Keita Aihara <keita.aihara@sony.com>
---
 drivers/mmc/core/quirks.h | 22 +++++++++++++---------
 drivers/mmc/core/sd.c     |  4 ++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index cca71867bc4a..92905fc46436 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -15,6 +15,19 @@

 #include "card.h"

+static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
+	/*
+	 * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
+	 * This has so far only been observed on cards from 11/2019, while new
+	 * cards from 2023/05 do not exhibit this behavior.
+	 */
+	_FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
+		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
+		   MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
+
+	END_FIXUP
+};
+
 static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 #define INAND_CMD38_ARG_EXT_CSD  113
 #define INAND_CMD38_ARG_ERASE    0x00
@@ -53,15 +66,6 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("MMC32G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_BLK_NO_CMD23),

-	/*
-	 * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
-	 * This has so far only been observed on cards from 11/2019, while new
-	 * cards from 2023/05 do not exhibit this behavior.
-	 */
-	_FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
-		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
-		   MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
-
 	/*
 	 * Some SD cards lockup while using CMD23 multiblock transfers.
 	 */
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 1c8148cdda50..ee37ad14e79e 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -26,6 +26,7 @@
 #include "host.h"
 #include "bus.h"
 #include "mmc_ops.h"
+#include "quirks.h"
 #include "sd.h"
 #include "sd_ops.h"

@@ -1475,6 +1476,9 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 	}

+	/* Apply quirks prior to card setup */
+	mmc_fixup_device(card, mmc_sd_fixups);
+
 	err = mmc_sd_setup_card(host, card, oldcard != NULL);
 	if (err)
 		goto free_card;
--
2.43.2

