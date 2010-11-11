From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH v2 1/1]sdhci-pxa: support tune_timming for various cards
Date: Thu, 11 Nov 2010 08:19:12 -0500
Message-ID: <AANLkTi=h1p98z542H=EzFaqnHmEDkQDPZ5QmCQGo4Cik@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3054a46de644a00494c6d103
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47532 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027Ab0KKNTO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Nov 2010 08:19:14 -0500
Received: by fxm16 with SMTP id 16so1276994fxm.19
        for <linux-mmc@vger.kernel.org>; Thu, 11 Nov 2010 05:19:12 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

--20cf3054a46de644a00494c6d103
Content-Type: text/plain; charset=ISO-8859-1

Hi, Chirs & Eric

Thanks for review, here is updated version.
1. After clk_gating is enabled, set_clock will transfer clock=0, so
clk_disable will be called, currently set_clock will never transfer
clock=0.
Later tune_timing only occurs once clock is started, currently it will
happen when clock is changed.

2. if pdata is NULL, on-chip device can not be detected, but SD card
is workable, though some card may have crc error at 50M.


>From 553b84abee56f36ee166564f7ce3c617950e194f Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Tue, 2 Nov 2010 07:37:44 -0400
Subject: [PATCH] sdhci-pxa: support tune_timing for various cards

	1. Add pdata check, in case pdata is NULL
	2. Add tune_timing to adjust read data/command timing without
performance impact when crc error, as a result
		a, sd could work at 50M
		b, emmc could work at ddr50 mode
	3. Remove clock_enable checking, since clock gating is still on-going
in core stack.

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |    2 +
 drivers/mmc/host/sdhci-pxa.c           |   47 +++++++++++++++++++++++--------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
b/arch/arm/plat-pxa/include/plat/sdhci.h
index fc5ceab..f6f46db 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -24,11 +24,13 @@
  * @max_speed: the maximum speed supported
  * @quirks: quirks of specific device
  * @flags: flags for platform requirement
+ * @clk_delay_cycles: 1 ~ 0x1f, each step is roughly 100ps, for tuning timing
  */
 struct sdhci_pxa_platdata {
 	unsigned int	max_speed;
 	unsigned int	quirks;
 	unsigned int	flags;
+	unsigned int	clk_delay_cycles;
 };

 #endif /* __PLAT_PXA_SDHCI_H */
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 8455c46..2b665e4 100644
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
@@ -46,9 +51,28 @@ struct sdhci_pxa {
  * SDHCI core callbacks                                                      *
  *                                                                           *
 \*****************************************************************************/
+static inline void tune_timing(struct sdhci_host *host,
+				struct sdhci_pxa_platdata *pdata)
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
+}
+
 static void set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pxa *pxa = sdhci_priv(host);
+	struct sdhci_pxa_platdata *pdata = pxa->pdata;
 	u32 tmp = 0;

 	if (clock == 0) {
@@ -57,15 +81,14 @@ static void set_clock(struct sdhci_host *host,
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
+		tune_timing(host, pdata);
+		if (pdata && pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
+			tmp = readl(host->ioaddr + SD_FIFO_PARAM);
+			tmp |= DIS_PAD_SD_CLK_GATE;
+			writel(tmp, host->ioaddr + SD_FIFO_PARAM);
 		}
+		clk_enable(pxa->clk);
+		pxa->clk_enable = 1;
 	}
 }

@@ -138,13 +161,13 @@ static int __devinit sdhci_pxa_probe(struct
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
@@ -153,8 +176,8 @@ static int __devinit sdhci_pxa_probe(struct
platform_device *pdev)
 		goto out;
 	}

-	if (pxa->pdata->max_speed)
-		host->mmc->f_max = pxa->pdata->max_speed;
+	if (pdata && pdata->max_speed)
+		host->mmc->f_max = pdata->max_speed;

 	platform_set_drvdata(pdev, host);

-- 
1.7.0.4

--20cf3054a46de644a00494c6d103
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-sdhci-pxa-support-tune_timing-for-various-cards.patch"
Content-Disposition: attachment;
	filename="0001-sdhci-pxa-support-tune_timing-for-various-cards.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ggdpjsw90

