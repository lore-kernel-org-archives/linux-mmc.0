Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5490430DECE;
	Mon, 22 Jun 2026 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139848; cv=none; b=HHntBOBiH93qkQR78uAjU+g5geiiuKjHuwwbC9BeoOgRj/mbG90i6+e0QJj5sK4IwFxm+mvdJJZjDy2iu45h5lIYpqXkqyEsPUAoaUa+WCid7pBmDh3/KsceX7i0oHuF+h6YsAzLROrQNbNUgi77OQymjAg2fxh3A1Y6aG+fj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139848; c=relaxed/simple;
	bh=jLCZ5Q+WG37d2UWGkKNwwz178UNYpoMejkpuFDcwwwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g7/rcKOFPhNXPF5Mh2X+MKeoC9oCCBpniXY8CvdRLqHUoPEM5sxClOtdQ8tTDeXmccwLSE+8bMYP8SMhmo1iwYl6tmQoPv9U9kDa1gRA4fyjz99XfjD49jWDpBvx85+M8URdWKkkQVWde1SCe7yNZXBoTuiE5e6kl86/QjmtIvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=Z3xBT+sL; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="Z3xBT+sL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=7XuZyTV4r/3MI+BiVjkB7uEgYkvRfLQ7qW0kEe12To4=; b=Z3xBT+sLxCysc5
	jYuEmQHkD7lyFDqlw2X/A5TFRFevJNQbrR/VmylZ8VIgHBxjCEVIA6izjuzzpUekT6QZ0YJjcPE5l
	J/24ch0Jdp7rXJ22frUPk4m3uJNQo3wftuogsofii5Uesg7siX4YFYmsgjHNg+twGPsRCCx2PaHmT
	dzfS8eINj93gsf3Pmymwu7xbyJJIIq6SiWVikjNmNDoA/aVysV9U3LJoMHGEJ24pMuvD4x/OWtr46
	YJrrk55j8RiLwtZIwBNpgbLDlG4JAzFQyDniyBEl6I+Nu/wu8sQCBaRUfHwS/yhThTkYC8MDZKKli
	PP5RSlfXLxbQh7/KHLUg==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wbfyw-005E4w-3Q; Mon, 22 Jun 2026 15:50:38 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1wbfyv-000000029UU-3Ke2;
	Mon, 22 Jun 2026 15:50:37 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] mmc: cqhci: fix to missed endian conversions
Date: Mon, 22 Jun 2026 15:50:36 +0100
Message-Id: <20260622145036.513129-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

Fix two places where the wrong type or conversion of little-endian
types to fix the following sparse warnings:

drivers/mmc/host/cqhci-core.c:487:15: warning: incorrect type in assignment (different base types)
drivers/mmc/host/cqhci-core.c:487:15:    expected restricted __le32 [usertype]
drivers/mmc/host/cqhci-core.c:487:15:    got int
drivers/mmc/host/cqhci-core.c:566:19: warning: incorrect type in assignment (different base types)
drivers/mmc/host/cqhci-core.c:566:19:    expected unsigned long long [usertype] *task_desc
drivers/mmc/host/cqhci-core.c:566:19:    got restricted __le64 [usertype] *

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/mmc/host/cqhci-core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index 178277d90c31..00614b500b2b 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -484,11 +484,11 @@ void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
 {
 	__le32 *attr = (__le32 __force *)desc;
 
-	*attr = (CQHCI_VALID(1) |
-		 CQHCI_END(end ? 1 : 0) |
-		 CQHCI_INT(0) |
-		 CQHCI_ACT(0x4) |
-		 CQHCI_DAT_LENGTH(len));
+	*attr = cpu_to_le32((CQHCI_VALID(1) |
+			     CQHCI_END(end ? 1 : 0) |
+			     CQHCI_INT(0) |
+			     CQHCI_ACT(0x4) |
+			     CQHCI_DAT_LENGTH(len)));
 
 	if (dma64) {
 		__le64 *dataddr = (__le64 __force *)(desc + 4);
@@ -542,7 +542,7 @@ static int cqhci_prep_tran_desc(struct mmc_request *mrq,
 static void cqhci_prep_dcmd_desc(struct mmc_host *mmc,
 				   struct mmc_request *mrq)
 {
-	u64 *task_desc = NULL;
+	__le64 *task_desc = NULL;
 	u64 data = 0;
 	u8 resp_type;
 	u8 *desc;
@@ -574,7 +574,7 @@ static void cqhci_prep_dcmd_desc(struct mmc_host *mmc,
 		 CQHCI_CMD_TIMING(timing) | CQHCI_RESP_TYPE(resp_type));
 	if (cq_host->ops->update_dcmd_desc)
 		cq_host->ops->update_dcmd_desc(mmc, mrq, &data);
-	*task_desc |= data;
+	*task_desc |= cpu_to_le64(data);
 	desc = (u8 *)task_desc;
 	pr_debug("%s: cqhci: dcmd: cmd: %d timing: %d resp: %d\n",
 		 mmc_hostname(mmc), mrq->cmd->opcode, timing, resp_type);
-- 
2.37.2.352.g3c44437643

