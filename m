From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [Patch 1/1]sdhci: verify ddr50 mode
Date: Mon, 1 Nov 2010 10:21:56 -0400
Message-ID: <AANLkTin5S_xKj_H5tFUE+RHa-T_z0USvhdzap3fpSaa8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c5aa65d030310493fe87cd
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44703 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756461Ab0KAOV5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Nov 2010 10:21:57 -0400
Received: by ywc21 with SMTP id 21so807333ywc.19
        for <linux-mmc@vger.kernel.org>; Mon, 01 Nov 2010 07:21:57 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Chris Ball <cjb@laptop.org>, Matt Fleming <matt@console-pimps.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

--001636c5aa65d030310493fe87cd
Content-Type: text/plain; charset=ISO-8859-1

Based on the work from Adrian and Hanumath, here is the patch to
verify ddr50 for sdhci.c on sdhci-pxa with HYNIX and toshiba eMMC.
Only support emmc DDR50 mode now.
Would you help review, thanks

>From 59072fa8fea50634f01009e51c4b5e16308ab466 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Mon, 1 Nov 2010 07:43:57 -0400
Subject: [PATCH] sdhci: support DDR50 mode

	Verified DDR50 mode on sdhci-pxa and HYNIX and toshiba eMMC

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci.c |   48 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.h |   15 ++++++++++++-
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 782c0ee..d9e4ab8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -982,6 +982,44 @@ static void sdhci_finish_command(struct sdhci_host *host)
 	host->cmd = NULL;
 }

+static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
+{
+	u16 con;
+	unsigned long timeout;
+
+	if (ddr == MMC_SDR_MODE)
+		return;
+
+	if (host->ops->set_ddr)
+		host->ops->set_ddr(host, ddr);
+
+	/* Fixme, how to support 1.2v Mode */
+	if (ddr & MMC_1_8V_DDR_MODE) {
+		con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		con |= SDHCI_CTRL2_1_8V;
+		sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
+
+		/* Wait max 5 ms */
+		timeout = 5;
+		while (!((con = sdhci_readw(host, SDHCI_HOST_CONTROL2))
+					& SDHCI_CTRL2_1_8V)) {
+			if (timeout == 0) {
+				printk(KERN_ERR "%s: HOST CONTROL fail switch to 1.8v\n",
+						mmc_hostname(host->mmc));
+				sdhci_dumpregs(host);
+				return;
+			}
+			timeout--;
+			mdelay(1);
+		}
+		con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		con &= ~SDHCI_CTRL2_UHS_MASK;
+		/* only support DDR50 */
+		con |= SDHCI_CTRL2_DDR50;
+		sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
+	}
+}
+
 static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	int div;
@@ -1176,6 +1214,7 @@ static void sdhci_set_ios(struct mmc_host *mmc,
struct mmc_ios *ios)
 	}

 	sdhci_set_clock(host, ios->clock);
+	sdhci_set_ddr(host, ios->ddr);

 	if (ios->power_mode == MMC_POWER_OFF)
 		sdhci_set_power(host, -1);
@@ -1712,7 +1751,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
 int sdhci_add_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
-	unsigned int caps;
+	unsigned int caps, caps_h;
 	int ret;

 	WARN_ON(host == NULL);
@@ -1737,6 +1776,13 @@ int sdhci_add_host(struct sdhci_host *host)

 	caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
 		sdhci_readl(host, SDHCI_CAPABILITIES);
+	caps_h = sdhci_readl(host, SDHCI_CAPABILITIES_H);
+
+	if ((caps & SDHCI_CAN_VDD_180) &&
+		((caps_h & SDHCI_CAN_SDR50) ||
+		(caps_h & SDHCI_CAN_SDR104) ||
+		(caps_h & SDHCI_CAN_DDR50)))
+		mmc->caps |= (MMC_CAP_1_8V_DDR);

 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b7b8a3b..fe87c5f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -141,7 +141,14 @@

 #define SDHCI_ACMD12_ERR	0x3C

