Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4479F377004;
	Tue, 23 Jun 2026 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210248; cv=none; b=dNcMk51ikVZMSsThi+p/N8n6RWbN0VajKJFsLdDdkh60ktOXrVBa7f0WJqCFhQoJ+O8oFSxL/z22IWtXyAOpIPlw680ezGlq95PwHMNlukSJ3GpJ48nMvHLzQd74hPJP194kABKG1tNZ1WDTB3q2Bh6NNN2gmBLY+1CrgFRcLLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210248; c=relaxed/simple;
	bh=hzn60j+bV1xB2sZWmjYGVSK8Qjepi5Kq1MoULo1Ovsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n+8yLzKm16+JkqwtoYsbVp46WX24dsTFY4IzG6N2gN+i0dlIaVDXt/TA2nCryqqAU4klBJYhf2oLPNu+C+BJnJbz1Bfbpc+6ouEEYkwKMr2A5R8+s870H6hvubcPT2Koo+djlhqHupxxForZlPQJYg9L+rEXE9G32Q9swYFFQLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=lKJyu/Dc; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="lKJyu/Dc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=8GupHJw8tGiCowTRM/q7UB1PA0+bxdnj3/yxxP0497g=; b=lKJyu/Dcd2jVgo
	hyQGeCEelvFRTAu7QBCC7hiiFVBCiLNW4w2l9Ul45xHqkqVFeJlFIN3VHMD/UqQayjQHF2Ocukrck
	aQIFb0suYgvH9y54vqqGgnhLGG8EyVIB1lY1g5dPHSiA+d6KNDFHnmNIsMykg3pK5ZuRr5ByD6LnN
	eaajJJZd/mM9Npw0apGPX9vCjqMezNqCHjzRknh9yItqmq3X+tcSSKeSWZph6WPNZumlmeMvNYLkM
	GlJfsqXDmjI4Y6tnGDk/03Xfk3Nb0LM/JfnoJYnbGLnGJAjEjSLTeSLRCOfW44GQRB/yBFeiPO3lQ
	lua8sGax3xqBhhsuoMtg==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wbyIM-00FtiL-OJ; Tue, 23 Jun 2026 11:23:54 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1wbyIM-00000003ATQ-1uEJ;
	Tue, 23 Jun 2026 11:23:54 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] mmc: dw_mmc: add declaration of dw_mci_pmops
Date: Tue, 23 Jun 2026 11:23:53 +0100
Message-Id: <20260623102353.755235-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The dw_mci_pmops is exported out of dw_mmc.c so add a declaration of
it in dw_mmc.h to fix the following sparse warning:

drivers/mmc/host/dw_mmc.c:3512:25: warning: symbol 'dw_mci_pmops' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/mmc/host/dw_mmc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 9ffcd3946cff..38610c89d54a 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -19,6 +19,8 @@
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
 
+extern const struct dev_pm_ops dw_mci_pmops;
+
 enum dw_mci_state {
 	STATE_IDLE = 0,
 	STATE_SENDING_CMD,
-- 
2.37.2.352.g3c44437643

