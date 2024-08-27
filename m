Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A761B4C2D
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761587; cv=none; b=rBg79NJ+KXJk67rvOiUDDXP5WI+sZQI/nLAPHlUAj7JFAKNlG5VZErPj3eB2G3duODrgKv33daKIT8HNBMRrO48agiYALiOkexf1Knb+96U8LsBi2kM+gsvLKGYJ8rULp+x22S1kxj/lNP1vHIIjhevyIrzyudOkbOW9phA7JaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761587; c=relaxed/simple;
	bh=KhLw2cIeU26Njm3pIvs0KiFLLn7t2hzqXdK9b6qDqJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vl8Lq5Zm+WNMfaZ1ISziCNn+OemRhs5rg78RlsC1D/6+KVnEsjDuThHj8Q17YwQ/57xQZlc172/FeznRaeoxgAn2Zu+xT/0tCSe50pT+PePWHYji09uXMRo5CUNr34UR/O3BIMYqRjjKAFoVBtl5W9q1F7KLDIi4iBHF2lRmqmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FXKganJK; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FXKganJK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724761585; x=1756297585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KhLw2cIeU26Njm3pIvs0KiFLLn7t2hzqXdK9b6qDqJI=;
  b=FXKganJKouxBL/HxLZwzvhUEhEXO9IGoNfbatGruAljHNiz3IC7AfEI+
   NtsAqsD4jvm3RvUU2fTaZdaCS2+LnFYW2VuA5Ca0tU1IqmFzy8Tid7OvR
   q9lH7yqBLiIWbsLuOBVkR5ijo5eKoQthJJJl8hfec/fNaQSgulkWn3P3C
   ICZ9D+ZnL93gb0Owrfi3Oq1zedAd8GipjhZmNTsnPx3AlJJKeRAQGxAz4
   b94M0GjOkIfvgj9IJ/KjQNsJDFrpRAY6+9X4EtQnumZSsDCCXy00gPoP1
   0g/0iGBMy0efWkaIeEP+eF7dRcSMrnp0+rUhEzOEaiJbtOUk5RrksnAgA
   A==;
X-CSE-ConnectionGUID: nS6ot2NLTMm/rPsI7Vny6w==
X-CSE-MsgGUID: 6D7n2vRlSQqH6wyL1PXg6Q==
X-IronPort-AV: E=Sophos;i="6.10,180,1719849600"; 
   d="scan'208";a="26277174"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2024 20:26:24 +0800
IronPort-SDR: 66cdb7dd_R9CZ4Q9BeQF18TfL8y+mDI0ivJjA+mw8E/8tOenGvrVNFXs
 Av7muS5xTqWvGAzGzim/j3WYpg8Sq3pVBMaiWsQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 04:26:22 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 05:26:23 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v5 8/9] mmc: core: Disable SDUC for mmc_test
Date: Tue, 27 Aug 2024 15:23:41 +0300
Message-Id: <20240827122342.3314173-9-avri.altman@wdc.com>
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

Panning to ameliorate it in the very near future.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/mmc_test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index b7f627a9fdea..a28e1a1aded3 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -3218,6 +3218,13 @@ static int mmc_test_register_dbgfs_file(struct mmc_card *card)
 
 	mutex_lock(&mmc_test_lock);
 
+	if (mmc_card_ult_capacity(card)) {
+		pr_info("%s: mmc-test currently UNSUPPORTED for SDUC\n",
+			mmc_hostname(card->host));
+		ret = -EOPNOTSUPP;
+		goto err;
+	}
+
 	ret = __mmc_test_register_dbgfs_file(card, "test", S_IWUSR | S_IRUGO,
 		&mmc_test_fops_test);
 	if (ret)
-- 
2.25.1

