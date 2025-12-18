Received: from mail-m32105.qiye.163.com (mail-m32105.qiye.163.com [220.197.32.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D2E34C804
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066720; cv=none; b=l8QC6rH4BuXcodLoixm/g0c1FOCex/onpcAAp6inFDD/17cIP937h2u5cAVLcrQKVOj6op95VhQkrDstxxlmzJ81qkmbU4fMl7FhkiGG14WSsDmhWAAdbFUffNZu1iiGrGZBmdU924WfanP53h5b6XAoE14Q7wPuxUKCGqbveoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066720; c=relaxed/simple;
	bh=RlS/sgswt9vSHXek1GpszibhxsrpGhgzq1LovZmJsjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tx6iu0kqWOfhhRpq3ziBYL+LzF6wTkFMG8Ugo+o03XLJAGjJcx0ioJ5TlJ+xxfOyHzX3UC1DjDa6n33vpUeMyV1nxl2gmsSbx2YCOp/Qaoe0nSonIqKVY6s851RdxCbMFqCCkB4aHutbdIEvM5S4jlz2Xq+sEhB1qXuR9mmLzIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=EHrC0Dbn; arc=none smtp.client-ip=220.197.32.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="EHrC0Dbn"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb3f5;
	Thu, 18 Dec 2025 22:05:07 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 11/18] mmc: dw_mmc: Remove redundant struct mmc_data forward declaration
Date: Thu, 18 Dec 2025 22:00:38 +0800
Message-Id: <1766066445-14144-12-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c75a7809cckunm1f354c4b763e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR5KHlZISE5OHk1KGUtLGRpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=EHrC0DbnDUQGeiDmUNEJ77TtzXEklcira8PGGARGBwjdEBjWjBCEnKCpA2Ya1wem6MYJy2j+Frs668qnoUKd5wR/jlorPpsoFGOYYFF+BzD6wJZexRhOiSFLBRb12nEGsZioHiT5rZjXeJYTN5dWjw0PgHfo2sExwgYkGmi5rLE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=WGvMEBOZyOTM5z54NLTKdJVdsEfs253ki4Eg8G/NwAU=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The header file linux/mmc/core.h, which is already included in dw_mmc.h,
contains the forward declaration of struct mmc_data. There's no need to
redeclare it here.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 548ff51..647517a 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -43,8 +43,6 @@ enum dw_mci_cookie {
 	COOKIE_MAPPED,		/* mapped by prepare_data() of dwmmc */
 };
 
-struct mmc_data;
-
 enum {
 	TRANS_MODE_PIO = 0,
 	TRANS_MODE_IDMAC,
-- 
2.7.4

