Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DC12773E4;
	Fri, 20 Mar 2026 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044146; cv=none; b=mv7AD1KEpwA/GT10phLBlKo3IjAFnusYm7CDZCFU0Y5GATjiXLBjX12puhTKL8QKkxU5ay0XpYyUHOyRlGOhYQ2WpDv94aXbfBObONgx6zYOWAID5xcondcPcyz1XE3H6Z8Qrz0nZZr2ZUZ8mP1l9Ljlhdg7EZgPVBFSO0dQows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044146; c=relaxed/simple;
	bh=Kt6uqnOvH1snK9b65ZFDE11Lknt1ncN6H6hjFZt0zNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmlw/lZAtAOE5kHCPpMIC6xwp6QM7M/1uEUY19PN9C8gqMiI8JyICFOsFb52fI6RDO0Z6eFlaj+XL1pyGujV2xX2Vp6zon4b7ylT6AsoHyALIvx9scRbjfJx4dt+qzYDwb9bHFAZf4SYJPaL2r5TJm6MjLoPjJQVSDgw6xVvCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYJD8Pb8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYJD8Pb8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774044146; x=1805580146;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kt6uqnOvH1snK9b65ZFDE11Lknt1ncN6H6hjFZt0zNY=;
  b=gYJD8Pb8FZlCl5pniW3vkadIDEBJyh/ZIRTQTaZS7WVcpG94Uw0yKXSA
   O2oIJuHWkr+dPBzMaIyReOS9g1IEDAyltTjdgWgBpjWcmOF37CGgwh6+x
   KD+EVI0dulvGpQZ9DZqTf+QKThG2bvKNfUviUvVkvsMc1K86e7VJp0U+p
   xsGBtiP7jB32PNXDorwLZDSFZrSi4AtrsuBatPfm0JjESDGq0xD6rrLPL
   n/C1v0AOPjMri16zJUpbmq85JIPh9pc4decE1IAC+eiWBdUi1dVI3jaRU
   XMCtX5vXdDs1MV/6Cyz/dsiJya9CwvHYcjcKK1z3HTFb1PpMYjPAtwzhn
   Q==;
X-CSE-ConnectionGUID: P7msUDUETGmKBAa829CjrA==
X-CSE-MsgGUID: 6McIoQ01THimNIzpFnjA+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="62698219"
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="62698219"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 15:02:25 -0700
X-CSE-ConnectionGUID: pQSbgEgDTDuTWcJ4NjeDmw==
X-CSE-MsgGUID: WrV1Y9KbQUOAUDz4lU8Fqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="261301883"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2026 15:02:23 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 1879295; Fri, 20 Mar 2026 23:02:22 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mmc: sdhci-pci: Drop unused include
Date: Fri, 20 Mar 2026 23:02:21 +0100
Message-ID: <20260320220221.3236937-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver includes the legacy header <linux/gpio.h> but does
not use any symbols from it. Drop the inclusion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 47a0a738862b..c347fac24515 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -20,7 +20,6 @@
 #include <linux/scatterlist.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-#include <linux/gpio.h>
 #include <linux/gpio/machine.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
-- 
2.50.1

