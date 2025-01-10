Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C616DEA9
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jan 2025 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736499431; cv=none; b=mRajLXi2S/yMFqhp9VqSYjVr4OIROSiaAr/apoBqd7iLEo5xdpwfpltkg/QNY9auRrDaYeD7qXxBXLtytNFbnKtkGuolLIxJTgCWPHg3HYhi6Jh/Wpce/wrpw7aV9KV1qtOmsaTtf6H1bNlC/Bk84buO2pQ3gxpqQ3mMJi18JnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736499431; c=relaxed/simple;
	bh=RndmShM25+mkRfUuMw4dDfcryOtO+IJ6YB89ubC8mwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HnPHO/J706H+vA4ClPx2FC2c+wFXr2vPrIhXl+ov5l/K6dxbf5RvfI02OHxLEi3b57t6afLtNkZO0LKLmllzhBZliDPpFgLOPbREtCXo8MQsHRurr/vGnu0OEX2k2Dzps314/X2ht5yU7qKNOZFycpV7CTtMGxXQgvfVNj4CTOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Bz74h2jS; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Bz74h2jS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736499429; x=1768035429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RndmShM25+mkRfUuMw4dDfcryOtO+IJ6YB89ubC8mwk=;
  b=Bz74h2jSkH1Gm1lGmSxhTlYAjt788igiu9RLQbGVwoqKjmDnbyVZsE8r
   a2Qqc43OXpNQLRlbsZyXDhCIuHZW/ZADkJZ1bcVppf1EPlSQKSIZl/LGK
   efnHX8Unor2EGoxyG0oWRSC6+ENycds/CL/ZxohrHxFWyr22tUxlFD3da
   M1Eff9d2g1ObAfQnIsI4lo/j4pEDH+OXWJcVJnx66KbCk/e+sX8iiLvF/
   9ewk1DSSSv3wC8UzgGMwjEMCjOM6OGQ85F/0dYORDb7MuaNWUEMfOK3ob
   UyfS/qcIqnYEYLdLeD6BJOrBwY0ImyG6SV7CF7OjTwrK9WTfY9+ZLB4eA
   g==;
X-CSE-ConnectionGUID: F6dwGNqTRpySTtyWcl1HCQ==
X-CSE-MsgGUID: jmPNCkMcSQKyGYoUxd+3CQ==
X-IronPort-AV: E=Sophos;i="6.12,303,1728921600"; 
   d="scan'208";a="36152903"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2025 16:57:08 +0800
IronPort-SDR: 6780d35d_ANdV/vyvkIYvExYzQ2f6u6zvx60zVo+RgHKT+QsgH0I996g
 6AbwAsX6VK2gAc2LSKqBFwH9g1zcsTKFa8Hau7A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2025 23:59:25 -0800
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2025 00:57:07 -0800
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>,
	Daniel Custodio <Daniel.Custodio@wdc.com>
Subject: [PATCH] mmc-utils: docs: Fix a typo
Date: Fri, 10 Jan 2025 10:54:24 +0200
Message-Id: <20250110085424.104849-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in mmc-utils official repository address.

Reported-by: Daniel Custodio <Daniel.Custodio@wdc.com>
Closes: https://github.com/avri-altman-wdc/mmc-utils/issues/1
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 docs/README.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/README.rst b/docs/README.rst
index dd07ffc..9606501 100644
--- a/docs/README.rst
+++ b/docs/README.rst
@@ -11,7 +11,7 @@ Source
 
 mmc-utils resides in a git repo, the canonical place is:
 
-https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc-utils.git
+https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
 
 
 Mailing list
-- 
2.25.1

