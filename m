Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QotLXqrw"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708AC1B6;
	Tue,  5 Dec 2023 21:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=NtggG1InZAv0Tvwy1xVMHIpHvfsKvYI8PLGZB31GSbI=; b=QotLXqrwpRTYc2pzUE7UCK0QTo
	davewsxjMwpxIDTws2pUuJdEBN9MvrG1JCDi7YZC2foZ+0QbVj/5HIbSCK7xrLcjkjoPJ3ASZlrlA
	km7C5al91lIYfdF02LuFVTaZ9mzw26Kd49nqva99sf72F0p9MAfhQhpW2F5rtaR56PVJ/2QIuVhQF
	Q85cAbyP31UOPUYEbJYSCeqVl2jKN384ge2DxT+j6v4t5cdVtfJwBxN1biaD6SMBgtRKfvnY8SSlC
	jQrA28yeRsfFo2h21ZYvkljqSFrsA7cThNNOVJ69sZYrMRCEBvWTXboZ9rvErb9JxT/2Yot13ijb6
	Zykw5+nA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rAkvw-0098sn-0k;
	Wed, 06 Dec 2023 05:58:56 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-omap: don't misuse kernel-doc marker
Date: Tue,  5 Dec 2023 21:58:55 -0800
Message-ID: <20231206055855.21092-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use "/*" instead of "/**" for common C comments to prevent warnings
from scripts/kernel-doc.

sdhci-omap.c:3: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
sdhci-omap.c:3: warning: missing initial short description on line:
 * SDHCI Controller driver for TI's OMAP SoCs

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202311201117.lFxgJTK6-lkp@intel.com/
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
---
This does not Close the report since there are also some warnings for
missing-prototypes.

 drivers/mmc/host/sdhci-omap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * SDHCI Controller driver for TI's OMAP SoCs
  *
  * Copyright (C) 2017 Texas Instruments
