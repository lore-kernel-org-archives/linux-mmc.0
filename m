Received: from mail-m32112.qiye.163.com (mail-m32112.qiye.163.com [220.197.32.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59423D297
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767667998; cv=none; b=o5W5BEf3Ns2rpPYnhHOrYDcE22ksP8UsE2rRrex/WUcDpH4xqTpw8Owa0A9gA5/HPLv5RqsT7wUu6qprS9FRdwxsofunhy3Spl4aFDpU4LPjKAQMKEDsN4qdVeYeYphH6nu3NONl2ljYhYbs9TvCsmqt/mUdhbYoepkY+r/Ir6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767667998; c=relaxed/simple;
	bh=1if1SG92FHF/Dlwqb192p8FCHDy0fVqPAI94vffjlE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ej8s8ziIHN3m+qJB7mqebQzaXJFfC75CuKESUQhyV75V0lEBOfQcEZh8NoYcuW/PZIsVkHWSVwZsjIIXb/LXB/sKZfthryCnk/juozNmFDZ727OUfBBs+deVPGa3DwZ2brAHxk6DSLZxYlgH8eb7Flg1GTLaguBbvanU92C0E7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=c1+InERh; arc=none smtp.client-ip=220.197.32.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="c1+InERh"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9c15469;
	Tue, 6 Jan 2026 10:17:37 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 01/18] mmc: dw_mmc: Check return value of dma_ops->init() in resume
Date: Tue,  6 Jan 2026 10:16:52 +0800
Message-Id: <1767665829-183001-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b9118722209cckunmc69ba49b79b848
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktJTVZNSU9JHkgYSRkaGE9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=c1+InERh43nNDUKCALWm/+UUEE9d8iVEGd32ACJDp/LuX2reNKaNHP4Len0bnxBrB1ACqkO//5HcBbEf8BhUwqU1wC5dEEaQbnYOEhfnqjQF/gYXNIkj5cCMUzc7jV6f72rIIIZgwwlK7F0eDbRXhTCzyrbs8LVXzS5LKl5Aztk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=uQTwnaK0ZS3Plg/b47f/ExABBA/sP/Dhyvw5IKmFpBY=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

dma_ops->init() may fail, should check the return value.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a328a36..9491bab 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3524,8 +3524,11 @@ int dw_mci_runtime_resume(struct device *dev)
 		goto err;
 	}
 
-	if (host->use_dma && host->dma_ops->init)
-		host->dma_ops->init(host);
+	if (host->use_dma && host->dma_ops->init) {
+		ret = host->dma_ops->init(host);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * Restore the initial value at FIFOTH register
-- 
2.7.4

