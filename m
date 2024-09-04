Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D921DC732
	for <linux-mmc@vger.kernel.org>; Wed,  4 Sep 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461703; cv=none; b=i2TAVTSwlyz5yH5db22di/CV4bLth68QVGCsyGolwCMnkOaX8SW9BkN0c9JFZr9b2RPmieG0fRFYZnRcuh1q6ixMraddgjSLu42t0visFU38RL7Y9gm1HVRypjirbNPl8yDe/wBZQu1TgJ4/aVYAzxE3osaBGtQPZ18FR7YSgu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461703; c=relaxed/simple;
	bh=4uB40Z2fbTrLI5r1u82/VpnC+k5USXQUOE8h9zoJDwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsj267Cn+ANDhprzFyaf1UB0bbntHI2u+mD58Ye28aJPNj/SRREoP1dQV4/riOU2Yrs1GZq6VLfVkfExc82DHRX4jtj00ShRdQhaP2HxP/AnSJ+r+alFYrH8TXtc1WAaLtS1dDyWqtmv8TRafwcwwhRxWqhMJl0J3sWb3FSyfus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V1QiZhb9; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V1QiZhb9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725461701; x=1756997701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4uB40Z2fbTrLI5r1u82/VpnC+k5USXQUOE8h9zoJDwE=;
  b=V1QiZhb9k07NO4TkONhhC9dPRwLg+HjCq5oxD41nZJh+7js3yDXe88HD
   r6KgfuGIN9ZTPm8lAageRVPuAYgKl5MLKkibobyHruNbnaE/PrpxOwaXy
   1vvxiRmOt5wf4rmsu/pJ1TcIL1WXYi/LKCmA4u9FlXltfYfz1sr9K8tLa
   oP/WEifExwIBHMuuPQiE+/ZHdqxp0NuqRrpWKPPGYqrATocNx4chY5+U6
   1VhaYxHM0bvX2VrVH388HEg3xX/WJK/aw++JkNenMFuhg7JCamUpYrrYQ
   95QlkGJbNqMKcZIuRyY6hQXjJAJv4VFMDmZtrSrCMXQuk8VbHuJQFYIdW
   w==;
X-CSE-ConnectionGUID: LeFrHs5AQXy6HEPGUjSABw==
X-CSE-MsgGUID: vQ4QRBZXS7aMIb/wiLsrgA==
X-IronPort-AV: E=Sophos;i="6.10,202,1719849600"; 
   d="scan'208";a="26291299"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2024 22:55:01 +0800
IronPort-SDR: 66d867ee_6b6hqwbQ/e7benuwcvnlVyFbMp9tv3FJM+tYvrpbylfhVL5
 kUcM+oqwdFiboXkvDwvLW1FnH3YWzYXDAiW59ww==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 07:00:14 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 07:55:00 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v6 4/9] mmc: core: Don't use close-ended rw for SDUC
Date: Wed,  4 Sep 2024 17:52:51 +0300
Message-Id: <20240904145256.3670679-5-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240904145256.3670679-1-avri.altman@wdc.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SDUC spec expects CMD22 to get squeezed between CMD23 and the
read/write command, e.g. CMD23->CMD22->CMD18 and CMD23->CMD22->CMD25.
At this early stage of adoption, we want to avoid an amid stream of
fixes & quirks of bogus hw, that tends to apply extra logic specifically
around auto-cmd12 & auto-cmd23.

Let's leave close-ended out for now, and re-consider this should those
cards become ubiquitous, if any.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 54469261bc25..35e82b0f924b 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2551,7 +2551,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	if (mmc_host_cmd23(card->host)) {
 		if ((mmc_card_mmc(card) &&
 		     card->csd.mmca_vsn >= CSD_SPEC_VER_3) ||
-		    (mmc_card_sd(card) &&
+		    (mmc_card_sd(card) && !mmc_card_ult_capacity(card) &&
 		     card->scr.cmds & SD_SCR_CMD23_SUPPORT))
 			md->flags |= MMC_BLK_CMD23;
 	}
-- 
2.25.1

