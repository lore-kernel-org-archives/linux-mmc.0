Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83233A1686;
	Sun,  6 Sep 2026 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666012; cv=none; b=r5mKQ83aaaiYk3eCc1O7AyQ97CcMzssBrONvWXWf26TDieQ/08AKtHRjCuTt1+QVGjwcozghJjokfPz0Py9POyXvCMJbG94j7813UZsYsGByP6TXtAC3FlHBiqllNZIoSHPof+iUETGhES+cBkJEeZ9lWsd5vMsAoaqJXhkRz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666012; c=relaxed/simple;
	bh=Np9GYly2nmSibAY+wk35qs6DaaRAVSF3hTV1CwAWS4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xu9hy4OUGNnCbSf3MeV/tG8JSi8iDZ0UDfwh+bJoHkiH82sZjKJ3mroEzSw6xas1m77Nt4FLK7kp3ucc/UmqO+g8dQdw3/txpZUsStx4BT905+NM02TEFEqTRN1eIqYmJfI+heorbiOdnkVWzpPrSbfw3Y5wIBW0DWKje0Wz94A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oEFcLdoE; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oEFcLdoE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=y0
	vng9vkYi1q25axJmHlaaKW0UIEkdDmt30COI4tJ/Q=; b=oEFcLdoEGHT44fHFWz
	yY5adZpYI+ipwUaulgq8vNz9t8DylKGAFq93cAe0QLTMydYgVhvfwElVBXkIRzn7
	fBHBAJiwCkjc6L00LPyaXPcarC4jBBJYUhqgtxg7nZhwuhfK2nPiEsj17TshBaFj
	FqqC4eZcfgUqPdiZFEaRWEBC0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAnTRaF4Jxqpd1RAw--.1734S2;
	Sun, 06 Sep 2026 11:39:50 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Pengpeng Hou <hppiscas@163.com>,
	linux-mmc@vger.kernel.org,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-pci-gli: Fail runtime resume on PLL timeout
Date: Sun,  6 Sep 2026 11:39:47 +0800
Message-ID: <20260906033947.85078-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnTRaF4Jxqpd1RAw--.1734S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr18uF4fJF4rWw1ftFyDGFg_yoW8Cw4UpF
	s3XaykKrWxtayFvFn5Aa1vqr15Gw4jgrWDCFZ5uw18Zw1IvrWaqF42kFyUtFWvqFWfJ3ZF
	vF4qqFyUJrWjvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQYFZUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7QYb42qc4IanTAAA3o

gl9763e_runtime_resume() logs when the internal clock never becomes
stable but still enables the card clock and reports runtime-resume
success.

Return the poll timeout before enabling the card clock. Clear the
PLL-enable bit so a failed resume leaves the clock state matching runtime
suspend. Low-power negotiation remains enabled for the suspended device.

The issue was found by our static-analysis tool and manually reviewed.

Fixes: d607667bb8fa ("mmc: sdhci-pci-gli: Add runtime PM for GL9763E")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index b55618566d65..17717b54e08c 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1888,6 +1888,7 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
 	struct sdhci_pci_slot *slot = chip->slots[0];
 	struct sdhci_host *host = slot->host;
 	u16 clock;
+	int ret;
 
 	if (host->mmc->ios.power_mode != MMC_POWER_ON)
 		return 0;
@@ -1899,11 +1900,18 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
 	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
 
 	/* Wait max 150 ms */
-	if (read_poll_timeout(sdhci_readw, clock, (clock & SDHCI_CLOCK_INT_STABLE),
-			      1000, 150000, false, host, SDHCI_CLOCK_CONTROL)) {
+	ret = read_poll_timeout(sdhci_readw, clock,
+				(clock & SDHCI_CLOCK_INT_STABLE),
+				1000, 150000, false, host,
+				SDHCI_CLOCK_CONTROL);
+	if (ret) {
 		pr_err("%s: PLL clock never stabilised.\n",
 		       mmc_hostname(host->mmc));
 		sdhci_dumpregs(host);
+
+		clock &= ~SDHCI_CLOCK_PLL_EN;
+		sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
+		return ret;
 	}
 
 	clock |= SDHCI_CLOCK_CARD_EN;
-- 
2.50.1 (Apple Git-155)

