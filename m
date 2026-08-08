Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46663238C2A
	for <linux-mmc@vger.kernel.org>; Sat,  8 Aug 2026 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194763; cv=none; b=EkzwiPB6cuYkwYwEK7c3Tcp5xPWGoHu0xeNr/8o4XW6K5HFqZF2j3RTzrrKYfQ1g17TOnYgJqJqa9yIiTkryS06uAY+X/dUSITytv1DNs/t3jB2bAj9w3MopxZ1qC91b8e9u0r+i/+g1uKQ9HNVUXAeFQ8Y4XSOiw6Yt2KVPZqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194763; c=relaxed/simple;
	bh=0RkGSSPYrRT1IpqJz6TOOHhnk0Arqfvbve27AfHa/zM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B9ifq4NgJ6XlbEcOBkBiblreFrB+6Q27vB4ImguC5Mpn3HdfHdD50lcO6LCtwPHpzP94P01JgUM+VOKPn4GxiXBqzJv200F1/SFwJ0TuH5sIZ4e2cq68dtpXZY6Vb2jXO5HTLBxsfx26C9UF7PKBvtz6dWfP8OCWRkiJMZjDIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mattbrocklehurst.co.uk; spf=pass smtp.mailfrom=mattbrocklehurst.co.uk; dkim=pass (2048-bit key) header.d=mattbrocklehurst.co.uk header.i=@mattbrocklehurst.co.uk header.b=G0XYqhjV; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mattbrocklehurst.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mattbrocklehurst.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mattbrocklehurst.co.uk header.i=@mattbrocklehurst.co.uk header.b="G0XYqhjV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mattbrocklehurst.co.uk;
	s=key1; t=1786194759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CgZ/KNbQrExUOX/XCANQlUe/sAFVueM4n2RThC/A9iQ=;
	b=G0XYqhjV3q9wrnFttmbdeoWh50nnKGwOdDBDsxxZXL9QNOCrqGnog+78WJfkVf+ozCxLnm
	vhfFizeNTbiAiljEWXaY46Z71nTU5MGIRoK5xMr0dSQTkN0pVBCu8Yand9JJR+hh0qjgpR
	0+DbaIVI+E22K44YBT0qHkALAl+LoLd9X7WM7cqYLsLnzPcAcFQBvdXP7EISZT9dixTZEA
	knZEmoSsTR7kawctVc3OB87ZvlIwKhpf2bixSffib91oM7ioGmw2yc/tcz0fLgDhmo3iVV
	JZw/sdcl2NsyalVouo69aKzH5nW4/ogMMa1N0+KAoEDl/E2GD0vLgD82Z49S7Q==
From: Matt Brocklehurst <matt@mattbrocklehurst.co.uk>
To: linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org,
	Matt Brocklehurst <matt@mattbrocklehurst.co.uk>
Subject: [PATCH] mmc: bcm2835: guard against host->data being NULL in bcm2835_finish_data()
Date: Sat,  8 Aug 2026 14:12:27 +0100
Message-Id: <20260808131227.23319-1-matt@mattbrocklehurst.co.uk>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

bcm2835_dma_complete_work() calls bcm2835_finish_data() unconditionally
from a workqueue once the DMA engine signals completion. But the same
transfer can also complete via the interrupt/status-poll path first
(bcm2835_finish_data() -> bcm2835_transfer_complete(), which sets
host->data = NULL) before that deferred DMA-completion callback gets
to run. When the DMA-completion path loses that race, host->data is
already NULL and the next line dereferences it unconditionally.

Hit this as a real NULL pointer dereference while bringing up BCM2836/
BCM2837 support in a downstream build system, confirmed live via a
kernel panic on the serial console:

  Unable to handle kernel NULL pointer dereference at virtual address 00000014
  PC is at bcm2835_finish_data+0x28/0x60
  ...
  bcm2835_finish_data from bcm2835_dma_complete_work+0xf8/0x124

This code path is only reachable once a DMA transfer actually
completes successfully, which is presumably why it hasn't surfaced
before on setups where DMA transfers complete quickly and reliably --
the race window is narrow. It is not specific to any particular SoC
or devicetree configuration; both bcm2835_finish_data() and
bcm2835_dma_complete_work() are unchanged from mainline, so any board
using this driver can hit it.

Signed-off-by: Matt Brocklehurst <matt@mattbrocklehurst.co.uk>
---
 drivers/mmc/host/bcm2835.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index ee63835..fbcdfac 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -717,6 +717,17 @@ static void bcm2835_finish_data(struct bcm2835_host *host)
 
 	data = host->data;
 
+	/*
+	 * host->data can already be NULL here: bcm2835_dma_complete_work()
+	 * calls this unconditionally from a workqueue, but the same
+	 * transfer may already have completed via the interrupt/status-poll
+	 * path (bcm2835_finish_data() -> bcm2835_transfer_complete(), which
+	 * sets host->data = NULL) before the deferred DMA-completion
+	 * callback runs.
+	 */
+	if (!data)
+		return;
+
 	host->hcfg &= ~(SDHCFG_DATA_IRPT_EN | SDHCFG_BLOCK_IRPT_EN);
 	writel(host->hcfg, host->ioaddr + SDHCFG);
 
-- 
2.39.5 (Apple Git-154)

