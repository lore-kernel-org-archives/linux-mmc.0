From: Dave Hansen <dave@sr71.net>
Subject: [PATCH 17/20] x86, mmc: use Intel family name macros for mmc driver
Date: Wed, 01 Jun 2016 17:12:21 -0700
Message-ID: <20160602001221.85C6DEC6@viggo.jf.intel.com>
References: <20160602001157.D8BE59D7@viggo.jf.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:18121 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103AbcFBAMW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 1 Jun 2016 20:12:22 -0400
In-Reply-To: <20160602001157.D8BE59D7@viggo.jf.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Dave Hansen <dave@sr71.net>, dave.hansen@linux.intel.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Another straightforward replacement of magic numbers.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
---

 b/drivers/mmc/host/sdhci-acpi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/mmc/host/sdhci-acpi.c~x86-intel-families-sdhci-acpi drivers/mmc/host/sdhci-acpi.c
--- a/drivers/mmc/host/sdhci-acpi.c~x86-intel-families-sdhci-acpi	2016-06-01 15:45:09.826201501 -0700
+++ b/drivers/mmc/host/sdhci-acpi.c	2016-06-01 15:45:09.830201683 -0700
@@ -43,6 +43,7 @@
 
 #ifdef CONFIG_X86
 #include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
 #include <asm/iosf_mbi.h>
 #endif
 
@@ -126,7 +127,7 @@ static const struct sdhci_acpi_chip sdhc
 static bool sdhci_acpi_byt(void)
 {
 	static const struct x86_cpu_id byt[] = {
-		{ X86_VENDOR_INTEL, 6, 0x37 },
+		{ X86_VENDOR_INTEL, 6, INTEL_FAM6_MODEL_ATOM_SILVERMONT1 },
 		{}
 	};
 
_
