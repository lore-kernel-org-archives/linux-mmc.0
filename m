Received: from mail-m1973190.qiye.163.com (mail-m1973190.qiye.163.com [220.197.31.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A5335082
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066537; cv=none; b=OT7kg5BFPciy3EV4X0WZ0R0xD9J88Vrkx7hNYltO0Bp3SNBIwnF2jbGiKakSIsCrzShvdqT14mtVAKFMFeHIdhDeMpeE3YZCTpDgv9V9+n04TNCo/OBw2XEwKO1kbaOVmWhvlhoCgmOjYGQbnGlDyxLzuel1EFqavfnktoQkDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066537; c=relaxed/simple;
	bh=ESzXw++4avotKnZdbsZzQRiRUIh2jVsjqt3c67n+D8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Vq7YllGU6fU36D2gl9lmt+0dmwVzLM3HKHuhLX5gz7JYr5FAgSr87SkT4S5RR9sZeGojFsuBvIVJrG2YYRxUae29XPdaKe8MaoJjNVkgOK0qjB6CqaCslk5GZVF6lheKAAUWiZ7QVjZs+PNZALouMFmeMshCKfuTBa+TQumxlQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XZAEBFgC; arc=none smtp.client-ip=220.197.31.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XZAEBFgC"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb2aa;
	Thu, 18 Dec 2025 22:02:03 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 03/18] mmc: dw_mmc: Remove SDMMC_INT_ERROR
Date: Thu, 18 Dec 2025 22:00:30 +0800
Message-Id: <1766066445-14144-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c48c4409cckunm1f354c4b71d4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkweTVYYTUxITE0fT0JIS09WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XZAEBFgChsoCwEs3ycBrFI6I4qdSEK/dnJ9voYJhiOLeVNoPfP3GFxaLGy8LseOVNDsYm4DhSGSjEoLRgGoWDDN4b+53Tsqci5TLXvfuBhv+rXAbcEw7wxWgFo8Bc5dWL+pEMiyvu9y00GzgESiJ8kkITjGfEqyU+xHw1pmSiN0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=DYKPwPTSQVWnq6K/uW5iomHsh9uT9ExSAbEo9+2PqMU=;
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

 drivers/mmc/host/dw_mmc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 48f474b..99d492f 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -400,7 +400,6 @@ struct dw_mci_board {
 #define SDMMC_INT_CMD_DONE		BIT(2)
 #define SDMMC_INT_RESP_ERR		BIT(1)
 #define SDMMC_INT_CD			BIT(0)
-#define SDMMC_INT_ERROR			0xbfc2
 /* Command register defines */
 #define SDMMC_CMD_START			BIT(31)
 #define SDMMC_CMD_USE_HOLD_REG	BIT(29)
-- 
2.7.4

