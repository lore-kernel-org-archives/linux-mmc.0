From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH 1/1]sdhci-pxa: support tune_timming for various cards
Date: Tue, 9 Nov 2010 09:17:21 -0500
Message-ID: <AANLkTinyu5j0KpZ5AWuE0yOvAaFNBkM+bSfiLqpNcS+_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502a30c2fd78b04949f6670
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61117 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab0KIORX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2010 09:17:23 -0500
Received: by yxe1 with SMTP id 1so82978yxe.19
        for <linux-mmc@vger.kernel.org>; Tue, 09 Nov 2010 06:17:23 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

--00504502a30c2fd78b04949f6670
Content-Type: text/plain; charset=ISO-8859-1

Haojian,

Would you help review, since arch/arm/plat-pxa/include/plat/sdhci.h is
updated, thanks

>From 6619812b749aa12ebf0efbe057366c2f99051bfe Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Tue, 2 Nov 2010 07:37:44 -0400
Subject: [PATCH] sdhci-pxa: support tune_timming for various cards

	1. Add pdata check, in case pdata is NULL
	2. Add tune_timming to adjust read data/command timming without
performance impact when crc error, as a result
		a, sd could work at 50M
		b, emmc could work at ddr50 mode
	3. Remove clock_enable checking, since clock gating is still on-going
in core stack.

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |    2 +
 drivers/mmc/host/sdhci-pxa.c           |   51 +++++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
b/arch/arm/plat-pxa/include/plat/sdhci.h
index fc5ceab..8c340b1 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -24,11 +24,13 @@
  * @max_speed: the maximum speed supported
  * @quirks: quirks of specific device
  * @flags: flags for platform requirement
+ * @clk_delay: clk_delay vlaue to tunning various cards
  */
 struct sdhci_pxa_platdata {
 	unsigned int	max_speed;
 	unsigned int	quirks;
 	unsigned int	flags;
+	unsigned int	clk_delay;
 };

 #endif /* __PLAT_PXA_SDHCI_H */
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 8455c46..cf514f8 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -32,6 +32,11 @@
 #define SD_FIFO_PARAM		0x104
 #define DIS_PAD_SD_CLK_GATE	0x400

+#define SD_CLOCK_AND_BURST_SIZE_SETUP		0x10A
+#define SDCLK_SEL	0x100
+#define SDCLK_DELAY_SHIFT	9
+#define SDCLK_DELAY_MASK	0x1f
+
 struct sdhci_pxa {
 	struct sdhci_host		*host;
 	struct sdhci_pxa_platdata	*pdata;
@@ -46,6 +51,26 @@ struct sdhci_pxa {
  * SDHCI core callbacks                                                      *
  *                                                                           *
 \*****************************************************************************/
+static void tune_timming(struct sdhci_host *host)
+{
+	struct sdhci_pxa *pxa = sdhci_priv(host);
+
+	/*
+	 * tune timming of read data/command when crc error happen
+	 * No perfermance impact
+	 */
+	if (pxa->pdata && 0 != pxa->pdata->clk_delay) {
+		u16 tmp;
+
+		tmp = readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+		tmp |= (pxa->pdata->clk_delay & SDCLK_DELAY_MASK)
+					<< SDCLK_DELAY_SHIFT;
+		tmp |= SDCLK_SEL;
+		writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+	}
+
+}
+
 static void set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pxa *pxa = sdhci_priv(host);
@@ -57,15 +82,16 @@ static void set_clock(struct sdhci_host *host,
unsigned int clock)
 			pxa->clk_enable = 0;
 		}
 	} else {
-		if (0 == pxa->clk_enable) {
-			if (pxa->pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
-				tmp = readl(host->ioaddr + SD_FIFO_PARAM);
-				tmp |= DIS_PAD_SD_CLK_GATE;
-				writel(tmp, host->ioaddr + SD_FIFO_PARAM);
-			}
-			clk_enable(pxa->clk);
-			pxa->clk_enable = 1;
+		tune_timming(host);
+		if (pxa->pdata &&
+			pxa->pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
+
+			tmp = readl(host->ioaddr + SD_FIFO_PARAM);
+			tmp |= DIS_PAD_SD_CLK_GATE;
+			writel(tmp, host->ioaddr + SD_FIFO_PARAM);
 		}
+		clk_enable(pxa->clk);
+		pxa->clk_enable = 1;
 	}
 }

