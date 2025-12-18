Received: from mail-m49221.qiye.163.com (mail-m49221.qiye.163.com [45.254.49.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88172BB17
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066805; cv=none; b=kwRzIRsMtl0hzJekwZfnkx5eiSQO3QLupmxs3dC7rIUdDDNzqSOMulOJG/2xVgy+oT7urVZa8JwF6DQVKCHJ5CEeZq3jnFEfMbpI6dnAdxnOhp4VCAisKvDqvY7Vs8ix/5e9hz+345lRDDV+kmnIBvP4XMx5SS+ipvMPuo+BR9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066805; c=relaxed/simple;
	bh=w6kwsPo65ekNcxBAvFLaah/0nxhIBg3uQV29IM0UpzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Hzyv2auwaNBYyNmwRYZkh2RAcUestP03D706PAIunyA5WXGg2LdTZROZoUvjfyhBpc7aT2ThdfKbamSND/10zCRQIuoVNY6Hgop2L3eAejo6QnTMAUmMbaIn4rivRIDEtNcBoA/NdEOiV7td8fjBfcKs6zxazUKdT5sbqYAJeVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DQV2Je5B; arc=none smtp.client-ip=45.254.49.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DQV2Je5B"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb254;
	Thu, 18 Dec 2025 22:01:25 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 01/18] mmc: dw_mmc: Check return value of dma_ops->init() in resume
Date: Thu, 18 Dec 2025 22:00:28 +0800
Message-Id: <1766066445-14144-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c3f85c09cckunm1f354c4b70cf
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGksdTFZJSkMaHxhJThgeHU5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=DQV2Je5B5j3QCsqEct7kcCOi6Mf/sOvFMwgMyd0XIG6+l3YZxrI3A9SLs8bRfSx8yZq+SEBQPPGuDv6hn2Pz585VEUGNyLOKUNbb736EiWlevtiPL4WrSVF+zfJokhCYTjSPdF8Z/CZKK95GNjZOCJgSoV77c6AKosDGOSHKqcY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=R8WB2dehxIzml9QF3ZywuajO4p9dTsKlyeqzuT3mB28=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

dma_ops->init() may fail, should check the return value.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 8a03622..166511d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3523,8 +3523,11 @@ int dw_mci_runtime_resume(struct device *dev)
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

