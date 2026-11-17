Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881270;
	b=Se/0uJb9FaJa0z8VP6iurhopF5iS/drhTcbZeweKK+lwgCP4vWZY2Gv80SAmgKZV3Flz
	 62jGcXdhxrLKWOTCtaQR6QIZKORTyqWXvwKIlH+rybYpaGNNLLp8MX9MY2I7YqFHKj72i
	 CWOKc6+ERaFo0kUzYDPqBQXWy6uE0gh5w8+IvHmA4kyT+pi2FFKlmHM1s/Dkj+pu250J6
	 8pc0O1LmNi5DZJDBK3lvUPWL9yTX20D2EzSsiX8y6GQQffqfoMJU06Vn8fUf+0DxLjEjO
	 VHDqpNDXb10LEpvvhoPqmXRdhQxkKMBatiyQNJPPl1Jdw208mxZU7oGEsESEtEy7YpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881270;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0aqdef+A3S0AoJl+8zueLzbSlQNp6YnEX03i+OBapQ0=;
	b=artI6pY1Yfqqjry4NLEsj2bFJzgdXMa+cSgxd0O8mRHGLS54EY57ECS2qUrd0ZWdxCdQ
	 hcSnWjFDLVIXtQ8a3CD+yB1oWYv3xnfwAO6cqVbPhCVgdx76Y6lezFwO6MNbSY+mSGDyT
	 WSMJaNeq24zeP9OnHBIAuhpyvW/KtLiTRvOhLH3wogKa6QHnjrTIjYk/pQdMhKPlkF49i
	 OUc0NFLvoBBGEK7R/lMhOhH5PNPFamBPTd0xY8bhYtDoHxBYAz+U4WGu6cj+l1dLSerBT
	 iPtTDtBqntGaO8LhLVETvnCCrcFkW2Xl8UOpoMBDj1t93Br35P5c49zwfYkQs2WHixg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=eFREfpg2;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F14606A31C
	for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2026 02:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2F14606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=eFREfpg2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=eFREfpg2qx5YE7Ur+HrG3/OnU6r9WX0hwvKsHhNo0FPBVbJeTduUQTPEuvn5LTmrSo70Z1kpV98FA
	 pIpMjOxEgGBIscdnWae3lrdffKBrQzAWZqfPCBnI2FRtD/hOUvXU+txAvBqHKzsNxy4SyLksuq4joL
	 z6jcr4KjzB3Ke2cw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76afbb6f3fa1-04d6a;
	Tue, 17 Nov 2026 10:07:48 +0800 (CST)
X-RM-TRANSID:2ee76afbb6f3fa1-04d6a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66afbb6f3de6-9f0f5;
	Tue, 17 Nov 2026 10:07:48 +0800 (CST)
X-RM-TRANSID:2ee66afbb6f3de6-9f0f5
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: Russell King <linux@armlinux.org.uk>,
	linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulfh@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mmc: mmci: handle clk_prepare_enable() failure on runtime resume
Date: Tue, 17 Nov 2026 10:07:51 +0800
Message-Id: <20261117020751.20250-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.24.4
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmci_runtime_resume() ignores the return value of clk_prepare_enable()
and then calls mmci_restore(), which writes to the controller registers.
If the clock cannot be enabled, the restore runs with the clock off and
the PM core never learns that the resume failed.

Return the error before touching the controller.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 drivers/mmc/host/mmci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f5ee793dda..16c8cf57fd 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2578,7 +2578,12 @@ static int mmci_runtime_resume(struct device *dev)
 
 	if (mmc) {
 		struct mmci_host *host = mmc_priv(mmc);
-		clk_prepare_enable(host->clk);
+		int ret;
+
+		ret = clk_prepare_enable(host->clk);
+		if (ret)
+			return ret;
+
 		mmci_restore(host);
 		pinctrl_select_default_state(dev);
 	}
-- 
2.24.4



