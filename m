Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8156EC5
	for <linux-mmc@vger.kernel.org>; Sun,  6 Oct 2024 05:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728191683; cv=none; b=K8PmKwBrSnuw+pBk53WIIFCDNoqWTtSksWI0Zabcrq50VD8KY+wB4s8PROnTB4WuBLoHhkS6/0JxOs8W0sW2Zqbu3+txUMQpXebmxwRGK/xD8CtpeBWiycSE3px+qG4eMtZE96nTyVHTdhVi+Bhr0+uoj8ZSD9zvUusazPQvUck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728191683; c=relaxed/simple;
	bh=2LlAg9pxbyU/0I16uf9LcDSSv9+hDFHlpvmryLXiKFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LMpJZGNcSsBUtJg/3rtlX2b51vYJL9Ll17X6LICOOuDBGhPRG+TSIfpPgbzCcRJgzV3c3ofo9waabD5RFQGNHWNADv3odKHd5vqmNQn/QOG/+3DQbvUrQXqDRSaY+6x3mssLGsPGuHmrs9L9SdKMfPCxEu3Ko0Meet+fYDVngHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QJOVxbFJ; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QJOVxbFJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728191677; x=1759727677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2LlAg9pxbyU/0I16uf9LcDSSv9+hDFHlpvmryLXiKFM=;
  b=QJOVxbFJNbXC1AeWdBeAoJg0mDW8WLpldHB8ksp3ksXVBQlzVD2cz+rW
   YjihT4IfAyUlX1MrO/LacLduxzVE61GNlvvoipd0ONqj2vgIuCzx2O7hx
   cmW0sj90dR9WGJvUl4wM34kbr439GKct1aWVj4tGmFORHxR7/5bgBvYu2
   c/sdE8KZUVv6Us/OPmsJIRRVXvUEmjrGTeghQ753lm//YExjjZ/sWxWJJ
   HCcHQNbmFughbBA4DQ5z6MTmsAWkO13ATW80xKs6nE/zOFK2qnUisIQNK
   +jyvPrn2RZfA7Z39Ic5QKtYFjyZJ1B+t+yKoFpaCrsIrkQcDEZFpbfEya
   A==;
X-CSE-ConnectionGUID: 0rntislNQEKaEO/HznK+Vw==
X-CSE-MsgGUID: 5NpWzJeoSoeLLNfP0gFZMg==
X-IronPort-AV: E=Sophos;i="6.11,181,1725292800"; 
   d="scan'208";a="27708037"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2024 13:14:37 +0800
IronPort-SDR: 67020fbf_LNF4+1ZFlwwgk0Qa8BV9ZGZcjE9G/P0yfxe/MK8uVFMdS5B
 REbV0F8+Dwi90MO2mQx9P3Zk5MTVoOzWeX/9+mg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 21:19:12 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 22:14:35 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v8 10/10] mmc: core: Enable SDUC
Date: Sun,  6 Oct 2024 08:11:48 +0300
Message-Id: <20241006051148.160278-11-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241006051148.160278-1-avri.altman@wdc.com>
References: <20241006051148.160278-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable SDUC if the card responded to ACMD41 with HCS & HO2T bits set.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/sd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 33e806adcbf7..918b86bf8bbb 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -836,8 +836,11 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 	 * block-addressed SDHC cards.
 	 */
 	err = mmc_send_if_cond(host, ocr);
-	if (!err)
+	if (!err) {
 		ocr |= SD_OCR_CCS;
+		/* Set HO2T as well - SDUC card won't respond otherwise */
+		ocr |= SD_OCR_2T;
+	}
 
 	/*
 	 * If the host supports one of UHS-I modes, request the card
@@ -1448,7 +1451,10 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	if (!oldcard) {
-		err = mmc_sd_get_csd(card, false);
+		u32 sduc_arg = SD_OCR_CCS | SD_OCR_2T;
+		bool is_sduc = (rocr & sduc_arg) == sduc_arg;
+
+		err = mmc_sd_get_csd(card, is_sduc);
 		if (err)
 			goto free_card;
 
-- 
2.25.1

