Received: from mail-m19731112.qiye.163.com (mail-m19731112.qiye.163.com [220.197.31.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B931A9FB7;
	Mon, 14 Sep 2026 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349031; cv=none; b=IeGpHjBeBUdorhEq7oftg3B/JAx2bqx2V/+VpDGpADHe4hqh5bl+VZm0R6MfP+hZR4QlNJhz71IHe1Uuwc4j8d9AlTv0dIYZuuZ+N9G0qqyuYAE2CFJc4kkyzn+0Xc6bBZg+rfBJsd5SnM/PtAclIDf2CgwEy2kXp8WPDKenoZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349031; c=relaxed/simple;
	bh=DoK3PSbnvzbJNEeuCFk76avKpntNOebSWFH/LNMbQdg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Kegw1L3o4AAhBCyTQKRKgGlMi2XkcEoEfrTr5ZK0rJkFK2dJBmirFTpdVUwOey8luzi0QV0IXj2ACqUtAun5dR7GWCIFFMl6/eU3xYqZXgOPTZkIb1mvG4EWYDCP4lWdfnH6TUdeGtFbfBApyYsFEdKnC7i1KICtCTAR9Y4Wk0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QmUrbFiR; arc=none smtp.client-ip=220.197.31.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QmUrbFiR"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d986fd02;
	Mon, 14 Sep 2026 09:08:23 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc: remove unused slot member
Date: Mon, 14 Sep 2026 09:08:11 +0800
Message-Id: <1789348091-82037-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa09d7543b703a4kunm62deee21766be1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQhlOGVZIS0MdTB1OHU
	oeHx5WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QmUrbFiRcQDGcq43moojcOn7ocjdpo0JMcvb2OOBKdh3w6ENPyZXdo4l3JMTXDPiiOxNGni5deF621qVgss+VtNPG/8Bwuu+3QcuuTPd3thz8Kqq2htdjL+C8AF5v4fVPYbFBm62+XnfdphvaqtYzhgxObduWD2+GmPaz4CDuiA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=z2lLEPxaF2NstOTgNKXHpu/DEv8emyLONw0g4ZKJgmY=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

struct dw_mci_slot does not exist anymore and nothing ever references
host->slot; the member is a leftover from the multi-slot design this
driver was upstreamed with, where the slot struct lived in the same
header.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 12b88e7..f4695a1 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -216,7 +216,6 @@ struct dw_mci {
 	void			*priv;
 	struct clk		*biu_clk;
 	struct clk		*ciu_clk;
-	struct dw_mci_slot	*slot;
 
 	/* FIFO push and pull */
 	int			fifo_depth;
-- 
2.7.4

