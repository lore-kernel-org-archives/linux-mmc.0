From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [patch]: sdhci support emmc ddr50 mode [v3]
Date: Tue, 21 Dec 2010 07:37:08 -0500
Message-ID: <AANLkTinbp0i5WmNp5VnfTChDmy2c0gF5_G9YMAHbeGvo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016368e29f7130cc10497eae534
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:56538 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab0LUMhJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Dec 2010 07:37:09 -0500
Received: by fxm18 with SMTP id 18so4245860fxm.2
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2010 04:37:08 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

--0016368e29f7130cc10497eae534
Content-Type: text/plain; charset=ISO-8859-1

v3: sync to mmc-next

Emmc speed could double if using ddr50 mode, help check

>From 895c3d15a200d5f5803f992dab46ff114ad26f90 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Tue, 21 Dec 2010 19:51:38 -0500
Subject: [PATCH] mmc: sdhci support emmc ddr50 mode

	1. spec sdhc 3.0 does not claim support 1.2v ddr mode
	2. Call back function set_power is added, since some controller count
on external pmic to provide power
	3. According to spec sdhc 3.0, uhs mode, including emmc ddr50 takes
effect only when 1.8v Signaling Enable bit, which used for providing
1.8v.
	   So emmc ddr50 mode works after 1.8v switching process, though emmc
ddr50 could work at high voltage such as 3.3v if external pmic provide
voltage.
	   Limitation: emmc ddr50 mode only workable when both host and emmc
card support 1.70-1.90v
	4. According to JESD84, power down and power up is required to
provide low voltage 1.70-1.90v to mmc.

	Verified: toshiba emmc on mmp2, with io voltage at 1.8v provided by
external pmic.

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/core/core.c  |   13 +++++++++++++
 drivers/mmc/core/core.h  |    1 +
 drivers/mmc/core/mmc.c   |    6 +++++-
 drivers/mmc/host/sdhci.c |   44 +++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/sdhci.h |   14 +++++++++++++-
 5 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a8e89f3..fd657f1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1012,6 +1012,19 @@ static void mmc_power_off(struct mmc_host *host)
 }

 /*
+ * mmc select low voltage 1.70-1.95v
+ */
+void mmc_select_low_voltage(struct mmc_host *host, u32 ocr)
+{
+	if (!(ocr & MMC_VDD_165_195))
+		return;
+
+	mmc_power_off(host);
+	host->ocr = ocr & host->ocr_avail;
+	mmc_power_up(host);
+}
+
+/*
  * Cleanup when the last reference to the bus operator is dropped.
  */
 static void __mmc_release_bus(struct mmc_host *host)
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 026c975..b05c20a 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -41,6 +41,7 @@ void mmc_set_bus_width(struct mmc_host *host,
unsigned int width);
 void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
 			   unsigned int ddr);
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
+void mmc_select_low_voltage(struct mmc_host *host, u32 ocr);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);

 static inline void mmc_delay(unsigned int ms)
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 86cac0d..8779339 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -790,7 +790,11 @@ int mmc_attach_mmc(struct mmc_host *host, u32 ocr)
 		ocr &= ~0x7F;
 	}

