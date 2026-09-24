Received: from mail-m49244.qiye.163.com (mail-m49244.qiye.163.com [45.254.49.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57D9238C36
	for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2026 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240199; cv=none; b=YAGQRaQS+t5QMRTPJvee+zvuImgp+z3y3n042PpCQI9pkNHkGqn+hir62IuZcofhyRh/tIxnlT5rtaWVx5HS4rtkBnbaB0QuELd7npYCwQRN1QRxBup1/bhji+/dZN0gf5P5tRun6RVtf02kTarZn3NTsZb/6rESDyXlZJ8OrCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240199; c=relaxed/simple;
	bh=/15NdDy5JBbKXXpEXf56SvRD3mfzL9wWGLM+iKx3tOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BnRLBD+JtI/35QylVqfYERU4x2PynfPM3Z+rSu30xRUM/PIMUFT+11xCpqyk9PvQRTkYu+bqJVVH9F+JkFbCrbIgAOdnLgMpWkHwN7gLJD8U0w5LYo/BOtXnWMRCloC7GbkaFZIeHD7ouC9nH77NsoU48qdC58lP44cjkmvy7Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=F0EVsE/D; arc=none smtp.client-ip=45.254.49.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="F0EVsE/D"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f01e1b9b;
	Thu, 24 Sep 2026 16:50:53 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/2] mmc: dw_mmc-rockchip: use a tighter per-command tuning timeout
Date: Thu, 24 Sep 2026 16:50:23 +0800
Message-Id: <1790239823-139583-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1790239823-139583-1-git-send-email-shawn.lin@rock-chips.com>
References: <1790239823-139583-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0d29c4a5c03a4kunm11feacd55405ff
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUpDSFYeHUhLSUxJTx
	lMGk5WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=F0EVsE/DdWQuIxPSmpyQ+PaH1eSB7OZpjUJjgqJKl0MICkJNHRg5X1KSHmYYbjSlp7kHCaaLrrz+N/IvbBko6vWbbx/LUwLqP1v2m6eviLLqdILtdGiYmfn9LZQxF2SbVeZEXlww74eJOgeZh9ekv02Kj5x3Sp4xGKOqwJjwlrk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=+nj5+tRCIA4j3XVHMniMQPIvm7tZysjqPVhHEgXS1Og=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

dw_mmc-rockchip's execute_tuning() scans the tuning window phase by phase
through mmc_send_tuning(), which applied the whole-sequence 150 ms
bound as the data timeout of every single CMD19/CMD21.  With HS200
eMMC the TMOUT register saturates at ~112 ms for the requested
150 ms, so every phase that misses the window stalls that long, and
multi-second boot slowdowns have been reported[1].

Use 5 ms per tuning command via mmc_send_tuning_timeout() instead:
~1.3x the spec-implied per-execution device budget (150 ms / 40 =
3.75 ms, excluding host overhead), 30x below the 150 ms ceiling, and
the reporter verified that tuning keeps passing with it.  A wrong
sampling phase normally fails fast with a CRC error anyway, so the
timeout only catches devices which never return the tuning block at
all.  This also bounds the cost of runtime re-tuning.

[1] Link: https://bugzilla.kernel.org/show_bug.cgi?id=221781
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2:
- Let drivers provide the timeout via a new mmc_send_tuning_timeout()
  instead of shortening the default for everybody, as suggested by
  Adrian, so it is less likely to cause a regression.
- Split into two patches; mmc_send_tuning() keeps its current
  behaviour (150 ms) and dw_mmc-rockchip opts in with 5 ms.

 drivers/mmc/host/dw_mmc-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 75c82ff..a07707a 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -327,7 +327,7 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci *host, u32 opcode)
 						i,
 						priv->num_phases));
 
-		v = !mmc_send_tuning(mmc, opcode, NULL);
+		v = !mmc_send_tuning_timeout(mmc, opcode, NULL, 5);
 
 		if (i == 0)
 			first_v = v;
-- 
2.7.4

