Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B35E37C105;
	Mon, 13 Apr 2026 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103594; cv=none; b=A7gIq0JHV845LVb2XOjQBCb5d86GGdQ2JAxGQUsjc5zz442Q7wvFfO2ANHNEyugERfwa3YRhOgvbXNhcvr0+6aQCMQnZc+QQ8p+gn8vT25mJKbny1QcZVsZiUxeus0pu/JWpBgBFaZ16xHtPh598NhPNCeJ+/9w4VFqdH+pj1W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103594; c=relaxed/simple;
	bh=S4Gta5zWf4yO0TPygmVXQ3p5GgJCc3ehvPtyiGFssKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aHYb1PlRi5jfj6kOrkEFC2xCnPyYu2OmdRYJcE8BlF4a9VQsW3Nxlh2Z8eSx4+DUrnniohT6PGV1KzJl31Lwkb3xuG+DcgPGze9D/sWOr80DGHbmFg3+7v7cUypFz7sbJtTZPk9gpnx0hemcwV5laXCJQLma8d1EW2PyicFETds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HBmXkObI; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HBmXkObI"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8CF28C0000DB;
	Mon, 13 Apr 2026 11:06:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8CF28C0000DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1776103587;
	bh=S4Gta5zWf4yO0TPygmVXQ3p5GgJCc3ehvPtyiGFssKc=;
	h=From:To:Cc:Subject:Date:From;
	b=HBmXkObIEDrzFHzhtqWqFXw7OpowfQ4Tc4D3GcNiAB5JWFHW4qdMXwszcRU5/IrRQ
	 oKWmOosm+8jnW9+LkVb3PvgUDJm20HQ8uTSX9QCReraaYC0/it9j9bHsskVyy/fV81
	 OiNco7jF16vABmZh2YxyMuRW/i4Ara8irvHwQ5L0=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 6C37DB6B;
	Mon, 13 Apr 2026 11:06:27 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Avri Altman <avri.altman@sandisk.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...)
Subject: [PATCH] mmc: core: Kioxia 016G01 does not enter boot mode after SLEEP
Date: Mon, 13 Apr 2026 11:05:37 -0700
Message-ID: <20260413180551.3683969-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Kioxia 016G01 eMMC device does not exit SLEEP mode when sending CMD0
which prevents the system from properly resuming from S3 warm boot where
the eMMC is necessary to pull in the boot components.

Add a quirk which prevents that specific device model from entering
SLEEP mode. There are no differences in the power consumption observed.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/mmc/core/mmc.c    | 3 ++-
 drivers/mmc/core/quirks.h | 7 +++++++
 include/linux/mmc/card.h  | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7c86efb1044a..8471115f7fc9 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1958,7 +1958,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 
 static bool mmc_card_can_sleep(struct mmc_card *card)
 {
-	return card->ext_csd.rev >= 3;
+	return card->ext_csd.rev >= 3 &&
+	       !(card->quirks & MMC_QUIRK_BROKEN_SLEEP);
 }
 
 static int mmc_sleep_busy_cb(void *cb_data, bool *busy)
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c417ed34c057..dc6badf740f3 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -153,6 +153,13 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
+	/*
+	 * Some Kioxia eMMC devices will not go into boot mode on CMD0 arg
+	 * after going into SLEEP state.
+	 */
+	MMC_FIXUP("016G01", CID_MANFID_TOSHIBA, 0x0100, add_quirk_mmc,
+		  MMC_QUIRK_BROKEN_SLEEP),
+
 	END_FIXUP
 };
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index e9e964c20e53..3812e9e79541 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -329,6 +329,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
 #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD poweroff notify support */
 #define MMC_QUIRK_NO_UHS_DDR50_TUNING	(1<<18) /* Disable DDR50 tuning */
+#define MMC_QUIRK_BROKEN_SLEEP		(1<<19) /* Broken sleep mode */
 
 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
-- 
2.43.0

