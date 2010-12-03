From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH v2 1/1] sdhci support emmc ddr50 mode
Date: Fri, 3 Dec 2010 07:08:37 -0500
Message-ID: <AANLkTiknFGMQczA-bcnDLv7K4ZpDOZgiG-iQNLDm+aNC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3054ace5fc9dc804968065d4
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48589 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758451Ab0LCMIj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Dec 2010 07:08:39 -0500
Received: by fxm20 with SMTP id 20so2109897fxm.19
        for <linux-mmc@vger.kernel.org>; Fri, 03 Dec 2010 04:08:38 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@nokia.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

--20cf3054ace5fc9dc804968065d4
Content-Type: text/plain; charset=ISO-8859-1

>From 5e4d3011401c3a248851c22b6aa92ee3b2397dfc Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Fri, 3 Dec 2010 07:21:15 -0500
Subject: [PATCH] mmc: sdhci support emmc ddr50 mode

	1. spec 3.0 does not claim support 1.2v ddr mode
	2. Call back function set_power is added, since some controller count
on external pmic to provide power

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/core/core.c   |    6 ++++++
 drivers/mmc/host/sdhci.c  |   36 +++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.h  |   14 ++++++++++++--
 include/linux/mmc/mmc.h   |    1 +
 include/linux/mmc/sdhci.h |    2 ++
 5 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8bf542c..512e15d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1573,6 +1573,12 @@ void mmc_rescan(struct work_struct *work)
 		 */
 		err = mmc_send_op_cond(host, 0, &ocr);
 		if (!err) {
+			if (ocr & MMC_CARD_1_8V) {
+				mmc_power_off(host);
+				host->ocr = ocr & host->ocr_avail;
+				mmc_power_up(host);
+			}
+
 			if (mmc_attach_mmc(host, ocr))
 				mmc_power_off(host);
 			goto out;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a25db42..b7ad2f6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -982,6 +982,22 @@ static void sdhci_finish_command(struct sdhci_host *host)
 	host->cmd = NULL;
 }

+static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
+{
+	u16 con;
+
+	if (ddr == MMC_SDR_MODE)
+		return;
+
+	con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	if (con & SDHCI_CTRL2_1_8V) {
+		con &= ~SDHCI_CTRL2_UHS_MASK;
+		if (ddr & MMC_1_8V_DDR_MODE)
+			con |= SDHCI_CTRL2_DDR50;
+		sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
+	}
+}
+
 static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	int div;
@@ -1080,6 +1096,17 @@ static void sdhci_set_power(struct sdhci_host
*host, unsigned short power)
 		return;
 	}

+	if (pwr == SDHCI_POWER_180) {
+		u16 con;
+
+		con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		con |= SDHCI_CTRL2_1_8V;
+		sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
+
+		if (host->ops->set_power)
+			host->ops->set_power(host, pwr);
+	}
+
 	/*
 	 * Spec says that we should clear the power reg before setting
 	 * a new value. Some controllers don't seem to like this though.
@@ -1176,6 +1203,7 @@ static void sdhci_set_ios(struct mmc_host *mmc,
struct mmc_ios *ios)
 	}

 	sdhci_set_clock(host, ios->clock);
+	sdhci_set_ddr(host, ios->ddr);

 	if (ios->power_mode == MMC_POWER_OFF)
 		sdhci_set_power(host, -1);
@@ -1736,7 +1764,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
 int sdhci_add_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
-	unsigned int caps;
+	unsigned int caps, caps_h;
 	int ret;

 	WARN_ON(host == NULL);
@@ -1761,6 +1789,12 @@ int sdhci_add_host(struct sdhci_host *host)

 	caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
 		sdhci_readl(host, SDHCI_CAPABILITIES);
+	caps_h = sdhci_readl(host, SDHCI_CAPABILITIES_H);
+
+	if (caps & SDHCI_CAN_VDD_180) {
+		if (caps_h & SDHCI_CAN_SDR50)
+			mmc->caps |= (MMC_CAP_1_8V_DDR);
+	}

 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b689cc6..28c460a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -144,7 +144,14 @@

 #define SDHCI_ACMD12_ERR	0x3C

-/* 3E-3F reserved */
+#define SDHCI_HOST_CONTROL2	0x3E
+#define  SDHCI_CTRL2_UHS_MASK	0x0007
+#define   SDHCI_CTRL2_SDR12	0x0000
+#define   SDHCI_CTRL2_SDR25	0x0001
+#define   SDHCI_CTRL2_SDR50	0x0002
+#define   SDHCI_CTRL2_SDR104	0x0003
+#define   SDHCI_CTRL2_DDR50	0x0004
+#define  SDHCI_CTRL2_1_8V	0x0008

 #define SDHCI_CAPABILITIES	0x40
 #define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F
