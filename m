Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2F1EFFAB
	for <linux-mmc@vger.kernel.org>; Tue,  1 Apr 2025 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501539; cv=none; b=qEH8NmQvZ83YiM70/PausfJBUjdy3YE6YXVQ4kjHt/vuufVD6CgXh8A8ZimWY1btF0+qYuugRmxtW97Vqh9SAvvyjfGQqBZkjbiPsqXwj51CmhkBbguz00yu17o+34cvcYF8Pyc5R3rtT03CNoDy2gr2iddAe+39xhKYem/CjC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501539; c=relaxed/simple;
	bh=9HWFKM2ae0FnWnEOa6Z5Sm1pPIk1ZbCnpmjmTnE81kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZp04oA/DNs6zZlPwWSzoRR8945DjK+n6VdhVTGTYxTADoA5ohrRJYn9kdA1hBYNtqJZ/ufAD0FzCN/zOe8ZN7nmgBAdj+yOJ/ls3/jWeYmi1emMyC209rGogkC1EcX8F3yk+IbktGALMlcUKsTPxZz8NlgKBBWvEpT0vHOWDgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DtWMsWig; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DtWMsWig"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=ePs0YSLtP6xSj65xIgWTtd65+7YiFf5tJg/EBjPox24=; b=DtWMsW
	ig0WXpigL39w7sf1Aw5ZIZXGPzFzor7am6i4cveAVHCfzszI9MWqDEivYyouJ5BA
	i0WdNPQmusDQWeprTVHeKZBeUNlpP7kEAuc+SO3ddYckA/aSRtSGIpYS9flpTTdI
	jt3bRikR6O5VUWT7HboqeQnC/A6GaPKdSNANfLaogQEe+NrNV9nUSIUuIsWMpMRL
	IrL1Ft6vbk9hizoiQziaUPBUT/UFuviOKi7mbWoYsVD+7V7OjAycfOOn3FWtlzz9
	vA1+kyNWbc5VHJ1YA8H4aOgRneGxr2xSvhdPfpw6gvRoKNdjAb5RuFlHn5L6Uue6
	9k0JZhVoRyeoh+Ng==
Received: (qmail 1558722 invoked from network); 1 Apr 2025 11:58:52 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Apr 2025 11:58:52 +0200
X-UD-Smtp-Session: l3s3148p1@aJOBlbQxOIIgAwDPXwSgADIEZgbhJYA3
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 03/11] mmc: rename mmc_can_ext_csd() to mmc_card_can_ext_csd()
Date: Tue,  1 Apr 2025 11:58:39 +0200
Message-ID: <20250401095847.29271-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250401095847.29271-1-wsa+renesas@sang-engineering.com>
References: <20250401095847.29271-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmc_can_* functions sometimes relate to the card and sometimes to the host.
Make it obvious by renaming this function to include 'card'. Also, convert to
proper bool type while we are here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/mmc.c     | 8 ++++----
 drivers/mmc/core/mmc_ops.c | 4 ++--
 drivers/mmc/core/mmc_ops.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 0bcad3ec8c83..2b63eb608489 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -680,7 +680,7 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 	u8 *ext_csd;
 	int err;
 
-	if (!mmc_can_ext_csd(card))
+	if (!mmc_card_can_ext_csd(card))
 		return 0;
 
 	err = mmc_get_ext_csd(card, &ext_csd);
@@ -959,7 +959,7 @@ static int mmc_select_powerclass(struct mmc_card *card)
 	int err, ddr;
 
 	/* Power class selection is supported for versions >= 4.0 */
-	if (!mmc_can_ext_csd(card))
+	if (!mmc_card_can_ext_csd(card))
 		return 0;
 
 	bus_width = host->ios.bus_width;
@@ -1022,7 +1022,7 @@ static int mmc_select_bus_width(struct mmc_card *card)
 	unsigned idx, bus_width = 0;
 	int err = 0;
 
-	if (!mmc_can_ext_csd(card) ||
+	if (!mmc_card_can_ext_csd(card) ||
 	    !(host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)))
 		return 0;
 
@@ -1543,7 +1543,7 @@ static int mmc_select_timing(struct mmc_card *card)
 {
 	int err = 0;
 
-	if (!mmc_can_ext_csd(card))
+	if (!mmc_card_can_ext_csd(card))
 		goto bus_speed;
 
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES) {
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 5c8e62e8f331..638e87a861bc 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -383,7 +383,7 @@ int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
 	if (!card || !new_ext_csd)
 		return -EINVAL;
 
-	if (!mmc_can_ext_csd(card))
+	if (!mmc_card_can_ext_csd(card))
 		return -EOPNOTSUPP;
 
 	/*
@@ -944,7 +944,7 @@ static int mmc_interrupt_hpi(struct mmc_card *card)
 	return err;
 }
 
-int mmc_can_ext_csd(struct mmc_card *card)
+bool mmc_card_can_ext_csd(struct mmc_card *card)
 {
 	return (card && card->csd.mmca_vsn > CSD_SPEC_VER_3);
 }
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 0df3ebd900d1..514c40ff4b4e 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -37,7 +37,7 @@ int mmc_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
 int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
 int mmc_bus_test(struct mmc_card *card, u8 bus_width);
-int mmc_can_ext_csd(struct mmc_card *card);
+bool mmc_card_can_ext_csd(struct mmc_card *card);
 int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
 bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
 			  unsigned int timeout_ms);
-- 
2.47.2

