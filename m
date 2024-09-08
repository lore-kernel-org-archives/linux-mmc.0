Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E20E14D71F
	for <linux-mmc@vger.kernel.org>; Sun,  8 Sep 2024 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790961; cv=none; b=LgZAYe8HnHwr/z4BNr7Gx7nlwnjKpfJk7xuMXQ9uyqQNEUZlmFDdZ3Oe+Lm0DIjwr4PYOZfnr6CkjuvgLmpGCOyt9CJQQXUZSPVj6dBXgpbrZ/n6vBmj+C7EWx3vD4Eo0H3kPsbCdUsnyK2VzSsR3EkuEIeAfv4uGLlHW/42Ppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790961; c=relaxed/simple;
	bh=DsY7FEGA26mIOq/BNXWWOggrIsTPTayjqBPzwh9Dq5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZEbheLFPCB3JkqYJ7/LF+sCwYIlF5pgwsJ8Baz0T/UTBfyBHVAfjhn5gz+0BgGX8+fOwqmJBDl3b1wwr/Ti69v95ys5y1HS2ZZwrdqfdLoGwD2RBsm8BtpJscC23f4xzq1Z3KYiPltq+iZBJGVNNZZZsyAI710fF6q6UqMAIHqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SBJtCOTm; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SBJtCOTm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725790959; x=1757326959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DsY7FEGA26mIOq/BNXWWOggrIsTPTayjqBPzwh9Dq5w=;
  b=SBJtCOTmWCrgoK5lMs03uI9vIwFOvIZthnsqBm2Nh6iVff05Qi7juD4v
   1ROYDNXE49E6YglabNsz4vHjYIG4q+BIcl6D8mEgFYbTuR4muVo+8o1M+
   DWPbbq9NgfRBaxdE5WfhciX76LP7cNMaAP+GB+kzYv4l303VFpS+cciYG
   5LRQSGmUxpZYCmhs2he+diuZl0MvooBm0mt+tTpFs0VlalayzsqTk18/V
   CF4fEW4KukHnGxeNRlE3wrd/IM5YQ+pRsp9veOjK47wcphUbNw1qoV+Q7
   in3HPx4J5HIbHyup5XYF6pK5kIC9dsuiyTlu4BrVTgXVN1q9TVMjsdGfv
   w==;
X-CSE-ConnectionGUID: NxyGLCDiRc6Qz5p7gzbZZw==
X-CSE-MsgGUID: yhlgFYW+RHyx4N/Da8XezQ==
X-IronPort-AV: E=Sophos;i="6.10,212,1719849600"; 
   d="scan'208";a="25553888"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2024 18:22:39 +0800
IronPort-SDR: 66dd6e13_1/X19dIaWq6lQeaVRLAOi8WLzUmUqCxkVgXE7vV1OwAOjnw
 CK9KhFIUWdcPnaeWHCqIloUa1X3mqjEg8oojJdw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 02:27:48 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 03:22:37 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v7 08/10] mmc: core: Disable SDUC for mmc_test
Date: Sun,  8 Sep 2024 13:20:16 +0300
Message-Id: <20240908102018.3711527-9-avri.altman@wdc.com>
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

