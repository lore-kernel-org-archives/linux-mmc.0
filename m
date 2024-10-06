Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF4EC5
	for <linux-mmc@vger.kernel.org>; Sun,  6 Oct 2024 05:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728191676; cv=none; b=VTGEGBXrBr3OxCfEzwwElJwPOZ022b97jYseUvz00OJiE6mWw/E50RGqRbYPvgll6lhb9Bff+3D/fO3aEDiaeFENN5Dfbhcwd9MvEVHKYOd84B3N7KEruqhI8BsvSTEao7n6nOCskIfca1wp/WpYx2woTFCj/xAXmaWP68AmWTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728191676; c=relaxed/simple;
	bh=DsY7FEGA26mIOq/BNXWWOggrIsTPTayjqBPzwh9Dq5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dOGjS1u8+IHnuZhcr4LQADzHJOyyroAgtvagWpXDs+eRHh0D7F1fS6J9BzGhzxPEtDa8jLCUWNJKEgRlML36rjf981vRBjD5rp5B3ei4uBDmnDQXRpHWoZoBARiHFS55d6cHZpXu3VB7Fa+ISHyC8DqKEkQMRLHREkEAGdwzcrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DoLBWGYN; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DoLBWGYN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728191671; x=1759727671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DsY7FEGA26mIOq/BNXWWOggrIsTPTayjqBPzwh9Dq5w=;
  b=DoLBWGYNBPhFU6G2x9eSlfHiZUhkc7qEBrXPJqr7CCCSrePFKRtafjXN
   9vRJi7N9rmtNHdYg5MxBypgoT5kgFkm3YkO9hQrYWG1oGEr7SX9Ozu0Ly
   WATuCTKYpKuB7QX64VuSwY5y/5G/OacRhTQQPKBigdzzPyfezM0NsBCtg
   v0zdMrQ4qZoGpLmY6qtnAyJL7jsSUJHqH+9luxJTkv0KN7BNDydcKT8+s
   S9mek42t9UdAzWfcrRNhpLVEWJCqPeE9mkyNcFRPAtWSIYB6fTiw7J4Gg
   dpueWJw0vC5aHnKv59knrXHtAliV9efDfTdzYnGZ4oBcIuezrGl7Ajzuk
   Q==;
X-CSE-ConnectionGUID: WXyJK6ZKTgiB5ZfIM4KE1A==
X-CSE-MsgGUID: oM9tWpb7SjqKpuc1gc13QA==
X-IronPort-AV: E=Sophos;i="6.11,181,1725292800"; 
   d="scan'208";a="27708031"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2024 13:14:28 +0800
IronPort-SDR: 67020fb6_RmJYZrEz2Q52EAOc2kWcz1tpZSj/wahVwm8PN8MY1vZhB3R
 Pc4aqY7MDKtO52fciJ0CzVwQThCibBn1Fj4h3eg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 21:19:03 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 22:14:26 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v8 08/10] mmc: core: Disable SDUC for mmc_test
Date: Sun,  6 Oct 2024 08:11:46 +0300
Message-Id: <20241006051148.160278-9-avri.altman@wdc.com>
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

Planning to ameliorate it in the very near future.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/mmc_test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index b7f627a9fdea..4f4286b8e0f2 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -3241,6 +3241,12 @@ static int mmc_test_probe(struct mmc_card *card)
 	if (!mmc_card_mmc(card) && !mmc_card_sd(card))
 		return -ENODEV;
 
+	if (mmc_card_ult_capacity(card)) {
+		pr_info("%s: mmc-test currently UNSUPPORTED for SDUC\n",
+			mmc_hostname(card->host));
+		return -EOPNOTSUPP;
+	}
+
 	ret = mmc_test_register_dbgfs_file(card);
 	if (ret)
 		return ret;
-- 
2.25.1