RnJvbSA1NTNiODRhYmVlNTZmMzZlZTE2NjU2NGY3Y2UzYzYxNzk1MGUxOTRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogVHVlLCAyIE5vdiAyMDEwIDA3OjM3OjQ0IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0g
c2RoY2ktcHhhOiBzdXBwb3J0IHR1bmVfdGltaW5nIGZvciB2YXJpb3VzIGNhcmRzCgoJMS4gQWRk
IHBkYXRhIGNoZWNrLCBpbiBjYXNlIHBkYXRhIGlzIE5VTEwKCTIuIEFkZCB0dW5lX3RpbWluZyB0
byBhZGp1c3QgcmVhZCBkYXRhL2NvbW1hbmQgdGltaW5nIHdpdGhvdXQgcGVyZm9ybWFuY2UgaW1w
YWN0IHdoZW4gY3JjIGVycm9yLCBhcyBhIHJlc3VsdAoJCWEsIHNkIGNvdWxkIHdvcmsgYXQgNTBN
CgkJYiwgZW1tYyBjb3VsZCB3b3JrIGF0IGRkcjUwIG1vZGUKCTMuIFJlbW92ZSBjbG9ja19lbmFi
bGUgY2hlY2tpbmcsIHNpbmNlIGNsb2NrIGdhdGluZyBpcyBzdGlsbCBvbi1nb2luZyBpbiBjb3Jl
IHN0YWNrLgoKU2lnbmVkLW9mZi1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbWFydmVs
bC5jb20+Ci0tLQogYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmggfCAgICAy
ICsKIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMgICAgICAgICAgIHwgICA0NyArKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMo
KyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1
ZGUvcGxhdC9zZGhjaS5oIGIvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmgK
aW5kZXggZmM1Y2VhYi4uZjZmNDZkYiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1weGEvaW5j
bHVkZS9wbGF0L3NkaGNpLmgKKysrIGIvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3Nk
aGNpLmgKQEAgLTI0LDExICsyNCwxMyBAQAogICogQG1heF9zcGVlZDogdGhlIG1heGltdW0gc3Bl
ZWQgc3VwcG9ydGVkCiAgKiBAcXVpcmtzOiBxdWlya3Mgb2Ygc3BlY2lmaWMgZGV2aWNlCiAgKiBA
ZmxhZ3M6IGZsYWdzIGZvciBwbGF0Zm9ybSByZXF1aXJlbWVudAorICogQGNsa19kZWxheV9jeWNs
ZXM6IDEgfiAweDFmLCBlYWNoIHN0ZXAgaXMgcm91Z2hseSAxMDBwcywgZm9yIHR1bmluZyB0aW1p
bmcKICAqLwogc3RydWN0IHNkaGNpX3B4YV9wbGF0ZGF0YSB7CiAJdW5zaWduZWQgaW50CW1heF9z
cGVlZDsKIAl1bnNpZ25lZCBpbnQJcXVpcmtzOwogCXVuc2lnbmVkIGludAlmbGFnczsKKwl1bnNp
Z25lZCBpbnQJY2xrX2RlbGF5X2N5Y2xlczsKIH07CiAKICNlbmRpZiAvKiBfX1BMQVRfUFhBX1NE
SENJX0ggKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMgYi9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jCmluZGV4IDg0NTVjNDYuLjJiNjY1ZTQgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaS1weGEuYwpAQCAtMzIsNiArMzIsMTEgQEAKICNkZWZpbmUgU0RfRklGT19QQVJBTQkJMHgx
MDQKICNkZWZpbmUgRElTX1BBRF9TRF9DTEtfR0FURQkweDQwMAogCisjZGVmaW5lIFNEX0NMT0NL
X0FORF9CVVJTVF9TSVpFX1NFVFVQCQkweDEwQQorI2RlZmluZSBTRENMS19TRUwJMHgxMDAKKyNk
ZWZpbmUgU0RDTEtfREVMQVlfU0hJRlQJOQorI2RlZmluZSBTRENMS19ERUxBWV9NQVNLCTB4MWYK
Kwogc3RydWN0IHNkaGNpX3B4YSB7CiAJc3RydWN0IHNkaGNpX2hvc3QJCSpob3N0OwogCXN0cnVj
dCBzZGhjaV9weGFfcGxhdGRhdGEJKnBkYXRhOwpAQCAtNDYsOSArNTEsMjggQEAgc3RydWN0IHNk
aGNpX3B4YSB7CiAgKiBTREhDSSBjb3JlIGNhbGxiYWNrcyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoKICAqICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKgog
XCoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqLworc3RhdGljIGlubGluZSB2b2lkIHR1bmVfdGltaW5nKHN0
cnVjdCBzZGhjaV9ob3N0ICpob3N0LAorCQkJCXN0cnVjdCBzZGhjaV9weGFfcGxhdGRhdGEgKnBk
YXRhKQoreworCS8qCisJICogdHVuZSB0aW1pbmcgb2YgcmVhZCBkYXRhL2NvbW1hbmQgd2hlbiBj
cmMgZXJyb3IgaGFwcGVuCisJICogbm8gcGVyZm9ybWFuY2UgaW1wYWN0CisJICovCisJaWYgKHBk
YXRhICYmIDAgIT0gcGRhdGEtPmNsa19kZWxheV9jeWNsZXMpIHsKKwkJdTE2IHRtcDsKKworCQl0
bXAgPSByZWFkdyhob3N0LT5pb2FkZHIgKyBTRF9DTE9DS19BTkRfQlVSU1RfU0laRV9TRVRVUCk7
CisJCXRtcCB8PSAocGRhdGEtPmNsa19kZWxheV9jeWNsZXMgJiBTRENMS19ERUxBWV9NQVNLKQor
CQkJCQk8PCBTRENMS19ERUxBWV9TSElGVDsKKwkJdG1wIHw9IFNEQ0xLX1NFTDsKKwkJd3JpdGV3
KHRtcCwgaG9zdC0+aW9hZGRyICsgU0RfQ0xPQ0tfQU5EX0JVUlNUX1NJWkVfU0VUVVApOworCX0K
K30KKwogc3RhdGljIHZvaWQgc2V0X2Nsb2NrKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1bnNp
Z25lZCBpbnQgY2xvY2spCiB7CiAJc3RydWN0IHNkaGNpX3B4YSAqcHhhID0gc2RoY2lfcHJpdiho
b3N0KTsKKwlzdHJ1Y3Qgc2RoY2lfcHhhX3BsYXRkYXRhICpwZGF0YSA9IHB4YS0+cGRhdGE7CiAJ
dTMyIHRtcCA9IDA7CiAKIAlpZiAoY2xvY2sgPT0gMCkgewpAQCAtNTcsMTUgKzgxLDE0IEBAIHN0
YXRpYyB2b2lkIHNldF9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5zaWduZWQgaW50
IGNsb2NrKQogCQkJcHhhLT5jbGtfZW5hYmxlID0gMDsKIAkJfQogCX0gZWxzZSB7Ci0JCWlmICgw
ID09IHB4YS0+Y2xrX2VuYWJsZSkgewotCQkJaWYgKHB4YS0+cGRhdGEtPmZsYWdzICYgUFhBX0ZM
QUdfRElTQUJMRV9DTE9DS19HQVRJTkcpIHsKLQkJCQl0bXAgPSByZWFkbChob3N0LT5pb2FkZHIg
KyBTRF9GSUZPX1BBUkFNKTsKLQkJCQl0bXAgfD0gRElTX1BBRF9TRF9DTEtfR0FURTsKLQkJCQl3
cml0ZWwodG1wLCBob3N0LT5pb2FkZHIgKyBTRF9GSUZPX1BBUkFNKTsKLQkJCX0KLQkJCWNsa19l
bmFibGUocHhhLT5jbGspOwotCQkJcHhhLT5jbGtfZW5hYmxlID0gMTsKKwkJdHVuZV90aW1pbmco
aG9zdCwgcGRhdGEpOworCQlpZiAocGRhdGEgJiYgcGRhdGEtPmZsYWdzICYgUFhBX0ZMQUdfRElT
QUJMRV9DTE9DS19HQVRJTkcpIHsKKwkJCXRtcCA9IHJlYWRsKGhvc3QtPmlvYWRkciArIFNEX0ZJ
Rk9fUEFSQU0pOworCQkJdG1wIHw9IERJU19QQURfU0RfQ0xLX0dBVEU7CisJCQl3cml0ZWwodG1w
LCBob3N0LT5pb2FkZHIgKyBTRF9GSUZPX1BBUkFNKTsKIAkJfQorCQljbGtfZW5hYmxlKHB4YS0+
Y2xrKTsKKwkJcHhhLT5jbGtfZW5hYmxlID0gMTsKIAl9CiB9CiAKQEAgLTEzOCwxMyArMTYxLDEz
IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IHNkaGNpX3B4YV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQogCWhvc3QtPmlycSA9IGlycTsKIAlob3N0LT5xdWlya3MgPSBTREhDSV9R
VUlSS19CUk9LRU5fQURNQSB8IFNESENJX1FVSVJLX0JST0tFTl9USU1FT1VUX1ZBTDsKIAotCWlm
IChweGEtPnBkYXRhLT5mbGFncyAmIFBYQV9GTEFHX0NBUkRfUEVSTUFORU5UKSB7CisJaWYgKHBk
YXRhICYmIHBkYXRhLT5mbGFncyAmIFBYQV9GTEFHX0NBUkRfUEVSTUFORU5UKSB7CiAJCS8qIG9u
LWNoaXAgZGV2aWNlICovCiAJCWhvc3QtPnF1aXJrcyB8PSBTREhDSV9RVUlSS19CUk9LRU5fQ0FS
RF9ERVRFQ1RJT047CiAJCWhvc3QtPm1tYy0+Y2FwcyB8PSBNTUNfQ0FQX05PTlJFTU9WQUJMRTsK
IAl9CiAKLQlpZiAocGRhdGEtPnF1aXJrcykKKwlpZiAocGRhdGEgJiYgcGRhdGEtPnF1aXJrcykK
IAkJaG9zdC0+cXVpcmtzIHw9IHBkYXRhLT5xdWlya3M7CiAKIAlyZXQgPSBzZGhjaV9hZGRfaG9z
dChob3N0KTsKQEAgLTE1Myw4ICsxNzYsOCBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBzZGhjaV9w
eGFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAkJZ290byBvdXQ7CiAJfQog
Ci0JaWYgKHB4YS0+cGRhdGEtPm1heF9zcGVlZCkKLQkJaG9zdC0+bW1jLT5mX21heCA9IHB4YS0+
cGRhdGEtPm1heF9zcGVlZDsKKwlpZiAocGRhdGEgJiYgcGRhdGEtPm1heF9zcGVlZCkKKwkJaG9z
dC0+bW1jLT5mX21heCA9IHBkYXRhLT5tYXhfc3BlZWQ7CiAKIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0
YShwZGV2LCBob3N0KTsKIAotLSAKMS43LjAuNAoK
--20cf3054a46de644a00494c6d103--
