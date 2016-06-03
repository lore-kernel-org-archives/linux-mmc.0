From: Dave Hansen <dave@sr71.net>
Subject: [PATCH 17/20] x86, mmc: use Intel family name macros for mmc driver
Date: Thu, 02 Jun 2016 17:19:51 -0700
Message-ID: <20160603001951.9EEA53D8@viggo.jf.intel.com>
References: <20160603001927.F2A7D828@viggo.jf.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160603001927.F2A7D828@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, jacob.jun.pan@intel.com, Dave Hansen <dave@sr71.net>, dave.hansen@linux.intel.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Another straightforward replacement of magic numbers.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
---

 b/drivers/mmc/host/sdhci-acpi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/mmc/host/sdhci-acpi.c~x86-intel-families-sdhci-acpi drivers/mmc/host/sdhci-acpi.c
--- a/drivers/mmc/host/sdhci-acpi.c~x86-intel-families-sdhci-acpi	2016-06-02 15:19:22.849424331 -0700
+++ b/drivers/mmc/host/sdhci-acpi.c	2016-06-02 15:19:22.854424559 -0700
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
+		{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_SILVERMONT1 },
 		{}
 	};
 
_