-/* 3E-3F reserved */
+#define SDHCI_HOST_CONTROL2	0x3E
+#define  SDHCI_CTRL2_UHS_MASK	0x07
+#define   SDHCI_CTRL2_SDR12	0x00
+#define   SDHCI_CTRL2_SDR25	0x01
+#define   SDHCI_CTRL2_SDR50	0x02
+#define   SDHCI_CTRL2_SDR104	0x03
+#define   SDHCI_CTRL2_DDR50	0x04
+#define  SDHCI_CTRL2_1_8V	0x08

 #define SDHCI_CAPABILITIES	0x40
 #define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F
@@ -161,7 +168,10 @@
 #define  SDHCI_CAN_VDD_180	0x04000000
 #define  SDHCI_CAN_64BIT	0x10000000

-/* 44-47 reserved for more caps */
+#define SDHCI_CAPABILITIES_H	0x44
+#define  SDHCI_CAN_SDR50	0x00000001
+#define  SDHCI_CAN_SDR104	0x00000002
+#define  SDHCI_CAN_DDR50	0x00000004

 #define SDHCI_MAX_CURRENT	0x48

@@ -207,6 +217,7 @@ struct sdhci_ops {
 #endif

 	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
+	void	(*set_ddr)(struct sdhci_host *host, unsigned int ddr);

 	int		(*enable_dma)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
-- 
1.7.0.4

--001636c5aa65d030310493fe87cd
Content-Type: text/x-patch; charset=US-ASCII; name="0001-sdhci-support-DDR50-mode.patch"
Content-Disposition: attachment;
	filename="0001-sdhci-support-DDR50-mode.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gfzftsww0

RnJvbSA1OTA3MmZhOGZlYTUwNjM0ZjAxMDA5ZTUxYzRiNWUxNjMwOGFiNDY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogTW9uLCAxIE5vdiAyMDEwIDA3OjQzOjU3IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0g
c2RoY2k6IHN1cHBvcnQgRERSNTAgbW9kZQoKCVZlcmlmaWVkIEREUjUwIG1vZGUgb24gc2RoY2kt
cHhhIGFuZCBIWU5JWCBhbmQgdG9zaGliYSBlTU1DCgpTaWduZWQtb2ZmLWJ5OiBaaGFuZ2ZlaSBH
YW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNvbT4KLS0tCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNp
LmMgfCAgIDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0K
IGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaCB8ICAgMTUgKysrKysrKysrKysrLQogMiBmaWxlcyBj
aGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYwppbmRleCA3
ODJjMGVlLi5kOWU0YWI4IDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMKKysr
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCkBAIC05ODIsNiArOTgyLDQ0IEBAIHN0YXRpYyB2
b2lkIHNkaGNpX2ZpbmlzaF9jb21tYW5kKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQogCWhvc3Qt
PmNtZCA9IE5VTEw7CiB9CiAKK3N0YXRpYyB2b2lkIHNkaGNpX3NldF9kZHIoc3RydWN0IHNkaGNp
X2hvc3QgKmhvc3QsIHVuc2lnbmVkIGludCBkZHIpCit7CisJdTE2IGNvbjsKKwl1bnNpZ25lZCBs
b25nIHRpbWVvdXQ7CisKKwlpZiAoZGRyID09IE1NQ19TRFJfTU9ERSkKKwkJcmV0dXJuOworCisJ
aWYgKGhvc3QtPm9wcy0+c2V0X2RkcikKKwkJaG9zdC0+b3BzLT5zZXRfZGRyKGhvc3QsIGRkcik7
CisKKwkvKiBGaXhtZSwgaG93IHRvIHN1cHBvcnQgMS4ydiBNb2RlICovCisJaWYgKGRkciAmIE1N
Q18xXzhWX0REUl9NT0RFKSB7CisJCWNvbiA9IHNkaGNpX3JlYWR3KGhvc3QsIFNESENJX0hPU1Rf
Q09OVFJPTDIpOworCQljb24gfD0gU0RIQ0lfQ1RSTDJfMV84VjsKKwkJc2RoY2lfd3JpdGV3KGhv
c3QsIGNvbiwgU0RIQ0lfSE9TVF9DT05UUk9MMik7CisKKwkJLyogV2FpdCBtYXggNSBtcyAqLwor
CQl0aW1lb3V0ID0gNTsKKwkJd2hpbGUgKCEoKGNvbiA9IHNkaGNpX3JlYWR3KGhvc3QsIFNESENJ
X0hPU1RfQ09OVFJPTDIpKQorCQkJCQkmIFNESENJX0NUUkwyXzFfOFYpKSB7CisJCQlpZiAodGlt
ZW91dCA9PSAwKSB7CisJCQkJcHJpbnRrKEtFUk5fRVJSICIlczogSE9TVCBDT05UUk9MIGZhaWwg
c3dpdGNoIHRvIDEuOHZcbiIsCisJCQkJCQltbWNfaG9zdG5hbWUoaG9zdC0+bW1jKSk7CisJCQkJ
c2RoY2lfZHVtcHJlZ3MoaG9zdCk7CisJCQkJcmV0dXJuOworCQkJfQorCQkJdGltZW91dC0tOwor
CQkJbWRlbGF5KDEpOworCQl9CisJCWNvbiA9IHNkaGNpX3JlYWR3KGhvc3QsIFNESENJX0hPU1Rf
Q09OVFJPTDIpOworCQljb24gJj0gflNESENJX0NUUkwyX1VIU19NQVNLOworCQkvKiBvbmx5IHN1
cHBvcnQgRERSNTAgKi8KKwkJY29uIHw9IFNESENJX0NUUkwyX0REUjUwOworCQlzZGhjaV93cml0
ZXcoaG9zdCwgY29uLCBTREhDSV9IT1NUX0NPTlRST0wyKTsKKwl9Cit9CisKIHN0YXRpYyB2b2lk
IHNkaGNpX3NldF9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5zaWduZWQgaW50IGNs
b2NrKQogewogCWludCBkaXY7CkBAIC0xMTc2LDYgKzEyMTQsNyBAQCBzdGF0aWMgdm9pZCBzZGhj
aV9zZXRfaW9zKHN0cnVjdCBtbWNfaG9zdCAqbW1jLCBzdHJ1Y3QgbW1jX2lvcyAqaW9zKQogCX0K
IAogCXNkaGNpX3NldF9jbG9jayhob3N0LCBpb3MtPmNsb2NrKTsKKwlzZGhjaV9zZXRfZGRyKGhv
c3QsIGlvcy0+ZGRyKTsKIAogCWlmIChpb3MtPnBvd2VyX21vZGUgPT0gTU1DX1BPV0VSX09GRikK
IAkJc2RoY2lfc2V0X3Bvd2VyKGhvc3QsIC0xKTsKQEAgLTE3MTIsNyArMTc1MSw3IEBAIEVYUE9S
VF9TWU1CT0xfR1BMKHNkaGNpX2FsbG9jX2hvc3QpOwogaW50IHNkaGNpX2FkZF9ob3N0KHN0cnVj
dCBzZGhjaV9ob3N0ICpob3N0KQogewogCXN0cnVjdCBtbWNfaG9zdCAqbW1jOwotCXVuc2lnbmVk
IGludCBjYXBzOworCXVuc2lnbmVkIGludCBjYXBzLCBjYXBzX2g7CiAJaW50IHJldDsKIAogCVdB
Uk5fT04oaG9zdCA9PSBOVUxMKTsKQEAgLTE3MzcsNiArMTc3NiwxMyBAQCBpbnQgc2RoY2lfYWRk
X2hvc3Qoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpCiAKIAljYXBzID0gKGhvc3QtPnF1aXJrcyAm
IFNESENJX1FVSVJLX01JU1NJTkdfQ0FQUykgPyBob3N0LT5jYXBzIDoKIAkJc2RoY2lfcmVhZGwo
aG9zdCwgU0RIQ0lfQ0FQQUJJTElUSUVTKTsKKwljYXBzX2ggPSBzZGhjaV9yZWFkbChob3N0LCBT
REhDSV9DQVBBQklMSVRJRVNfSCk7CisKKwlpZiAoKGNhcHMgJiBTREhDSV9DQU5fVkREXzE4MCkg
JiYKKwkJKChjYXBzX2ggJiBTREhDSV9DQU5fU0RSNTApIHx8CisJCShjYXBzX2ggJiBTREhDSV9D
QU5fU0RSMTA0KSB8fAorCQkoY2Fwc19oICYgU0RIQ0lfQ0FOX0REUjUwKSkpCisJCW1tYy0+Y2Fw
cyB8PSAoTU1DX0NBUF8xXzhWX0REUik7CiAKIAlpZiAoaG9zdC0+cXVpcmtzICYgU0RIQ0lfUVVJ
UktfRk9SQ0VfRE1BKQogCQlob3N0LT5mbGFncyB8PSBTREhDSV9VU0VfU0RNQTsKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaCBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaApp
bmRleCBiN2I4YTNiLi5mZTg3YzVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LmgKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oCkBAIC0xNDEsNyArMTQxLDE0IEBACiAK
ICNkZWZpbmUgU0RIQ0lfQUNNRDEyX0VSUgkweDNDCiAKLS8qIDNFLTNGIHJlc2VydmVkICovCisj
ZGVmaW5lIFNESENJX0hPU1RfQ09OVFJPTDIJMHgzRQorI2RlZmluZSAgU0RIQ0lfQ1RSTDJfVUhT
X01BU0sJMHgwNworI2RlZmluZSAgIFNESENJX0NUUkwyX1NEUjEyCTB4MDAKKyNkZWZpbmUgICBT
REhDSV9DVFJMMl9TRFIyNQkweDAxCisjZGVmaW5lICAgU0RIQ0lfQ1RSTDJfU0RSNTAJMHgwMgor
I2RlZmluZSAgIFNESENJX0NUUkwyX1NEUjEwNAkweDAzCisjZGVmaW5lICAgU0RIQ0lfQ1RSTDJf
RERSNTAJMHgwNAorI2RlZmluZSAgU0RIQ0lfQ1RSTDJfMV84VgkweDA4CiAKICNkZWZpbmUgU0RI
Q0lfQ0FQQUJJTElUSUVTCTB4NDAKICNkZWZpbmUgIFNESENJX1RJTUVPVVRfQ0xLX01BU0sJMHgw
MDAwMDAzRgpAQCAtMTYxLDcgKzE2OCwxMCBAQAogI2RlZmluZSAgU0RIQ0lfQ0FOX1ZERF8xODAJ
MHgwNDAwMDAwMAogI2RlZmluZSAgU0RIQ0lfQ0FOXzY0QklUCTB4MTAwMDAwMDAKIAotLyogNDQt
NDcgcmVzZXJ2ZWQgZm9yIG1vcmUgY2FwcyAqLworI2RlZmluZSBTREhDSV9DQVBBQklMSVRJRVNf
SAkweDQ0CisjZGVmaW5lICBTREhDSV9DQU5fU0RSNTAJMHgwMDAwMDAwMQorI2RlZmluZSAgU0RI
Q0lfQ0FOX1NEUjEwNAkweDAwMDAwMDAyCisjZGVmaW5lICBTREhDSV9DQU5fRERSNTAJMHgwMDAw
MDAwNAogCiAjZGVmaW5lIFNESENJX01BWF9DVVJSRU5UCTB4NDgKIApAQCAtMjA3LDYgKzIxNyw3
IEBAIHN0cnVjdCBzZGhjaV9vcHMgewogI2VuZGlmCiAKIAl2b2lkCSgqc2V0X2Nsb2NrKShzdHJ1
Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5zaWduZWQgaW50IGNsb2NrKTsKKwl2b2lkCSgqc2V0X2Rk
cikoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHVuc2lnbmVkIGludCBkZHIpOwogCiAJaW50CQko
KmVuYWJsZV9kbWEpKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KTsKIAl1bnNpZ25lZCBpbnQJKCpn
ZXRfbWF4X2Nsb2NrKShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCk7Ci0tIAoxLjcuMC40Cgo=
--001636c5aa65d030310493fe87cd--
