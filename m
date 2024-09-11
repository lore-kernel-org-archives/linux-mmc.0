Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22B15445B;
	Wed, 11 Sep 2024 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045800; cv=none; b=Inz9aNrXmqdy079DGXC4wyFgLc9HkZz1PUPtve5fxlUvTEW2eyzFNooOt3I4UaTuk+6ikzTg5TfVQT4P83WjBN4vDJPeMrDCGtKqbg7+nQsP92qYwzhyMrcs/2e08sqWt5RflXEajJv6oWRhZTo30jksjj9I9Xv3ecj+Pdqc7EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045800; c=relaxed/simple;
	bh=NLKG1s/hUkeFO5n+Xk3s9RxQzmTdBz11N2y/DRJ0aNY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mFYKF7C9iA4OPbaALVhfSiNAHhocaBC50rSXyjeMf9bqwtTB1nxnjhCgqDpn4T6IvABe5rGmSKYlKE8N7wcA4cdXegLv5bnMFlWgx2psFsPB5ONK8U94g1AmuBirZj4xaUHwTKNgO9r+6/txhCU3gblwCJRAbzKNb5LX+cbpuVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=VSToC9qg; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=pyM/1Hx2 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="VSToC9qg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="pyM/1Hx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1726045796; x=1757581796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=46BgWppNkiqJDwiFsXyHMRlvMd8GEeUp7NfKnafeDJY=;
  b=VSToC9qg/ZXMcfkUTqvWWEYmhAQUp+H3A2HofGUPFooQgFoEq1PlClct
   8CLU/gy+Lrlvys+txergLOHbYSumijTnKoVGyWPj0RQpm/H57lkGMV9zM
   Nzll+3EiAWHmJG//x6bc0JEhQJMS6I13jHDo7YcYgm3MGcJ5iJmgNhgdC
   t7b1YeHpKB90AunOTBwWT9cy0i6tvKJ39nVuFAdCzEgXv4NE7uix8YLwl
   6CBTs02dhZm0c9Rmf/XxMGIHvzWd6L9LO89h0Mllb/EZT/atJbvkpuAky
   NvzI8rOPKz57M4CEs3EG+O7m1qNWcQUrnScYWQXQPwMkL0iav3lm2g599
   w==;
X-CSE-ConnectionGUID: BRp+yKMETcCYzRy79kGrag==
X-CSE-MsgGUID: Ov0NP05AR56ASAjbVxLv6g==
X-IronPort-AV: E=Sophos;i="6.10,219,1719871200"; 
   d="scan'208";a="38883263"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 11 Sep 2024 11:09:53 +0200
X-CheckPoint: {66E15E61-6-22BB8E18-F5F6D0B4}
X-MAIL-CPID: 606A30203632BA081BF7836B0F65C595_5
X-Control-Analysis: str=0001.0A782F22.66E15E61.00F3,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E10F5161641;
	Wed, 11 Sep 2024 11:09:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1726045789; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=46BgWppNkiqJDwiFsXyHMRlvMd8GEeUp7NfKnafeDJY=;
	b=pyM/1Hx2Ruyerl531K/uGxitlN1sNGAAsErzBneWKqgofj8FKDtbkSWi3DeBExzB7uOMxe
	pfNpxYr/3pLTXLbsrQiChlrG3UHe6yGvMrJSoTpvs1o0ZforZgdfvdSiCLK/b9N2Tk443A
	Frgc56EMfNHZDVUkRmPg6k1w42oE/580Lvgk6p9fD6Q4ekBj04wYnlJQRkh+im0G2gb2B0
	C99L8WfkjujKzwbHM6Xy7EPCwz2a/oPkZ1uWyZgsIv71lbXTCDiBFj4cb4KnoX7uAvjJv0
	qb+GQLz41sQB/63fXaSQ26BEo1oWE6AWiXlmICj0HnGKwnx757H8qfGKpTMPdw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mmc: core: Use dev_err_probe for deferred regulators
Date: Wed, 11 Sep 2024 11:09:09 +0200
Message-Id: <20240911090910.3060749-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

In case vmmc or vqmmc regulator is not available yet, use dev_err_probe
in order to set a deferred probe reason. This is a helpful hint in
/sys/kernel/debug/devices_deferred

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/mmc/core/regulator.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 005247a49e51b..01747ab1024ec 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -255,7 +255,9 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 
 	if (IS_ERR(mmc->supply.vmmc)) {
 		if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+			return dev_err_probe(dev, -EPROBE_DEFER,
+					     "vmmc regulator not available\n");
+
 		dev_dbg(dev, "No vmmc regulator found\n");
 	} else {
 		ret = mmc_regulator_get_ocrmask(mmc->supply.vmmc);
@@ -267,7 +269,9 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 
 	if (IS_ERR(mmc->supply.vqmmc)) {
 		if (PTR_ERR(mmc->supply.vqmmc) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+			return dev_err_probe(dev, -EPROBE_DEFER,
+					     "vqmmc regulator not available\n");
+
 		dev_dbg(dev, "No vqmmc regulator found\n");
 	}
 
-- 
2.34.1

