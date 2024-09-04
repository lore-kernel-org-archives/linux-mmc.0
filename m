Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E721DC187
	for <linux-mmc@vger.kernel.org>; Wed,  4 Sep 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461726; cv=none; b=NhFrGHdVf9uATBlfbZ3UBvIL7rGNJDb7QFw2nEDQH7zF+sr6iJlNpww9hgMSBwMiw39ja3Cug3MugEmDVqsLDZfSs5JdEQPXGDwrYu5XTJC3quuj7DyKJnBsXv5Mqr3YrTAAZZem0iXRHb2FxvPFU1T2PAqaHwicnLx/Zm8u2Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461726; c=relaxed/simple;
	bh=KhLw2cIeU26Njm3pIvs0KiFLLn7t2hzqXdK9b6qDqJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M3wj/Mhvi70vhbTSkjoa8aRnSFoYhMHvKNRchoTn4XNNgb+0uynRv4ecMSV+NaRpy6Y7DDto4u/RnDdrai2G3Yy8nDrLpOAaGhioI2bzYYo3HZPMgPB9YytT5EiWOqC2WSXAgGPX1hyw8gFUtI3Xxef99JcBzu9dgAg3f5tczts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=o0WbgFtY; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o0WbgFtY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725461725; x=1756997725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KhLw2cIeU26Njm3pIvs0KiFLLn7t2hzqXdK9b6qDqJI=;
  b=o0WbgFtYusRNIWAj5VMZPCaCGqbDQ64MWcxFFGjNuUscDCn2rHDtjJK8
   RCZu7jbinVrHQvqTYPSrs8pUh1l34TZ3kwolGn483SrqUfYTwY9ysc0AU
   dRv0FkFTQ1KlDwZ+crbdQPvLFtPSb6xgkIpPh/KpDHEjjaLHQFRUM7H1+
   tzfHciavWdSQ89fm5532M7sJSY0f4R1I4WPz2b2UyMlKkFq+KOBIlDlOH
   cu5Bnt81yQOr/cvdaw4YTYtGWI77LCtvRoywwaWJNafGns9gxBs533YqQ
   VH7y9rd5Gwu0LA1EV3qXdxP7iAfdkSwjRvfOctcOXrXcgLgDgby4xTGCy
   g==;
X-CSE-ConnectionGUID: JWhPXHZbTP+R2zpSK+Ybow==
X-CSE-MsgGUID: VDbWEoCISuS6YR+zcQvzvQ==
X-IronPort-AV: E=Sophos;i="6.10,202,1719849600"; 
   d="scan'208";a="26933752"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2024 22:55:24 +0800
IronPort-SDR: 66d866bf_7DyYjbyXevmgD3seP7512ylArjIt5gHb05Wm8O4xpxL7J55
 GhufWTrWmW1uJ9EULNyi+K/VEg2f84b3UNkf3/g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 06:55:11 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 07:55:21 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v6 8/9] mmc: core: Disable SDUC for mmc_test
Date: Wed,  4 Sep 2024 17:52:55 +0300
Message-Id: <20240904145256.3670679-9-avri.altman@wdc.com>
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

