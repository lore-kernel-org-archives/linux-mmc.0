Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F0409E16
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780475991; cv=none; b=onUVmFgzj2hiNHteE6IX0BIcVYe7Dd1zb8GS5gmbfpZyknou8S5Ac+KQBBVcUJQc/K7SlRyuR3REBdswCCV/CXJlxm3brK6lRhcxFxGVxpXNS8QQdlI/FZkQzi9Gw7ntLc8g0OKvJmBPkjY8UL1TrvzMqt7YKUJDM6e+LF0RbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780475991; c=relaxed/simple;
	bh=abgr73Y+jkDQxicrHGZxgKFSEjNBJ5yXtFdmrEpcBkU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=UH3RPFY/RBan8fJjubvIwCRJ//4InE9c3SwcMmL0rJwvk+BmJjBmpbmboHUEaQiDwdRMsJ+MfK/2qfSpD2jeNKxd8NJTdtCMeKn76XnG5Sx+tL26W1Qw5ZvLKay4VRqkoYvgKsZ2UY2gEf9XQul9W5cK4hNcdINiWW2D4TWrt5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=A1wwWNH3; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A1wwWNH3"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260603083947euoutp0100fcaa235fe69009fcfd40554b59448a~1hXoVQrgy1287012870euoutp01a
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 08:39:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260603083947euoutp0100fcaa235fe69009fcfd40554b59448a~1hXoVQrgy1287012870euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780475987;
	bh=XdmoD/JEVK+cBhEU8wr5frDfEpMWwUeIWfUAQqzRmag=;
	h=From:To:Cc:Subject:Date:References:From;
	b=A1wwWNH3c8BjzUxWrlwKPf/Cdkg8gzvnIyxRBxHeGRo45OR4QazdJjsio1he94TQP
	 /YIh0816QFKrmX7R5s2DzSVsaKuZn+u6u6r00kQzBgVPj0QBPIGPAiND/kQgG6GXKu
	 MzwMqQ6wQA01YBog2qeHuFYIG3Rz/+p45TuByLfI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260603083946eucas1p278014c7fb89fb7764abc7b0904d15e71~1hXoIxaYj2707527075eucas1p2D;
	Wed,  3 Jun 2026 08:39:46 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260603083946eusmtip2695124ef302ce36408a9620edd32fd31~1hXn3Wqs71768417684eusmtip2a;
	Wed,  3 Jun 2026 08:39:46 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-mmc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Jaehoon Chung
	<jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson
	<ulfh@kernel.org>
Subject: [PATCH] mmc: dw_mmc: stop and complete DMA also in STATE_DATA_BUSY
 state
Date: Wed,  3 Jun 2026 10:39:35 +0200
Message-Id: <20260603083935.3201411-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260603083946eucas1p278014c7fb89fb7764abc7b0904d15e71
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260603083946eucas1p278014c7fb89fb7764abc7b0904d15e71
X-EPHeader: CA
X-CMS-RootMailID: 20260603083946eucas1p278014c7fb89fb7764abc7b0904d15e71
References: <CGME20260603083946eucas1p278014c7fb89fb7764abc7b0904d15e71@eucas1p2.samsung.com>

When transfer was stopped in STATE_DATA_BUSY state, there was no call to
dma_ops->cleanup function, so the DMA mapped buffer was never properly
unmapped. Fix this by calling dw_mci_stop_dma() function also in that
state to ensure proper cleanup call when DMA transfer was used.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d734d010444d..cf5cecc5491d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2057,6 +2057,7 @@ static void dw_mci_work_func(struct work_struct *t)
 			}
 
 			dw_mci_stop_fault_timer(host);
+			dw_mci_stop_dma(host);
 			host->data = NULL;
 			set_bit(EVENT_DATA_COMPLETE, &host->completed_events);
 			err = dw_mci_data_complete(host, data);
-- 
2.34.1

