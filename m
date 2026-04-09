Received: from mail-m1973190.qiye.163.com (mail-m1973190.qiye.163.com [220.197.31.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AB5386576;
	Thu,  9 Apr 2026 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720931; cv=none; b=KF5GllMFrzLDy/aRpfXjNcRcCSZ/S2YLw5TAJe6YhlCXJsDic0XjOOR4e5ATDxmYAn7+G7qiErOlx5ymCpnXVz6WXbsn0/BmzHfC68UVaL0k8KyfoOFn3UU/KFtkWqNk4YY85YRW2c5Os+YQwFauJCCEMQafF7637ynVXylfAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720931; c=relaxed/simple;
	bh=BzOhoPZ0VBRVYeVdaFbzNrWq0HEPY4W0ycoe0M4CpG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cw37Hd7AAwawo6d+N5AEnoBkIsfmxkVhdHKBb6L7p/2IhTPo/bis5fheAc6SFkgoE4rgNmlK4EMPkqCKTClAPZk+x9imsnZ7F6ThFw+iQpH+1NrgV5B2YGi4Vxrj5XbpY68L9e0fHoOoOc7DLvEELjATKc+Fm4EP80Q9QlJ2lDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QY/n87v9; arc=none smtp.client-ip=220.197.31.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QY/n87v9"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3a14149e3;
	Thu, 9 Apr 2026 15:48:41 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/4] mmc: dw_mmc: Move misplaced comment
Date: Thu,  9 Apr 2026 15:48:12 +0800
Message-Id: <1775720894-97901-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1775720894-97901-1-git-send-email-shawn.lin@rock-chips.com>
References: <1775720894-97901-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9d7136f86e09cckunm41b60ef14ae55d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh1LTFYYH0MYGUoaTB8dSElWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QY/n87v9hVgrn19zK095l+lkEWRDBT+C914i23GdREIBNFm4/0B4J7iaZZPKpbYprR0DiaoVgNyZ7GrQ5fhZCrNyOFAXkzRYWn+Vt6IXfWHHf6WOjsGVbt+u99va57f5vPPlb7gsVRX4GEPXepA07eu3A0Rk6zjgPoskEeBfk50=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=xUJOorcH0rkIC+8Xhmh2ejYgA+Zrc9oNbwzUaiVJLh0=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

It was originally part of the @cmd_status field description but became
separated and now appears between @ring_size and @dms without proper context.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 42e58be..14fb2b3 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -78,8 +78,8 @@ struct dw_mci_dma_slave {
  * @sg_cpu: Virtual address of DMA buffer.
  * @dma_ops: Pointer to DMA callbacks.
  * @cmd_status: Snapshot of SR taken upon completion of the current
- * @ring_size: Buffer size for idma descriptors.
  *	command. Only valid when EVENT_CMD_COMPLETE is pending.
+ * @ring_size: Buffer size for idma descriptors.
  * @dms: structure of slave-dma private data.
  * @phy_regs: physical address of controller's register map
  * @data_status: Snapshot of SR taken upon completion of the current
-- 
2.7.4

