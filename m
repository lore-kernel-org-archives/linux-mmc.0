Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23F1B3F3B
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761569; cv=none; b=cQwG+gXagqkqwJL0ufySsrZ0pKti6OKSM41iLfhq6c8+ZsCeZfX81/4l0pkTGvxRtfZJT6znTVpUBAIcCJJcprbWUCGodIzjcp55XjIF8VAJzuo2hrKOsrxwbWAQx4oPp+YQXO9K9cEw+OSG0GUz513GsqLZ038DP67PaE7Yq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761569; c=relaxed/simple;
	bh=MUf1Xqk+n5qLlVaaZHtTV6petTH/EQoXMg6topXkfEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TtAlkyRm80qhb6Laf/YVAWyVbj+d4AWKPfM2F3d6LeM+MVTIoKf+8Ajwg2pOzkh+8blP89hEQ1nzrYd/LnI82w2FTIXuSPccCGCrMWPVZprZKfZ1+ixq0ZX1GvISDWHXTLwN5cWO0O+pdFtzYXb+hfEZYPh2/4iWzV0qKrv09t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fUoKOOKb; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fUoKOOKb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724761567; x=1756297567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MUf1Xqk+n5qLlVaaZHtTV6petTH/EQoXMg6topXkfEI=;
  b=fUoKOOKbSM89l+E7s4FMJl0QRDWYFzhpM9+s5peYEscNGb4Adwtle6D+
   Cjs8kn5FZrDUaHIsQWmzdjIV+Z5dxGt5vtsaszE2qkVgJlgzG6bBILhdX
   Sf54sAl6bV4PHo2xEpqfKE84T7mlSPV31wtKOmWwA/O09wLAVjQOmlgsU
   1/06s+Bl4zp3jM/Fv34r+TaqsfoZs34GOHdjz8h+xbdl0P4BHLvREaZK1
   kEb1PN78M7iBVehKFZXj6YOdyjYfCFZPzyh3esl3vrRnBa+20tnHGr1mK
   DkcYdvxuB/jcLasTuaYUtLzj/VWiM+Tcg1bqdZAvOUuk1htxw9UkNQQU/
   A==;
X-CSE-ConnectionGUID: V3mHSmn1RjiXdfxTq3KEBQ==
X-CSE-MsgGUID: QJYU3xL/SnK66uRe3tM6qQ==
X-IronPort-AV: E=Sophos;i="6.10,180,1719849600"; 
   d="scan'208";a="25626013"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2024 20:26:06 +0800
IronPort-SDR: 66cdb7cb_yjIdk66HTSA+0Oe6MxKh8Xlgs7XYJ3Vl9CvsBOzvI1n9SJH
 EeFreYfWLmZeCd2FxKKKWEVkIANzAbJEnMdPSxw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 04:26:04 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 05:26:05 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v5 6/9] mmc: core: Add Ext memory addressing for erase
Date: Tue, 27 Aug 2024 15:23:39 +0300
Message-Id: <20240827122342.3314173-7-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827122342.3314173-1-avri.altman@wdc.com>
References: <20240827122342.3314173-1-avri.altman@wdc.com>
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
index 349e5c578da5..f43e6532702d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1642,8 +1642,12 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
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
@@ -1657,8 +1661,12 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
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

