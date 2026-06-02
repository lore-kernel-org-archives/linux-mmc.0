Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8423D1715
	for <linux-mmc@vger.kernel.org>; Tue,  2 Jun 2026 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393290; cv=none; b=Vvpy4GoEtP4fdIlqLIAXGkXGuW5721m9o7dTwQLqV0A50OSs3bw3CQ2k4BZgYXuJiAxWKQe6ligZADXDcP/w4eEciU2QsP6aXOB0E1jfcNDGxb6OJdc1uZ3a6NX3I5CrFLSEt8yX/AMahTa4HbvXJNsYebphNs73LowwJgLLgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393290; c=relaxed/simple;
	bh=WIFAHuSGEwBfZMaVU9szSBa8m5KBX6Ls1LCswXuTE7M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=eNuy3Dhp8kkaKmLfSEeoxoQnQ/t6r+indjUmMjg3Q0g0SVNmASNApaBqN0AlUUrsr4d7b3j1uVVbRMtpCGTKMFidaquCGVaM7NBgAYgzUUjKkalpg+d/2ItXQoqiXwWgy8LXVObT+mSI71xjMPpGWZWES1bsYYPugu0e9ba2EL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rb4dRKS1; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rb4dRKS1"
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260602094119epoutp02706c7d9e7d81bed4389b5b0836329eb6~1OkEmN01r0344003440epoutp02H
	for <linux-mmc@vger.kernel.org>; Tue,  2 Jun 2026 09:41:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260602094119epoutp02706c7d9e7d81bed4389b5b0836329eb6~1OkEmN01r0344003440epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780393279;
	bh=pBDB8vZWhgNn/AfLE1/Gq+8GsYCLP00sR5VbuUTPsVo=;
	h=From:To:Subject:Date:References:From;
	b=rb4dRKS1sONkFVPsMxoa+zEjxd+VsRWeNcU/BWbhytMNJ1lqWPcmOunPuz+DpA7im
	 sRjMkXtQ0YzwX+xr6B/Z+2mvaUNJNIniYxBsiy7B9MCd4zoDdcMhWLtHrhFXfzrzTM
	 soGCgfU9kCznb59EKR4ioyILZf4e/A6ex0RO+6J0=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20260602094118epcas1p1af1ad0c9c1484622d532ccce00f30e7a~1OkEFfQn80944809448epcas1p1E;
	Tue,  2 Jun 2026 09:41:18 +0000 (GMT)
Received: from epcas1p2.samsung.com (unknown [182.195.38.196]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4gV5SG2vwwz2SSKY; Tue,  2 Jun
	2026 09:41:18 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20260602094117epcas1p398765b6fb4a8ee28836cfde89744430f~1OkDccVAq3121931219epcas1p3O;
	Tue,  2 Jun 2026 09:41:17 +0000 (GMT)
Received: from cw9316lee.. (unknown [10.253.101.98]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20260602094117epsmtip1a9f5f1ebbe776403e57acf3d6f9e9a18~1OkDZ81431924719247epsmtip1P;
	Tue,  2 Jun 2026 09:41:17 +0000 (GMT)
From: Chanwoo Lee <cw9316.lee@samsung.com>
To: Ulf Hansson <ulfh@kernel.org>, Pedro Demarchi Gomes
	<pedrodemargomes@gmail.com>, Avri Altman <avri.altman@sandisk.com>, Chanwoo
	Lee <cw9316.lee@samsung.com>, Sarthak Garg <quic_sartgarg@quicinc.com>,
	Linus Walleij <linusw@kernel.org>, linux-mmc@vger.kernel.org (open
	list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mmc: core: sd: Remove unused buffer allocation in
 sd_enable_cache()
Date: Tue,  2 Jun 2026 18:40:55 +0900
Message-ID: <20260602094058.358267-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260602094117epcas1p398765b6fb4a8ee28836cfde89744430f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260602094117epcas1p398765b6fb4a8ee28836cfde89744430f
References: <CGME20260602094117epcas1p398765b6fb4a8ee28836cfde89744430f@epcas1p3.samsung.com>

sd_enable_cache() allocates a 512-byte buffer that is never used.
sd_write_ext_reg() allocates its own internal buffer, and no read-back
verification is done in this function. Remove the unnecessary allocation.

Fixes: 130206a615a9 ("mmc: core: Add support for cache ctrl for SD cards")
Signed-off-by: Chanwoo Lee <cw9316.lee@samsung.com>
---
 drivers/mmc/core/sd.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 948948ca9b4a..c763efb10f64 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1379,15 +1379,10 @@ static int sd_flush_cache(struct mmc_host *host)
 
 static int sd_enable_cache(struct mmc_card *card)
 {
-	u8 *reg_buf;
 	int err;
 
 	card->ext_perf.feature_enabled &= ~SD_EXT_PERF_CACHE;
 
-	reg_buf = kzalloc(512, GFP_KERNEL);
-	if (!reg_buf)
-		return -ENOMEM;
-
 	/*
 	 * Set Cache Enable at bit 0 in the performance enhancement register at
 	 * 260 bytes offset.
@@ -1397,7 +1392,7 @@ static int sd_enable_cache(struct mmc_card *card)
 	if (err) {
 		pr_warn("%s: error %d writing Cache Enable bit\n",
 			mmc_hostname(card->host), err);
-		goto out;
+		return err;
 	}
 
 	err = mmc_poll_for_busy(card, SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false,
@@ -1405,8 +1400,6 @@ static int sd_enable_cache(struct mmc_card *card)
 	if (!err)
 		card->ext_perf.feature_enabled |= SD_EXT_PERF_CACHE;
 
-out:
-	kfree(reg_buf);
 	return err;
 }
 
-- 
2.43.0

