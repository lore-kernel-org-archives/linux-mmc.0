Received: from mail-m3284.qiye.163.com (mail-m3284.qiye.163.com [220.197.32.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D2C224AF9
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 02:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767668033; cv=none; b=fjlXLzQqWOKUnOibEUQwltAz1XelKosF+PdLZ9kiBsVgaK7pu2Ds4ZbinnP7NWcCs6S05TOBmRn7k5ATxZ7Yuc0in/Ta8X51BphFV4PQNFsZBUnPOCBdnowbY25ZV0G79PjWDAxPbaeij4+9WwUrlmBXslKTeON0xeGvjwLZlxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767668033; c=relaxed/simple;
	bh=G4kkOerAOKeQ42Y3kv13+Xz43fNTcZlUQKGU5jZtPPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kIJ/yGWv1//s6qJ+0QBebwE2C8DNYiGuHvztllyKorfypAIBPA4n09bRmn4Bw/QeIxGiPeB7uGChTvZO2x89qzt1u60e7MDH4Up5HDCVy4epD5sw9YqsYIUMOk1+4ZOyRjdxgR6jz64+gn9Ux1M8uzBnYoXN0MuZOMRL+8oac/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bYRIlKBl; arc=none smtp.client-ip=220.197.32.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bYRIlKBl"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9c15540;
	Tue, 6 Jan 2026 10:18:20 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 03/18] mmc: dw_mmc: Remove SDMMC_INT_ERROR
Date: Tue,  6 Jan 2026 10:16:54 +0800
Message-Id: <1767665829-183001-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b91191d4009cckunmc69ba49b79ba5a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0xDS1ZJSUtPGkpJQxgfQ0xWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bYRIlKBlgTRemtOw2CQveoyYE+3tNFwzs2/Xt0ehSlhHc6Ki+wciddu+/AbW6s2kfUrFBTEReHWZ1WFFc+mJL6pE0ImK8962nCwKlSZGNajatKo31CV2Ee4CNDSFSsc2JvgkT/bYiy4twBsW8alzhyk3dkXRE9NUQrIRdkhSd6E=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=1mkrVjC652r3aucRpK39muWOdnZVMdglegAFZloH2SE=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

SDMMC_INT_ERROR is defined as 0xbfc2, which looks like a magic number and
it's never used, so remove it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index bf3566a..0ff301c 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -399,7 +399,6 @@ struct dw_mci_board {
 #define SDMMC_INT_CMD_DONE		BIT(2)
 #define SDMMC_INT_RESP_ERR		BIT(1)
 #define SDMMC_INT_CD			BIT(0)
-#define SDMMC_INT_ERROR			0xbfc2
 /* Command register defines */
 #define SDMMC_CMD_START			BIT(31)
 #define SDMMC_CMD_USE_HOLD_REG	BIT(29)
-- 
2.7.4

