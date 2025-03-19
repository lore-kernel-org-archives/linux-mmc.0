Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA66733985
	for <linux-mmc@vger.kernel.org>; Wed, 19 Mar 2025 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416822; cv=none; b=MUoeGvIvJL6AyQxHyqGI0FwpY8YCokqRZ0Lk4vkE1Czi7yaOPbZ0ZXADD+JQjbl/MheyT5w5g2cj0V1QBrTpuC7YAuzEMB783jCivB1FpAv1NYfa8UrBZTRjx+XnDu/57bIy4urVJWdwunkPtJHSd8lq7UTUoXKq8w4ovBjkGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416822; c=relaxed/simple;
	bh=f04BOb6TKKJEdcURYJAaSWtt4Kg7npWj4kOlXgSqkAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=up08DgnvOx7XYP8mAWP1DufhfyIe526EmY6Cwyiu0+Z9b9VY1yOfhGK9T9HMiIzCy3kV7NJco6mRQspByD9QxQ1LLB5tfVOuhaT+bWEuUAyGFLJfq8cbIPC8FuNrRhlPbcfCLRN3OO7iu8X6z6lCeg+Va/bhvrbdwvyVP0bZfQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=nzYr2YfK; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="nzYr2YfK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1742416820; x=1773952820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f04BOb6TKKJEdcURYJAaSWtt4Kg7npWj4kOlXgSqkAI=;
  b=nzYr2YfKwZWFE1VivB+fZd6u3w65+E8DsuCHZGWswJQ3VW2bmPH1FYeD
   jV/acwyHA9QMrdX7lyOVM8EMOfkzrj+Fj5RbH55WG5sSQoVaGaTfY0SOm
   58mbVVSxYeScAxTFkEIFMlO7bSxQBfpiQ6+2bQcv0Eomof8o1/insx1j2
   k0Bo1zJAmWf011e97XvKwsxVr6YdysWYbYbch+p1qqh/6ABG5gOVurbj4
   rXSBIlTuCs93/1hc+2vTfJuF8LyW0BjDQOhC8e0U4TwRfWtorW1zc8uGS
   XDkeEvqU2SHqNSTWf4Lf2Hy6wX9hW+w6AKVDk6RI4q483Zkyzt01baSA7
   g==;
X-CSE-ConnectionGUID: u2xZk6c7TuaeJU62RnKr4g==
X-CSE-MsgGUID: In8KGjrBSSemUuLYsaKayQ==
X-IronPort-AV: E=Sophos;i="6.14,259,1736784000"; 
   d="scan'208";a="56899582"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2025 04:40:14 +0800
IronPort-SDR: 67db1dcc_8/QJjbHCWVi2y/NENnQdpY5tKvTM5xbbEl5965UzmULp3Ik
 JZXKG2O9cJIzhyLonE/Wbgu/8wwaTY96BwqqaJQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2025 12:41:00 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2025 13:40:12 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] mmc: core: Remove redundant null check
Date: Wed, 19 Mar 2025 22:36:42 +0200
Message-Id: <20250319203642.778016-1-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change removes a redundant null check found by Smatch.

Fixes: 737d220bb2be ("mmc: core: Add open-ended Ext memory addressing")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-mmc/345be6cd-f2f3-472e-a897-ca4b7c4cf826@stanley.mountain/
Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 drivers/mmc/core/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5241528f8b90..ce08e0ea7fc1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -335,7 +335,7 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 {
 	int err;
 
-	if (mrq->cmd && mrq->cmd->has_ext_addr)
+	if (mrq->cmd->has_ext_addr)
 		mmc_send_ext_addr(host, mrq->cmd->ext_addr);
 
 	init_completion(&mrq->cmd_completion);
-- 
2.25.1

