Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371093BBF4
	for <linux-mmc@vger.kernel.org>; Wed, 14 Aug 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620725; cv=none; b=m5onA+ljD1yI95/Dcw8qxhUO/Bpy6WrUgAbkbVNsmEZ6C8l714Vd0g6W5rPi0zOSf7VnPGCvleggXJ9VQTAY4X6Tmc8Eyh/TmFK1iiBlI7PZsla9TjmGN/ghTzNL/8EV08nFbr2Rhv9t/OPHMtA7ykMg3AbAizWdYlKKAz7sHJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620725; c=relaxed/simple;
	bh=oxJxGzIlf3xyO+cEDi9I22/OxExVma7Zqlp/fL7tJcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BrwJGKqgSYkE1i9UnBYuzPrJ6uvJT3aI1we+yT5pie4q8zAS5YvsD7kLrTUhrcLkQ8q9sZ7vO9UA74k7LUc7c8ACMhOvKdlkB20HTpWHUoKOzSw9K1pzXSO9cdX/XBvOZrPPOCa0oP6bJiVdLguPzSfB5C1ZOpC/q0KNKvHCxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WvalVBVH; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WvalVBVH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723620723; x=1755156723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oxJxGzIlf3xyO+cEDi9I22/OxExVma7Zqlp/fL7tJcw=;
  b=WvalVBVHQwJJyWR5F6hU5x3p80ul1um/6PxUZUzo1jsWV1Uo/QOSpgWe
   UEVhHbPiQhIU9aJAwOM2ZGFzwBR6Wo4a46YtSyZNbsje7R1LmporJH/Yc
   CH3d2PaBEy22mZwwN+jAWB7mcX5wTpgMOz/6q0IgUYgpobYp3/KtF6zyo
   w2Kr1CdYF+YdZH9uXrs/tocxxgEYYPXX+3u7SjgtCW3aXwIxepHhPQXEn
   z1rLDum0P30cb+hitG+u9wiSuWFPFpDiQdaVIjNiMhIIZL3AYc1tQbn39
   gOMphG5YrYFlkO1QL5LDB/uGAwNgSW41USMh3KPHfv5PcOejIiMIwtyqD
   w==;
X-CSE-ConnectionGUID: 6EwDspRUQYGVz9sG2t40WQ==
X-CSE-MsgGUID: tkEQlgkzSkKlSk/oQhbRtA==
X-IronPort-AV: E=Sophos;i="6.09,288,1716220800"; 
   d="scan'208";a="24218487"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2024 15:31:56 +0800
IronPort-SDR: 66bc4f69_X3cbeR3bf73bglWgdZdRRwpaIb8hzXpyGNrun8vCUCohVZr
 xOe4MKrbwI7xy6MY/Sqer6cqeTnRm9wncQzv1xg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 23:32:10 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 00:31:55 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 09/10] mmc: core: Add Ext memory addressing for erase
Date: Wed, 14 Aug 2024 10:29:33 +0300
Message-Id: <20240814072934.2559911-10-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240814072934.2559911-1-avri.altman@wdc.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CMD22 shall precede CMD32 and CMD33 to configure 38-bit erase start
address and 38 bit erase stop address.

Tested-by: Ricky WU <ricky_wu@realtek.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 07aa249c227b..a982ead0c8af 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1660,8 +1660,12 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
 		cmd.opcode = SD_ERASE_WR_BLK_START;
 	else
 		cmd.opcode = MMC_ERASE_GROUP_START;
-	cmd.arg = from;
+	cmd.arg = from & 0xFFFFFFFF;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	if (mmc_card_is_sduc(card->host))
+		mmc_send_ext_addr(card->host, from);
+
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: group start error %d, "
@@ -1675,8 +1679,12 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
 		cmd.opcode = SD_ERASE_WR_BLK_END;
 	else
 		cmd.opcode = MMC_ERASE_GROUP_END;
-	cmd.arg = to;
+	cmd.arg = to & 0xFFFFFFFF;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	if (mmc_card_is_sduc(card->host))
+		mmc_send_ext_addr(card->host, to);
+
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: group end error %d, status %#x\n",
-- 
2.25.1