-	host->ocr = mmc_select_voltage(host, ocr);
+	if ((ocr & MMC_VDD_165_195)
+			&& (host->ocr_avail & MMC_VDD_165_195))
+		mmc_select_low_voltage(host, ocr);
+	else
+		host->ocr = mmc_select_voltage(host, ocr);

 	/*
 	 * Can we support the voltage of the card?
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d5febe5..aafbb42 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -986,6 +986,22 @@ static void sdhci_finish_command(struct sdhci_host *host)
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
@@ -1084,6 +1100,18 @@ static void sdhci_set_power(struct sdhci_host
*host, unsigned short power)
 		return;
 	}

+	if ((pwr == SDHCI_POWER_180) &&
+		(host->mmc->caps & MMC_CAP_1_8V_DDR)) {
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
@@ -1180,6 +1208,7 @@ static void sdhci_set_ios(struct mmc_host *mmc,
struct mmc_ios *ios)
 	}

 	sdhci_set_clock(host, ios->clock);
+	sdhci_set_ddr(host, ios->ddr);

 	if (ios->power_mode == MMC_POWER_OFF)
 		sdhci_set_power(host, -1);
@@ -1744,7 +1773,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
 int sdhci_add_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
-	unsigned int caps, ocr_avail;
+	unsigned int caps, caps_h = 0, ocr_avail;
 	int ret;

 	WARN_ON(host == NULL);
@@ -1767,8 +1796,17 @@ int sdhci_add_host(struct sdhci_host *host)
 			host->version);
 	}

-	caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
-		sdhci_readl(host, SDHCI_CAPABILITIES);
+	if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
+		caps = host->caps;
+	else {
+		caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+		caps_h = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	}
+
+	if (caps & SDHCI_CAN_VDD_180) {
+		if (caps_h & SDHCI_CAN_SDR50)
+			mmc->caps |= (MMC_CAP_1_8V_DDR);
+	}

 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6e0969e..c4bd5dd 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -145,7 +145,14 @@

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
@@ -167,6 +174,9 @@
 #define  SDHCI_CAN_64BIT	0x10000000

 #define SDHCI_CAPABILITIES_1	0x44
+#define  SDHCI_CAN_SDR50	0x00000001
+#define  SDHCI_CAN_SDR104	0x00000002
+#define  SDHCI_CAN_DDR50	0x00000004

 #define SDHCI_MAX_CURRENT	0x48

@@ -222,6 +232,8 @@ struct sdhci_ops {
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
 	unsigned int    (*get_ro)(struct sdhci_host *host);
+	unsigned int    (*set_power)(struct sdhci_host *host,
+				unsigned short power);
 };

 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.0.4

--0016368e29f7130cc10497eae534
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-mmc-sdhci-support-emmc-ddr50-mode.patch"
Content-Disposition: attachment;
	filename="0001-mmc-sdhci-support-emmc-ddr50-mode.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ghzjg7um0

RnJvbSA4OTVjM2QxNWEyMDBkNWY1ODAzZjk5MmRhYjQ2ZmYxMTRhZDI2ZjkwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogVHVlLCAyMSBEZWMgMjAxMCAxOTo1MTozOCAtMDUwMApTdWJqZWN0OiBbUEFUQ0hd
IG1tYzogc2RoY2kgc3VwcG9ydCBlbW1jIGRkcjUwIG1vZGUKCgkxLiBzcGVjIHNkaGMgMy4wIGRv
ZXMgbm90IGNsYWltIHN1cHBvcnQgMS4ydiBkZHIgbW9kZQoJMi4gQ2FsbCBiYWNrIGZ1bmN0aW9u
IHNldF9wb3dlciBpcyBhZGRlZCwgc2luY2Ugc29tZSBjb250cm9sbGVyIGNvdW50IG9uIGV4dGVy
bmFsIHBtaWMgdG8gcHJvdmlkZSBwb3dlcgoJMy4gQWNjb3JkaW5nIHRvIHNwZWMgc2RoYyAzLjAs
IHVocyBtb2RlLCBpbmNsdWRpbmcgZW1tYyBkZHI1MCB0YWtlcyBlZmZlY3Qgb25seSB3aGVuIDEu
OHYgU2lnbmFsaW5nIEVuYWJsZSBiaXQsIHdoaWNoIHVzZWQgZm9yIHByb3ZpZGluZyAxLjh2LgoJ
ICAgU28gZW1tYyBkZHI1MCBtb2RlIHdvcmtzIGFmdGVyIDEuOHYgc3dpdGNoaW5nIHByb2Nlc3Ms
IHRob3VnaCBlbW1jIGRkcjUwIGNvdWxkIHdvcmsgYXQgaGlnaCB2b2x0YWdlIHN1Y2ggYXMgMy4z
diBpZiBleHRlcm5hbCBwbWljIHByb3ZpZGUgdm9sdGFnZS4KCSAgIExpbWl0YXRpb246IGVtbWMg
ZGRyNTAgbW9kZSBvbmx5IHdvcmthYmxlIHdoZW4gYm90aCBob3N0IGFuZCBlbW1jIGNhcmQgc3Vw
cG9ydCAxLjcwLTEuOTB2Cgk0LiBBY2NvcmRpbmcgdG8gSkVTRDg0LCBwb3dlciBkb3duIGFuZCBw
b3dlciB1cCBpcyByZXF1aXJlZCB0byBwcm92aWRlIGxvdyB2b2x0YWdlIDEuNzAtMS45MHYgdG8g
bW1jLgoKCVZlcmlmaWVkOiB0b3NoaWJhIGVtbWMgb24gbW1wMiwgd2l0aCBpbyB2b2x0YWdlIGF0
IDEuOHYgcHJvdmlkZWQgYnkgZXh0ZXJuYWwgcG1pYy4KClNpZ25lZC1vZmYtYnk6IFpoYW5nZmVp
IEdhbyA8emhhbmdmZWkuZ2FvQG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvbW1jL2NvcmUvY29y
ZS5jICB8ICAgMTMgKysrKysrKysrKysrKwogZHJpdmVycy9tbWMvY29yZS9jb3JlLmggIHwgICAg
MSArCiBkcml2ZXJzL21tYy9jb3JlL21tYy5jICAgfCAgICA2ICsrKysrLQogZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS5jIHwgICA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oIHwgICAxNCArKysrKysrKysrKysrLQog
NSBmaWxlcyBjaGFuZ2VkLCA3MyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5jIGIvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMK
aW5kZXggYThlODlmMy4uZmQ2NTdmMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvY29yZS9jb3Jl
LmMKKysrIGIvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMKQEAgLTEwMTIsNiArMTAxMiwxOSBAQCBz
dGF0aWMgdm9pZCBtbWNfcG93ZXJfb2ZmKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkKIH0KIAogLyoK
KyAqIG1tYyBzZWxlY3QgbG93IHZvbHRhZ2UgMS43MC0xLjk1dgorICovCit2b2lkIG1tY19zZWxl
Y3RfbG93X3ZvbHRhZ2Uoc3RydWN0IG1tY19ob3N0ICpob3N0LCB1MzIgb2NyKQoreworCWlmICgh
KG9jciAmIE1NQ19WRERfMTY1XzE5NSkpCisJCXJldHVybjsKKworCW1tY19wb3dlcl9vZmYoaG9z
dCk7CisJaG9zdC0+b2NyID0gb2NyICYgaG9zdC0+b2NyX2F2YWlsOworCW1tY19wb3dlcl91cCho
b3N0KTsKK30KKworLyoKICAqIENsZWFudXAgd2hlbiB0aGUgbGFzdCByZWZlcmVuY2UgdG8gdGhl
IGJ1cyBvcGVyYXRvciBpcyBkcm9wcGVkLgogICovCiBzdGF0aWMgdm9pZCBfX21tY19yZWxlYXNl
X2J1cyhzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3Jl
L2NvcmUuaCBiL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5oCmluZGV4IDAyNmM5NzUuLmIwNWMyMGEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5oCisrKyBiL2RyaXZlcnMvbW1jL2Nv
cmUvY29yZS5oCkBAIC00MSw2ICs0MSw3IEBAIHZvaWQgbW1jX3NldF9idXNfd2lkdGgoc3RydWN0
IG1tY19ob3N0ICpob3N0LCB1bnNpZ25lZCBpbnQgd2lkdGgpOwogdm9pZCBtbWNfc2V0X2J1c193
aWR0aF9kZHIoc3RydWN0IG1tY19ob3N0ICpob3N0LCB1bnNpZ25lZCBpbnQgd2lkdGgsCiAJCQkg
ICB1bnNpZ25lZCBpbnQgZGRyKTsKIHUzMiBtbWNfc2VsZWN0X3ZvbHRhZ2Uoc3RydWN0IG1tY19o
b3N0ICpob3N0LCB1MzIgb2NyKTsKK3ZvaWQgbW1jX3NlbGVjdF9sb3dfdm9sdGFnZShzdHJ1Y3Qg
bW1jX2hvc3QgKmhvc3QsIHUzMiBvY3IpOwogdm9pZCBtbWNfc2V0X3RpbWluZyhzdHJ1Y3QgbW1j
X2hvc3QgKmhvc3QsIHVuc2lnbmVkIGludCB0aW1pbmcpOwogCiBzdGF0aWMgaW5saW5lIHZvaWQg
bW1jX2RlbGF5KHVuc2lnbmVkIGludCBtcykKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUv
bW1jLmMgYi9kcml2ZXJzL21tYy9jb3JlL21tYy5jCmluZGV4IDg2Y2FjMGQuLjg3NzkzMzkgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMKKysrIGIvZHJpdmVycy9tbWMvY29yZS9t
bWMuYwpAQCAtNzkwLDcgKzc5MCwxMSBAQCBpbnQgbW1jX2F0dGFjaF9tbWMoc3RydWN0IG1tY19o
b3N0ICpob3N0LCB1MzIgb2NyKQogCQlvY3IgJj0gfjB4N0Y7CiAJfQogCi0JaG9zdC0+b2NyID0g
bW1jX3NlbGVjdF92b2x0YWdlKGhvc3QsIG9jcik7CisJaWYgKChvY3IgJiBNTUNfVkREXzE2NV8x
OTUpCisJCQkmJiAoaG9zdC0+b2NyX2F2YWlsICYgTU1DX1ZERF8xNjVfMTk1KSkKKwkJbW1jX3Nl
bGVjdF9sb3dfdm9sdGFnZShob3N0LCBvY3IpOworCWVsc2UKKwkJaG9zdC0+b2NyID0gbW1jX3Nl
bGVjdF92b2x0YWdlKGhvc3QsIG9jcik7CiAKIAkvKgogCSAqIENhbiB3ZSBzdXBwb3J0IHRoZSB2
b2x0YWdlIG9mIHRoZSBjYXJkPwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5j
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCmluZGV4IGQ1ZmViZTUuLmFhZmJiNDIgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYworKysgYi9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLmMKQEAgLTk4Niw2ICs5ODYsMjIgQEAgc3RhdGljIHZvaWQgc2RoY2lfZmluaXNoX2NvbW1h
bmQoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpCiAJaG9zdC0+Y21kID0gTlVMTDsKIH0KIAorc3Rh
dGljIHZvaWQgc2RoY2lfc2V0X2RkcihzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5zaWduZWQg
aW50IGRkcikKK3sKKwl1MTYgY29uOworCisJaWYgKGRkciA9PSBNTUNfU0RSX01PREUpCisJCXJl
dHVybjsKKworCWNvbiA9IHNkaGNpX3JlYWR3KGhvc3QsIFNESENJX0hPU1RfQ09OVFJPTDIpOwor
CWlmIChjb24gJiBTREhDSV9DVFJMMl8xXzhWKSB7CisJCWNvbiAmPSB+U0RIQ0lfQ1RSTDJfVUhT
X01BU0s7CisJCWlmIChkZHIgJiBNTUNfMV84Vl9ERFJfTU9ERSkKKwkJCWNvbiB8PSBTREhDSV9D
VFJMMl9ERFI1MDsKKwkJc2RoY2lfd3JpdGV3KGhvc3QsIGNvbiwgU0RIQ0lfSE9TVF9DT05UUk9M
Mik7CisJfQorfQorCiBzdGF0aWMgdm9pZCBzZGhjaV9zZXRfY2xvY2soc3RydWN0IHNkaGNpX2hv
c3QgKmhvc3QsIHVuc2lnbmVkIGludCBjbG9jaykKIHsKIAlpbnQgZGl2OwpAQCAtMTA4NCw2ICsx
MTAwLDE4IEBAIHN0YXRpYyB2b2lkIHNkaGNpX3NldF9wb3dlcihzdHJ1Y3Qgc2RoY2lfaG9zdCAq
aG9zdCwgdW5zaWduZWQgc2hvcnQgcG93ZXIpCiAJCXJldHVybjsKIAl9CiAKKwlpZiAoKHB3ciA9
PSBTREhDSV9QT1dFUl8xODApICYmCisJCShob3N0LT5tbWMtPmNhcHMgJiBNTUNfQ0FQXzFfOFZf
RERSKSkgeworCQl1MTYgY29uOworCisJCWNvbiA9IHNkaGNpX3JlYWR3KGhvc3QsIFNESENJX0hP
U1RfQ09OVFJPTDIpOworCQljb24gfD0gU0RIQ0lfQ1RSTDJfMV84VjsKKwkJc2RoY2lfd3JpdGV3
KGhvc3QsIGNvbiwgU0RIQ0lfSE9TVF9DT05UUk9MMik7CisKKwkJaWYgKGhvc3QtPm9wcy0+c2V0
X3Bvd2VyKQorCQkJaG9zdC0+b3BzLT5zZXRfcG93ZXIoaG9zdCwgcHdyKTsKKwl9CisKIAkvKgog
CSAqIFNwZWMgc2F5cyB0aGF0IHdlIHNob3VsZCBjbGVhciB0aGUgcG93ZXIgcmVnIGJlZm9yZSBz
ZXR0aW5nCiAJICogYSBuZXcgdmFsdWUuIFNvbWUgY29udHJvbGxlcnMgZG9uJ3Qgc2VlbSB0byBs
aWtlIHRoaXMgdGhvdWdoLgpAQCAtMTE4MCw2ICsxMjA4LDcgQEAgc3RhdGljIHZvaWQgc2RoY2lf
c2V0X2lvcyhzdHJ1Y3QgbW1jX2hvc3QgKm1tYywgc3RydWN0IG1tY19pb3MgKmlvcykKIAl9CiAK
IAlzZGhjaV9zZXRfY2xvY2soaG9zdCwgaW9zLT5jbG9jayk7CisJc2RoY2lfc2V0X2Rkcihob3N0
LCBpb3MtPmRkcik7CiAKIAlpZiAoaW9zLT5wb3dlcl9tb2RlID09IE1NQ19QT1dFUl9PRkYpCiAJ
CXNkaGNpX3NldF9wb3dlcihob3N0LCAtMSk7CkBAIC0xNzQ0LDcgKzE3NzMsNyBAQCBFWFBPUlRf
U1lNQk9MX0dQTChzZGhjaV9hbGxvY19ob3N0KTsKIGludCBzZGhjaV9hZGRfaG9zdChzdHJ1Y3Qg
c2RoY2lfaG9zdCAqaG9zdCkKIHsKIAlzdHJ1Y3QgbW1jX2hvc3QgKm1tYzsKLQl1bnNpZ25lZCBp
bnQgY2Fwcywgb2NyX2F2YWlsOworCXVuc2lnbmVkIGludCBjYXBzLCBjYXBzX2ggPSAwLCBvY3Jf
YXZhaWw7CiAJaW50IHJldDsKIAogCVdBUk5fT04oaG9zdCA9PSBOVUxMKTsKQEAgLTE3NjcsOCAr
MTc5NiwxNyBAQCBpbnQgc2RoY2lfYWRkX2hvc3Qoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpCiAJ
CQlob3N0LT52ZXJzaW9uKTsKIAl9CiAKLQljYXBzID0gKGhvc3QtPnF1aXJrcyAmIFNESENJX1FV
SVJLX01JU1NJTkdfQ0FQUykgPyBob3N0LT5jYXBzIDoKLQkJc2RoY2lfcmVhZGwoaG9zdCwgU0RI
Q0lfQ0FQQUJJTElUSUVTKTsKKwlpZiAoaG9zdC0+cXVpcmtzICYgU0RIQ0lfUVVJUktfTUlTU0lO
R19DQVBTKQorCQljYXBzID0gaG9zdC0+Y2FwczsKKwllbHNlIHsKKwkJY2FwcyA9IHNkaGNpX3Jl
YWRsKGhvc3QsIFNESENJX0NBUEFCSUxJVElFUyk7CisJCWNhcHNfaCA9IHNkaGNpX3JlYWRsKGhv
c3QsIFNESENJX0NBUEFCSUxJVElFU18xKTsKKwl9CisKKwlpZiAoY2FwcyAmIFNESENJX0NBTl9W
RERfMTgwKSB7CisJCWlmIChjYXBzX2ggJiBTREhDSV9DQU5fU0RSNTApCisJCQltbWMtPmNhcHMg
fD0gKE1NQ19DQVBfMV84Vl9ERFIpOworCX0KIAogCWlmIChob3N0LT5xdWlya3MgJiBTREhDSV9R
VUlSS19GT1JDRV9ETUEpCiAJCWhvc3QtPmZsYWdzIHw9IFNESENJX1VTRV9TRE1BOwpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5o
CmluZGV4IDZlMDk2OWUuLmM0YmQ1ZGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2kuaAorKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmgKQEAgLTE0NSw3ICsxNDUsMTQgQEAK
IAogI2RlZmluZSBTREhDSV9BQ01EMTJfRVJSCTB4M0MKIAotLyogM0UtM0YgcmVzZXJ2ZWQgKi8K
KyNkZWZpbmUgU0RIQ0lfSE9TVF9DT05UUk9MMgkweDNFCisjZGVmaW5lICBTREhDSV9DVFJMMl9V
SFNfTUFTSwkweDAwMDcKKyNkZWZpbmUgICBTREhDSV9DVFJMMl9TRFIxMgkweDAwMDAKKyNkZWZp
bmUgICBTREhDSV9DVFJMMl9TRFIyNQkweDAwMDEKKyNkZWZpbmUgICBTREhDSV9DVFJMMl9TRFI1
MAkweDAwMDIKKyNkZWZpbmUgICBTREhDSV9DVFJMMl9TRFIxMDQJMHgwMDAzCisjZGVmaW5lICAg
U0RIQ0lfQ1RSTDJfRERSNTAJMHgwMDA0CisjZGVmaW5lICBTREhDSV9DVFJMMl8xXzhWCTB4MDAw
OAogCiAjZGVmaW5lIFNESENJX0NBUEFCSUxJVElFUwkweDQwCiAjZGVmaW5lICBTREhDSV9USU1F
T1VUX0NMS19NQVNLCTB4MDAwMDAwM0YKQEAgLTE2Nyw2ICsxNzQsOSBAQAogI2RlZmluZSAgU0RI
Q0lfQ0FOXzY0QklUCTB4MTAwMDAwMDAKIAogI2RlZmluZSBTREhDSV9DQVBBQklMSVRJRVNfMQkw
eDQ0CisjZGVmaW5lICBTREhDSV9DQU5fU0RSNTAJMHgwMDAwMDAwMQorI2RlZmluZSAgU0RIQ0lf
Q0FOX1NEUjEwNAkweDAwMDAwMDAyCisjZGVmaW5lICBTREhDSV9DQU5fRERSNTAJMHgwMDAwMDAw
NAogCiAjZGVmaW5lIFNESENJX01BWF9DVVJSRU5UCTB4NDgKIApAQCAtMjIyLDYgKzIzMiw4IEBA
IHN0cnVjdCBzZGhjaV9vcHMgewogCXZvaWQgKCpwbGF0Zm9ybV9zZW5kX2luaXRfNzRfY2xvY2tz
KShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwKIAkJCQkJICAgICB1OCBwb3dlcl9tb2RlKTsKIAl1
bnNpZ25lZCBpbnQgICAgKCpnZXRfcm8pKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KTsKKwl1bnNp
Z25lZCBpbnQgICAgKCpzZXRfcG93ZXIpKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LAorCQkJCXVu
c2lnbmVkIHNob3J0IHBvd2VyKTsKIH07CiAKICNpZmRlZiBDT05GSUdfTU1DX1NESENJX0lPX0FD
Q0VTU09SUwotLSAKMS43LjAuNAoK
--0016368e29f7130cc10497eae534--
