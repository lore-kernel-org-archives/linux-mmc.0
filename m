Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ECC152165
	for <linux-mmc@vger.kernel.org>; Sun,  8 Sep 2024 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790952; cv=none; b=KmhaPUHz1XrN4IqiP0F9Fat6iGUGxWHY4j2EsKVY1IHyTim6b8WvH/ZjHQsiKYgmCWZJuJIBtlyd9NMSyCU4tE/DT+8Uel9jQG7g6yxfYOSWU3zWu5PUYCQgTeHilpVWMeOmxvzbWWcTDaOVXiAr20jEEztpUZyVxZUUAOPGN3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790952; c=relaxed/simple;
	bh=3wprHQrSZqGP0YWgVuzGkwQk8ALqtO2KWYXfyoqZ6CU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CgQx9kmC8RHyuGw3cXpk5dUpYZgiUZ8HKBsVMng7jyLz7DByZyynNR8G/oVKYvyWp3u6W8LxXQGqmI5qw05G6O5KOiI8r8wc45/A6MUcqeqnHhpODsFvz/CheCYg3z3EWJUgSQXd/URi19Q7FEmZQEyu86C2CohfFMTPAW/Rp3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lfu1a9+v; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lfu1a9+v"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725790950; x=1757326950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3wprHQrSZqGP0YWgVuzGkwQk8ALqtO2KWYXfyoqZ6CU=;
  b=lfu1a9+v3shMviyX5qnGwzRz7N2rQZRt7U9tSnHHJsMIoUE5FnnNh9St
   lWAqz4aHzBMxSYEcin1hWGzw6kB21gTImYnvdaNQ4McVATqim6+4r+nue
   90cISN6opUHTYCcMrNApTcV1EZUssROrJy5BH0Lqj+SuxtbGKsgQwzNZz
   0t89VWIrOwl5UuQOsaYAwQEyt6BMz+xJYmpA1Gwe4luadL5wBCbrqm4oG
   8coxRBE/UmYRn2m1a8AgRr2ybUJebjp7zEgXD4Cu8BTIYZKs69NCoITJ5
   g6TAGmLlxAI3/K9dFSc6U6URtv+10vMdUSBKG6CIByv0Bkt/bg41HIxvK
   g==;
X-CSE-ConnectionGUID: UBFkLS7qQ9OXIGc0+/TqoA==
X-CSE-MsgGUID: YCfhf/A/RTuSBRjFFZl4aQ==
X-IronPort-AV: E=Sophos;i="6.10,212,1719849600"; 
   d="scan'208";a="25553879"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2024 18:22:30 +0800
IronPort-SDR: 66dd6e0a_hOIbbW81xGexXO0l6HEus9v1TX64z4GxRPQdXNYXS3HB9ow
 WgSoeE8aAfHBl6tHWh0ZaqFaacX/YfMzGZBBVcw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 02:27:39 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 03:22:28 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v7 06/10] mmc: core: Add Ext memory addressing for erase
Date: Sun,  8 Sep 2024 13:20:14 +0300
Message-Id: <20240908102018.3711527-7-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240908102018.3711527-1-avri.altman@wdc.com>
References: <20240908102018.3711527-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CMD22 shall precede CMD32 and CMD33 to configure 38-bit erase start
address and 38 bit erase stop address.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 06f63fbaadfb..01a7142eada3 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1647,6 +1647,12 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
 		cmd.opcode = MMC_ERASE_GROUP_START;
 	cmd.arg = from;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	if (mmc_card_ult_capacity(card)) {
+		cmd.ext_addr = from >> 32;
+		cmd.has_ext_addr = true;
+	}
+
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: group start error %d, "
@@ -1662,6 +1668,12 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
 		cmd.opcode = MMC_ERASE_GROUP_END;
 	cmd.arg = to;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	if (mmc_card_ult_capacity(card)) {
+		cmd.ext_addr = to >> 32;
+		cmd.has_ext_addr = true;
+	}
+
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: group end error %d, status %#x\n",
-- 
2.25.1

