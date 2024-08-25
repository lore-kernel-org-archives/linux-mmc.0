Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87123EDE
	for <linux-mmc@vger.kernel.org>; Sun, 25 Aug 2024 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724571829; cv=none; b=mEdUgkzs4yRK0F/S+qG1EcGr1AOIROdoEDKCmQVFFdEHCsaQAlRhXxEASpX5Un/5nGWb9HdsK3BBNBMikCIWTxdpoc8LeOr6W+M6NWTomvnhnUMWyep4K126fnEjdTEiW+WsyRHltHCFD0pYt2JlnSE3MXbwSJGPOCLHYSitUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724571829; c=relaxed/simple;
	bh=IH8LiC8RXqEYWeE5wiX6U/jl2mWswK2gnyJUfS5YXxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EfdxqHaauYBgr5BjMcGoHl3pTW8akEyJqsTRqsSvoje7AgJ8Gu7xjeIMbWEE4dwfmiHNUv9IvdN0iSwjJaG6SpHrgkRusrt/wXqY8Rtt8r9ipKWJ+a+m8SFoWlRvZu8Bbo8eV3+wDlshWTvXNEA6tJLkvGV/Sd+htFTVUZqca5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dPVzMRje; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dPVzMRje"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724571828; x=1756107828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IH8LiC8RXqEYWeE5wiX6U/jl2mWswK2gnyJUfS5YXxc=;
  b=dPVzMRje5oVeCmrd4oxEFwlL4PGv19l48gsRQ5t2xbaJq8EtNqyaFTid
   fAmOo4dA94Qx8jXexramc9jo/mE55lM3wRe3Tn8DUDrlPlV3Jtaw0Si8s
   7kGYWFDS/ThNQtXO/owvAF4+n4mj6CmGomCTgveLQHjdCBUe/+G7+30YR
   xo9FeHEIzw9XABQKBvXWywlwlLsGhUee/yAyWHYMJ8ow6+K/Sz2irczoi
   2MYtEAP2AsdsRjW3P0Cq8Nl/TV0gd0qp6dalxQeCgRutZFZvXNxT9bI3o
   lJ/sCx6H4ua8ksKSpqaaucSnIlwdfGLSpKvdXqd8ACtgL2BK8FYRr88aw
   w==;
X-CSE-ConnectionGUID: m+wQO0k/TkilwHoC8iUOnw==
X-CSE-MsgGUID: wq2C8LEtRYmKH0UNhCG+ow==
X-IronPort-AV: E=Sophos;i="6.10,175,1719849600"; 
   d="scan'208";a="25100444"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2024 15:43:47 +0800
IronPort-SDR: 66cad3f7_JEK5nUpSevJiwHBNiGKgW4CvoX4tEpQIKsCVPe8GBDKZiRk
 5trGw+r1EjR6HqzBWi17k4Y2gTdhBeOWH92/4Sg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2024 23:49:27 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2024 00:43:46 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 8/9] mmc: core: Add Ext memory addressing for erase
Date: Sun, 25 Aug 2024 10:41:40 +0300
Message-Id: <20240825074141.3171549-9-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240825074141.3171549-1-avri.altman@wdc.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
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
index 2148ce4535ee..3315c1fad264 100644
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
+	if (mmc_card_ult_capacity(card))
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
+	if (mmc_card_ult_capacity(card))
+		mmc_send_ext_addr(card->host, to);
+
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: group end error %d, status %#x\n",
-- 
2.25.1

