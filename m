From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH v1 1/1]sdhci-pxa: init_sdh for different platform
Date: Thu, 18 Nov 2010 15:42:00 +0800
Message-ID: <AANLkTinccZKV0trj602o=yQ-W12097dfTP30GWeXwVB3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf30433fa4dc478704954eec00
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39892 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023Ab0KRHmC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Nov 2010 02:42:02 -0500
Received: by fxm6 with SMTP id 6so1333095fxm.19
        for <linux-mmc@vger.kernel.org>; Wed, 17 Nov 2010 23:42:00 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

--20cf30433fa4dc478704954eec00
Content-Type: text/plain; charset=ISO-8859-1

Different platform will provide different init_sdh to handle private
register is not same in various platform.
Put init_sdh in set_clock is we don't want to add more call back
function to sdhci.c to keep sdhci.c as simple as possible.
Currently init_sdh will be called several times when clk is changed:
insert, 2 times; remove: 4 times.
After clk_gating in MMC stack is enabled, set_clock will send clock=0,
and then init_sdh will only called only once as well as enable_clk.

>From c1abef994120536f9f0498293afeebf5412f22f6 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Thu, 18 Nov 2010 01:22:23 -0500
Subject: [PATCH] sdhci-pxa: init_sdh for different platform

	The sdhci-pxa ip is same, but may be different version among
different platforms, as a result private register have different
address.
	Provide init_sdh in arch/arm/mach to move the difference to platform code.

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 arch/arm/mach-mmp/include/mach/mmp2_sdh.h |   58 +++++++++++++++++++++++++++++
 arch/arm/plat-pxa/include/plat/sdhci.h    |    6 +++
 drivers/mmc/host/sdhci-pxa.c              |   34 +----------------
 3 files changed, 66 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/mmp2_sdh.h

diff --git a/arch/arm/mach-mmp/include/mach/mmp2_sdh.h
b/arch/arm/mach-mmp/include/mach/mmp2_sdh.h
new file mode 100644
index 0000000..c1d4a80
--- /dev/null
+++ b/arch/arm/mach-mmp/include/mach/mmp2_sdh.h
@@ -0,0 +1,58 @@
+/* linux/arch/arm/mach-mmp/include/mach/mmp2_sdh.h
+ *
+ * Copyright 2010 Marvell
+ *	Zhangfei Gao <zhangfei.gao@marvell.com>
+ *
+ * MMP2 Platform - sepcific sdh function
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MMP2_SDH_H
+#define __MMP2_SDH_H
+
+#include <linux/mmc/sdhci.h>
+#include <plat/sdhci.h>
+#include <linux/io.h>
+
+#define SD_FIFO_PARAM		0x104
+#define DIS_PAD_SD_CLK_GATE	0x400
+
+#define SD_CLOCK_AND_BURST_SIZE_SETUP		0x10A
+#define SDCLK_SEL	0x100
+#define SDCLK_DELAY_SHIFT	9
+#define SDCLK_DELAY_MASK	0x1f
+
+inline void mmp2_init_sdh(struct sdhci_host *host,
+			struct sdhci_pxa_platdata *pdata)
+{
+	/*
+	 * tune timing of read data/command when crc error happen
+	 * no performance impact
+	 */
+	if (pdata && 0 != pdata->clk_delay_cycles) {
+		u16 tmp;
+
+		tmp = readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+		tmp |= (pdata->clk_delay_cycles & SDCLK_DELAY_MASK)
+					<< SDCLK_DELAY_SHIFT;
+		tmp |= SDCLK_SEL;
+		writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+	}
+
+	/*
+	 * disable clock gating per some cards requirement
+	 */
+
+	if (pdata && pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
+		u32 tmp = 0;
+
+		tmp = readl(host->ioaddr + SD_FIFO_PARAM);
+		tmp |= DIS_PAD_SD_CLK_GATE;
+		writel(tmp, host->ioaddr + SD_FIFO_PARAM);
+	}
+}
+
+#endif /* __MMP2_SDH_H */
diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
b/arch/arm/plat-pxa/include/plat/sdhci.h
index f6f46db..a3a08db 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -13,6 +13,8 @@
 #ifndef __PLAT_PXA_SDHCI_H
 #define __PLAT_PXA_SDHCI_H

+#include <linux/mmc/sdhci.h>
+
 /* pxa specific flag */
 /* Require clock free running */
 #define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