@@ -165,7 +172,10 @@
 #define  SDHCI_CAN_VDD_180	0x04000000
 #define  SDHCI_CAN_64BIT	0x10000000

-/* 44-47 reserved for more caps */
+#define SDHCI_CAPABILITIES_H	0x44
+#define  SDHCI_CAN_SDR50	0x00000001
+#define  SDHCI_CAN_SDR104	0x00000002
+#define  SDHCI_CAN_DDR50	0x00000004

 #define SDHCI_MAX_CURRENT	0x48

diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 956fbd8..bd09b19 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -202,6 +202,7 @@ struct _mmc_csd {
  * OCR bits are mostly in host.h
  */
 #define MMC_CARD_BUSY	0x80000000	/* Card Power up status bit */
+#define MMC_CARD_1_8V	0x00000080	/* Card 1.70-1.95V support bit */

 /*
  * Card Command Classes (CCC)
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 86e8380..57bcda9 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -163,6 +163,8 @@ struct sdhci_ops {
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
 	unsigned int    (*get_ro)(struct sdhci_host *host);
+	unsigned int    (*set_power)(struct sdhci_host *host,
+				unsigned short power);
 };


-- 
1.7.0.4

--20cf3054ace5fc9dc804968065d4
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-mmc-sdhci-support-emmc-ddr50-mode.patch"
Content-Disposition: attachment;
	filename="0001-mmc-sdhci-support-emmc-ddr50-mode.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gh93anri0

RnJvbSA1ZTRkMzAxMTQwMWMzYTI0ODg1MWMyMmI2YWE5MmVlM2IyMzk3ZGZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogRnJpLCAzIERlYyAyMDEwIDA3OjIxOjE1IC0wNTAwClN1YmplY3Q6IFtQQVRDSF0g
bW1jOiBzZGhjaSBzdXBwb3J0IGVtbWMgZGRyNTAgbW9kZQoKCTEuIHNwZWMgMy4wIGRvZXMgbm90
IGNsYWltIHN1cHBvcnQgMS4ydiBkZHIgbW9kZQoJMi4gQ2FsbCBiYWNrIGZ1bmN0aW9uIHNldF9w
b3dlciBpcyBhZGRlZCwgc2luY2Ugc29tZSBjb250cm9sbGVyIGNvdW50IG9uIGV4dGVybmFsIHBt
aWMgdG8gcHJvdmlkZSBwb3dlcgoKU2lnbmVkLW9mZi1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2Zl
aS5nYW9AbWFydmVsbC5jb20+Ci0tLQogZHJpdmVycy9tbWMvY29yZS9jb3JlLmMgICB8ICAgIDYg
KysrKysrCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgIHwgICAzNiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0KIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaCAgfCAgIDE0ICsr
KysrKysrKysrKy0tCiBpbmNsdWRlL2xpbnV4L21tYy9tbWMuaCAgIHwgICAgMSArCiBpbmNsdWRl
L2xpbnV4L21tYy9zZGhjaS5oIHwgICAgMiArKwogNSBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvY29y
ZS5jIGIvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMKaW5kZXggOGJmNTQyYy4uNTEyZTE1ZCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMKKysrIGIvZHJpdmVycy9tbWMvY29yZS9j
b3JlLmMKQEAgLTE1NzMsNiArMTU3MywxMiBAQCB2b2lkIG1tY19yZXNjYW4oc3RydWN0IHdvcmtf
c3RydWN0ICp3b3JrKQogCQkgKi8KIAkJZXJyID0gbW1jX3NlbmRfb3BfY29uZChob3N0LCAwLCAm
b2NyKTsKIAkJaWYgKCFlcnIpIHsKKwkJCWlmIChvY3IgJiBNTUNfQ0FSRF8xXzhWKSB7CisJCQkJ
bW1jX3Bvd2VyX29mZihob3N0KTsKKwkJCQlob3N0LT5vY3IgPSBvY3IgJiBob3N0LT5vY3JfYXZh
aWw7CisJCQkJbW1jX3Bvd2VyX3VwKGhvc3QpOworCQkJfQorCiAJCQlpZiAobW1jX2F0dGFjaF9t
bWMoaG9zdCwgb2NyKSkKIAkJCQltbWNfcG93ZXJfb2ZmKGhvc3QpOwogCQkJZ290byBvdXQ7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgYi9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLmMKaW5kZXggYTI1ZGI0Mi4uYjdhZDJmNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYwpAQCAtOTgyLDYgKzk4Miwy
MiBAQCBzdGF0aWMgdm9pZCBzZGhjaV9maW5pc2hfY29tbWFuZChzdHJ1Y3Qgc2RoY2lfaG9zdCAq
aG9zdCkKIAlob3N0LT5jbWQgPSBOVUxMOwogfQogCitzdGF0aWMgdm9pZCBzZGhjaV9zZXRfZGRy
KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1bnNpZ25lZCBpbnQgZGRyKQoreworCXUxNiBjb247
CisKKwlpZiAoZGRyID09IE1NQ19TRFJfTU9ERSkKKwkJcmV0dXJuOworCisJY29uID0gc2RoY2lf
cmVhZHcoaG9zdCwgU0RIQ0lfSE9TVF9DT05UUk9MMik7CisJaWYgKGNvbiAmIFNESENJX0NUUkwy
XzFfOFYpIHsKKwkJY29uICY9IH5TREhDSV9DVFJMMl9VSFNfTUFTSzsKKwkJaWYgKGRkciAmIE1N
Q18xXzhWX0REUl9NT0RFKQorCQkJY29uIHw9IFNESENJX0NUUkwyX0REUjUwOworCQlzZGhjaV93
cml0ZXcoaG9zdCwgY29uLCBTREhDSV9IT1NUX0NPTlRST0wyKTsKKwl9Cit9CisKIHN0YXRpYyB2
b2lkIHNkaGNpX3NldF9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5zaWduZWQgaW50
IGNsb2NrKQogewogCWludCBkaXY7CkBAIC0xMDgwLDYgKzEwOTYsMTcgQEAgc3RhdGljIHZvaWQg
c2RoY2lfc2V0X3Bvd2VyKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1bnNpZ25lZCBzaG9ydCBw
b3dlcikKIAkJcmV0dXJuOwogCX0KIAorCWlmIChwd3IgPT0gU0RIQ0lfUE9XRVJfMTgwKSB7CisJ
CXUxNiBjb247CisKKwkJY29uID0gc2RoY2lfcmVhZHcoaG9zdCwgU0RIQ0lfSE9TVF9DT05UUk9M
Mik7CisJCWNvbiB8PSBTREhDSV9DVFJMMl8xXzhWOworCQlzZGhjaV93cml0ZXcoaG9zdCwgY29u
LCBTREhDSV9IT1NUX0NPTlRST0wyKTsKKworCQlpZiAoaG9zdC0+b3BzLT5zZXRfcG93ZXIpCisJ
CQlob3N0LT5vcHMtPnNldF9wb3dlcihob3N0LCBwd3IpOworCX0KKwogCS8qCiAJICogU3BlYyBz
YXlzIHRoYXQgd2Ugc2hvdWxkIGNsZWFyIHRoZSBwb3dlciByZWcgYmVmb3JlIHNldHRpbmcKIAkg
KiBhIG5ldyB2YWx1ZS4gU29tZSBjb250cm9sbGVycyBkb24ndCBzZWVtIHRvIGxpa2UgdGhpcyB0
aG91Z2guCkBAIC0xMTc2LDYgKzEyMDMsNyBAQCBzdGF0aWMgdm9pZCBzZGhjaV9zZXRfaW9zKHN0
cnVjdCBtbWNfaG9zdCAqbW1jLCBzdHJ1Y3QgbW1jX2lvcyAqaW9zKQogCX0KIAogCXNkaGNpX3Nl
dF9jbG9jayhob3N0LCBpb3MtPmNsb2NrKTsKKwlzZGhjaV9zZXRfZGRyKGhvc3QsIGlvcy0+ZGRy
KTsKIAogCWlmIChpb3MtPnBvd2VyX21vZGUgPT0gTU1DX1BPV0VSX09GRikKIAkJc2RoY2lfc2V0
X3Bvd2VyKGhvc3QsIC0xKTsKQEAgLTE3MzYsNyArMTc2NCw3IEBAIEVYUE9SVF9TWU1CT0xfR1BM
KHNkaGNpX2FsbG9jX2hvc3QpOwogaW50IHNkaGNpX2FkZF9ob3N0KHN0cnVjdCBzZGhjaV9ob3N0
ICpob3N0KQogewogCXN0cnVjdCBtbWNfaG9zdCAqbW1jOwotCXVuc2lnbmVkIGludCBjYXBzOwor
CXVuc2lnbmVkIGludCBjYXBzLCBjYXBzX2g7CiAJaW50IHJldDsKIAogCVdBUk5fT04oaG9zdCA9
PSBOVUxMKTsKQEAgLTE3NjEsNiArMTc4OSwxMiBAQCBpbnQgc2RoY2lfYWRkX2hvc3Qoc3RydWN0
IHNkaGNpX2hvc3QgKmhvc3QpCiAKIAljYXBzID0gKGhvc3QtPnF1aXJrcyAmIFNESENJX1FVSVJL
X01JU1NJTkdfQ0FQUykgPyBob3N0LT5jYXBzIDoKIAkJc2RoY2lfcmVhZGwoaG9zdCwgU0RIQ0lf
Q0FQQUJJTElUSUVTKTsKKwljYXBzX2ggPSBzZGhjaV9yZWFkbChob3N0LCBTREhDSV9DQVBBQklM
SVRJRVNfSCk7CisKKwlpZiAoY2FwcyAmIFNESENJX0NBTl9WRERfMTgwKSB7CisJCWlmIChjYXBz
X2ggJiBTREhDSV9DQU5fU0RSNTApCisJCQltbWMtPmNhcHMgfD0gKE1NQ19DQVBfMV84Vl9ERFIp
OworCX0KIAogCWlmIChob3N0LT5xdWlya3MgJiBTREhDSV9RVUlSS19GT1JDRV9ETUEpCiAJCWhv
c3QtPmZsYWdzIHw9IFNESENJX1VTRV9TRE1BOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS5oIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oCmluZGV4IGI2ODljYzYuLjI4YzQ2
MGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaAorKysgYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLmgKQEAgLTE0NCw3ICsxNDQsMTQgQEAKIAogI2RlZmluZSBTREhDSV9BQ01E
MTJfRVJSCTB4M0MKIAotLyogM0UtM0YgcmVzZXJ2ZWQgKi8KKyNkZWZpbmUgU0RIQ0lfSE9TVF9D
T05UUk9MMgkweDNFCisjZGVmaW5lICBTREhDSV9DVFJMMl9VSFNfTUFTSwkweDAwMDcKKyNkZWZp
bmUgICBTREhDSV9DVFJMMl9TRFIxMgkweDAwMDAKKyNkZWZpbmUgICBTREhDSV9DVFJMMl9TRFIy
NQkweDAwMDEKKyNkZWZpbmUgICBTREhDSV9DVFJMMl9TRFI1MAkweDAwMDIKKyNkZWZpbmUgICBT
REhDSV9DVFJMMl9TRFIxMDQJMHgwMDAzCisjZGVmaW5lICAgU0RIQ0lfQ1RSTDJfRERSNTAJMHgw
MDA0CisjZGVmaW5lICBTREhDSV9DVFJMMl8xXzhWCTB4MDAwOAogCiAjZGVmaW5lIFNESENJX0NB
UEFCSUxJVElFUwkweDQwCiAjZGVmaW5lICBTREhDSV9USU1FT1VUX0NMS19NQVNLCTB4MDAwMDAw
M0YKQEAgLTE2NSw3ICsxNzIsMTAgQEAKICNkZWZpbmUgIFNESENJX0NBTl9WRERfMTgwCTB4MDQw
MDAwMDAKICNkZWZpbmUgIFNESENJX0NBTl82NEJJVAkweDEwMDAwMDAwCiAKLS8qIDQ0LTQ3IHJl
c2VydmVkIGZvciBtb3JlIGNhcHMgKi8KKyNkZWZpbmUgU0RIQ0lfQ0FQQUJJTElUSUVTX0gJMHg0
NAorI2RlZmluZSAgU0RIQ0lfQ0FOX1NEUjUwCTB4MDAwMDAwMDEKKyNkZWZpbmUgIFNESENJX0NB
Tl9TRFIxMDQJMHgwMDAwMDAwMgorI2RlZmluZSAgU0RIQ0lfQ0FOX0REUjUwCTB4MDAwMDAwMDQK
IAogI2RlZmluZSBTREhDSV9NQVhfQ1VSUkVOVAkweDQ4CiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvbW1jL21tYy5oIGIvaW5jbHVkZS9saW51eC9tbWMvbW1jLmgKaW5kZXggOTU2ZmJkOC4u
YmQwOWIxOSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9tbWMvbW1jLmgKKysrIGIvaW5jbHVk
ZS9saW51eC9tbWMvbW1jLmgKQEAgLTIwMiw2ICsyMDIsNyBAQCBzdHJ1Y3QgX21tY19jc2Qgewog
ICogT0NSIGJpdHMgYXJlIG1vc3RseSBpbiBob3N0LmgKICAqLwogI2RlZmluZSBNTUNfQ0FSRF9C
VVNZCTB4ODAwMDAwMDAJLyogQ2FyZCBQb3dlciB1cCBzdGF0dXMgYml0ICovCisjZGVmaW5lIE1N
Q19DQVJEXzFfOFYJMHgwMDAwMDA4MAkvKiBDYXJkIDEuNzAtMS45NVYgc3VwcG9ydCBiaXQgKi8K
IAogLyoKICAqIENhcmQgQ29tbWFuZCBDbGFzc2VzIChDQ0MpCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L21tYy9zZGhjaS5oIGIvaW5jbHVkZS9saW51eC9tbWMvc2RoY2kuaAppbmRleCA4NmU4
MzgwLi41N2JjZGE5IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L21tYy9zZGhjaS5oCisrKyBi
L2luY2x1ZGUvbGludXgvbW1jL3NkaGNpLmgKQEAgLTE2Myw2ICsxNjMsOCBAQCBzdHJ1Y3Qgc2Ro
Y2lfb3BzIHsKIAl2b2lkICgqcGxhdGZvcm1fc2VuZF9pbml0Xzc0X2Nsb2Nrcykoc3RydWN0IHNk
aGNpX2hvc3QgKmhvc3QsCiAJCQkJCSAgICAgdTggcG93ZXJfbW9kZSk7CiAJdW5zaWduZWQgaW50
ICAgICgqZ2V0X3JvKShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCk7CisJdW5zaWduZWQgaW50ICAg
ICgqc2V0X3Bvd2VyKShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwKKwkJCQl1bnNpZ25lZCBzaG9y
dCBwb3dlcik7CiB9OwogCiAKLS0gCjEuNy4wLjQKCg==
--20cf3054ace5fc9dc804968065d4--