@@ -138,13 +164,13 @@ static int __devinit sdhci_pxa_probe(struct
platform_device *pdev)
 	host->irq = irq;
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;

-	if (pxa->pdata->flags & PXA_FLAG_CARD_PERMANENT) {
+	if (pdata && pdata->flags & PXA_FLAG_CARD_PERMANENT) {
 		/* on-chip device */
 		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
 	}

-	if (pdata->quirks)
+	if (pdata && pdata->quirks)
 		host->quirks |= pdata->quirks;

 	ret = sdhci_add_host(host);
@@ -153,9 +179,8 @@ static int __devinit sdhci_pxa_probe(struct
platform_device *pdev)
 		goto out;
 	}

-	if (pxa->pdata->max_speed)
-		host->mmc->f_max = pxa->pdata->max_speed;
-
+	if (pdata && pdata->max_speed)
+		host->mmc->f_max = pdata->max_speed;
 	platform_set_drvdata(pdev, host);

 	return 0;
-- 
1.7.0.4

--00504502a30c2fd78b04949f6670
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-sdhci-pxa-support-tune_timming-for-various-cards.patch"
Content-Disposition: attachment;
	filename="0001-sdhci-pxa-support-tune_timming-for-various-cards.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ggax9llv0

RnJvbSA2NjE5ODEyYjc0OWFhMTJlYmYwZWZiZTA1NzM2NmMyZjk5MDUxYmZlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogVHVlLCAyIE5vdiAyMDEwIDA3OjM3OjQ0IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0g
c2RoY2ktcHhhOiBzdXBwb3J0IHR1bmVfdGltbWluZyBmb3IgdmFyaW91cyBjYXJkcwoKCTEuIEFk
ZCBwZGF0YSBjaGVjaywgaW4gY2FzZSBwZGF0YSBpcyBOVUxMCgkyLiBBZGQgdHVuZV90aW1taW5n
IHRvIGFkanVzdCByZWFkIGRhdGEvY29tbWFuZCB0aW1taW5nIHdpdGhvdXQgcGVyZm9ybWFuY2Ug
aW1wYWN0IHdoZW4gY3JjIGVycm9yLCBhcyBhIHJlc3VsdAoJCWEsIHNkIGNvdWxkIHdvcmsgYXQg
NTBNCgkJYiwgZW1tYyBjb3VsZCB3b3JrIGF0IGRkcjUwIG1vZGUKCTMuIFJlbW92ZSBjbG9ja19l
bmFibGUgY2hlY2tpbmcsIHNpbmNlIGNsb2NrIGdhdGluZyBpcyBzdGlsbCBvbi1nb2luZyBpbiBj
b3JlIHN0YWNrLgoKU2lnbmVkLW9mZi1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbWFy
dmVsbC5jb20+Ci0tLQogYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmggfCAg
ICAyICsKIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMgICAgICAgICAgIHwgICA1MSArKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlv
bnMoKyksIDEzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtcHhhL2lu
Y2x1ZGUvcGxhdC9zZGhjaS5oIGIvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNp
LmgKaW5kZXggZmM1Y2VhYi4uOGMzNDBiMSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1weGEv
aW5jbHVkZS9wbGF0L3NkaGNpLmgKKysrIGIvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0
L3NkaGNpLmgKQEAgLTI0LDExICsyNCwxMyBAQAogICogQG1heF9zcGVlZDogdGhlIG1heGltdW0g
c3BlZWQgc3VwcG9ydGVkCiAgKiBAcXVpcmtzOiBxdWlya3Mgb2Ygc3BlY2lmaWMgZGV2aWNlCiAg
KiBAZmxhZ3M6IGZsYWdzIGZvciBwbGF0Zm9ybSByZXF1aXJlbWVudAorICogQGNsa19kZWxheTog
Y2xrX2RlbGF5IHZsYXVlIHRvIHR1bm5pbmcgdmFyaW91cyBjYXJkcwogICovCiBzdHJ1Y3Qgc2Ro
Y2lfcHhhX3BsYXRkYXRhIHsKIAl1bnNpZ25lZCBpbnQJbWF4X3NwZWVkOwogCXVuc2lnbmVkIGlu
dAlxdWlya3M7CiAJdW5zaWduZWQgaW50CWZsYWdzOworCXVuc2lnbmVkIGludAljbGtfZGVsYXk7
CiB9OwogCiAjZW5kaWYgLyogX19QTEFUX1BYQV9TREhDSV9IICovCmRpZmYgLS1naXQgYS9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwpp
bmRleCA4NDU1YzQ2Li5jZjUxNGY4IDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LXB4YS5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMKQEAgLTMyLDYgKzMyLDEx
IEBACiAjZGVmaW5lIFNEX0ZJRk9fUEFSQU0JCTB4MTA0CiAjZGVmaW5lIERJU19QQURfU0RfQ0xL
X0dBVEUJMHg0MDAKIAorI2RlZmluZSBTRF9DTE9DS19BTkRfQlVSU1RfU0laRV9TRVRVUAkJMHgx
MEEKKyNkZWZpbmUgU0RDTEtfU0VMCTB4MTAwCisjZGVmaW5lIFNEQ0xLX0RFTEFZX1NISUZUCTkK
KyNkZWZpbmUgU0RDTEtfREVMQVlfTUFTSwkweDFmCisKIHN0cnVjdCBzZGhjaV9weGEgewogCXN0
cnVjdCBzZGhjaV9ob3N0CQkqaG9zdDsKIAlzdHJ1Y3Qgc2RoY2lfcHhhX3BsYXRkYXRhCSpwZGF0
YTsKQEAgLTQ2LDYgKzUxLDI2IEBAIHN0cnVjdCBzZGhjaV9weGEgewogICogU0RIQ0kgY29yZSBj
YWxsYmFja3MgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAqCiAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICoKIFwqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KK3N0
YXRpYyB2b2lkIHR1bmVfdGltbWluZyhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkKK3sKKwlzdHJ1
Y3Qgc2RoY2lfcHhhICpweGEgPSBzZGhjaV9wcml2KGhvc3QpOworCisJLyoKKwkgKiB0dW5lIHRp
bW1pbmcgb2YgcmVhZCBkYXRhL2NvbW1hbmQgd2hlbiBjcmMgZXJyb3IgaGFwcGVuCisJICogTm8g
cGVyZmVybWFuY2UgaW1wYWN0CisJICovCisJaWYgKHB4YS0+cGRhdGEgJiYgMCAhPSBweGEtPnBk
YXRhLT5jbGtfZGVsYXkpIHsKKwkJdTE2IHRtcDsKKworCQl0bXAgPSByZWFkdyhob3N0LT5pb2Fk
ZHIgKyBTRF9DTE9DS19BTkRfQlVSU1RfU0laRV9TRVRVUCk7CisJCXRtcCB8PSAocHhhLT5wZGF0
YS0+Y2xrX2RlbGF5ICYgU0RDTEtfREVMQVlfTUFTSykKKwkJCQkJPDwgU0RDTEtfREVMQVlfU0hJ
RlQ7CisJCXRtcCB8PSBTRENMS19TRUw7CisJCXdyaXRldyh0bXAsIGhvc3QtPmlvYWRkciArIFNE
X0NMT0NLX0FORF9CVVJTVF9TSVpFX1NFVFVQKTsKKwl9CisKK30KKwogc3RhdGljIHZvaWQgc2V0
X2Nsb2NrKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1bnNpZ25lZCBpbnQgY2xvY2spCiB7CiAJ
c3RydWN0IHNkaGNpX3B4YSAqcHhhID0gc2RoY2lfcHJpdihob3N0KTsKQEAgLTU3LDE1ICs4Miwx
NiBAQCBzdGF0aWMgdm9pZCBzZXRfY2xvY2soc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHVuc2ln
bmVkIGludCBjbG9jaykKIAkJCXB4YS0+Y2xrX2VuYWJsZSA9IDA7CiAJCX0KIAl9IGVsc2Ugewot
CQlpZiAoMCA9PSBweGEtPmNsa19lbmFibGUpIHsKLQkJCWlmIChweGEtPnBkYXRhLT5mbGFncyAm
IFBYQV9GTEFHX0RJU0FCTEVfQ0xPQ0tfR0FUSU5HKSB7Ci0JCQkJdG1wID0gcmVhZGwoaG9zdC0+
aW9hZGRyICsgU0RfRklGT19QQVJBTSk7Ci0JCQkJdG1wIHw9IERJU19QQURfU0RfQ0xLX0dBVEU7
Ci0JCQkJd3JpdGVsKHRtcCwgaG9zdC0+aW9hZGRyICsgU0RfRklGT19QQVJBTSk7Ci0JCQl9Ci0J
CQljbGtfZW5hYmxlKHB4YS0+Y2xrKTsKLQkJCXB4YS0+Y2xrX2VuYWJsZSA9IDE7CisJCXR1bmVf
dGltbWluZyhob3N0KTsKKwkJaWYgKHB4YS0+cGRhdGEgJiYKKwkJCXB4YS0+cGRhdGEtPmZsYWdz
ICYgUFhBX0ZMQUdfRElTQUJMRV9DTE9DS19HQVRJTkcpIHsKKworCQkJdG1wID0gcmVhZGwoaG9z
dC0+aW9hZGRyICsgU0RfRklGT19QQVJBTSk7CisJCQl0bXAgfD0gRElTX1BBRF9TRF9DTEtfR0FU
RTsKKwkJCXdyaXRlbCh0bXAsIGhvc3QtPmlvYWRkciArIFNEX0ZJRk9fUEFSQU0pOwogCQl9CisJ
CWNsa19lbmFibGUocHhhLT5jbGspOworCQlweGEtPmNsa19lbmFibGUgPSAxOwogCX0KIH0KIApA
QCAtMTM4LDEzICsxNjQsMTMgQEAgc3RhdGljIGludCBfX2RldmluaXQgc2RoY2lfcHhhX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJaG9zdC0+aXJxID0gaXJxOwogCWhvc3Qt
PnF1aXJrcyA9IFNESENJX1FVSVJLX0JST0tFTl9BRE1BIHwgU0RIQ0lfUVVJUktfQlJPS0VOX1RJ
TUVPVVRfVkFMOwogCi0JaWYgKHB4YS0+cGRhdGEtPmZsYWdzICYgUFhBX0ZMQUdfQ0FSRF9QRVJN
QU5FTlQpIHsKKwlpZiAocGRhdGEgJiYgcGRhdGEtPmZsYWdzICYgUFhBX0ZMQUdfQ0FSRF9QRVJN
QU5FTlQpIHsKIAkJLyogb24tY2hpcCBkZXZpY2UgKi8KIAkJaG9zdC0+cXVpcmtzIHw9IFNESENJ
X1FVSVJLX0JST0tFTl9DQVJEX0RFVEVDVElPTjsKIAkJaG9zdC0+bW1jLT5jYXBzIHw9IE1NQ19D
QVBfTk9OUkVNT1ZBQkxFOwogCX0KIAotCWlmIChwZGF0YS0+cXVpcmtzKQorCWlmIChwZGF0YSAm
JiBwZGF0YS0+cXVpcmtzKQogCQlob3N0LT5xdWlya3MgfD0gcGRhdGEtPnF1aXJrczsKIAogCXJl
dCA9IHNkaGNpX2FkZF9ob3N0KGhvc3QpOwpAQCAtMTUzLDkgKzE3OSw4IEBAIHN0YXRpYyBpbnQg
X19kZXZpbml0IHNkaGNpX3B4YV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQog
CQlnb3RvIG91dDsKIAl9CiAKLQlpZiAocHhhLT5wZGF0YS0+bWF4X3NwZWVkKQotCQlob3N0LT5t
bWMtPmZfbWF4ID0gcHhhLT5wZGF0YS0+bWF4X3NwZWVkOwotCisJaWYgKHBkYXRhICYmIHBkYXRh
LT5tYXhfc3BlZWQpCisJCWhvc3QtPm1tYy0+Zl9tYXggPSBwZGF0YS0+bWF4X3NwZWVkOwogCXBs
YXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGhvc3QpOwogCiAJcmV0dXJuIDA7Ci0tIAoxLjcuMC40
Cgo=
--00504502a30c2fd78b04949f6670--