@@ -25,12 +27,16 @@
  * @quirks: quirks of specific device
  * @flags: flags for platform requirement
  * @clk_delay_cycles: 1 ~ 0x1f, each step is roughly 100ps, for tuning timing
+ * @init_sdh: init function for specific card
  */
 struct sdhci_pxa_platdata {
 	unsigned int	max_speed;
 	unsigned int	quirks;
 	unsigned int	flags;
 	unsigned int	clk_delay_cycles;
+
+	void (*init_sdh)(struct sdhci_host *host,
+			struct sdhci_pxa_platdata *pdata);
 };

 #endif /* __PLAT_PXA_SDHCI_H */
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 2b665e4..d628dcc 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -29,14 +29,6 @@

 #define DRIVER_NAME	"sdhci-pxa"

-#define SD_FIFO_PARAM		0x104
-#define DIS_PAD_SD_CLK_GATE	0x400
-
-#define SD_CLOCK_AND_BURST_SIZE_SETUP		0x10A
-#define SDCLK_SEL	0x100
-#define SDCLK_DELAY_SHIFT	9
-#define SDCLK_DELAY_MASK	0x1f
-
 struct sdhci_pxa {
 	struct sdhci_host		*host;
 	struct sdhci_pxa_platdata	*pdata;
@@ -51,29 +43,11 @@ struct sdhci_pxa {
  * SDHCI core callbacks                                                      *
  *                                                                           *
 \*****************************************************************************/
-static inline void tune_timing(struct sdhci_host *host,
-				struct sdhci_pxa_platdata *pdata)
-{
-	/*
-	 * tune timing of read data/command when crc error happen
-	 * no performance impact
-	 */
-	if (pdata && 0 != pdata->clk_delay_cycles) {
-		u16 tmp;
-
-		tmp = readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
-		tmp |= (pdata->clk_delay_cycles & SDCLK_DELAY_MASK)
-					<< SDCLK_DELAY_SHIFT;
-		tmp |= SDCLK_SEL;
-		writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
-	}
-}

 static void set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pxa *pxa = sdhci_priv(host);
 	struct sdhci_pxa_platdata *pdata = pxa->pdata;
-	u32 tmp = 0;

 	if (clock == 0) {
 		if (pxa->clk_enable) {
@@ -81,12 +55,8 @@ static void set_clock(struct sdhci_host *host,
unsigned int clock)
 			pxa->clk_enable = 0;
 		}
 	} else {
-		tune_timing(host, pdata);
-		if (pdata && pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
-			tmp = readl(host->ioaddr + SD_FIFO_PARAM);
-			tmp |= DIS_PAD_SD_CLK_GATE;
-			writel(tmp, host->ioaddr + SD_FIFO_PARAM);
-		}
+		if (pdata && pdata->init_sdh)
+			pdata->init_sdh(host, pdata);
 		clk_enable(pxa->clk);
 		pxa->clk_enable = 1;
 	}
-- 
1.7.0.4

--20cf30433fa4dc478704954eec00
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-sdhci-pxa-init_sdh-for-different-platform.patch"
Content-Disposition: attachment;
	filename="0001-sdhci-pxa-init_sdh-for-different-platform.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ggndzd5i0

RnJvbSBjMWFiZWY5OTQxMjA1MzZmOWYwNDk4MjkzYWZlZWJmNTQxMmYyMmY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogVGh1LCAxOCBOb3YgMjAxMCAwMToyMjoyMyAtMDUwMApTdWJqZWN0OiBbUEFUQ0hd
IHNkaGNpLXB4YTogaW5pdF9zZGggZm9yIGRpZmZlcmVudCBwbGF0Zm9ybQoKCVRoZSBzZGhjaS1w
eGEgaXAgaXMgc2FtZSwgYnV0IG1heSBiZSBkaWZmZXJlbnQgdmVyc2lvbiBhbW9uZyBkaWZmZXJl
bnQgcGxhdGZvcm1zLCBhcyBhIHJlc3VsdCBwcml2YXRlIHJlZ2lzdGVyIGhhdmUgZGlmZmVyZW50
IGFkZHJlc3MuCglQcm92aWRlIGluaXRfc2RoIGluIGFyY2gvYXJtL21hY2ggdG8gbW92ZSB0aGUg
ZGlmZmVyZW5jZSB0byBwbGF0Zm9ybSBjb2RlLgoKU2lnbmVkLW9mZi1ieTogWmhhbmdmZWkgR2Fv
IDx6aGFuZ2ZlaS5nYW9AbWFydmVsbC5jb20+Ci0tLQogYXJjaC9hcm0vbWFjaC1tbXAvaW5jbHVk
ZS9tYWNoL21tcDJfc2RoLmggfCAgIDU4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBh
cmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2RoY2kuaCAgICB8ICAgIDYgKysrCiBkcml2
ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jICAgICAgICAgICAgICB8ICAgMzQgKy0tLS0tLS0tLS0t
LS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKSwgMzIgZGVsZXRpb25zKC0p
CiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vbWFjaC1tbXAvaW5jbHVkZS9tYWNoL21tcDJf
c2RoLmgKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW1tcC9pbmNsdWRlL21hY2gvbW1wMl9z
ZGguaCBiL2FyY2gvYXJtL21hY2gtbW1wL2luY2x1ZGUvbWFjaC9tbXAyX3NkaC5oCm5ldyBmaWxl
IG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLmMxZDRhODAKLS0tIC9kZXYvbnVsbAorKysgYi9h
cmNoL2FybS9tYWNoLW1tcC9pbmNsdWRlL21hY2gvbW1wMl9zZGguaApAQCAtMCwwICsxLDU4IEBA
CisvKiBsaW51eC9hcmNoL2FybS9tYWNoLW1tcC9pbmNsdWRlL21hY2gvbW1wMl9zZGguaAorICoK
KyAqIENvcHlyaWdodCAyMDEwIE1hcnZlbGwKKyAqCVpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2Fv
QG1hcnZlbGwuY29tPgorICoKKyAqIE1NUDIgUGxhdGZvcm0gLSBzZXBjaWZpYyBzZGggZnVuY3Rp
b24KKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3Ry
aWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKKyAqIHB1Ymxpc2hlZCBieSB0aGUg
RnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorICovCisKKyNpZm5kZWYgX19NTVAyX1NESF9ICisj
ZGVmaW5lIF9fTU1QMl9TREhfSAorCisjaW5jbHVkZSA8bGludXgvbW1jL3NkaGNpLmg+CisjaW5j
bHVkZSA8cGxhdC9zZGhjaS5oPgorI2luY2x1ZGUgPGxpbnV4L2lvLmg+CisKKyNkZWZpbmUgU0Rf
RklGT19QQVJBTQkJMHgxMDQKKyNkZWZpbmUgRElTX1BBRF9TRF9DTEtfR0FURQkweDQwMAorCisj
ZGVmaW5lIFNEX0NMT0NLX0FORF9CVVJTVF9TSVpFX1NFVFVQCQkweDEwQQorI2RlZmluZSBTRENM
S19TRUwJMHgxMDAKKyNkZWZpbmUgU0RDTEtfREVMQVlfU0hJRlQJOQorI2RlZmluZSBTRENMS19E
RUxBWV9NQVNLCTB4MWYKKworaW5saW5lIHZvaWQgbW1wMl9pbml0X3NkaChzdHJ1Y3Qgc2RoY2lf
aG9zdCAqaG9zdCwKKwkJCXN0cnVjdCBzZGhjaV9weGFfcGxhdGRhdGEgKnBkYXRhKQoreworCS8q
CisJICogdHVuZSB0aW1pbmcgb2YgcmVhZCBkYXRhL2NvbW1hbmQgd2hlbiBjcmMgZXJyb3IgaGFw
cGVuCisJICogbm8gcGVyZm9ybWFuY2UgaW1wYWN0CisJICovCisJaWYgKHBkYXRhICYmIDAgIT0g
cGRhdGEtPmNsa19kZWxheV9jeWNsZXMpIHsKKwkJdTE2IHRtcDsKKworCQl0bXAgPSByZWFkdyho
b3N0LT5pb2FkZHIgKyBTRF9DTE9DS19BTkRfQlVSU1RfU0laRV9TRVRVUCk7CisJCXRtcCB8PSAo
cGRhdGEtPmNsa19kZWxheV9jeWNsZXMgJiBTRENMS19ERUxBWV9NQVNLKQorCQkJCQk8PCBTRENM
S19ERUxBWV9TSElGVDsKKwkJdG1wIHw9IFNEQ0xLX1NFTDsKKwkJd3JpdGV3KHRtcCwgaG9zdC0+
aW9hZGRyICsgU0RfQ0xPQ0tfQU5EX0JVUlNUX1NJWkVfU0VUVVApOworCX0KKworCS8qCisJICog
ZGlzYWJsZSBjbG9jayBnYXRpbmcgcGVyIHNvbWUgY2FyZHMgcmVxdWlyZW1lbnQKKwkgKi8KKwor
CWlmIChwZGF0YSAmJiBwZGF0YS0+ZmxhZ3MgJiBQWEFfRkxBR19ESVNBQkxFX0NMT0NLX0dBVElO
RykgeworCQl1MzIgdG1wID0gMDsKKworCQl0bXAgPSByZWFkbChob3N0LT5pb2FkZHIgKyBTRF9G
SUZPX1BBUkFNKTsKKwkJdG1wIHw9IERJU19QQURfU0RfQ0xLX0dBVEU7CisJCXdyaXRlbCh0bXAs
IGhvc3QtPmlvYWRkciArIFNEX0ZJRk9fUEFSQU0pOworCX0KK30KKworI2VuZGlmIC8qIF9fTU1Q
Ml9TREhfSCAqLwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3Nk
aGNpLmggYi9hcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2RoY2kuaAppbmRleCBmNmY0
NmRiLi5hM2EwOGRiIDEwMDY0NAotLS0gYS9hcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQv
c2RoY2kuaAorKysgYi9hcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2RoY2kuaApAQCAt
MTMsNiArMTMsOCBAQAogI2lmbmRlZiBfX1BMQVRfUFhBX1NESENJX0gKICNkZWZpbmUgX19QTEFU
X1BYQV9TREhDSV9ICiAKKyNpbmNsdWRlIDxsaW51eC9tbWMvc2RoY2kuaD4KKwogLyogcHhhIHNw
ZWNpZmljIGZsYWcgKi8KIC8qIFJlcXVpcmUgY2xvY2sgZnJlZSBydW5uaW5nICovCiAjZGVmaW5l
IFBYQV9GTEFHX0RJU0FCTEVfQ0xPQ0tfR0FUSU5HICgxPDwwKQpAQCAtMjUsMTIgKzI3LDE2IEBA
CiAgKiBAcXVpcmtzOiBxdWlya3Mgb2Ygc3BlY2lmaWMgZGV2aWNlCiAgKiBAZmxhZ3M6IGZsYWdz
IGZvciBwbGF0Zm9ybSByZXF1aXJlbWVudAogICogQGNsa19kZWxheV9jeWNsZXM6IDEgfiAweDFm
LCBlYWNoIHN0ZXAgaXMgcm91Z2hseSAxMDBwcywgZm9yIHR1bmluZyB0aW1pbmcKKyAqIEBpbml0
X3NkaDogaW5pdCBmdW5jdGlvbiBmb3Igc3BlY2lmaWMgY2FyZAogICovCiBzdHJ1Y3Qgc2RoY2lf
cHhhX3BsYXRkYXRhIHsKIAl1bnNpZ25lZCBpbnQJbWF4X3NwZWVkOwogCXVuc2lnbmVkIGludAlx
dWlya3M7CiAJdW5zaWduZWQgaW50CWZsYWdzOwogCXVuc2lnbmVkIGludAljbGtfZGVsYXlfY3lj
bGVzOworCisJdm9pZCAoKmluaXRfc2RoKShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwKKwkJCXN0
cnVjdCBzZGhjaV9weGFfcGxhdGRhdGEgKnBkYXRhKTsKIH07CiAKICNlbmRpZiAvKiBfX1BMQVRf
UFhBX1NESENJX0ggKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMg
Yi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jCmluZGV4IDJiNjY1ZTQuLmQ2MjhkY2MgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMKKysrIGIvZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS1weGEuYwpAQCAtMjksMTQgKzI5LDYgQEAKIAogI2RlZmluZSBEUklWRVJfTkFN
RQkic2RoY2ktcHhhIgogCi0jZGVmaW5lIFNEX0ZJRk9fUEFSQU0JCTB4MTA0Ci0jZGVmaW5lIERJ
U19QQURfU0RfQ0xLX0dBVEUJMHg0MDAKLQotI2RlZmluZSBTRF9DTE9DS19BTkRfQlVSU1RfU0la
RV9TRVRVUAkJMHgxMEEKLSNkZWZpbmUgU0RDTEtfU0VMCTB4MTAwCi0jZGVmaW5lIFNEQ0xLX0RF
TEFZX1NISUZUCTkKLSNkZWZpbmUgU0RDTEtfREVMQVlfTUFTSwkweDFmCi0KIHN0cnVjdCBzZGhj
aV9weGEgewogCXN0cnVjdCBzZGhjaV9ob3N0CQkqaG9zdDsKIAlzdHJ1Y3Qgc2RoY2lfcHhhX3Bs
YXRkYXRhCSpwZGF0YTsKQEAgLTUxLDI5ICs0MywxMSBAQCBzdHJ1Y3Qgc2RoY2lfcHhhIHsKICAq
IFNESENJIGNvcmUgY2FsbGJhY2tzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKgogICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqCiBcKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKiovCi1zdGF0aWMgaW5saW5lIHZvaWQgdHVuZV90aW1pbmcoc3RydWN0IHNkaGNpX2hv
c3QgKmhvc3QsCi0JCQkJc3RydWN0IHNkaGNpX3B4YV9wbGF0ZGF0YSAqcGRhdGEpCi17Ci0JLyoK
LQkgKiB0dW5lIHRpbWluZyBvZiByZWFkIGRhdGEvY29tbWFuZCB3aGVuIGNyYyBlcnJvciBoYXBw
ZW4KLQkgKiBubyBwZXJmb3JtYW5jZSBpbXBhY3QKLQkgKi8KLQlpZiAocGRhdGEgJiYgMCAhPSBw
ZGF0YS0+Y2xrX2RlbGF5X2N5Y2xlcykgewotCQl1MTYgdG1wOwotCi0JCXRtcCA9IHJlYWR3KGhv
c3QtPmlvYWRkciArIFNEX0NMT0NLX0FORF9CVVJTVF9TSVpFX1NFVFVQKTsKLQkJdG1wIHw9IChw
ZGF0YS0+Y2xrX2RlbGF5X2N5Y2xlcyAmIFNEQ0xLX0RFTEFZX01BU0spCi0JCQkJCTw8IFNEQ0xL
X0RFTEFZX1NISUZUOwotCQl0bXAgfD0gU0RDTEtfU0VMOwotCQl3cml0ZXcodG1wLCBob3N0LT5p
b2FkZHIgKyBTRF9DTE9DS19BTkRfQlVSU1RfU0laRV9TRVRVUCk7Ci0JfQotfQogCiBzdGF0aWMg
dm9pZCBzZXRfY2xvY2soc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHVuc2lnbmVkIGludCBjbG9j
aykKIHsKIAlzdHJ1Y3Qgc2RoY2lfcHhhICpweGEgPSBzZGhjaV9wcml2KGhvc3QpOwogCXN0cnVj
dCBzZGhjaV9weGFfcGxhdGRhdGEgKnBkYXRhID0gcHhhLT5wZGF0YTsKLQl1MzIgdG1wID0gMDsK
IAogCWlmIChjbG9jayA9PSAwKSB7CiAJCWlmIChweGEtPmNsa19lbmFibGUpIHsKQEAgLTgxLDEy
ICs1NSw4IEBAIHN0YXRpYyB2b2lkIHNldF9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwg
dW5zaWduZWQgaW50IGNsb2NrKQogCQkJcHhhLT5jbGtfZW5hYmxlID0gMDsKIAkJfQogCX0gZWxz
ZSB7Ci0JCXR1bmVfdGltaW5nKGhvc3QsIHBkYXRhKTsKLQkJaWYgKHBkYXRhICYmIHBkYXRhLT5m
bGFncyAmIFBYQV9GTEFHX0RJU0FCTEVfQ0xPQ0tfR0FUSU5HKSB7Ci0JCQl0bXAgPSByZWFkbCho
b3N0LT5pb2FkZHIgKyBTRF9GSUZPX1BBUkFNKTsKLQkJCXRtcCB8PSBESVNfUEFEX1NEX0NMS19H
QVRFOwotCQkJd3JpdGVsKHRtcCwgaG9zdC0+aW9hZGRyICsgU0RfRklGT19QQVJBTSk7Ci0JCX0K
KwkJaWYgKHBkYXRhICYmIHBkYXRhLT5pbml0X3NkaCkKKwkJCXBkYXRhLT5pbml0X3NkaChob3N0
LCBwZGF0YSk7CiAJCWNsa19lbmFibGUocHhhLT5jbGspOwogCQlweGEtPmNsa19lbmFibGUgPSAx
OwogCX0KLS0gCjEuNy4wLjQKCg==
--20cf30433fa4dc478704954eec00--
