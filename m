Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54641C6FE2;
	Thu, 24 Apr 2025 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745517656; cv=none; b=quZkJCgGMFTdUSk7E3QqtdHdnFetJEBOOU1Um9h1sa8/O7FP0TRhcdu3OvJcGtBW1hHA6PFkgRm+gyboFwFESfDWVCVaD4jLWbl5d0VjJRujZCd1N0zdmC5pVaaqGVlFCFafI8Seq8O2MNDvWc+PMCdQLL9KkuVF8k7wplSWV/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745517656; c=relaxed/simple;
	bh=gzkngvgwo1+yiVsoemeib+OK3wRSllROc3wkRWwwMrk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plI6Z3YESiZOjMuYKb7x/1Zlv3fBuFNeTJJJ4vtFtU8oJo1bVIiPIU3PjebFRn3gWRRrjF8cW32UoFNwCezmk0PjqYJtG4+FLQGnw8byGdAYewO3E55+QyYopsco90xOgPyles87QSlkFGx4nlmSTX2BRkXC2VmWPX5cDjdembI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wOzMwm5q; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wOzMwm5q"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53OI0ar22714440
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745517637;
	bh=usREDAHEy8mK95/m5FMHSdapsRHpgRToMcYcZiXGFe4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wOzMwm5quTKWo9KgBmGWIMRvpXOuuLuRmtyllbwBStXHXzOvtPwN4g8w0GPPbgmoe
	 LmSNQc+cYFTgAbwuJ7RwqA1JwPZC6SLe1Cj30XF4YImeENorAGnY6xQFLV5ZHgO4/k
	 IHYsbh7XFnAe0G2F3WvpFVFj5+uyQRIkoQ6WJYbU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53OI0avu025494
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Apr 2025 13:00:36 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Apr 2025 13:00:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Apr 2025 13:00:36 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53OI0ac9054845;
	Thu, 24 Apr 2025 13:00:36 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf
 Hansson <ulf.hansson@linaro.org>
CC: Josua Mayer <josua@solid-run.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Francesco Dolcini
	<francesco@dolcini.it>,
        Hiago De Franco <hiagofranco@gmail.com>, Moteen Shah
	<m-shah@ti.com>
Subject: [PATCH v4 1/2] mmc: sdhci: Add a quirk for suppressing V1P8_SIGNAL_ENA
Date: Thu, 24 Apr 2025 13:00:35 -0500
Message-ID: <20250424180036.1541568-2-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424180036.1541568-1-jm@ti.com>
References: <20250424180036.1541568-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

There are init failures across Kingston eMMC and SD cards like Microcenter
and Patriot due to the sequence of when V1P8_SIGNAL_ENA is set. Since it
is not always required, add a quirk SDHCI_QUIRK2_SUPPRESS_V1P8_ENA which
allows users with init failures to suppress V1P8_SIGNAL_ENA.

Fixes: ac5a41b472b4 ("Revert "mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch"")
Fixes: 941a7abd4666 ("mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci.c | 8 +++++---
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fd5681d1e31f..ef66dede8d09 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2698,8 +2698,10 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		 * Enable 1.8V Signal Enable in the Host Control2
 		 * register
 		 */
-		ctrl |= SDHCI_CTRL_VDD_180;
-		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+		if (!(host->quirks2 & SDHCI_QUIRK2_SUPPRESS_V1P8_ENA)) {
+			ctrl |= SDHCI_CTRL_VDD_180;
+			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+		}
 
 		/* Some controller need to do more when switching */
 		if (host->ops->voltage_switch)
@@ -2707,7 +2709,7 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 
 		/* 1.8V regulator output should be stable within 5 ms */
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-		if (ctrl & SDHCI_CTRL_VDD_180)
+		if (ctrl & SDHCI_CTRL_VDD_180 || (host->quirks2 & SDHCI_QUIRK2_SUPPRESS_V1P8_ENA))
 			return 0;
 
 		pr_warn("%s: 1.8V regulator output did not become stable\n",
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cd0e35a80542..60e180456ccc 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -536,6 +536,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
 /* Issue CMD and DATA reset together */
 #define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER	(1<<19)
+/* Suppress setting V1P8_SIGNAL_ENA */
+#define SDHCI_QUIRK2_SUPPRESS_V1P8_ENA			(1<<20)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.49.0

