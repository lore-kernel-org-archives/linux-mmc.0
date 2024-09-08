Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862C51531CC
	for <linux-mmc@vger.kernel.org>; Sun,  8 Sep 2024 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790964; cv=none; b=V9l7316G1EEmEegUg8GithEDbmbdLSqWxmbsZyZ3xcXjwIH25drqgt5hcYR7lVdi86XwX84uE0gFggMsKX9M+c/ye/uaB13FEZze/gB5QYiNS4KQOWUwnQ+sPhsLLjkfKTfPy8zT/6dnLxdKBxf7/3kaDXuLj9ZmyrkcEW1Dd6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790964; c=relaxed/simple;
	bh=9kqbHJzYDSY3n5nRcl0yORyub7SvJhqQwK0th1vVNV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kEK7l22RWSQWKx5caL9USs+8n3kuGIi0Lc7d7r7ssGqlhfzpi+JdEmg2ePyi4DNSa5Wh7TZcwFL7DvdI2MAP1ihBKIwCvNThihLj51dsiNDs+YO05XJspGx6QYV/faaizqUG+HKOe9uZgVdw/Gu+8uySKeoltOD8TgDFPOSLmCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=E45H50hi; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E45H50hi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725790963; x=1757326963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9kqbHJzYDSY3n5nRcl0yORyub7SvJhqQwK0th1vVNV0=;
  b=E45H50hi6T4gSwhG2yXvmEqlrtwhRTHKIbJEZ2itvCMQYyEArXusVzNj
   WP2aKa8wZY+ankDXPYaf+owh6wDounLrkaiz3tYbQdcMMQ8FzLmBu9x0G
   Nq/cCx6BsKxUbyRQqt+rKDqeQ/CMtHCf6RChYvqvVSnrebxkLgSXsmCrp
   3lSRTrlJqFxuTK0gjGkFdUFLpSH6tFZ4SujB5I3htPbAbWA9QbYL3KadX
   PfAPfEPeAgl3W4Ovt8BGIKMD9isuF1wjoruqyFFnbzckJyuHe/pu4VxWe
   3oAzP/EKg0b2n91bXtnfYuEUyzxBlFL2zBJzEgR3efFT8aOUc597AesBJ
   Q==;
X-CSE-ConnectionGUID: 6gsl9c2DQNi0JCJP1jbT5w==
X-CSE-MsgGUID: kvjO3W4ETzCTJV003xikpg==
X-IronPort-AV: E=Sophos;i="6.10,212,1719849600"; 
   d="scan'208";a="25553890"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2024 18:22:43 +0800
IronPort-SDR: 66dd6e17_G8TmnwUX90cxBXH8ISUfma5FcJhkp63A4I/hjLfnWVvb6uH
 OV+sNUoCa7bMO0vBICds52q8pSsrqc9Bo8nA1BA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 02:27:52 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 03:22:41 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v7 09/10] mmc: core: Prevent HSQ from enabling for SDUC
Date: Sun,  8 Sep 2024 13:20:17 +0300
Message-Id: <20240908102018.3711527-10-avri.altman@wdc.com>
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

Prevent Host Software Queue from enabling for SDUC. In SDUC, CMD44 is
modified to include 6-bit upper address by utilizing its reserved bits.
Exclude hsq for SDUC for now.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 1d09f0f2e769..5d35fc8802c7 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1558,7 +1558,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 	}
 
-	if (host->cqe_ops && !host->cqe_enabled) {
+	if (!mmc_card_ult_capacity(card) && host->cqe_ops && !host->cqe_enabled) {
 		err = host->cqe_ops->cqe_enable(host, card);
 		if (!err) {
 			host->cqe_enabled = true;
-- 
2.25.1

