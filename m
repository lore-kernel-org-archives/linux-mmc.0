Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E781531D1
	for <linux-mmc@vger.kernel.org>; Sun,  8 Sep 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790970; cv=none; b=WrUFfPVMUq1dnbDpSsKNAh9zTbL6HF5SsYhdHSlMezD7JnXZd4TI4QOc4b6WDdMadMKNJa0H8p/f0IIHAt3Hi+57TkvWVNj0tfeJYJEjJbf1L7Uv4k1EkIYgWcuhGv1GWaW4XrBCsKha6YwtdEyhbOJyoFNojonSl8l6QQsG1lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790970; c=relaxed/simple;
	bh=U563Mhh0q1723MHDkGoEkWrVPGt30/RE8nUI/CW64Fc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eSd/FOO1rbQ8pyolskxjjccI6zGi+kj02+VQewXhQ1nHMaGa+xydKEfybWuKX3gQam2mE4ZGuVxjOSj6uDiTgbug/nWSF+qXHWp5HF/n1aUZtUzpyZMjAYNRsZK64aqNjGubEh1SDnVV6oAl/Su1YICCre2cuJ1pwiCOMR6sZwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lAsYGRTO; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lAsYGRTO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725790968; x=1757326968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U563Mhh0q1723MHDkGoEkWrVPGt30/RE8nUI/CW64Fc=;
  b=lAsYGRTOzupvb+b8dbrmH0ux8l073EDucvIUM/Nsw5SgYislK/NsFsnD
   TYUHM/K542OAc5vQK9wqPw9LXHHK62YpH6B1QfkNEVUW4KMI6VDF2hwAs
   gwO1E/E9VbDMsHEr40p35VwQDu9MNQCeHNWN+RZhHzWlJ2FlfCqQAwLHw
   EaW4DFmgbF8VUqoM6Hx5GTMKeXwidjacuK8F73beWEAgHjMsBrZiqWvfx
   vbNmBftihI8hi8BSVC4wGJhbVwX3YUdMM/s9At3RDmLRK7oR6wKxsFu3p
   v+YLp7R3gNtESNXeZoHVyLJBHOXpzVFxLCm9GPHSiq/0a9ukRg42GSlG+
   A==;
X-CSE-ConnectionGUID: Jsxe9BNgRGuMnnyb2wTvQw==
X-CSE-MsgGUID: L+kA3hdwQByx6dEB33GkSA==
X-IronPort-AV: E=Sophos;i="6.10,212,1719849600"; 
   d="scan'208";a="25553894"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2024 18:22:48 +0800
IronPort-SDR: 66dd6e1c_f0CqIGIKsWIdiBvxFW2wkEoY7GK/zm0GkKUdwO0g2lWBH11
 ojjRnwyALH+3umxy7n2rU7BhWSQlAddeQOldDSQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 02:27:57 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 03:22:46 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v7 10/10] mmc: core: Enable SDUC
Date: Sun,  8 Sep 2024 13:20:18 +0300
Message-Id: <20240908102018.3711527-11-avri.altman@wdc.com>
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

Enable SDUC if the card responded to ACMD41 with HCS & HO2T bits set.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/sd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 5d35fc8802c7..0ee89e3e8f94 100644
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

