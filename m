Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A841885B0;
	Fri,  1 Nov 2024 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456094; cv=none; b=AemAuqHpY/jUCG0ErLTu8k4Px6oj65DEgwyEsb67FqT+Vpob4LVSOUcLStry++OofPuxSa6VENtsSlOyldqAbhvwjPkCHsqodSLRSfEi8l7FVKyISV8falxy/cDA93OrO3FxCGk8l7EgwlH6Lu1LF2qQ6fG+EB60d2JU8UiOWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456094; c=relaxed/simple;
	bh=bHJR8SM95eGim0uQIvrzDUF6VWp5MUoPqulcvUcx1GQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1cjAtyWXqF67uIs0rNh/0+HB+si4buBMlQz+ub8IWXW1PlHj+rPiblqCkLQDOqsuIOSVYFcV2WaPXZ4I0X8dR5abcJUkpRf4RQbamh2N4XYP69OZf9D1NxMR+19/V2CpXWQAKJaO6Is3BeXCw1OKvnnHdEOWxdWIbj5Q/hW9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAeNOTzh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAeNOTzh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730456092; x=1761992092;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=bHJR8SM95eGim0uQIvrzDUF6VWp5MUoPqulcvUcx1GQ=;
  b=IAeNOTzhY49/U83O+Fj0nKCoyOG/p91/YRsbPsQC3U2jddITqOmwYqtw
   EbhKbE8O8y8ZsPYGFvyLsFXfiMZZZiO0TbA2T2nABTPKnRscLHkty046Q
   1RC7oAuutZ6+OReDmCvdx2S1KhrkqXxx7z+WenvqPKlkPx0BVV6HXmh1Q
   vAEAafVpn9W+8dj/OpBKEA3UyA8pbfgvc3hMip5n0caWhYD+KwXnexdbv
   UtSYUVXvBDODKVqQuxjcOhLQudukmEaMLd4JvA6F28T2R/NYn3FAAFPEu
   s23P4Koep7hhntKcof5JTDXcoD5oh8vg+DFXjsumT5b47gro+LiIeQLQ1
   Q==;
X-CSE-ConnectionGUID: 1ymS2PVKT2Kzk1OV/b4zIw==
X-CSE-MsgGUID: nOb9I6eZT/amuI/kb6mZxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41319320"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41319320"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 03:14:50 -0700
X-CSE-ConnectionGUID: tc/e7HAwRheFgO4+/uctqg==
X-CSE-MsgGUID: Rb3ip6b4THW6jI26P96O2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83355133"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 01 Nov 2024 03:14:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E329D3AD; Fri, 01 Nov 2024 12:14:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] mmc: sdhci-acpi: Don't use "proxy" headers
Date: Fri,  1 Nov 2024 12:11:36 +0200
Message-ID: <20241101101441.3518612-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use) principle.
While at it, sort them alphabetically for better maintenance.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index c931f506c1b0..fcb69a509c1e 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -5,27 +5,30 @@
  * Copyright (c) 2012, Intel Corporation.
  */
 
+#include <linux/acpi.h>
 #include <linux/bitfield.h>
-#include <linux/init.h>
-#include <linux/export.h>
-#include <linux/module.h>
+#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmi.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-#include <linux/dma-mapping.h>
-#include <linux/compiler.h>
-#include <linux/stddef.h>
-#include <linux/bitops.h>
-#include <linux/types.h>
-#include <linux/err.h>
-#include <linux/interrupt.h>
-#include <linux/acpi.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
-#include <linux/delay.h>
-#include <linux/dmi.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/pm.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac

